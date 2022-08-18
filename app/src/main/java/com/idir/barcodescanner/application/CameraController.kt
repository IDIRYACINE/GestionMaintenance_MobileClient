package com.idir.barcodescanner.application

import android.content.Context
import android.util.Log
import androidx.camera.core.Camera
import androidx.camera.core.CameraSelector
import androidx.camera.core.Preview
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.camera.view.PreviewView
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import com.google.common.util.concurrent.ListenableFuture
import com.idir.barcodescanner.infrastructure.barcode.ICameraAnalyser

class CameraController(private val cameraAnalyser: ICameraAnalyser){

    private var cameraPreview: MutableState<Preview?> = mutableStateOf(null)

    private var cameraId : State<Int> = cameraAnalyser.getCamera()

    private lateinit var camera: Camera

    private var isTorchOn = false

    fun setupCameraPreview(previewView: PreviewView,lifecycleOwner:LifecycleOwner,context: Context){

        val cameraProviderFuture: ListenableFuture<ProcessCameraProvider> =
            ProcessCameraProvider.getInstance(context)

        cameraProviderFuture.addListener({
            val barcodeAnalyser = cameraAnalyser.getBarcodeAnalyser()

            cameraPreview.value = Preview.Builder().build().also {
                it.setSurfaceProvider(previewView.surfaceProvider)
            }

            val cameraSelector = CameraSelector.Builder()
                .requireLensFacing(cameraId.value)
                .build()

            val cameraProvider: ProcessCameraProvider = cameraProviderFuture.get()
            try {
                cameraProvider.unbindAll()
                camera = cameraProvider.bindToLifecycle(
                    lifecycleOwner,
                    cameraSelector,
                    cameraPreview.value,
                    barcodeAnalyser
                )

            } catch (e: Exception) {
                Log.d("TAG", "CameraPreview: ${e.localizedMessage}")
            }
        }, ContextCompat.getMainExecutor(context))
    }

    fun setFrontCamera(){
        cameraAnalyser.setCamera(CameraSelector.LENS_FACING_FRONT)
    }

    fun setBackCamera(){
       cameraAnalyser.setCamera(CameraSelector.LENS_FACING_BACK)
    }

    fun toggleCameraFlash(){
        if(cameraId.value == CameraSelector.LENS_FACING_BACK){
            isTorchOn = !isTorchOn
            camera.cameraControl.enableTorch(isTorchOn)
        }
    }

    fun toggleAnalysisState(){
        cameraAnalyser.toggleActiveState()
    }

    fun getAnalysisState() : MutableState<Boolean>{
        return cameraAnalyser.getActiveState()
    }


}