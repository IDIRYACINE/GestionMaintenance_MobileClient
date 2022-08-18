package com.idir.barcodescanner.ui.components

import androidx.compose.material.DropdownMenuItem
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf
import com.idir.barcodescanner.R
import com.idir.barcodescanner.application.HomeController
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.Provider

@Composable
fun ActionsDrop(controller:HomeController){
        fun hideActionsDrop(){
            controller.visibleActions.value = false
        }
        DropdownMenuItem(
            onClick = {
                controller.popupCardState.setCreateState()
                controller.popupCardState.value = mutableStateOf("")
                controller.showPopupCard()
                hideActionsDrop()
            }
        ) {
            Text(Provider.resourceLoader.loadStringResource(R.string.button_new))
        }

        DropdownMenuItem(
            onClick = {
                controller.clearAll()
                hideActionsDrop()
            })
        {
            Text(Provider.resourceLoader.loadStringResource(R.string.button_clear_all))
        }
        DropdownMenuItem(
            onClick = {
                controller.sendData()
                hideActionsDrop() })
        {
            Text(Provider.resourceLoader.loadStringResource(R.string.button_send))
        }

}

@Composable
fun ActionsGroupDrop(controller: HomeController,barcodeGroup: BarcodeGroup,visibleGroupAction:MutableState<Boolean>){

    fun hideActionsDrop(){
        visibleGroupAction.value = false

    }
        DropdownMenuItem(
            onClick = {
                controller.setEditGroup(barcodeGroup)
                controller.popupCardState.setEditState()
                controller.popupCardState.value = barcodeGroup.name
                controller.popupCardState.isOpen.value = true
                hideActionsDrop()
            }
        ){
            Text(Provider.resourceLoader.loadStringResource(R.string.actions_edit))
        }
            DropdownMenuItem(
            onClick = {
                controller.clearGroup(barcodeGroup)
                hideActionsDrop()
            }
        ){
            Text(Provider.resourceLoader.loadStringResource(R.string.button_clear_all))
        }
            DropdownMenuItem(
            onClick = {
                controller.deleteGroup(barcodeGroup)
                hideActionsDrop()
            }
        ){
            Text(Provider.resourceLoader.loadStringResource(R.string.actions_delete))
        }


}
