package com.idir.barcodescanner.ui.components.barcodes

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.AlertDialog
import androidx.compose.material.Text
import androidx.compose.material.TextButton
import androidx.compose.material.TextField
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.idir.barcodescanner.data.CardPopupState
import com.idir.barcodescanner.R

@Composable
fun ManageCardPopup(
    state : CardPopupState,
){
    val fieldValue = remember{state.value}

    AlertDialog(
        onDismissRequest = {
            state.onCancel()
        },
        title = {
            Text(stringResource(id =  state.title.value))
        },
        text = {
            TextField(value = fieldValue.value,
                onValueChange = {
                fieldValue.value = it
            })
        },
        buttons = {
            Row(
                horizontalArrangement = Arrangement.End,
                modifier = Modifier.fillMaxWidth().padding(end=20.dp)
            ){
                TextButton(onClick = {
                    state.onCancel()
                }) {
                    Text(stringResource(id = R.string.button_cancel))
                }
                TextButton(onClick = {
                    state.onConfirm(fieldValue.value)
                }) {
                    Text(stringResource(id = R.string.button_confirm))
                }
            }
        }
    )
}
