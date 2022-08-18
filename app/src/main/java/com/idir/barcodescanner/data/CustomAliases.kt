package com.idir.barcodescanner.data

import com.google.mlkit.vision.barcode.common.Barcode
import kotlinx.serialization.json.JsonElement

typealias ToggleCallback = (value:Boolean) ->Unit
typealias VoidCallback = ()->Unit
typealias ConfirmFunction = (value:String)->Unit
typealias OnBarCodeDetected = (barcodes: List<Barcode>) -> Unit
typealias JsonMap = Map<String,JsonElement>


