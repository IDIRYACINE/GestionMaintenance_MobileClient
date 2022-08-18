package com.idir.barcodescanner.data

import androidx.compose.runtime.mutableStateOf
import com.idir.barcodescanner.R

class CardPopupState(
    val open : Boolean,
    private val onConfirmEdit :ConfirmFunction,
    private val onConfirmCreate : ConfirmFunction,
    val onCancel : VoidCallback
) {

    val title = mutableStateOf(R.string.popup_add_title)
    var value = mutableStateOf("")
    val isOpen = mutableStateOf(open)

    var onConfirm = onConfirmCreate
        private set

    fun setEditState(){
        title.value = R.string.popup_edit_title
        onConfirm = onConfirmEdit
    }

    fun setCreateState(){
        title.value = R.string.popup_add_title
        onConfirm = onConfirmCreate
    }


}