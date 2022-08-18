package com.idir.barcodescanner.ui.screens

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.Provider
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeManager
import com.idir.barcodescanner.ui.components.barcodes.BarcodeCard
import com.idir.barcodescanner.ui.components.SecondaryAppBar

class BarcodeGroupContentActivity : ComponentActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            BarcodeGroupContentScreen(Provider.barcodesManager)
        }
    }
}

@Composable
fun BarcodeGroupContentScreen(barcodesManager: IBarcodeManager){
    val barcodeGroup: BarcodeGroup = barcodesManager.getActiveGroup()

    Scaffold(
        topBar = { SecondaryAppBar(title = barcodeGroup.name.value)})
    {
        paddings ->
        LazyColumn(
            modifier = Modifier.padding(paddings)
        ){

            barcodeGroup.barcodes.forEach{
                    barcode -> item{BarcodeCard(barcode = barcode.value)}
            }

        }
    }
}