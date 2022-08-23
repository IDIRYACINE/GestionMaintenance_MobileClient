package com.idir.barcodescanner.infrastructure.services

import android.app.Service
import android.content.Intent
import android.os.IBinder
import com.idir.barcodescanner.infrastructure.StorageManager

class DataSaverService : Service() {
    private val storageManager : StorageManager = StorageManager()

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val context = applicationContext
        val extras = intent.extras!!

        val settings =  extras.getString("Settings")!!

        storageManager.saveSettings(context, settings)

        stopSelf()
        return START_NOT_STICKY
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

}