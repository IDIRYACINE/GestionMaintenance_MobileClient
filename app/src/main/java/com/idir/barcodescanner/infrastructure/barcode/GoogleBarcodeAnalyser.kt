package com.idir.barcodescanner.infrastructure.barcode

import android.annotation.SuppressLint
import android.media.Image
import android.util.Log
import androidx.camera.core.ImageAnalysis
import androidx.camera.core.ImageProxy
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.mutableStateOf
import com.google.mlkit.vision.barcode.BarcodeScanner
import com.google.mlkit.vision.barcode.BarcodeScannerOptions
import com.google.mlkit.vision.barcode.BarcodeScanning
import com.google.mlkit.vision.barcode.common.Barcode
import com.google.mlkit.vision.common.InputImage
import com.idir.barcodescanner.infrastructure.Provider.barcodeBroadcaster

@SuppressLint("UnsafeOptInUsageError")
class GoogleBarcodeAnalyser : ImageAnalysis.Analyzer, IBarcodeAnalyser {

    class ManualAnalysis(private val isActive: MutableState<Boolean>) : IBarcodeAnalysisMode {

        override fun isAllowed() : Boolean{
            return isActive.value
        }

        override fun turnOf() {
            isActive.value = false
        }

        override fun turnOn() {
            isActive.value = true
        }

        override fun onAnalysisSuccess() {
            isActive.value = false
        }

    }

    class TimeStampHolder{
        private var lastAnalyzedTimeStamp:Long = 0L
        var currentTimestamp :Long = 0L

        private val minTimeBetweenScansInMillis = 4000L

        fun selfEqualize(){
            lastAnalyzedTimeStamp = currentTimestamp
        }

        fun minScreenshotIntervalPassed() =
            currentTimestamp - lastAnalyzedTimeStamp >= minTimeBetweenScansInMillis
    }

    class ContinuousAnalysis(
        private val isActive:MutableState<Boolean>,
        private var timeStampHolder: TimeStampHolder,
        ) : IBarcodeAnalysisMode{

        private var enabled = false

        override fun isAllowed() : Boolean{
            timeStampHolder.currentTimestamp = System.currentTimeMillis()
            if(isActive.value){
                enabled = timeStampHolder.minScreenshotIntervalPassed()
            }

            return enabled
        }

        override fun turnOf() {
            isActive.value = false
        }

        override fun turnOn() {
            isActive.value = true
        }

        override fun onAnalysisSuccess() {}

    }

    private val barcodeScanner : BarcodeScanner
    private val isActive = mutableStateOf(false)
    private var timeStampHolder = TimeStampHolder()
    private val continuousAnalysis = ContinuousAnalysis(isActive, timeStampHolder)
    private val manualAnalysis = ManualAnalysis(isActive)
    private var analysisMode : IBarcodeAnalysisMode = continuousAnalysis

    init {
        barcodeScanner = setUpBarcodeScanner()
    }
    private fun setUpBarcodeScanner() : BarcodeScanner {
        val options = BarcodeScannerOptions.Builder()
            .setBarcodeFormats(Barcode.FORMAT_ALL_FORMATS)
            .build()
        return BarcodeScanning.getClient(options)
    }


    private fun generateImageToProcess(imageToAnalyze : Image, image: ImageProxy): InputImage {
        return InputImage.fromMediaImage(imageToAnalyze, image.imageInfo.rotationDegrees)
    }

    override fun setManualMode() {
        analysisMode = manualAnalysis
    }

    override fun setContinuousMode() {
        analysisMode = continuousAnalysis
    }

    override fun toggleActiveState() {
        if(isActive.value){
            analysisMode.turnOf()
        }
        else{
            analysisMode.turnOn()
        }
    }

    override fun getActiveState(): MutableState<Boolean> {
        return isActive
    }

    private fun onBarcodeDetected(barcodes : List<Barcode>){
        barcodes.forEach { barcode ->
            barcode.rawValue?.let { barcodeValue ->
                barcodeBroadcaster.notifyBarcode(barcodeValue)
            }
        }
    }

    override fun analyze(image: ImageProxy) {
        if (analysisMode.isAllowed()) {
            image.image?.let { imageToAnalyze ->
                val imageToProcess = generateImageToProcess(imageToAnalyze,image)
                barcodeScanner.process(imageToProcess)
                    .addOnSuccessListener { barcodes ->
                        if (barcodes.isNotEmpty()) {
                            analysisMode.onAnalysisSuccess()
                            onBarcodeDetected(barcodes)
                        } else {
                            Log.d("TAG", "analyze: No barcode Scanned")
                        }
                    }
                    .addOnFailureListener { exception ->
                        Log.d("TAG", "BarcodeAnalyser: Something went wrong $exception")
                    }
                    .addOnCompleteListener {
                        image.close()
                    }
                timeStampHolder.selfEqualize()
            }
        } else {
            image.close()
        }
    }

}

