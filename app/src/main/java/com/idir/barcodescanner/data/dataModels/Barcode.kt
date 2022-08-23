
package com.idir.barcodescanner.data

import androidx.compose.runtime.MutableState
import com.idir.barcodescanner.data.dataModels.InventoryProduct
import com.idir.barcodescanner.data.dataModels.StockProduct

data class Barcode (
    val id : String,
    val value:String,
    var time : String,
)

data class BarcodeGroup(
    val id : Int,
    val productInstance: StockProduct,
    var count : MutableState<Int>,
    val barcodes:MutableMap<Int, InventoryProduct>,
)















