package com.idir.barcodescanner.data

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AddCircle
import androidx.compose.material.icons.sharp.*
import androidx.compose.ui.graphics.vector.ImageVector
import com.idir.barcodescanner.R

object  ActionsIcons {
    val Delete : ImageVector = Icons.Sharp.Delete
    val Add : ImageVector =  Icons.Filled.AddCircle
    val Send : ImageVector = Icons.Sharp.Send
    val Edit : ImageVector = Icons.Sharp.Edit
    val Clear : ImageVector = Icons.Sharp.Clear
    val More: ImageVector = Icons.Sharp.MoreVert

}


 object SettingsIcons{
     const val Vibrate : Int = R.drawable.ic_vibrate
     const val PlaySound : Int = R.drawable.ic_sound
     const val ManualScan : Int =R.drawable.ic_hand
     const val DuplicateBarcode : Int =R.drawable.ic_repeat_barcode
     const val DuplicateGroup : Int = R.drawable.ic_repeat_group
     const val Clear : Int = R.drawable.ic_clear

}

sealed class CameraIcons(var icon: Int){
    object Flash : CameraIcons(R.drawable.ic_flash)
    object Analyse : CameraIcons(R.drawable.ic_recording_filled)
}
