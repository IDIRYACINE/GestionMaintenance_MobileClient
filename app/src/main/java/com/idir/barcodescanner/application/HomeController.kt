package com.idir.barcodescanner.application

import android.content.Context
import android.content.Intent
import android.os.Handler
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.data.CardPopupState
import com.idir.barcodescanner.infrastructure.Provider
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeManager
import com.idir.barcodescanner.ui.screens.BarcodeGroupContentActivity


class HomeController(private val barcodesManager: IBarcodeManager, private val handler:Handler) {

    lateinit var popupCardState : CardPopupState
        private set

    val visibleActions : MutableState<Boolean> = mutableStateOf(false)



    init {
        popupCardState = CardPopupState(
            open = false,
            onConfirmCreate = {
                addGroup(it)
                popupCardState.isOpen.value = false
            },
            onConfirmEdit = {
                barcodesManager.editGroup(it)
                popupCardState.isOpen.value = false
            },
            onCancel = {popupCardState.isOpen.value = false }
        )
    }

    private fun addGroup(name:String){
       barcodesManager.addGroup(name)
    }

    fun deleteGroup(group:BarcodeGroup){
        barcodesManager.removeGroup(group)
    }

    fun startGroupContentActivity(context: Context,group: BarcodeGroup){
        barcodesManager.setActiveGroup(group)
        context.startActivity(Intent(context, BarcodeGroupContentActivity::class.java))
    }

    fun setEditGroup(group:BarcodeGroup){
        barcodesManager.setActiveGroup(group)
    }

    fun sendData(){
        Provider.httpManager.sendData(handler)

    }

    fun toggleActions(){
        visibleActions.value = !visibleActions.value
    }

    fun showPopupCard() {
        popupCardState.isOpen.value = true
    }

    fun clearAll() {
        barcodesManager.clearAll()
    }

    fun clearGroup(group: BarcodeGroup) {
        barcodesManager.clearGroup(group)
    }


}