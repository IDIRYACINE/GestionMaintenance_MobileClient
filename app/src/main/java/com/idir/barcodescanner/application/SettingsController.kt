package com.idir.barcodescanner.application

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.compose.runtime.MutableState
import androidx.core.content.ContextCompat
import androidx.lifecycle.ViewModel
import com.idir.barcodescanner.data.CardPopupState
import com.idir.barcodescanner.data.dataModels.Settings
import com.idir.barcodescanner.infrastructure.Provider
import com.idir.barcodescanner.infrastructure.ResourcesLoader
import com.idir.barcodescanner.infrastructure.barcode.*
import com.idir.barcodescanner.infrastructure.barcode.commands.ICommand
import com.idir.barcodescanner.infrastructure.barcode.commands.PlaySoundCommand
import com.idir.barcodescanner.infrastructure.barcode.commands.VibrateCommand


class SettingsController : ViewModel() {

    lateinit var settings : Settings
        private set

    lateinit var popupCardState: CardPopupState

    private lateinit var editableProperty : MutableState<String>

    private lateinit var cameraAnalyser: ICameraAnalyser

    private lateinit var googleBarcodeAnalyser :IBarcodeAnalyser

    private lateinit var barcodeManager : IBarcodeManager

    private lateinit var barcodeBroadcaster: IBarcodeBroadcaster

    private lateinit var playSoundCommand : ICommand

    private lateinit var vibrateCommand : ICommand

    private lateinit var resourceLoader : ResourcesLoader


    fun toggleManualScan(){
        val value = toggleBoolean(settings.manualScan)

        if(value){
            googleBarcodeAnalyser.setManualMode()
        }
        else{
            googleBarcodeAnalyser.setContinuousMode()
        }

    }

    fun loadStringResource(resourceId:Int) : String{
        return resourceLoader.loadStringResource(resourceId)
    }

    fun togglePlaySound(){
        toggleBoolean(settings.playSound)
        if(settings.playSound.value){
            barcodeBroadcaster.registerOnNotifyCommand(playSoundCommand)
        }
        else{
            barcodeBroadcaster.unregisterOnNotifyCommand(playSoundCommand)
        }
    }

    fun toggleVibration(){
        toggleBoolean(settings.vibrate)
        if(settings.vibrate.value){
            barcodeBroadcaster.registerOnNotifyCommand(vibrateCommand)
        }
        else{
            barcodeBroadcaster.unregisterOnNotifyCommand(vibrateCommand)
        }
    }


    fun toggleClearSend(){
        toggleBoolean(settings.clearSend)
    }

    fun showEditPopup(property:MutableState<String>,title:Int){
        editableProperty = property
        popupCardState.title.value = title
        popupCardState.value.value = property.value
        popupCardState.isOpen.value = true
    }


    private fun toggleBoolean(value:MutableState<Boolean>) : Boolean{
        val newValue = !value.value
        value.value = newValue
        return newValue
    }

    fun load(context: Context) {
        settings = Provider.storageManager.loadSettings(context)

        playSoundCommand = PlaySoundCommand()
        vibrateCommand = VibrateCommand(context)

        setupInitialState()
    }

    private fun setupInitialState(){

        barcodeBroadcaster = Provider.barcodeBroadcaster

        barcodeManager = Provider.barcodesManager

        cameraAnalyser = Provider.cameraAnalyser

        resourceLoader = Provider.resourceLoader

        popupCardState = CardPopupState(
            open = false,
            onConfirmCreate = {
                editableProperty.value = it
                popupCardState.isOpen.value = false
            },
            onConfirmEdit = {
                editableProperty.value = it
                popupCardState.isOpen.value = false
            },
            onCancel = {popupCardState.isOpen.value = false }
        )

        if(settings.playSound.value){
            barcodeBroadcaster.registerOnNotifyCommand(playSoundCommand)
        }

        if(settings.vibrate.value){
            barcodeBroadcaster.registerOnNotifyCommand(vibrateCommand)
        }

        val barcodeAnalyser = GoogleBarcodeAnalyser()
        googleBarcodeAnalyser = barcodeAnalyser
        cameraAnalyser.setBarcodeAnalyser(barcodeAnalyser,barcodeAnalyser)

        if(!settings.manualScan.value){
            googleBarcodeAnalyser.setContinuousMode()
        }
        else{
            googleBarcodeAnalyser.setManualMode()
        }

    }


    fun getAppVersion(): String {
        return "1"
    }

    fun showOnPlayStore(context: Context) {
        val packageName =  "com.idir.barcodescanner"
        try {
            ContextCompat.startActivity(
                context,
                Intent(
                    Intent.ACTION_VIEW,
                    Uri.parse("market://details?id=$packageName")
                ),
                null
            )
        } catch (e: ActivityNotFoundException) {
            ContextCompat.startActivity(
                context,
                Intent(
                    Intent.ACTION_VIEW,
                    Uri.parse("https://play.google.com/store/apps/details?id=$packageName")
                ),
                null
            )
        }

    }



}