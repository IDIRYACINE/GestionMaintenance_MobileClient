package com.idir.barcodescanner.data.dataModels

import java.util.*

data class InventoryProduct(val articleId:Int , val barcode:Int, val stockId:Int,var scanTime: Date?)