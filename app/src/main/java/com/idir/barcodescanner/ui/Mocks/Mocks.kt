package com.idir.barcodescanner.ui.Mocks

import android.os.Handler
import androidx.compose.runtime.mutableStateOf
import com.idir.barcodescanner.application.HomeController
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeManager
import com.idir.barcodescanner.infrastructure.barcode.manager.BarcodeManager

class Mocks {
    companion object{
        fun mockBarcodeGroup() : BarcodeGroup{

            val group = BarcodeGroup(
                id = 0,
                name = mutableStateOf("Mock Group"),
                barcodes = mutableMapOf()
            )


            return group
        }

        fun mockHomeController() : HomeController{
            val controller = HomeController(
                barcodesManager =  mockBarcodeManager(),
                handler = Handler()
            )
            return controller
        }

        fun mockBarcodeManager() : IBarcodeManager{
            val manager = BarcodeManager(
            )

            return manager;
        }


    }
}