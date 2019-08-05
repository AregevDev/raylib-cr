require "./link"

link_flag

lib LibRaylib
  # ifndef

  PI = 3.14159265358979323846_f64

  DEG2RAD = PI / 180.0_f64
  RAD2DEG = 180.0_f64 / PI

  MAX_TOUCH_POINTS = 10_u32

  MAX_SHADER_LOCATIONS = 32_u32
  MAX_MATERIAL_MAPS    = 12_u32

  # {% if RL_MALLOC %}
  #  RL_MALLOC(sz) = LibC::malloc(sz)
  # {% end %}

  # {% if RL_CALLOC %}
  #  RL_CALLOC(n,sz) = LibC::calloc(n,sz)
  # {% end %}

  # {% if RL_FREE %}
  #  RL_FREE(p) = LibC::free(p)
  # {% end %}#

  LIGHTGRAY  = Color.new r: 200, g: 200, b: 200, a: 255
  GRAY       = Color.new r: 130, g: 130, b: 130, a: 255
  DARKGRAY   = Color.new r: 80, g: 80, b: 80, a: 255
  YELLOW     = Color.new r: 253, g: 249, b: 0, a: 255
  GOLD       = Color.new r: 255, g: 203, b: 0, a: 255
  ORANGE     = Color.new r: 255, g: 161, b: 0, a: 255
  PINK       = Color.new r: 255, g: 109, b: 194, a: 255
  RED        = Color.new r: 230, g: 41, b: 55, a: 255
  MAROON     = Color.new r: 190, g: 33, b: 55, a: 255
  GREEN      = Color.new r: 0, g: 228, b: 48, a: 255
  LIME       = Color.new r: 0, g: 158, b: 47, a: 255
  DARKGREEN  = Color.new r: 0, g: 117, b: 44, a: 255
  SKYBLUE    = Color.new r: 102, g: 191, b: 255, a: 255
  BLUE       = Color.new r: 0, g: 121, b: 241, a: 255
  DARKBLUE   = Color.new r: 0, g: 82, b: 172, a: 255
  PURPLE     = Color.new r: 200, g: 122, b: 255, a: 255
  VIOLET     = Color.new r: 135, g: 60, b: 190, a: 255
  DARKPURPLE = Color.new r: 112, g: 31, b: 126, a: 255
  BEIGE      = Color.new r: 211, g: 176, b: 131, a: 255
  BROWN      = Color.new r: 127, g: 106, b: 79, a: 255
  DARKBROWN  = Color.new r: 76, g: 63, b: 47, a: 255
  WHITE      = Color.new r: 255, g: 255, b: 255, a: 255
  BLACK      = Color.new r: 0, g: 0, b: 0, a: 255
  BLANK      = Color.new r: 0, g: 0, b: 0, a: 0
  MAGENTA    = Color.new r: 255, g: 0, b: 255, a: 255
  RAYWHITE   = Color.new r: 245, g: 245, b: 245, a: 255

  FormatText = TextFormat
  SubText    = TextsubText
  ShowWindow = UnhideWindow

  # bool type

  struct Vector2
    x : Float32
    y : Float32
  end

  struct Vector3
    x : Float32
    y : Float32
    z : Float32
  end

  struct Vector4
    x : Float32
    y : Float32
    z : Float32
    w : Float32
  end

  alias Quaternion = Vector4

  struct Matrix
    m0 : Float32
    m4 : Float32
    m8 : Float32
    m12 : Float32
    m1 : Float32
    m5 : Float32
    m9 : Float32
    m13 : Float32
    m2 : Float32
    m6 : Float32
    m10 : Float32
    m14 : Float32
    m3 : Float32
    m7 : Float32
    m11 : Float32
    m15 : Float32
  end

  struct Color
    r : UInt8
    g : UInt8
    b : UInt8
    a : UInt8
  end

  struct Rectangle
    x : Float32
    y : Float32
    width : Float32
    height : Float32
  end

  struct Image
    data : Void*
    width : Int32
    height : Int32
    mipmaps : Int32
    format : Int32
  end

  struct Texture2D
    id : UInt32
    width : Int32
    height : Int32
    mipmaps : Int32
    format : Int32
  end

  alias Texture = Texture2D

  alias TextureCubemap = Texture2D

  struct RenderTexture2D
    id : UInt32
    texture : Texture2D
    depth : Texture2D
    depthTexture : Bool
  end

  alias RenderTexture = RenderTexture2D

  struct NPatchInfo
    sourceRec : Rectangle
    left : Int32
    top : Int32
    right : Int32
    bottom : Int32
    type : Int32
  end

  struct CharInfo
    value : Int32
    rec : Rectangle
    offestX : Int32
    offestY : Int32
    advanceX : Int32
    data : UInt8*
  end

  struct Font
    texture : Texture2D
    baseSize : Int32
    charsCount : Int32
    chars : CharInfo*
  end

  alias SpriteFont = Font

  struct Camera3D
    position : Vector3
    target : Vector3
    up : Vector3
    fovy : Float32
    type : Int32
  end

  struct Camera2D
    offest : Vector2
    target : Vector2
    rotation : Float32
    zoom : Float32
  end

  struct Mesh
    vertexCount : Int32
    triangleCount : Int32
    vertices : Float32*
    texcoords : Float32*
    texcoords2 : Float32*
    normals : Float32*
    tangents : Float32*
    colors : UInt8*
    indices : UInt16*
    animVerticies : Float32*
    animNormals : Float32*
    boneIds : Int32
    boneWeights : Float32*
    vaoId : UInt32*
    vboId : StaticArray(UInt32, 7)
  end

  struct Shader
    id : UInt32
    locs : StaticArray(Int32, MAX_SHADER_LOCATIONS)
  end

  struct MaterialMap
    texture : Texture2D
    color : Color
    value : Float32
  end

  struct Material
    shader : Shader
    maps : StaticArray(MaterialMap, MAX_MATERIAL_MAPS)
    params : Float32*
  end

  struct Transform
    translation : Vector3
    rotation : Quaternion
    scale : Vector3
  end

  struct BoneInfo
    name : StaticArray(Int8, 32)
    parent : Int32
  end

  struct Model
    transform : Matrix
    meshCount : Mesh
    meshes : Mesh*
    materialCount : Int32
    materials : Material*
    meshMaterial : Int32*
    bones : BoneInfo*
    bindPose : Transform*
  end

  struct ModelAnimation
    boneCount : Int32
    bones : BoneInfo*
    frameCount : Int32
    framePoses : Transform**
  end

  struct Ray
    position : Vector3
    direction : Vector3
  end

  struct RayHitInfo
    hit : Bool
    distance : Float32
    position : Vector3
    normal : Vector3
  end

  struct BoundingBox
    min : Vector3
    max : Vector3
  end

  struct Wave
    sampleCount : UInt32
    sampleRate : UInt32
    sampleSize : UInt32
    channels : UInt32
    data : Void*
  end

  struct Sound
    audioBuffer : Void*
    source : UInt32
    buffer : UInt32
    format : Int32
  end

  struct MusicData
    _unused : StaticArray(UInt8, 0)
  end

  alias Music = MusicData*

  struct AudioStream
    sampleRate : UInt32
    sampleSize : UInt32
    channels : UInt32
    audioBuffer : Void*
    format : Int32
    source : UInt32
    buffers : StaticArray(UInt32, 2)
  end

  struct VrDeviceInfo
    hResolution : Int32
    vResolution : Int32
    hScreenSize : Float32
    vScreenSize : Float32
    vScreenCenter : Float32
    eyeToScreenDistance : Float32
    lensSeparationDistance : Float32
    interpupillaryDistance : Float32
    lensDistortionValues : StaticArray(Float32, 4)
    chromaAbCorrection : StaticArray(Float32, 4)
  end

  enum ConfigFlag
    FLAG_SHOW_LOGO          =   1
    FLAG_FULLSCREEN_MODE    =   2
    FLAG_WINDOW_RESIZABLE   =   4
    FLAG_WINDOW_UNDECORATED =   8
    FLAG_WINDOW_TRANSPARENT =  16
    FLAG_WINDOW_HIDDEN      = 128
    FLAG_MSAA_4X_HINT       =  32
    FLAG_VSYNC_HINT         =  64
  end

  enum TraceLogType
    LOG_ALL     = 0
    LOG_TRACE   = 1
    LOG_DEBUG   = 2
    LOG_INFO    = 3
    LOG_WARNING = 4
    LOG_ERROR   = 5
    LOG_FATAL   = 6
    LOG_NONE    = 7
  end

  enum KeyboardKey
    KEY_APOSTROPHE    =  39
    KEY_COMMA         =  44
    KEY_MINUS         =  45
    KEY_PERIOD        =  46
    KEY_SLASH         =  47
    KEY_ZERO          =  48
    KEY_ONE           =  49
    KEY_TWO           =  50
    KEY_THREE         =  51
    KEY_FOUR          =  52
    KEY_FIVE          =  53
    KEY_SIX           =  54
    KEY_SEVEN         =  55
    KEY_EIGHT         =  56
    KEY_NINE          =  57
    KEY_SEMICOLON     =  59
    KEY_EQUAL         =  61
    KEY_A             =  65
    KEY_B             =  66
    KEY_C             =  67
    KEY_D             =  68
    KEY_E             =  69
    KEY_F             =  70
    KEY_G             =  71
    KEY_H             =  72
    KEY_I             =  73
    KEY_J             =  74
    KEY_K             =  75
    KEY_L             =  76
    KEY_M             =  77
    KEY_N             =  78
    KEY_O             =  79
    KEY_P             =  80
    KEY_Q             =  81
    KEY_R             =  82
    KEY_S             =  83
    KEY_T             =  84
    KEY_U             =  85
    KEY_V             =  86
    KEY_W             =  87
    KEY_X             =  88
    KEY_Y             =  89
    KEY_Z             =  90
    KEY_SPACE         =  32
    KEY_ESCAPE        = 256
    KEY_ENTER         = 257
    KEY_TAB           = 258
    KEY_BACKSPACE     = 259
    KEY_INSERT        = 260
    KEY_DELETE        = 261
    KEY_RIGHT         = 262
    KEY_LEFT          = 263
    KEY_DOWN          = 264
    KEY_UP            = 265
    KEY_PAGE_UP       = 266
    KEY_PAGE_DOWN     = 267
    KEY_HOME          = 268
    KEY_END           = 269
    KEY_CAPS_LOCK     = 280
    KEY_SCROLL_LOCK   = 281
    KEY_NUM_LOCK      = 282
    KEY_PRINT_SCREEN  = 283
    KEY_PAUSE         = 284
    KEY_F1            = 290
    KEY_F2            = 291
    KEY_F3            = 292
    KEY_F4            = 293
    KEY_F5            = 294
    KEY_F6            = 295
    KEY_F7            = 296
    KEY_F8            = 297
    KEY_F9            = 298
    KEY_F10           = 299
    KEY_F11           = 300
    KEY_F12           = 301
    KEY_LEFT_SHIFT    = 340
    KEY_LEFT_CONTROL  = 341
    KEY_LEFT_ALT      = 342
    KEY_LEFT_SUPER    = 343
    KEY_RIGHT_SHIFT   = 344
    KEY_RIGHT_CONTROL = 345
    KEY_RIGHT_ALT     = 346
    KEY_RIGHT_SUPER   = 347
    KEY_KB_MENU       = 348
    KEY_LEFT_BRACKET  =  91
    KEY_BACKSLASH     =  92
    KEY_RIGHT_BRACKET =  93
    KEY_GRAVE         =  96
    KEY_KP_0          = 320
    KEY_KP_1          = 321
    KEY_KP_2          = 322
    KEY_KP_3          = 323
    KEY_KP_4          = 324
    KEY_KP_5          = 325
    KEY_KP_6          = 326
    KEY_KP_7          = 327
    KEY_KP_8          = 328
    KEY_KP_9          = 329
    KEY_KP_DECIMAL    = 330
    KEY_KP_DIVIDE     = 331
    KEY_KP_MULTIPLY   = 332
    KEY_KP_SUBTRACT   = 333
    KEY_KP_ADD        = 334
    KEY_KP_ENTER      = 335
    KEY_KP_EQUAL      = 336
  end

  enum AndroidButton
    KEY_BACK        =  4
    KEY_MENU        = 82
    KEY_VOLUME_UP   = 24
    KEY_VOLUME_DOWN = 25
  end

  enum MouseButton
    MOUSE_LEFT_BUTTON   = 0
    MOUSE_RIGHT_BUTTON  = 1
    MOUSE_MIDDLE_BUTTON = 2
  end

  enum GamepadNumber
    GAMEPAD_PLAYER1 = 0
    GAMEPAD_PLAYER2 = 1
    GAMEPAD_PLAYER3 = 2
    GAMEPAD_PLAYER4 = 3
  end

  enum GamepadButton
    GAMEPAD_BUTTON_UNKNOWN          =  0
    GAMEPAD_BUTTON_LEFT_FACE_UP     =  1
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT  =  2
    GAMEPAD_BUTTON_LEFT_FACE_DOWN   =  3
    GAMEPAD_BUTTON_LEFT_FACE_LEFT   =  4
    GAMEPAD_BUTTON_RIGHT_FACE_UP    =  5
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT =  6
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN  =  7
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT  =  8
    GAMEPAD_BUTTON_LEFT_TRIGGER_1   =  9
    GAMEPAD_BUTTON_LEFT_TRIGGER_2   = 10
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1  = 11
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2  = 12
    GAMEPAD_BUTTON_MIDDLE_LEFT      = 13
    GAMEPAD_BUTTON_MIDDLE           = 14
    GAMEPAD_BUTTON_MIDDLE_RIGHT     = 15
    GAMEPAD_BUTTON_LEFT_THUMB       = 16
    GAMEPAD_BUTTON_RIGHT_THUMB      = 17
  end

  enum GamepadAxis
    GAMEPAD_AXIS_UNKNOWN       = 0
    GAMEPAD_AXIS_LEFT_X        = 1
    GAMEPAD_AXIS_LEFT_Y        = 2
    GAMEPAD_AXIS_RIGHT_X       = 3
    GAMEPAD_AXIS_RIGHT_Y       = 4
    GAMEPAD_AXIS_LEFT_TRIGGER  = 5
    GAMEPAD_AXIS_RIGHT_TRIGGER = 6
  end

  enum ShaderLocationIndex
    LOC_VERTEX_POSITION   =  0
    LOC_VERTEX_TEXCOORD01 =  1
    LOC_VERTEX_TEXCOORD02 =  2
    LOC_VERTEX_NORMAL     =  3
    LOC_VERTEX_TANGENT    =  4
    LOC_VERTEX_COLOR      =  5
    LOC_MATRIX_MVP        =  6
    LOC_MATRIX_MODEL      =  7
    LOC_MATRIX_VIEW       =  8
    LOC_MATRIX_PROJECTION =  9
    LOC_VECTOR_VIEW       = 10
    LOC_COLOR_DIFFUSE     = 11
    LOC_COLOR_SPECULAR    = 12
    LOC_COLOR_AMBIENT     = 13
    LOC_MAP_ALBEDO        = 14
    LOC_MAP_METALNESS     = 15
    LOC_MAP_NORMAL        = 16
    LOC_MAP_ROUGHNESS     = 17
    LOC_MAP_OCCLUSION     = 18
    LOC_MAP_EMISSION      = 19
    LOC_MAP_HEIGHT        = 20
    LOC_MAP_CUBEMAP       = 21
    LOC_MAP_IRRADIANCE    = 22
    LOC_MAP_PREFILTER     = 23
    LOC_MAP_BRDF          = 24
  end

  enum ShaderUniformDataType
    UNIFORM_FLOAT     = 0
    UNIFORM_VEC2      = 1
    UNIFORM_VEC3      = 2
    UNIFORM_VEC4      = 3
    UNIFORM_INT       = 4
    UNIFORM_IVEC2     = 5
    UNIFORM_IVEC3     = 6
    UNIFORM_IVEC4     = 7
    UNIFORM_SAMPLER2D = 8
  end

  enum MaterialMapType
    MAP_ALBEDO     =  0
    MAP_METALNESS  =  1
    MAP_NORMAL     =  2
    MAP_ROUGHNESS  =  3
    MAP_OCCLUSION  =  4
    MAP_EMISSION   =  5
    MAP_HEIGHT     =  6
    MAP_CUBEMAP    =  7
    MAP_IRRADIANCE =  8
    MAP_PREFILTER  =  9
    MAP_BRDF       = 10
  end

  enum PixelFormat
    UNCOMPRESSED_GRAYSCALE    =  1
    UNCOMPRESSED_GRAY_ALPHA   =  2
    UNCOMPRESSED_R5G6B5       =  3
    UNCOMPRESSED_R8G8B8       =  4
    UNCOMPRESSED_R5G5B5A1     =  5
    UNCOMPRESSED_R4G4B4A4     =  6
    UNCOMPRESSED_R8G8B8A8     =  7
    UNCOMPRESSED_R32          =  8
    UNCOMPRESSED_R32G32B32    =  9
    UNCOMPRESSED_R32G32B32A32 = 10
    COMPRESSED_DXT1_RGB       = 11
    COMPRESSED_DXT1_RGBA      = 12
    COMPRESSED_DXT3_RGBA      = 13
    COMPRESSED_DXT5_RGBA      = 14
    COMPRESSED_ETC1_RGB       = 15
    COMPRESSED_ETC2_RGB       = 16
    COMPRESSED_ETC2_EAC_RGBA  = 17
    COMPRESSED_PVRT_RGB       = 18
    COMPRESSED_PVRT_RGBA      = 19
    COMPRESSED_ASTC_4x4_RGBA  = 20
    COMPRESSED_ASTC_8x8_RGBA  = 21
  end

  enum TextureFilterMode
    FILTER_POINT           = 0
    FILTER_BILINEAR        = 1
    FILTER_TRILINEAR       = 2
    FILTER_ANISOTROPIC_4X  = 3
    FILTER_ANISOTROPIC_8X  = 4
    FILTER_ANISOTROPIC_16X = 5
  end

  enum CubemapLayoutType
    CUBEMAP_AUTO_DETECT         = 0
    CUBEMAP_LINE_VERTICAL       = 1
    CUBEMAP_LINE_HORIZONTAL     = 2
    CUBEMAP_CROSS_THREE_BY_FOUR = 3
    CUBEMAP_CROSS_FOUR_BY_THREE = 4
    CUBEMAP_PANORAMA            = 5
  end

  enum TextureWrapMode
    WRAP_REPEAT        = 0
    WRAP_CLAMP         = 1
    WRAP_MIRROR_REPEAT = 2
    WRAP_MIRROR_CLAMP  = 3
  end

  enum FontType
    FONT_DEFAULT = 0
    FONT_BITMAP  = 1
    FONT_SDF     = 2
  end

  enum BlendMode
    BLEND_ALPHA      = 0
    BLEND_ADDITIVE   = 1
    BLEND_MULTIPLIED = 2
  end

  enum GestureType
    GESTURE_NONE        =   0
    GESTURE_TAP         =   1
    GESTURE_DOUBLETAP   =   2
    GESTURE_HOLD        =   4
    GESTURE_DRAG        =   8
    GESTURE_SWIPE_RIGHT =  16
    GESTURE_SWIPE_LEFT  =  32
    GESTURE_SWIPE_UP    =  64
    GESTURE_SWIPE_DOWN  = 128
    GESTURE_PINCH_IN    = 256
    GESTURE_PINCH_OUT   = 512
  end

  enum CameraMode
    CAMERA_CUSTOM       = 0
    CAMERA_FREE         = 1
    CAMERA_ORBITAL      = 2
    CAMERA_FIRST_PERSON = 3
    CAMERA_THIRD_PERSON = 4
  end

  enum CameraType
    CAMERA_PERSPECTIVE  = 0
    CAMERA_ORTHOGRAPHIC = 1
  end

  enum NPatchType
    NPT_9PATCH            = 0
    NPT_3PATCH_VERTICAL   = 1
    NPT_3PATCH_HORIZONTAL = 2
  end

  # TraceLogCallback = Proc(Int32, UInt8, LibC::va_args) -> Void

  # Window related functions
  fun init_window = InitWindow(width : Int32, height : Int32, title : UInt8*)
  fun window_should_close = WindowShouldClose : Bool
  fun close_window = CloseWindow
  fun window_ready? = IsWindowReady : Bool
  fun window_minimized? = IsWindowMinimized : Bool
  fun window_hidden? = IsWindowHidden : Bool
  fun toggle_fullscreen = ToggleFullscreen
  fun unhide_window = UnhideWindow
  fun hide_window = HideWindow
  fun set_window_icon = SetWindowIcon(image : Image)
  fun set_window_title = SetWindowTitle(title : UInt8*)
  fun set_window_position = SetWindowPosition(x : Int32, y : Int32)
  fun set_window_monitor = SetWindowMonitor(monitor : Int32)
  fun set_window_min_size = SetWindowMinSize(width : Int32, height : Int32)
  fun set_window_size = SetWindowSize(width : Int32, height : Int32)
  fun get_window_handle = GetWindowHandle : Void*
  fun get_screen_width = GetScreenWidth : Int32
  fun set_window_height = GetScreenHeight : Int32
  fun get_monitor_count = GetMonitorCount : Int32
  fun get_monitor_width = GetMonitorWidth(monitor : Int32) : Int32
  fun get_monitor_height = GetMonitorHeight(monitor : Int32) : Int32
  fun get_monitor_physical_width = GetMonitorPhysicalWidth(monitor : Int32) : Int32
  fun get_monitor_physical_height = GetMonitorPhysicalHeight(monitor : Int32) : Int32
  fun get_monitor_name = GetMonitorName(monitor : Int32) : UInt8*
  fun get_clipboard_text = GetClipBoardText : UInt8*
  fun set_clipboard_text = SetClipBoardText(text : UInt8*)

  # Continue here!

  fun show_cursor = ShowCursor

  fun hide_cursor = HideCursor

  fun cursor_hidden? = IsCursorHidden : Bool

  fun enable_cursor = EnableCursor

  fun disable_cursor = DisableCursor
  
  fun clear_background = ClearBackground(color : Color)

  fun begin_drawing = BeginDrawing

  fun end_drawing = EndDrawing

  fun begin_mode_2d = BeginMode2D(camera : Camera2D)

  fun end_mode_2d = EndMode2D

  fun begin_mode_3d = BeginMode3D(camera : Camera3D)

  fun end_mode_3d = EndMode3D

  fun begin_texture_mode = BeginTextureMode(target : RenderTexture2D)

  fun end_texture_mode = EndTextureMode

  fun get_mouse_ray = GetMouseRay(mousePosition : Vector2, camera : Camera3D) : Ray

  fun get_world_to_screen = GetWorldToScreen(position : Vector3, camera : Camera3D) : Vector2

  fun get_camera_matrix = GetCameraMatrix(camera : Camera3D) : Matrix

  fun set_target_fps = SetTargetFPS(fps : Int32)

  fun get_fps = GetFPS : Int32

  fun get_frame_time = GetFrameTime : Float32

  fun get_time = GetTime : Float64

  fun color_to_int = ColorToInt(color : Color) : Int32

  fun color_normalize = ColorNormalize(color : Color) : Vector4

  fun color_to_hsv = ColorToHSV(color : Color) : Vector3

  fun get_color = GetColor(hexValue : Int32) : Color

  fun fade = Fade(color : Color, alpha : Float32) : Color

  fun show_logo = ShowLogo

  fun set_config_flags = SetConfigFlags(flags : UInt8)

  fun set_trace_log = SetTraceLog(types : UInt8)

  fun trace_log = TraceLog(logType : Int32, text : UInt8*, ...)

  fun take_screenshot = TakeScreenshot(fileName : UInt8*)

  fun get_random_value = GetRandomValue(
    min : Int32,
    max : Int32
  ) : Int32

  fun file_extension? = IsFileExtension(
    fileName : UInt8*,
    ext : UInt8*
  ) : Bool

  fun get_extension = GetExtension(fileName : UInt8*) : UInt8*

  fun get_file_name = GetFileName(filePath : UInt8*) : UInt8*

  fun get_directory_path = GetDirectoryPath(
    fileName : UInt8*
  ) : UInt8*

  fun get_working_directory = GetWorkingDirectory : UInt8*

  fun change_directory = ChangeDirectory(dir : UInt8*) : Bool

  fun file_dropped? = IsFileDropped : Bool

  fun get_dropped_files = GetDroppedFiles(count : Int32*) : UInt8**

  fun clear_dropped_files = ClearDroppedFiles

  fun storage_save_value = StorageSaveValue(position : Int32, value : Int32)

  fun storage_load_value = StorageLoadValue(position : Int32) : Int32

  fun key_pressed? = IsKeyPressed(key : Int32) : Bool

  fun key_down? = IsKeyDown(key : Int32) : Bool

  fun key_released? = IsKeyReleased(key : Int32) : Bool

  fun key_up? = IsKeyUp(key : Int32) : Bool

  fun get_key_pressed = GetKeyPressed : Int32

  fun set_exit_key = SetExitKey(key : Int32)

  fun gamepad_available? = IsGamepadAvailable(gamepad : Int32) : Bool

  fun gamepad_name? = IsGamepadName(
    gamepad : Int32,
    name : UInt8*
  ) : Bool

  fun get_gamepad_name = GetGamepadName(gamepad : Int32) : UInt8*

  fun gamepad_button_pressed? = IsGamepadButtonPressed(
    gamepad : Int32,
    button : Int32
  ) : Bool

  fun gamepad_button_down? = IsGamepadButtonDown(
    gamepad : Int32,
    button : Int32
  ) : Bool

  fun gamepad_button_released? = IsGamepadButtonReleased(
    gamepad : Int32,
    button : Int32
  ) : Bool

  fun gamepad_button_up? = IsGamepadButtonUp(gamepad : Int32, button : Int32) : Bool

  fun get_gamepad_button_pressed = GetGamepadButtonPressed : Int32

  fun get_gamepad_axis_count = GetGamepadAxisCount(gamepad : Int32) : Int32

  fun get_gamepad_axis_movement = GetGamepadAxisMovement(
    gamepad : Int32,
    axis : Int32
  ) : Float32

  fun mouse_button_pressed? = IsMouseButtonPressed(button : Int32) : Bool

  fun mouse_button_down? = IsMouseButtonDown(button : Int32) : Bool

  fun mouse_button_released? = IsMouseButtonReleased(button : Int32) : Bool

  fun mouse_button_up? = IsMouseButtonUp(button : Int32) : Bool

  fun get_mouse_x = GetMouseX : Int32

  fun get_mouse_y = GetMouseY : Int32

  fun get_mouse_position = GetMousePosition : Vector2

  fun set_mouse_position = SetMousePosition(position : Vector2)

  fun set_mouse_scale = SetMouseScale(scale : Float32)

  fun get_mouse_wheel_move = GetMouseWheelMove : Int32

  fun get_touch_x = GetTouchX : Int32

  fun get_touch_y = GetTouchY : Int32

  fun get_touch_position = GetTouchPosition(index : Int32) : Vector2

  fun set_gestures_enabled = SetGesturesEnabled(gestureFlags : UInt32)

  fun gesture_detected? = IsGestureDetected(gesture : Int32) : Bool

  fun get_gesture_detected = GetGestureDetected : Int32

  fun get_touch_points_count = GetTouchPointsCount : Int32

  fun get_gesture_hold_duration = GetGestureHoldDuration : Float32

  fun get_gesture_drag_vector = GetGestureDragVector : Vector2

  fun get_gesture_drag_angle = GetGestureDragAngle : Float32

  fun get_gesture_pinch_angle = GetGesturePinchVector : Vector2

  fun get_gesture_pinch_angle = GetGesturePinchAngle : Float32

  fun set_camera_mode = SetCameraMode(camera : Camera3D, mode : Int32)

  fun update_camera = UpdateCamera(camera : Camera3D*)

  fun set_camera_pan_control = SetCameraPanControl(panKey : Int32)

  fun set_camera_alt_control = SetCameraAltControl(altKey : Int32)

  fun set_camera_alt_control = SetCameraSmoothZoomControl(szKey : Int32)

  fun set_camera_move_controls = SetCameraMoveControls(
    frontKey : Int32,
    backKey : Int32,
    rightKey : Int32,
    leftKey : Int32,
    upKey : Int32,
    downKey : Int32
  )

  fun draw_pixel = DrawPixel(posX : Int32, posY : Int32, color : Color)

  fun draw_pixel_v = DrawPixelV(position : Vector2, color : Color)

  fun draw_line = DrawLine(
    startPosX : Int32,
    startPosY : Int32,
    endPosX : Int32,
    endPosY : Int32,
    color : Color
  )

  fun draw_line_v = DrawLineV(startPos : Vector2, endPos : Vector2, color : Color)

  fun draw_line_ex = DrawLineEx(startPos : Vector2, endPos : Vector2, thick : Float32, color : Color)

  fun draw_line_bezier = DrawLineBezier(startPos : Vector2, endPos : Vector2, thick : Float32, color : Color)

  fun draw_circle = DrawCircle(
    centerX : Int32,
    centerY : Int32,
    radius : Float32,
    color : Color
  )

  fun draw_circle_gradient = DrawCircleGradient(
    centerX : Int32,
    centerY : Int32,
    radius : Float32,
    color1 : Color,
    color2 : Color
  )

  fun draw_circle_v = DrawCircleV(center : Vector2, radius : Float32, color : Color)

  fun draw_circle_lines = DrawCircleLines(
    centerX : Int32,
    centerY : Int32,
    radius : Float32,
    color : Color
  )

  fun draw_rectangle = DrawRectangle(
    posX : Int32,
    posY : Int32,
    width : Int32,
    height : Int32,
    color : Color
  )

  fun draw_rectangle_v = DrawRectangleV(position : Vector2, size : Vector2, color : Color)

  fun draw_rectangle_rec = DrawRectangleRec(rec : Rectangle, color : Color)

  fun draw_rectangle_pro = DrawRectanglePro(rec : Rectangle, origin : Vector2, rotation : Float32, color : Color)

  fun draw_rectangle_gradient_v = DrawRectangleGradientV(
    posX : Int32,
    posY : Int32,
    width : Int32,
    height : Int32,
    color1 : Color,
    color2 : Color
  )

  fun draw_rectangle_gradient_h = DrawRectangleGradientH(
    posX : Int32,
    posY : Int32,
    width : Int32,
    height : Int32,
    color1 : Color,
    color2 : Color
  )

  fun draw_rectangle_gradient_h = DrawRectangleGradientEx(
    rec : Rectangle,
    col1 : Color,
    col2 : Color,
    col3 : Color,
    col4 : Color
  )

  fun draw_rectangle_lines = DrawRectangleLines(
    posX : Int32,
    posY : Int32,
    width : Int32,
    height : Int32,
    color : Color
  )

  fun draw_rectangle_lines_ex = DrawRectangleLinesEx(rec : Rectangle, lineThick : Int32, color : Color)

  fun draw_triangle = DrawTriangle(v1 : Vector2, v2 : Vector2, v3 : Vector2, color : Color)

  fun draw_triangle_lines = DrawTriangleLines(v1 : Vector2, v2 : Vector2, v3 : Vector2, color : Color)

  fun draw_poly = DrawPoly(
    center : Vector2,
    sides : Int32,
    radius : Float32,
    rotation : Float32,
    color : Color
  )

  fun draw_poly_ex = DrawPolyEx(points : Vector2*, numPoints : Int32, color : Color)

  fun draw_poly_ex_lines = DrawPolyExLines(points : Vector2*, numPoints : Int32, color : Color)

  fun check_collision_recs = CheckCollisionRecs(rec1 : Rectangle, rec2 : Rectangle) : Bool

  fun check_collision_circles = CheckCollisionCircles(
    center1 : Vector2,
    radius1 : Float32,
    center2 : Vector2,
    radius2 : Float32
  ) : Bool

  fun check_collision_circle_rec = CheckCollisionCircleRec(center : Vector2, radius : Float32, rec : Rectangle) : Bool

  fun get_collision_rec = GetCollisionRec(rec1 : Rectangle, rec2 : Rectangle) : Rectangle

  fun check_collision_point_rec = CheckCollisionPointRec(point : Vector2, rec : Rectangle) : Bool

  fun check_collision_point_circle = CheckCollisionPointCircle(point : Vector2, center : Vector2, radius : Float32) : Bool

  fun check_collision_point_triangle = CheckCollisionPointTriangle(
    point : Vector2,
    p1 : Vector2,
    p2 : Vector2,
    p3 : Vector2
  ) : Bool

  fun load_image = LoadImage(fileName : UInt8*) : Image

  fun load_image_ex = LoadImageEx(
    pixels : Color*,
    width : Int32,
    height : Int32
  ) : Image

  fun load_image_pro = LoadImagePro(
    data : Void*,
    width : Int32,
    height : Int32,
    format : Int32
  ) : Image

  fun load_image_raw = LoadImageRaw(
    fileName : UInt8*,
    width : Int32,
    height : Int32,
    format : Int32,
    headerSize : Int32
  ) : Image

  fun export_image = ExportImage(fileName : UInt8*, image : Image)

  fun load_texture = LoadTexture(fileName : UInt8*) : Texture2D

  fun load_texture_from_image = LoadTextureFromImage(image : Image) : Texture2D

  fun load_render_texture = LoadRenderTexture(
    width : Int32,
    height : Int32
  ) : RenderTexture2D

  fun unload_image = UnloadImage(image : Image)

  fun unload_texture = UnloadTexture(texture : Texture2D)

  fun unload_render_texture = UnloadRenderTexture(target : RenderTexture2D)

  fun get_image_data = GetImageData(image : Image) : Color*

  fun get_image_data_normalized = GetImageDataNormalized(image : Image) : Vector4*

  fun get_pixel_data_size = GetPixelDataSize(
    width : Int32,
    height : Int32,
    format : Int32
  ) : Int32

  fun get_texture_data = GetTextureData(texture : Texture2D) : Image

  fun update_texture = UpdateTexture(texture : Texture2D, pixels : Void*)

  fun image_copy = ImageCopy(image : Image) : Image

  fun imgae_to_pot = ImageToPOT(image : Image**, fillColor : Color)

  fun image_format = ImageFormat(image : Image**, newFormat : Int32)

  fun image_alpha_mask = ImageAlphaMask(image : Image**, alphaMask : Image)

  fun image_alpha_clear = ImageAlphaClear(image : Image**, color : Color, threshold : Float32)

  fun imgae_alpha_crop = ImageAlphaCrop(image : Image**, threshold : Float32)

  fun image_alpha_premultiply = ImageAlphaPremultiply(image : Image**)

  fun image_crop = ImageCrop(image : Image**, crop : Rectangle)

  fun image_resize = ImageResize(
    image : Image**,
    newWidth : Int32,
    newHeight : Int32
  )

  fun image_resize_nn = ImageResizeNN(
    image : Image**,
    newWidth : Int32,
    newHeight : Int32
  )

  fun image_resize_canvas = ImageResizeCanvas(
    image : Image**,
    newWidth : Int32,
    newHeight : Int32,
    offsetX : Int32,
    offsetY : Int32,
    color : Color
  )

  fun image_mipmaps = ImageMipmaps(image : Image**)

  fun image_dither = ImageDither(
    image : Image**,
    rBpp : Int32,
    gBpp : Int32,
    bBpp : Int32,
    aBpp : Int32
  )

  fun imgae_text = ImageText(
    text : UInt8*,
    fontSize : Int32,
    color : Color
  ) : Image

  fun imgae_text_ex = ImageTextEx(
    font : Font,
    text : UInt8*,
    fontSize : Float32,
    spacing : Float32,
    tint : Color
  ) : Image

  fun image_draw = ImageDraw(dst : Image**, src : Image, srcRec : Rectangle, dstRec : Rectangle)

  fun image_draw_rectangle = ImageDrawRectangle(dst : Image**, position : Vector2, rec : Rectangle, color : Color)

  fun image_draw_text = ImageDrawText(
    dst : Image**,
    position : Vector2,
    text : UInt8*,
    fontSize : Int32,
    color : Color
  )

  fun image_draw_text_ex = ImageDrawTextEx(
    dst : Image**,
    position : Vector2,
    font : Font,
    text : UInt8*,
    fontSize : Float32,
    spacing : Float32,
    color : Color
  )

  fun image_flip_vertical = ImageFlipVertical(image : Image**)

  fun image_flip_horizontal = ImageFlipHorizontal(image : Image**)

  fun image_rotate_cw = ImageRotateCW(image : Image*)

  fun image_rotate_ccw = ImageRotateCCW(image : Image*)

  fun imgae_color_tint = ImageColorTint(image : Image*, color : Color)

  fun imgae_color_invert = ImageColorInvert(image : Image*)

  fun imgae_color_grayscale = ImageColorGrayscale(image : Image*)

  fun imgae_color_contrast = ImageColorContrast(image : Image*, contrast : Float32)

  fun imgae_color_brightness = ImageColorBrightness(image : Image*, brightness : Int32)

  fun imgae_color_replace = ImageColorReplace(image : Image*, color : Color, replace : Color)

  fun gen_image_color = GenImageColor(
    width : Int32,
    height : Int32,
    color : Color
  ) : Image

  fun gen_image_gradient_v = GenImageGradientV(
    width : Int32,
    height : Int32,
    top : Color,
    bottom : Color
  ) : Image

  fun gen_image_gradient_h = GenImageGradientH(
    width : Int32,
    height : Int32,
    left : Color,
    right : Color
  ) : Image

  fun gen_image_gradient_radial = GenImageGradientRadial(
    width : Int32,
    height : Int32,
    density : Float32,
    inner : Color,
    outer : Color
  ) : Image

  fun gen_image_checked = GenImageChecked(
    width : Int32,
    height : Int32,
    checksX : Int32,
    checksY : Int32,
    col1 : Color,
    col2 : Color
  ) : Image

  fun gen_image_white_noise = GenImageWhiteNoise(
    width : Int32,
    height : Int32,
    factor : Float32
  ) : Image

  fun gen_image_perlin_noise = GenImagePerlinNoise(
    width : Int32,
    height : Int32,
    offsetX : Int32,
    offsetY : Int32,
    scale : Float32
  ) : Image

  fun gen_image_cellular = GenImageCellular(
    width : Int32,
    height : Int32,
    tileSize : Int32
  ) : Image

  fun gen_texture_mipmaps = GenTextureMipmaps(texture : Texture2D*)

  fun set_texture_filter = SetTextureFilter(texture : Texture2D, filterMode : Int32)

  fun set_texture_wrap = SetTextureWrap(texture : Texture2D, wrapMode : Int32)

  fun draw_texture = DrawTexture(
    texture : Texture2D,
    posX : Int32,
    posY : Int32,
    tint : Color
  )

  fun draw_texture_v = DrawTextureV(texture : Texture2D, position : Vector2, tint : Color)

  fun draw_texture_ex = DrawTextureEx(
    texture : Texture2D,
    position : Vector2,
    rotation : Float32,
    scale : Float32,
    tint : Color
  )

  fun draw_texture_rec = DrawTextureRec(texture : Texture2D, sourceRec : Rectangle, position : Vector2, tint : Color)

  fun draw_texture_pro = DrawTexturePro(
    texture : Texture2D,
    sourceRec : Rectangle,
    destRec : Rectangle,
    origin : Vector2,
    rotation : Float32,
    tint : Color
  )

  fun get_font_default = GetFontDefault : Font

  fun load_font = LoadFont(fileName : UInt8*) : Font

  fun load_font_ex = LoadFontEx(
    fileName : UInt8*,
    fontSize : Int32,
    charsCount : Int32,
    fontChars : Int32*
  ) : Font

  fun load_font_data = LoadFontData(
    fileName : UInt8*,
    fontSize : Int32,
    fontChars : Int32*,
    charsCount : Int32,
    sdf : Bool
  ) : CharInfo*

  fun gen_font_atlas = GenImageFontAtlas(
    chars : CharInfo*,
    fontSize : Int32,
    charsCount : Int32,
    padding : Int32,
    packMethod : Int32
  ) : Image

  fun unload_font = UnloadFont(font : Font)

  fun draw_fps = DrawFPS(posX : Int32, posY : Int32)

  fun draw_text = DrawText(
    text : UInt8*,
    posX : Int32,
    posY : Int32,
    fontSize : Int32,
    color : Color
  )

  fun draw_text_ex = DrawTextEx(
    font : Font,
    text : UInt8*,
    position : Vector2,
    fontSize : Float32,
    spacing : Float32,
    tint : Color
  )

  fun measure_text = MeasureText(
    text : UInt8*,
    fontSize : Int32
  ) : Int32

  fun measure_text_ex = MeasureTextEx(
    font : Font,
    text : UInt8*,
    fontSize : Float32,
    spacing : Float32
  ) : Vector2

  fun format_text = FormatText(text : UInt8*, ...) : UInt8*

  fun sub_text = SubText(
    text : UInt8*,
    position : Int32,
    length : Int32
  ) : UInt8*

  fun get_glyph_index = GetGlyphIndex(font : Font, character : Int32) : Int32

  fun draw_line_3d = DrawLine3D(startPos : Vector3, endPos : Vector3, color : Color)

  fun draw_circle_3d = DrawCircle3D(
    center : Vector3,
    radius : Float32,
    rotationAxis : Vector3,
    rotationAngle : Float32,
    color : Color
  )

  fun draw_cube = DrawCube(position : Vector3, width : Float32, height : Float32, length : Float32, color : Color)

  fun draw_cube_v = DrawCubeV(position : Vector3, size : Vector3, color : Color)

  fun draw_cube_wires = DrawCubeWires(position : Vector3, width : Float32, height : Float32, length : Float32, color : Color)

  fun draw_cube_texture = DrawCubeTexture(
    texture : Texture2D,
    position : Vector3,
    width : Float32,
    height : Float32,
    length : Float32,
    color : Color
  )

  fun draw_sphere = DrawSphere(centerPos : Vector3, radius : Float32, color : Color)

  fun draw_sphere_ex = DrawSphereEx(
    centerPos : Vector3,
    radius : Float32,
    rings : Int32,
    slices : Int32,
    color : Color
  )

  fun draw_sphere_wires = DrawSphereWires(
    centerPos : Vector3,
    radius : Float32,
    rings : Int32,
    slices : Int32,
    color : Color
  )

  fun draw_cylinder = DrawCylinder(
    position : Vector3,
    radiusTop : Float32,
    radiusBottom : Float32,
    height : Float32,
    slices : Int32,
    color : Color
  )

  fun draw_cylinder_wires = DrawCylinderWires(
    position : Vector3,
    radiusTop : Float32,
    radiusBottom : Float32,
    height : Float32,
    slices : Int32,
    color : Color
  )

  fun draw_plane = DrawPlane(centerPos : Vector3, size : Vector2, color : Color)

  fun draw_ray = DrawRay(ray : Ray, color : Color)

  fun draw_grid = DrawGrid(slices : Int32, spacing : Float32)

  fun draw_gizmo = DrawGizmo(position : Vector3)

  fun load_model = LoadModel(fileName : UInt8*) : Model

  fun load_model_from_mesh = LoadModelFromMesh(mesh : Mesh) : Model

  fun unload_model = UnloadModel(model : Model)

  fun load_mesh = LoadMesh(fileName : UInt8*) : Mesh

  fun unload_mesh = UnloadMesh(mesh : Mesh*)

  fun export_mesh = ExportMesh(fileName : UInt8*, mesh : Mesh)

  fun mesh_bounding_box = MeshBoundingBox(mesh : Mesh) : BoundingBox

  fun mesh_tangents = MeshTangents(mesh : Mesh*)

  fun mesh_binormals = MeshBinormals(mesh : Mesh*)

  fun gen_mesh_plane = GenMeshPlane(
    width : Float32,
    length : Float32,
    resX : Int32,
    resZ : Int32
  ) : Mesh

  fun gen_mesh_cube = GenMeshCube(width : Float32, height : Float32, length : Float32) : Mesh

  fun gen_mesh_sphere = GenMeshSphere(
    radius : Float32,
    rings : Int32,
    slices : Int32
  ) : Mesh

  fun gen_mesh_hemi_sphere = GenMeshHemiSphere(
    radius : Float32,
    rings : Int32,
    slices : Int32
  ) : Mesh

  fun gen_mesh_cylinder = GenMeshCylinder(radius : Float32, height : Float32, slices : Int32) : Mesh

  fun gen_mesh_torus = GenMeshTorus(
    radius : Float32,
    size : Float32,
    radSeg : Int32,
    sides : Int32
  ) : Mesh

  fun gen_mesh_knot = GenMeshKnot(
    radius : Float32,
    size : Float32,
    radSeg : Int32,
    sides : Int32
  ) : Mesh

  fun gen_mesh_heightmap = GenMeshHeightmap(heightmap : Image, size : Vector3) : Mesh

  fun gen_mesh_cubicmap = GenMeshCubicmap(cubicmap : Image, cubeSize : Vector3) : Mesh

  fun load_material = LoadMaterial(fileName : UInt8*) : Material

  fun load_material_default = LoadMaterialDefault : Material

  fun unload_material = UnloadMaterial(material : Material)

  fun draw_model = DrawModel(model : Model, position : Vector3, scale : Float32, tint : Color)

  fun draw_model_ex = DrawModelEx(
    model : Model,
    position : Vector3,
    rotationAxis : Vector3,
    rotationAngle : Float32,
    scale : Vector3,
    tint : Color
  )

  fun draw_model_wires = DrawModelWires(model : Model, position : Vector3, scale : Float32, tint : Color)

  fun draw_model_wires_ex = DrawModelWiresEx(
    model : Model,
    position : Vector3,
    rotationAxis : Vector3,
    rotationAngle : Float32,
    scale : Vector3,
    tint : Color
  )

  fun draw_bounding_box = DrawBoundingBox(box_ : BoundingBox, color : Color)

  fun draw_billboard = DrawBillboard(
    camera : Camera3D,
    texture : Texture2D,
    center : Vector3,
    size : Float32,
    tint : Color
  )

  fun draw_billboard_rec = DrawBillboardRec(
    camera : Camera3D,
    texture : Texture2D,
    sourceRec : Rectangle,
    center : Vector3,
    size : Float32,
    tint : Color
  )

  fun check_collision_spheres = CheckCollisionSpheres(
    centerA : Vector3,
    radiusA : Float32,
    centerB : Vector3,
    radiusB : Float32
  ) : Bool

  fun check_collision_boxes = CheckCollisionBoxes(box1 : BoundingBox, box2 : BoundingBox) : Bool

  fun check_collision_box_sphere = CheckCollisionBoxSphere(
    box_ : BoundingBox,
    centerSphere : Vector3,
    radiusSphere : Float32
  ) : Bool

  fun check_collision_ray_sphere = CheckCollisionRaySphere(ray : Ray, spherePosition : Vector3, sphereRadius : Float32) : Bool

  fun check_collision_ray_sphere_ex = CheckCollisionRaySphereEx(
    ray : Ray,
    spherePosition : Vector3,
    sphereRadius : Float32,
    collisionPoint : Vector3*
  ) : Bool

  fun check_collision_ray_box = CheckCollisionRayBox(ray : Ray, box_ : BoundingBox) : Bool

  fun get_collision_ray_model = GetCollisionRayModel(ray : Ray, model : Model*) : RayHitInfo

  fun get_collision_ray_triangle = GetCollisionRayTriangle(ray : Ray, p1 : Vector3, p2 : Vector3, p3 : Vector3) : RayHitInfo

  fun get_collision_ray_ground = GetCollisionRayGround(ray : Ray, groundHeight : Float32) : RayHitInfo

  fun load_text = LoadText(fileName : UInt8*) : UInt8*

  fun load_shader = LoadShader(
    vsFileName : UInt8*,
    fsFileName : UInt8*
  ) : Shader

  fun load_shader_code = LoadShaderCode(
    vsCode : UInt8*,
    fsCode : UInt8*
  ) : Shader

  fun unload_shader = UnloadShader(shader : Shader)

  fun get_shader_default = GetShaderDefault : Shader

  fun get_texture_default = GetTextureDefault : Texture2D

  fun get_shader_location = GetShaderLocation(
    shader : Shader,
    uniformName : UInt8*
  ) : Int32

  fun set_shader_value = SetShaderValue(
    shader : Shader,
    uniformLoc : Int32,
    value : Float32*,
    size : Int32
  )

  fun set_shader_valuei = SetShaderValuei(
    shader : Shader,
    uniformLoc : Int32,
    value : Int32*,
    size : Int32
  )

  fun set_shader_value_matrix = SetShaderValueMatrix(shader : Shader, uniformLoc : Int32, mat : Matrix)

  fun set_matrix_projection = SetMatrixProjection(proj : Matrix)

  fun set_matrix_modelview = SetMatrixModelview(view : Matrix)

  fun get_matrix_modelview = GetMatrixModelview : Matrix

  fun gen_texture_cubemap = GenTextureCubemap(
    shader : Shader,
    skyHDR : Texture2D,
    size : Int32
  ) : Texture2D

  fun get_texture_irradiance = GenTextureIrradiance(
    shader : Shader,
    cubemap : Texture2D,
    size : Int32
  ) : Texture2D

  fun gen_texture_prefilter = GenTexturePrefilter(
    shader : Shader,
    cubemap : Texture2D,
    size : Int32
  ) : Texture2D

  fun gen_texture_BRDF = GenTextureBRDF(
    shader : Shader,
    cubemap : Texture2D,
    size : Int32
  ) : Texture2D

  fun begin_shader_mode = BeginShaderMode(shader : Shader)

  fun end_shader_mode = EndShaderMode

  fun begin_blend_mode = BeginBlendMode(mode : Int32)

  fun end_blend_mode = EndBlendMode

  fun get_vr_device_info = GetVrDeviceInfo(vrDeviceType : Int32) : VrDeviceInfo

  fun init_vr_simulator = InitVrSimulator(info : VrDeviceInfo)

  fun close_vr_simulator = CloseVrSimulator

  fun vr_simulator_ready? = IsVrSimulatorReady : Bool

  fun set_vr_distortion_shader = SetVrDistortionShader(shader : Shader)

  fun update_vr_tracking = UpdateVrTracking(camera : Camera3D*)

  fun toggle_vr_mode = ToggleVrMode

  fun begin_vr_drawing = BeginVrDrawing

  fun end_vr_drawing = EndVrDrawing

  fun init_audio_devide = InitAudioDevice

  fun close_audio_device = CloseAudioDevice

  fun audio_device_ready? = IsAudioDeviceReady : Bool

  fun set_master_volume = SetMasterVolume(volume : Float32)

  fun load_wave = LoadWave(fileName : UInt8*) : Wave

  fun load_wave_ex = LoadWaveEx(
    data : Void*,
    sampleCount : Int32,
    sampleRate : Int32,
    sampleSize : Int32,
    channels : Int32
  ) : Wave

  fun load_sound = LoadSound(fileName : UInt8*) : Sound

  fun load_sound_from_wave = LoadSoundFromWave(wave : Wave) : Sound

  fun update_sound = UpdateSound(
    sound : Sound,
    data : Void*,
    samplesCount : Int32
  )

  fun unload_wave = UnloadWave(wave : Wave)

  fun unload_sound = UnloadSound(sound : Sound)

  fun play_sound = PlaySound(sound : Sound)

  fun pause_sound = PauseSound(sound : Sound)

  fun resume_sound = ResumeSound(sound : Sound)

  fun stop_sound = StopSound(sound : Sound)

  fun sound_playing? = IsSoundPlaying(sound : Sound) : Bool

  fun set_sound_volume = SetSoundVolume(sound : Sound, volume : Float32)

  fun set_sound_pitch = SetSoundPitch(sound : Sound, pitch : Float32)

  fun wave_format = WaveFormat(
    wave : Wave*,
    sampleRate : Int32,
    sampleSize : Int32,
    channels : Int32
  )

  fun wave_copy = WaveCopy(wave : Wave) : Wave

  fun wave_crop = WaveCrop(
    wave : Wave*,
    initSample : Int32,
    finalSample : Int32
  )

  fun get_wave_data = GetWaveData(wave : Wave) : Float32*

  fun load_music_stream = LoadMusicStream(fileName : UInt8*) : Music

  fun unload_music_stream = UnloadMusicStream(music : Music)

  fun play_music_stream = PlayMusicStream(music : Music)

  fun update_music_stream = UpdateMusicStream(music : Music)

  fun stop_music_stream = StopMusicStream(music : Music)

  fun pause_music_stream = PauseMusicStream(music : Music)

  fun resume_music_stream = ResumeMusicStream(music : Music)

  fun music_playing? = IsMusicPlaying(music : Music) : Bool

  fun set_music_volume = SetMusicVolume(music : Music, volume : Float32)

  fun set_music_pitch = SetMusicPitch(music : Music, pitch : Float32)

  fun set_music_loop_count = SetMusicLoopCount(music : Music, count : Int32)

  fun get_music_time_length = GetMusicTimeLength(music : Music) : Float32

  fun get_music_time_played = GetMusicTimePlayed(music : Music) : Float32

  fun init_audio_stream = InitAudioStream(
    sampleRate : UInt32,
    sampleSize : UInt32,
    channels : UInt32
  ) : AudioStream

  fun update_audio_stream = UpdateAudioStream(
    stream : AudioStream,
    data : Void*,
    samplesCount : Int32
  )

  fun close_audio_stream = CloseAudioStream(stream : AudioStream)

  fun audio_buffer_precessed? = IsAudioBufferProcessed(stream : AudioStream) : Bool

  fun play_audio_stream = PlayAudioStream(stream : AudioStream)

  fun pause_audio_stream = PauseAudioStream(stream : AudioStream)

  fun resume_audio_stream = ResumeAudioStream(stream : AudioStream)

  fun audio_stream_playing? = IsAudioStreamPlaying(stream : AudioStream) : Bool

  fun stop_audio_stream = StopAudioStream(stream : AudioStream)

  fun set_audio_stream_volume = SetAudioStreamVolume(stream : AudioStream, volume : Float32)

  fun set_audio_stream_pitch = SetAudioStreamPitch(stream : AudioStream, pitch : Float32)
end
