An ooc-binding of glfw3.


An example: (can be found under example/gltest.ooc)

	import gl
	import glfw3

	getKey: func(w: Window, a,b,c,d: Int) {
		a toString() println()
	}

	main: func(args: String[]) -> Int{
		pro := glfw new()
		window := Window new(640, 480, "Test", null, null)
		if(!window){
			pro terminate()
			Exception new("Cann to create window") throw()
		}

		window setWindowTitle("Test2")
		window makeContextCurrent()
		window onKey(getKey&)

		time := pro getTime()
		frames: Int = 0
		while (!window getShouldClose()){
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
			glRotatef( pro getTime() * 20.f, 0.f, 0.f, 1.f)
			glBegin(GL_TRIANGLES)
			glColor3f(1.f, 0.f, 0.f)
			glVertex3f(-0.6f, -0.4f, 0.f)
			glColor3f(0.f, 1.f, 0.f)
			glVertex3f(0.6f, -0.4f, 0.f)
			glColor3f(0.f, 0.f, 1.f)
			glVertex3f(0.f, 0.6f, 0.f)
			glEnd()
			window swapBuffers()
			pro pollEvents()
			frames += 1
			if(pro getTime() - time > 3){
				printf("%.3f\n" toCString(), frames / (pro getTime() - time))
				frames = 0
				time = pro getTime()
			}
		}

		window destroy()
		pro terminate()
	}