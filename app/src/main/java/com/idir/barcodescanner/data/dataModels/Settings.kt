
package com.idir.barcodescanner.data.dataModels

import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf

data class Settings(val host:MutableState<String>  = mutableStateOf(""),
                    val username:MutableState<String>  = mutableStateOf(""),
                    val password:MutableState<String>  = mutableStateOf(""),
                    val vibrate:MutableState<Boolean> = mutableStateOf(false),
                    val playSound:MutableState<Boolean> = mutableStateOf(false),
                    val manualScan : MutableState<Boolean> = mutableStateOf(false),
                    val duplicateGroup : MutableState<Boolean> = mutableStateOf(false),
                    val duplicateScan : MutableState<Boolean> = mutableStateOf(false),
                    val clearSend : MutableState<Boolean> = mutableStateOf(false)

)