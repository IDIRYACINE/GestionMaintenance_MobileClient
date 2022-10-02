@file:Suppress("UNCHECKED_CAST")

package com.idir.barcodescanner.infrastructure

import android.content.Context
import android.os.Handler
import android.widget.Toast
import com.idir.barcodescanner.application.CameraController
import com.idir.barcodescanner.application.HomeController
import com.idir.barcodescanner.application.SettingsController
import com.idir.barcodescanner.infrastructure.barcode.*
import com.idir.barcodescanner.infrastructure.barcode.manager.BarcodeManager
import com.idir.barcodescanner.infrastructure.database.DatabaseHelper
import com.idir.barcodescanner.infrastructure.database.RemoteDatabase
import com.idir.barcodescanner.infrastructure.licenses.LicensesManager


object Provider {

    lateinit var licenseManager: LicensesManager
        private set

    val storageManager : StorageManager = StorageManager()

    lateinit var barcodesManager :IBarcodeManager
        private set
    lateinit var cameraAnalyser: ICameraAnalyser
        private set

    lateinit var homeController : HomeController
        private set
    lateinit var settingsController : SettingsController
        private set
    lateinit var cameraController : CameraController
        private set

    private lateinit var toaster : IBarcodeSubscriber
    lateinit var resourceLoader:ResourcesLoader
        private set
    lateinit var barcodeBroadcaster : IBarcodeBroadcaster

    fun initApp(context: Context,handler : Handler){
        val dao = DatabaseHelper(RemoteDatabase())
        val tempManager = BarcodeManager(dao)

        barcodesManager = tempManager

        resourceLoader = ResourcesLoader(context)

        cameraAnalyser = CameraAnalyser()

        toaster = Toaster(context)
        barcodeBroadcaster.subscribeToBarcodeStream(toaster)

        settingsController = SettingsController()
        settingsController.load(context)

        homeController = HomeController(barcodesManager,handler)

        cameraController = CameraController(cameraAnalyser)

        licenseManager = LicensesManager(resourceLoader)

        barcodeBroadcaster = BarcodeBroadcaster()
    }


}

class Toaster(private val context: Context) : IBarcodeSubscriber{

    override fun getId(): String {
       return ""
    }

    override fun notify(rawBarcode: String) {
        Toast.makeText(context, rawBarcode, Toast.LENGTH_SHORT).show()
    }

    override fun notify(rawBarcodes: List<String>) {
        rawBarcodes.forEach {
            Toast.makeText(context, it, Toast.LENGTH_SHORT).show()
        }
    }

}