package com.idir.barcodescanner.infrastructure.barcode

import androidx.camera.core.CameraSelector
import androidx.camera.core.ImageAnalysis
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

class CameraAnalyser : ICameraAnalyser{

    private lateinit var barcodeProcessor : IBarcodeAnalyser

    private var barcodeAnalyser : ImageAnalysis = ImageAnalysis.Builder()
        .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
        .build()

    private var cameraLens = mutableStateOf(CameraSelector.LENS_FACING_BACK)


    override fun setBarcodeAnalyser(analyser: ImageAnalysis.Analyzer,processor:IBarcodeAnalyser) {
        val cameraExecutor: ExecutorService = Executors.newSingleThreadExecutor()
        barcodeAnalyser.setAnalyzer(cameraExecutor, analyser)
        barcodeProcessor = processor
    }

    override fun getBarcodeAnalyser(): ImageAnalysis{
        return barcodeAnalyser
    }

    override fun toggleActiveState() {
        barcodeProcessor.toggleActiveState()
    }

    override fun getActiveState(): MutableState<Boolean> {
        return barcodeProcessor.getActiveState()
    }

    override fun setCamera(cameraId: Int) {
        cameraLens.value = cameraId
    }

    override fun getCamera(): State<Int> {
        return cameraLens
    }

}