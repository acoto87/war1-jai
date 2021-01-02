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

    // input: WarInput;

    transitionDelay: f32;
    // scene: *WarScene;
    // nextScene: *WarScene;
    // map: *WarMap;
    // nextMap: *WarMap;
}
