/**
 * Extension function of MemoryBuffer to read variable lengths integer values.
 */
mbReadUIntVar :: (buffer: *MemoryBuffer, value: *u32) -> bool {
    v: u32 = 0;
    byte: u8;
    for i : 0..4-1 {
        if (!mbRead(buffer, *byte)) {
            return false;
        }

        v = (v << 7) | cast(u32) (byte & 0x7F);
        if ((byte & 0x80) == 0) {
            break;
        }
    }
    <<value = v;
    return true;
}

/**
 * Extension function of MemoryBuffer to write variable lengths integer values.
 */
mbWriteUIntVar :: (buffer: *MemoryBuffer, value: u32) -> bool {
    byteCount: s32 = 1;
    v: u32 = value & 0x7F;
    value >>= 7;
    while (value > 0) {
        v = (v << 8) | 0x80 | (value & 0x7F);
        byteCount += 1;
        value >>= 7;
    }

    for i : 0..byteCount-1 {
        byte := cast(u8) (v & 0xFF);
        if (!mbWrite(buffer, byte)) {
            return false;
        }
        v >>= 8;
    }

    return true;
}

/**
 * This code is a port in C of the XMI2MID converter by Peter "Corsix" Cawley
 * in the War1gus repository. You can find the original C++ code here:
 * https://github.com/Wargus/war1gus/blob/master/xmi2mid.cpp.
 *
 * To understand more about these formats see:
 * http://www.shikadi.net/moddingwiki/XMI_Format
 * http://www.shikadi.net/moddingwiki/MID_Format
 * https://github.com/colxi/midi-parser-js/wiki/MIDI-File-Format-Specifications
 */
transcodeXmiToMid :: (xmiData: *u8, xmiLength: u32, midLength: *u32) -> *u8 {
    bufInput: MemoryBuffer;
    mbInitFromMemory(*bufInput, xmiData, xmiLength);

    bufOutput: MemoryBuffer;
    defer mbFree(*bufOutput);
    mbInitEmpty(*bufOutput);

    if (!mbScanTo(*bufInput, "EVNT", 4)) {
        return null;
    }

    if (!mbSkip(*bufInput, 8)) {
        return null;
    }

    lstTokens: List(MidiToken);
    init(*lstTokens);

    token: *MidiToken;
    tokenTime: s32 = 0;
    tempo: s32 = 500000;
    tempoSet := false;
    end := false;
    tokenType, extendedType: u8;
    intVar: u32;

    while (!mbIsEOF(*bufInput) && !end) {
        while (true) {
            if (!mbRead(*bufInput, *tokenType)) {
                return null;
            }

            if (tokenType & 0x80) {
                break;
            }

            tokenTime += cast(s32) tokenType * 3;
        }

        token = append(*lstTokens, tokenTime, tokenType);
        token.buffer = bufInput._pointer + 1;

        if (tokenType & 0xF0) == {
            case 0xC0; #through;
            case 0xD0; {
                if (!mbRead(*bufInput, *token.data)) {
                    return null;
                }

                token.buffer = null;
            }
            case 0x80; #through;
            case 0xA0; #through;
            case 0xB0; #through;
            case 0xE0; {
                if (!mbRead(*bufInput, *token.data)) {
                    return null;
                }

                if (!mbSkip(*bufInput, 1)) {
                    return null;
                }
            }
            case 0x90; {
                if (!mbRead(*bufInput, *extendedType)) {
                    return null;
                }

                token.data = extendedType;

                if (!mbSkip(*bufInput, 1)) {
                    return null;
                }

                if (!mbReadUIntVar(*bufInput, *intVar)) {
                    return null;
                }

                token = append(*lstTokens, tokenTime + cast(s32) intVar * 3, tokenType);
                token.data = extendedType;
                token.buffer = cast(*u8) 0;
            }
            case 0xF0; {
                extendedType = 0;

                if (tokenType == 0xFF) {
                    if (!mbRead(*bufInput, *extendedType)) {
                        return null;
                    }

                    if (extendedType == 0x2F) {
                        end = true;
                    } else if (extendedType == 0x51) {
                        if (!tempoSet) {
                            if (!mbSkip(*bufInput, 1)) {
                                return null;
                            }
                            if (!mbReadInt24BE(*bufInput, *tempo)) {
                                return null;
                            }
                            tempo *= 3;
                            tempoSet = true;
                            if (!mbSkip(*bufInput, -4)) {
                                return null;
                            }
                        } else {
                            removeAt(*lstTokens, lstTokens.count - 1);
                            if (!mbReadUIntVar(*bufInput, *intVar)) {
                                return null;
                            }
                            if (!mbSkip(*bufInput, intVar)) {
                                return null;
                            }
                            break;
                        }
                    }
                }

                token.data = extendedType;
                if (!mbReadUIntVar(*bufInput, *token.bufferLength)) {
                    return null;
                }
                token.buffer = bufInput._pointer;
                if (!mbSkip(*bufInput, token.bufferLength)) {
                    return null;
                }
            }
        }
    }

    if (lstTokens.count == 0) {
        return null;
    }
    if (!mbWriteString(*bufOutput, "MThd\0\0\0\x06\0\0\0\x01")) {
        return null;
    }
    if (!mbWriteUInt16BE(*bufOutput, cast(u16) ((tempo * 3) / 25000))) {
        return null;
    }
    if (!mbWriteString(*bufOutput, "MTrk\xBA\xAD\xF0\x0D")) {
        return null;
    }

    sort(*lstTokens, (left, right) => cast(s64) (left.time - right.time));

    tokenTime = 0;
    tokenType = 0;
    end = false;

    for t, i : lstTokens {
        if (end) {
            break;
        }

        if (!mbWriteUIntVar(*bufOutput, cast(u32) (t.time - tokenTime))) {
            return null;
        }

        tokenTime = t.time;

        if (t.type >= 0xF0) {
            tokenType = t.type;
            if (!mbWrite(*bufOutput, tokenType)) {
                return null;
            }

            if (tokenType == 0xFF) {
                if (!mbWrite(*bufOutput, t.data)) {
                    return null;
                }

                if (t.data == 0x2F) {
                    end = true;
                }
            }

            if (!mbWriteUIntVar(*bufOutput, t.bufferLength)) {
                return null;
            }
            if (!mbWriteBytes(*bufOutput, t.buffer, t.bufferLength)) {
                return null;
            }
        } else {
            if (t.type != tokenType) {
                tokenType = t.type;

                if (!mbWrite(*bufOutput, tokenType)) {
                    return null;
                }
            }

            if (!mbWrite(*bufOutput, t.data)) {
                return null;
            }

            if (t.buffer) {
                if (!mbWriteBytes(*bufOutput, t.buffer, 1)) {
                    return null;
                }
            }
        }
    }

    length: u32 = cast(u32) mbPosition(*bufOutput) - 22;
    if (!mbSeek(*bufOutput, 18)) {
        return null;
    }
    if (!mbWriteUInt32BE(*bufOutput, length)) {
        return null;
    }

    midLength64: s64;
    midData := mbGetData(*bufOutput, *midLength64);
    <<midLength = cast(u32) midLength64;
    return midData;
}

changeSampleRate :: (samplesIn: *u8, length: s32, factor: s32) -> *u8 {
    assert(factor >= 1);

    newLength := length * factor;
    samplesOut := alloc(u8, newLength);

    samplesOut[0] = samplesIn[0];

    j: s32 = 0;
    for i : 1..length-1 {
        a := samplesIn[i - 1];
        b := samplesIn[i];

        dt: f32 = 1.0 / factor;
        for k : 0..factor-2 {
            // linear interpolation: a + (b - a) * t
            t: f32 = dt * (k + 1);
            samplesOut[j] = cast(u8) (a + (b - a) * t);
            j += 1;
        }
        samplesOut[j] = b;
        j += 1;
    }

    return samplesOut;
}

#scope_file

MidiToken :: struct {
    time: s32;
    bufferLength: u32;
    buffer: *u8;
    type: u8;
    data: u8;
}

append :: (list: *List(MidiToken), time: s32, type: u8) -> *MidiToken {
    token: MidiToken;
    token.time = time;
    token.type = type;
    add(list, token);
    return *list.items[list.count - 1];
}