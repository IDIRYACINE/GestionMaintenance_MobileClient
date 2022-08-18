package com.idir.barcodescanner

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Scaffold
import androidx.compose.material.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.compose.rememberNavController
import com.google.accompanist.permissions.ExperimentalPermissionsApi
import com.idir.barcodescanner.infrastructure.HttpManager
import com.idir.barcodescanner.infrastructure.Provider
import com.idir.barcodescanner.infrastructure.services.ServiceBroadcaster
import com.idir.barcodescanner.ui.components.BottomNavigationBar
import com.idir.barcodescanner.ui.components.NavigationGraph
import com.idir.barcodescanner.ui.components.PrimaryAppBar
import com.idir.barcodescanner.ui.theme.CodeBarScannerTheme
import com.idir.barcodescanner.ui.theme.Green500
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json


class MainActivity : ComponentActivity() {
    private lateinit var context : Context

    private lateinit var handler :Handler

    override fun onCreate(savedInstanceState: Bundle?) {
        setContent {
            SplashScreen()
        }
        super.onCreate(savedInstanceState)
        initApp()

    }

    private fun initApp(){
        context = App.appInstance.applicationContext

        handler = Handler(Looper.getMainLooper()) {
            if(it.what == HttpManager.SUCCESS){
                val resources = context.resources
                Toast.makeText(context, resources.getString(R.string.send_data_failed), Toast.LENGTH_LONG).show()
            }
            else{
                val resources = context.resources
                Toast.makeText(context, resources.getString(R.string.send_data_failed), Toast.LENGTH_LONG).show()
            }
            return@Handler true
        }

        Provider.initApp(this,handler)
        setContent {
            CodeBarScannerTheme {
                App(handler)
            }
        }
    }

    override fun onStop() {
        val settings : String = Json.encodeToString(Provider.settingsController.settings)
        val groups : String = Provider.barcodesManager.encodeToJson()

        val data = Bundle()

        data.putString(ServiceBroadcaster.SETTINGS_KEY,settings)
        data.putString(ServiceBroadcaster.BARCODE_KEY,groups)

        val saveDataIntent = Intent(this,ServiceBroadcaster::class.java)
        saveDataIntent.putExtras(data)
        sendBroadcast(saveDataIntent)

        super.onStop()
    }
}

@OptIn(ExperimentalPermissionsApi::class)
@Composable
fun App(handler: Handler) {
    val navController = rememberNavController()
    Scaffold(
        topBar = { PrimaryAppBar() },
        bottomBar = { BottomNavigationBar(navController) }
    ){
            innerPadding ->  Box(modifier = Modifier.padding(innerPadding)) {
                NavigationGraph(navController = navController,handler)
            }
    }
}

@Composable
fun SplashScreen(){
    Surface(color = Green500) {
    }
}

