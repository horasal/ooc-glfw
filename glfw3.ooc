/*
 * GLFW OOC wrapper
 *
 * Author: Hongjie Zhai
 */
import native/glfw3api

Image: cover from _GLFWimage
Gammaramp: cover from _GLFWgammaramp
Vidmode: cover from _GLFWvidmode

/**
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
        r rlength = count
        r unitSize = Vidmode size
        r
    }

    videoMode: func -> Vidmode{
        glfwGetVideoMode(this)@ as Vidmode
    }

    setGamma: func(gamma: Float){
        glfwSetGamma(this, gamma)
    }

    gammaRamp: Gammaramp {
        get{ glfwGetGammaRamp(this)@ as Gammaramp }
        set(ramp){
            glfwSetGammaRamp(this, ramp&)
        }
    }
}

/**
 * GLFW window cover
 */
Window: cover from GLFWwindow*{
    create: static func(width, height: Int, title: String, monitor: Monitor, share: Window) -> This {
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

    setWindowSize: func(x, y: Int){
        glfwSetWindowSize(this, x, y)
    }

    title: String{
        set(tit){ glfwSetWindowTitle(this, tit toCString())  }
        get
    }

    shouldClose: Bool{
        get{ glfwWindowShouldClose(this) as Bool }
        set(state){ glfwSetWindowShouldClose(this, state as Int) }
    }

    clipboardString: String{
        set(text){ glfwSetClipboardString(this, text toCString()) }
        get{ glfwGetClipboardString(this) toString() }
    }

    monitor: Monitor{
        get{ glfwGetWindowMonitor(this) as Monitor }
    }

    userPointer: Pointer{
        get{ glfwGetWindowUserPoInter(this) }
        set(p){ glfwSetWindowUserPoInter(this, p) }
    }

    getFrameBufferSize: (Int, Int){
        get{ 
            x,y: Int
            glfwGetFRameBufferSize(this, x&, y&)
            (x,y)
        }
    }

    getWindowFrameSize: (Int, Int, Int, Int){
        get{
            x,y,z,h: Int
            glfwGetWindowFrameSize(this, x&, y&, z&, h&)
            (x,y,z,h)
        }
    }

    cursor: Cursor{
        get
        set(c){
            glfwSetCursor(this, cursor)
        }
    }
}

/**
 * GLFW Cursor cover
 */
Cursor: cover from GLFWcursor*{
    create: static func(image: Image, height, width: Int) -> Cursor {
        glfwCreateCursor(image&, height, width)
    }

    create: static func~pointer(image: Image*, x, y: Int) -> Cursor {
        glfwCreateCursor(image, x, y)
    }

    destroy: func(){
        glfwDestroyCursor(this)
    }
}

