package com.idir.barcodescanner.infrastructure.barcode.commands

import android.content.Context
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import androidx.core.content.getSystemService

class VibrateCommand(context: Context) : ICommand {
    companion object{

        const val vibrationDurationInMillis : Long = 500

        const val vibrationAmplitude : Int = 2

    }

    private var vibrator:Vibrator?

    private var vibrationEffect : VibrationEffect? = null

    init{
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            vibrationEffect = VibrationEffect.createOneShot(
                vibrationDurationInMillis, vibrationAmplitude
            )
        }

        vibrator =  context.getSystemService()

    }

    override fun execute() {
        if(vibrator != null){
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
               vibrator!!.vibrate(vibrationEffect!!)
            }
            else{
                vibrator!!.vibrate(vibrationDurationInMillis)
            }
        }
    }

}
