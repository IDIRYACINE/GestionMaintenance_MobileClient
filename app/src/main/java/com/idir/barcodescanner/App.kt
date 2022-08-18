package com.idir.barcodescanner

import android.app.Application

class App : Application() {
    companion object{
        lateinit var appInstance : App
            private set
    }

    override fun onCreate() {
        super.onCreate()
        appInstance = this
    }
}