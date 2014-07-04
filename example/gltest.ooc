import gl, glfw3

getKey: func(w: GLFWwindow*, a,b,c,d: Int) {
    a toString() println()
}

main: func(args: String[]) -> Int{
    if (!glfwInit()) Exception new("Can not initialize glfw") throw()

    window := Window create(640, 480, "Test", null, null)
    if(!window){
        glfwTerminate()
        Exception new("Cann to create window") throw()
    }

    window title = "Test2"

    window makeContextCurrent()

    glfwSetKeyCallback(window, getKey&)

    time := glfwGetTime()
    frames: Int = 0
    while (!window shouldClose){
        ratio : Float
        (width, height) := window getFrameBufferSize()
        ratio = width / height
        glViewport(0, 0, width, height)
        glClear(GL_COLOR_BUFFER_BIT)
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()
        glOrtho(-ratio, ratio, -1.f, 1.f, 1.f, -1.f)
        glMatrixMode(GL_MODELVIEW)
        glLoadIdentity()
        glRotatef( glfwGetTime() * 20.f, 0.f, 0.f, 1.f)
        glBegin(GL_TRIANGLES)
        glColor3f(1.f, 0.f, 0.f)
        glVertex3f(-0.6f, -0.4f, 0.f)
        glColor3f(0.f, 1.f, 0.f)
        glVertex3f(0.6f, -0.4f, 0.f)
        glColor3f(0.f, 0.f, 1.f)
        glVertex3f(0.f, 0.6f, 0.f)
        glEnd()
        window swapBuffers()
        glfwPollEvents()
        frames += 1
        if(glfwGetTime() - time > 3){
            printf("%.3f\n" toCString(), frames / (glfwGetTime() -time))
            frames = 0
            time = glfwGetTime()
        }
    }

    window destroy()
    glfwTerminate()
}
