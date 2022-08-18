package com.idir.barcodescanner.ui.components.barcodes

import androidx.compose.material.*
import androidx.compose.runtime.*
import com.idir.barcodescanner.data.ToggleCallback
import com.idir.barcodescanner.ui.theme.Green200
import com.idir.barcodescanner.ui.theme.Green500



@Composable
fun ToggleAction(
                 onClick:ToggleCallback,
                 active : MutableState<Boolean>
                 ){

    val isActive = remember {active}

    Switch(
        checked = isActive.value,
        colors = SwitchDefaults.colors(
            checkedThumbColor = Green500,
            checkedTrackColor = Green200
        ),
        onCheckedChange = {
            isActive.value = it
            onClick(it)
        }
    )

}
