package com.example.termuxView;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.opengl.GLSurfaceView;
import android.content.Context;
import android.view.MotionEvent;
import android.view.Window;

public class Test {
    private static GLSurfaceView mGLView;
    private static Context mContext;
    public static void main(String[] args) {
        System.out.println("Hello, World");
        
        //mContext = new Context();
        //mGLView = new DemoGLSurfaceView(mContext);
    }
    
    static {
		System.loadLibrary("sanangeles");
    }
}

class DemoGLSurfaceView extends GLSurfaceView {
    public DemoGLSurfaceView(Context context) {
        super(context);
        mRenderer = new DemoRenderer();
        setRenderer(mRenderer);
    }

    public boolean onTouchEvent(final MotionEvent event) {
        if (event.getAction() == MotionEvent.ACTION_DOWN) {
            nativeTogglePauseResume();
        }
        return true;
    }

   @Override
    public void onPause() {
        super.onPause();
        nativePause();
    }

   @Override
    public void onResume() {
        super.onResume();
        nativeResume();
    }


    DemoRenderer mRenderer;

    private static native void nativePause();
    private static native void nativeResume();
    private static native void nativeTogglePauseResume();
}

class DemoRenderer implements GLSurfaceView.Renderer {
    public void onSurfaceCreated(GL10 gl, EGLConfig config) {
        nativeInit();
    }

    public void onSurfaceChanged(GL10 gl, int w, int h) {
        //gl.glViewport(0, 0, w, h);
        nativeResize(w, h);
    }

    public void onDrawFrame(GL10 gl) {
        nativeRender();
    }

    private static native void nativeInit();
    private static native void nativeResize(int w, int h);
    private static native void nativeRender();
    private static native void nativeDone();
}
