package com.idir.barcodescanner.ui.screens

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.Divider
import androidx.compose.material.Switch
import androidx.compose.material.SwitchDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.idir.barcodescanner.App
import com.idir.barcodescanner.R
import com.idir.barcodescanner.application.SettingsController
import com.idir.barcodescanner.data.dataModels.Settings
import com.idir.barcodescanner.data.SettingsIcons
import com.idir.barcodescanner.infrastructure.Provider
import com.idir.barcodescanner.ui.components.SettingRow
import com.idir.barcodescanner.ui.components.SettingSectionHeader
import com.idir.barcodescanner.ui.components.barcodes.ManageCardPopup
import com.idir.barcodescanner.ui.theme.Green200
import com.idir.barcodescanner.ui.theme.Green500

object SettingsScreenConstants{
    val dividerThickness  = 1.dp
    const val sectionTitleTopPadding = 10
}

@Composable
fun SettingsScreen(controller : SettingsController = Provider.settingsController){
    val settings = controller.settings
    val openDialog = remember{ controller.popupCardState.isOpen}

    if(openDialog.value){
        ManageCardPopup(state = controller.popupCardState)
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState()),
        horizontalAlignment = Alignment.CenterHorizontally

    ){
        GeneralSection(settings = settings,controller = controller)
        ScanControlsSection(settings = settings,controller = controller)
        AboutSection(controller = controller)
    }
}

@Composable
fun SelfSwitch(state: MutableState<Boolean>,onClick : ()->Unit = {}){
    Switch(checked = state.value,
        colors = SwitchDefaults.colors(
        checkedThumbColor = Green500,
        checkedTrackColor = Green200
    ), onCheckedChange = { onClick() })
}

@Composable
fun GeneralSection(settings: Settings, controller: SettingsController){
    SettingSectionHeader(title = R.string.settings_section_general,padding=SettingsScreenConstants.sectionTitleTopPadding)

    SettingRow(
        title = controller.loadStringResource(R.string.settings_host_url),
        description = settings.host.value,
        onClick = {controller.showEditPopup(settings.host,R.string.popup_host)},
        actionComposable = {},
    )

    SettingRow(
        title = controller.loadStringResource(R.string.settings_host_username),
        description = settings.username.value,
        onClick = {controller.showEditPopup(settings.username,R.string.popup_username)},
        actionComposable = {},
    )

    SettingRow(
        title = controller.loadStringResource(R.string.settings_host_password),
        description = settings.password.value,
        onClick = { controller.showEditPopup( settings.password,R.string.popup_password)},
        actionComposable = {},
    )

    Divider(color= Color.LightGray, thickness = SettingsScreenConstants.dividerThickness)

}

@Composable
fun ScanControlsSection(settings: Settings, controller:SettingsController){
    Divider(color= Color.LightGray, thickness =SettingsScreenConstants.dividerThickness)
    SettingSectionHeader(title = R.string.settings_section_scanControls,padding=SettingsScreenConstants.sectionTitleTopPadding)

    SettingRow(
        title = controller.loadStringResource(R.string.settings_vibration),
        icon = SettingsIcons.Vibrate,
        onClick = {controller.toggleVibration()},
        actionComposable = { SelfSwitch(state = settings.vibrate, onClick = { controller.toggleVibration() }) },
    )

    SettingRow(
        title = controller.loadStringResource(R.string.settings_playSound),
        icon = SettingsIcons.PlaySound,
        onClick = {controller.togglePlaySound()},
        actionComposable = { SelfSwitch(state = settings.playSound, onClick = {controller.togglePlaySound()}) },
    )

    SettingRow(
        title = controller.loadStringResource(R.string.settings_scanManually),
        description = controller.loadStringResource(R.string.settings_scanManually_description),
        icon = SettingsIcons.ManualScan,
        onClick = {controller.toggleManualScan()},
        actionComposable = { SelfSwitch(state = settings.manualScan,onClick = {controller.toggleManualScan()}) },
    )

    SettingRow(
        title = controller.loadStringResource(R.string.settings_clearSend),
        description = controller.loadStringResource(R.string.settings_clearSend_description),
        icon = SettingsIcons.Clear,
        onClick = {controller.toggleClearSend()},
        actionComposable = { SelfSwitch(state = settings.clearSend, onClick = {controller.toggleClearSend()}) },
    )


    Divider(color= Color.LightGray, thickness = SettingsScreenConstants.dividerThickness)
}

@Composable
fun AboutSection(controller:SettingsController){
    val context =  App.appInstance.applicationContext
    Divider(color= Color.LightGray, thickness = SettingsScreenConstants.dividerThickness)
    SettingSectionHeader(title = R.string.settings_section_about, padding = SettingsScreenConstants.sectionTitleTopPadding)

    SettingRow(
        title = controller.loadStringResource(R.string.settings_version),
        description = controller.getAppVersion(),
        onClick = {
            controller.showOnPlayStore(context)

        },
        actionComposable = {},
    )
}
