package com.idir.barcodescanner.ui.components.barcodes

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.material.Card
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.idir.barcodescanner.data.Barcode


@Composable
fun BarcodeCard(barcode: Barcode){
    Card(
        modifier = Modifier
            .padding(15.dp)
            .clickable { },
        elevation = 10.dp
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(15.dp)
        ) {
            Row(
                horizontalArrangement = Arrangement.SpaceBetween,
                modifier = Modifier
                .fillMaxWidth()){
                Text(text = barcode.value)

            }
            Text(text = barcode.time , color = Color.LightGray, fontWeight = FontWeight.ExtraLight)
        }
    }
}