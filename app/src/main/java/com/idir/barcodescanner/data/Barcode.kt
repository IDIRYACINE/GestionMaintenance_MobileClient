@file:UseSerializers(MutableStateSerializer::class)

package com.idir.barcodescanner.data

import androidx.compose.runtime.MutableState
import com.idir.barcodescanner.infrastructure.serializers.MutableStateSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers


@Serializable
data class Barcode (
    val id : String,
    val value:String,
    var time : String,
    )


@Serializable
data class BarcodeGroup(
    val id : Int,
    val name:MutableState<String>,
    val barcodes:MutableMap<String,Barcode>,
    )
















