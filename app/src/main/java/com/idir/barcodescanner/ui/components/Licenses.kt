package com.idir.barcodescanner.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp

@Composable
fun LicenseFragment(
    title:String,
    license : String,
    backgroundColor : Color = Color.Gray,
    titleColor : Color = Color.LightGray,
){
    Column() {
        Text(text = title , color = titleColor)
        Spacer(modifier = Modifier.height(10.dp))
        Box(modifier = Modifier.background(color = backgroundColor)){
            Text(text = license )
        }
        Spacer(modifier = Modifier.height(20.dp))
    }
}