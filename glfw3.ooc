/*
 * GLFW OOC wrapper
 *
 * Author: Hongjie Zhai
 */
import native/glfw3api
include GLFW/glfw3

Image: cover from _GLFWimage

Gammaramp: cover from _GLFWgammaramp

Vidmode: cover from _GLFWvidmode

glfw: class{
    init: func() { glfwInit() }

    terminate: func() { glfwTerminate() }

    getVersionString: func() -> String{ glfwGetVersionString() as CString toString() }

    getVersion: func() -> (Int, Int, Int) { 
        ma, mi, mo: Int
        glfwGetVersion(ma&, mi&, mo&)
        (ma, mi, mo)
    }

    onError: func(p: Pointer) -> Bool{
        !(glfwSetErrorCallback(p) == null)
    }

    monitors: func() -> Monitor[]{
        count: Int
        m: Monitor[]
        m data = glfwGetMonitors(count&)
        m length = count
        m
    }

    defaultWindowHints: func(){ glfwDefaultWindowHints() }

    windowHint: func(target, hint: Int){ glfwWindowHint(target, hint) }

    pollEvents: func() { glfwPollEvents() }

    waitEvents: func() { glfwWaitEvents() }

    postEmptyEvent: func() { glfwPostEmptyEvent() }

    joystickPresent: func(target: Int) -> Bool{ glfwJoystickPresent(target) as Bool }

    joystickAxes: func(joy: Int) -> Float[] {
        count: Int
        axes: Float[]
        axes data = glfwGetJoystickAxes(joy, count&)
        axes length = count
        axes
    }

    joystickButtons: func(joy: Int) -> UChar[]{
        count: Int
        r : UChar[]
        r data = glfwGetJoystickButtons(joy, count&)
        r length = count
        r
    }

    joystickName: func(joy: Int) -> String{
        glfwGetJoystickName(joy) as CString toString()
    }

    getTime: func() -> Double{ glfwGetTime() }
    setTime: func(t: Double){ glfwSetTime(t) }

    currentContext: func -> Window{
        glfwGetCurrentContext() as Window
    }

    setSwapInterval: func(si: Int){
        glfwSwapInterval(si)
    }

    extensionSupported: func(name: String) -> Bool{
        glfwExtensionSupported(name toCString() as Char*) as Bool
    }

    getProcAddress: func(name: String) -> Pointer{
        glfwGetProcAddress(name toCString() as Char*)
    }
}

/*
 * GLFW monitor cover
 */
Monitor: cover from GLFWmonitor*{
    pos: func -> (Int, Int){
        x,y: Int;
        glfwGetMonitorPos(this, x&, y&)
        (x,y)
    }

    physicalSize: func -> (Int, Int){
        x,y: Int;
        glfwGetMonitorPhysicalSize(this, x&, y&)
        (x,y)
    }

    name: func -> String{
        glfwGetMonitorName(this) as CString toString()
    }

    videoModes: func -> Vidmode[]{
        r: Vidmode[]
        count: Int
        r data = glfwGetVideoModes(this, count&)
        r length = count
        r
    }

    videoMode: func -> Vidmode{
        glfwGetVideoMode(this)@ as Vidmode
    }

    setGamma: func(gamma: Float){
        glfwSetGamma(this, gamma)
    }

    getGammaRamp: func -> Gammaramp { glfwGetGammaRamp(this)@ as Gammaramp }

    setGammaRamp: func(ramp: Gammaramp){
        glfwSetGammaRamp(this, ramp&)
    }
}

/**
 * GLFW window cover
 */
Window: cover from GLFWwindow*{
    new: static func(width, height: Int, title: String, monitor: Monitor, share: Window) -> This {
        glfwCreateWindow(width, height, title toCString(), monitor, share) as This
    }

    destroy: func{ glfwDestroyWindow(this) }

    makeContextCurrent: func{ glfwMakeContextCurrent(this) }

    swapBuffers: func(){ glfwSwapBuffers(this) }

    show: func(){ glfwShowWindow(this) }

    hide: func(){ glfwHideWindow(this) }

    restore: func(){ glfwRestoreWindow(this) }

    iconify: func(){ glfwIconifyWindow(this) }

    getKey: func(k: Int) -> Int{ glfwGetKey(this, k) }

    getMouseButton: func(b: Int) -> Int{ glfwGetMouseButton(this, b) }

    getWindowAttrib: func(pn: Int) -> Int{ glfwGetWindowAttrib(this, pn) }

    getInputMode: func(n: Int) -> Int{ glfwGetInputMode(this, n) }

    setInputMode: func(n,m: Int){ glfwSetInputMode(this, n, m) }

    getCursorPos: func -> (Double, Double){
        x, y: Double
        glfwGetCursorPos(this, x&, y&)
        (x,y)
    }

    setCursorPos: func(x, y: Double){
        glfwSetCursorPos(this, x, y)
    }

    getWindowPos: func -> (Int, Int){
        x, y: Int
        glfwGetWindowPos(this, x&, y&)
        (x,y)
    }
    
    setWindowPos: func(x, y: Int){
        glfwSetWindowPos(this, x, y)
    }

    getWindowSize: func -> (Int, Int){
        x, y: Int
        glfwGetWindowSize(this, x&, y&)
        (x, y)
    }

    setWindowSize: func(x, y: Int){ glfwSetWindowSize(this, x, y) }
    setWindowTitle: func(tit: String){ glfwSetWindowTitle(this, tit toCString())  }
    getShouldClose: func -> Bool{ glfwWindowShouldClose(this) as Bool }
    setShouldClose: func(state: Bool){ glfwSetWindowShouldClose(this, state as Int) }

    getClipboardString: func -> String{
        glfwGetClipboardString(this) as CString toString()
    }

    setClipboardString: func(text: String){
        glfwSetClipboardString(this, text toCString() as Pointer)
    }

    monitor: Monitor{
        get{ glfwGetWindowMonitor(this) as Monitor }
    }

    userPointer: Pointer{
        get{ glfwGetWindowUserPointer(this) }
        set(p){ glfwSetWindowUserPointer(this, p) }
    }

    getFrameBufferSize: func -> (Int, Int){
        x,y: Int
        glfwGetFramebufferSize(this, x&, y&)
        (x,y)
    }

    getWindowFrameSize: func -> (Int, Int, Int, Int){
        x,y,z,h: Int
        glfwGetWindowFrameSize(this, x&, y&, z&, h&)
        (x,y,z,h)
    }

    setCursor: func(cursor: Cursor){
        glfwSetCursor(this, cursor)
    }

    onPos: func(p: Pointer){ glfwSetWindowPosCallback(this, p) }
    onSize: func(p: Pointer){ glfwSetWindowSizeCallback(this, p) }
    onClose: func(p: Pointer){ glfwSetWindowCloseCallback(this, p) }
    onRefresh: func(p: Pointer){ glfwSetWindowRefreshCallback(this, p) }
    onFocus: func(p: Pointer){ glfwSetWindowFocusCallback(this, p) }
    onIconify: func(p: Pointer){ glfwSetWindowIconifyCallback(this, p) }
    onFramebufferSize: func(p: Pointer){ glfwSetFramebufferSizeCallback(this, p) }
    onKey: func(p: Pointer){ glfwSetKeyCallback(this, p) }
    onChar: func(p: Pointer){ glfwSetCharCallback(this, p) }
    onCharMods: func(p: Pointer){ glfwSetCharModsCallback(this, p) }
    onMouseButton: func(p: Pointer){ glfwSetMouseButtonCallback(this, p) }
    onCursorPos: func(p: Pointer){ glfwSetCursorPosCallback(this, p) }
    onCursorEnter: func(p: Pointer){ glfwSetCursorEnterCallback(this, p) }
    onScroll: func(p: Pointer){ glfwSetScrollCallback(this, p) }
    onDrop: func(p: Pointer){ glfwSetDropCallback(this, p) }
}

/**
 * GLFW Cursor cover
 */
Cursor: cover from GLFWcursor*{
    new : static func(image: Image, height, width: Int) -> Cursor {
        glfwCreateCursor(image&, height, width)
    }

    new: static func~pointer(image: Image*, x, y: Int) -> Cursor {
        glfwCreateCursor(image, x, y)
    }

    destroy: func(){
        glfwDestroyCursor(this)
    }
}

