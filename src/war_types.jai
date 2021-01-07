WarMouseButtons :: enum {
    MOUSE_LEFT;
    MOUSE_RIGHT;

    MOUSE_COUNT;
}

WarKeys :: enum {
    KEY_NONE;

    KEY_SPACE;
    KEY_APOSTROPHE;
    KEY_ASTERISK;
    KEY_PLUS;
    KEY_COMMA;
    KEY_MINUS;
    KEY_PERIOD;
    KEY_SLASH;

    KEY_0;
    KEY_1;
    KEY_2;
    KEY_3;
    KEY_4;
    KEY_5;
    KEY_6;
    KEY_7;
    KEY_8;
    KEY_9;

    KEY_SEMICOLON;
    KEY_EQUAL;

    KEY_A;
    KEY_B;
    KEY_C;
    KEY_D;
    KEY_E;
    KEY_F;
    KEY_G;
    KEY_H;
    KEY_I;
    KEY_J;
    KEY_K;
    KEY_L;
    KEY_M;
    KEY_N;
    KEY_O;
    KEY_P;
    KEY_Q;
    KEY_R;
    KEY_S;
    KEY_T;
    KEY_U;
    KEY_V;
    KEY_W;
    KEY_X;
    KEY_Y;
    KEY_Z;

    KEY_LEFT_BRACKET;
    KEY_BACKSLASH;
    KEY_RIGHT_BRACKET;
    KEY_GRAVE_ACCENT;

    KEY_ESC;
    KEY_ENTER;
    KEY_TAB;
    KEY_BACKSPACE;
    KEY_INSERT;
    KEY_DELETE;

    KEY_RIGHT;
    KEY_LEFT;
    KEY_DOWN;
    KEY_UP;

    KEY_PAGE_UP;
    KEY_PAGE_DOWN;
    KEY_HOME;
    KEY_END;

    KEY_F1;
    KEY_F2;
    KEY_F3;
    KEY_F4;
    KEY_F5;
    KEY_F6;
    KEY_F7;
    KEY_F8;
    KEY_F9;
    KEY_F10;
    KEY_F11;
    KEY_F12;

    KEY_SHIFT;
    KEY_CTRL;
    KEY_ALT;

    KEY_COUNT;
}

WarKeyButtonState :: struct {
    // indicates if the key is pressed in the current frame
    pressed: bool;

    // indicate if the key was pressed in the previous frame
    wasPressed: bool;
}

WarInput :: struct {
    // current mouse position
    pos: Vec2;

    // state of the mouse buttons
    buttons: [WarMouseButtons.MOUSE_COUNT] WarKeyButtonState;

    // state of the keys
    keys: [WarKeys.KEY_COUNT] WarKeyButtonState;

    // drag
    isDragging: bool;
    wasDragging: bool;
    dragPos: Vec2;
    dragRect: Rect;
}

WarContext :: struct {
    time: f32;
    deltaTime: f32;
    fps: u32;

    paused: bool;

    globalScale: f32;
    globalSpeed: f32;

    originalWindowWidth: s32;
    originalWindowHeight: s32;
    windowWidth: s32;
    windowHeight: s32;
    framebufferWidth: s32;
    framebufferHeight: s32;
    devicePixelRatio: f32;
    windowTitle: string;
    window: *GLFWwindow;

    // warFile: *WarFile;
    // resources: [MAX_RESOURCES_COUNT] *WarResource;
    // fontSprites: [2] WarSprite;

    gfx: *NVGcontext;

    // ma_device sfx;
    // tsf* soundFont;
    // // this is shortcut to disable all audios in the map
    // // to avoid crashes when freeing the map and the audio thread
    // // trying to reproduce audios
    audioEnabled: bool;
    musicEnabled: bool;
    soundEnabled: bool;
    musicVolume: f32;
    soundVolume: f32;

    cheatsEnabled: bool;

    // // this is a mutex used to make the deletion of the entities thread-safe
    // // since the audio thread will delete audio entities, that could lead
    // // to inconsistent states in the internal lists when the game try to also
    // // delete other entities.
    // pthread_mutex_t __mutex;

    input: WarInput;

    transitionDelay: f32;
    // scene: *WarScene;
    // nextScene: *WarScene;
    // map: *WarMap;
    // nextMap: *WarMap;
}
