package com.idir.barcodescanner.ui.Mocks

import android.os.Handler
import androidx.compose.runtime.mutableStateOf
import com.idir.barcodescanner.application.HomeController
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeManager
import com.idir.barcodescanner.infrastructure.barcode.manager.BarcodeManager

class Mocks {
    companion object{
        fun mockBarcodeGroup(): BarcodeGroup {


            return BarcodeGroup(
                id = 0,
                name = mutableStateOf("Mock Group"),
                barcodes = mutableMapOf()
            )
        }

        fun mockHomeController(): HomeController {
            return HomeController(
                barcodesManager = mockBarcodeManager(),
                handler = Handler()
            )
        }

        private fun mockBarcodeManager(): IBarcodeManager {

            return BarcodeManager(
            )
        }


    }
}