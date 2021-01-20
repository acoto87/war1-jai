WarRawResource :: struct {
    placeholder: bool;
    compressed: bool;
    offset: u32;
    compressedLength: u32;
    length: u32;
    index: u32;
    data: *u8;
}

WarFileType :: enum {
    Unknown;
    Demo;
    Retail;
}

WarFile :: struct {
    // File Header
    // Version          Archive ID          Number of Entries
    // PreRelease                           EF 01 00 00 (495)   little-endian
    // DOS Retail       18 00 00 00 (24)    47 02 00 00 (583)   little-endian
    // DOS Shareware    19 00 00 00 (25)    47 02 00 00 (583)   little-endian
    // Mac Retail       00 00 00 1A (26)    00 00 02 47 (583)   big-endian
    // Mac Shareware    00 00 00 19 (25)    00 00 02 47 (583)   big-endian
	archiveID: u32;
    numberOfEntries: u32;

    // File Table
    offsets: [MAX_RESOURCES_COUNT] u32;

    type: WarFileType;
    resources: [MAX_RESOURCES_COUNT] WarRawResource;
}

loadWarFile :: (ctx: *WarContext, filePath: string) -> *WarFile {
    file := fopen(toCString(filePath, tempAllocator), "rb");
    if (file == null) {
        print("Couldn't process the DATA.WAR file. The file doesn't exists.\n");
        return null;
    }
    defer fclose(file);

    fileLength := flength(file);

    warFile := alloc(WarFile);
    warFile.archiveID = fileReadU32(file);
    warFile.numberOfEntries = fileReadU32(file);

    if warFile.archiveID == {
        case 0x18; #through;
        case 0x1A;
            warFile.type = WarFileType.Retail;
        case 0x19;
            warFile.type = WarFileType.Demo;
        case;
            warFile.type = WarFileType.Unknown;
    }

    if (warFile.type == WarFileType.Unknown) {
        print("Couldn't process the DATA.WAR file. The file is not the RETAIL or DEMO version of the game.\n");
        return null;
    }

    fileReadBytes(cast(*u8) warFile.offsets.data, warFile.numberOfEntries * size_of(u32), file);

    for i : range(u32, 0, warFile.numberOfEntries) {
        // placeholders in demo versions
        if (warFile.offsets[i] == 0xFFFFFFFF ||
            warFile.offsets[i] == 0x00000000)
        {
            warFile.resources[i].placeholder = true;
            continue;
        }

        compressedLength: u32;

        if (i == warFile.numberOfEntries - 1) {
            compressedLength = cast(u32) fileLength - warFile.offsets[i];
        } else {
            j := i + 1;
            nextOffset := warFile.offsets[j];
            while (nextOffset == 0xFFFFFFFF || nextOffset == 0x00000000) {
                if (j + 1 >= warFile.numberOfEntries) {
                    nextOffset = cast(u32) fileLength;
                    break;
                }

                j += 1;
                nextOffset = warFile.offsets[j];
            }

            compressedLength = nextOffset - warFile.offsets[i];
        }

        fseek(file, warFile.offsets[i], SEEK_SET);

        size := fileReadU32(file);
        length := (size & 0x1FFFFFFF);
        compressed := (size & 0xE0000000) != 0;

        data := alloc(u8, length);
        if (!compressed) {
            fileReadBytes(data, length, file);
        } else {
/*
decompression algorithm as described in
The File Formats of WarCraft: Orcs & Humans December 4, 2015
http://www.blizzardarchive.com/pub/Misc/Wc1Book_041215.pdf

for o:=0 to 4095 do
bufwin[o] := 0; // init our 4096 byte buffer with zero

i :=0;

while (i < filesize) do
begin;
warfile.read(cmask, 1);
i := i + 1;
for a:=0 to 7 do
begin;
if (cmask mod 2 = 1) then // uncompressed byte
begin;
    warfile.read(bufbyte, 1);
    bufwin[tmp.position mod 4096] := bufbyte;
    tmp.write(bufbyte, 1);
    i := i + 1;
end;
else // compressed block begin;
    warfile.read(offset, 2);
    numbytes := offset div 4096;
    offset := offset mod 4096;
    i := i + 2;
    for m := 0 to numbytes + 2 do
    begin;
        bufbyte := bufwin[(offset + m) mod 4096];
        bufwin[(tmp.position) mod 4096] := bufbyte;
        tmp.write(bufbyte, 1);
    end;
end;
cmask := cmask div 2;
end;
end;

tmp.size := finalsize; // Crop the file, just in case
*/
            BUFWIN_SIZE :: 4096;

            bufwin: [BUFWIN_SIZE] u8;

            b: u32 = 0;
            bufwinPos: u32 = 0;

            while (b < compressedLength) {
                cmask := fileReadU8(file);
                b += 1;

                a: s32 = 0;
                while (a < 8 && bufwinPos < length) {
                    if (cmask % 2 == 1) {
                        // uncompressed byte
                        bufbyte := fileReadU8(file);
                        b += 1;

                        bufwin[bufwinPos % BUFWIN_SIZE] = bufbyte;
                        data[bufwinPos] = bufbyte;
                        bufwinPos += 1;
                    } else {
                        // compressed block begin
                        offset := fileReadU16(file);
                        numbytes := offset / BUFWIN_SIZE;
                        offset = offset % BUFWIN_SIZE;
                        b += 2;

                        m: s32 = 0;
                        while (m <= numbytes + 2 && bufwinPos < length) {
                            bufbyte := bufwin[(offset + m) % BUFWIN_SIZE];

                            bufwin[bufwinPos % BUFWIN_SIZE] = bufbyte;
                            data[bufwinPos] = bufbyte;
                            bufwinPos += 1;
                            m += 1;
                        }
                    }

                    cmask /= 2;
                    a += 1;
                }
            }
        }

        warFile.resources[i].placeholder = false;
        warFile.resources[i].index = i;
        warFile.resources[i].offset = warFile.offsets[i];
        warFile.resources[i].compressed = compressed;
        warFile.resources[i].compressedLength = compressedLength;
        warFile.resources[i].length = length;
        warFile.resources[i].data = data;
    }

    return warFile;
}

#scope_file

DEFAULT_BUFFER_SIZE :: 1024;

flength :: (file: *FILE) -> s64 {
    pos := ftell(file);
    fseek(file, 0, SEEK_END);
    length := ftell(file);
    fseek(file, pos, SEEK_SET);
    return length;
}

fileReadBytes:: (bytes: *u8, length: s64, file: *FILE) {
    buffer: [DEFAULT_BUFFER_SIZE] u8;

    total := 0;
    sz := min(length, DEFAULT_BUFFER_SIZE);
    read := fread(buffer.data, size_of(u8), sz, file);
    while (read && total < length) {
        memoryCopy(bytes + total, buffer.data, read);
        total += read;

        sz = min(length - total, DEFAULT_BUFFER_SIZE);
        read = fread(buffer.data, size_of(u8), sz, file);
    }
}

fileReadU8 :: (file: *FILE) -> u8 {
    value: u8;
    fread(*value, size_of(u8), 1, file);
    return value;
}

fileReadU16 :: (file: *FILE) -> u16 {
    value: u16;
    fread(*value, size_of(u16), 1, file);
    return value;
}

fileReadU32 :: (file: *FILE) -> u32 {
    value: u32;
    fread(*value, size_of(u32), 1, file);
    return value;
}
