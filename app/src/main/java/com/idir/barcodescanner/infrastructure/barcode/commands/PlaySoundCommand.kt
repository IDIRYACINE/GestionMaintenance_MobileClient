package com.idir.barcodescanner.infrastructure.barcode.commands

import android.media.MediaActionSound

class PlaySoundCommand : ICommand{
    private val mediaActionSound : MediaActionSound = MediaActionSound()

    override fun execute() {
        mediaActionSound.play(MediaActionSound.SHUTTER_CLICK)
    }
}