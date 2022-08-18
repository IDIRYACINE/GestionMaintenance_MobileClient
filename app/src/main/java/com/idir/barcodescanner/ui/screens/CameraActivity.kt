package com.idir.barcodescanner.ui.screens

import android.Manifest
import android.widget.Toast
import androidx.camera.view.PreviewView
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalLifecycleOwner
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import com.google.accompanist.permissions.ExperimentalPermissionsApi
import com.google.accompanist.permissions.rememberPermissionState
import com.idir.barcodescanner.R
import com.idir.barcodescanner.application.CameraController
import com.idir.barcodescanner.data.CameraIcons
import com.idir.barcodescanner.infrastructure.Provider

@OptIn(ExperimentalPermissionsApi::class)
@Composable
fun CameraScreen(){
    val context = LocalContext.current

    val cameraPermissionState = rememberPermissionState(permission = Manifest.permission.CAMERA)
    val permissionFailedMessage = stringResource(R.string.cam_permission_fail)


    if(cameraPermissionState.hasPermission){
        CameraPreview()

    }else{
        Toast.makeText(context, permissionFailedMessage, Toast.LENGTH_SHORT).show()

        Box(contentAlignment = Alignment.Center)
        {
            Button(
                onClick = {
                    cameraPermissionState.launchPermissionRequest()

                },
                content = {Text("Request Permissions")}
            )
        }

    }

}


@Composable
fun CameraPreview(controller: CameraController = Provider.cameraController) {
    val context = LocalContext.current
    val lifecycleOwner = LocalLifecycleOwner.current

    val isAnalysing = controller.getAnalysisState()
    Box {
    AndroidView(
        factory = { AndroidViewContext -> PreviewView(AndroidViewContext) },
        modifier = Modifier.fillMaxSize(),
        update = { previewView -> controller.setupCameraPreview(previewView,lifecycleOwner,context) }
    )

    Row(
        verticalAlignment = Alignment.Bottom,
        horizontalArrangement = Arrangement.SpaceEvenly,
        modifier = Modifier
            .fillMaxWidth()
            .align(Alignment.BottomCenter)
            .padding(40.dp)
    ) {
        IconButton(
            onClick = {
                controller.toggleCameraFlash()
            }
        ) {
            Icon(
                painter = painterResource(CameraIcons.Flash.icon),
                contentDescription = null,
                tint = Color.LightGray
            )
        }
        IconButton(
            onClick = {
                controller.toggleAnalysisState()
            }
        ) {
            Icon(
                painter = painterResource(CameraIcons.Analyse.icon),
                tint = if(isAnalysing.value) Color.Red else Color.Green ,
                contentDescription = null)
        }
    }

    }

}
