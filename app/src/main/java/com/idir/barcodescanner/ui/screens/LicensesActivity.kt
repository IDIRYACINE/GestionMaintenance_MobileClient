package com.idir.barcodescanner.ui.screens

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import com.idir.barcodescanner.infrastructure.Provider
import com.idir.barcodescanner.infrastructure.licenses.LicensesManager
import com.idir.barcodescanner.ui.components.LicenseFragment
import com.idir.barcodescanner.ui.components.SecondaryAppBar

class LicensesActivity : ComponentActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            LicensesScreen(Provider.licenseManager)
        }
    }
}

@Composable
fun LicensesScreen (licensesManager: LicensesManager){

    Scaffold(
        topBar = { SecondaryAppBar(title = licensesManager.getTitle())},

    ) {
        paddingValues -> LazyColumn(
            modifier = Modifier.padding(paddingValues)
        ){

        licensesManager.licenses.forEach{
                license -> item{ LicenseFragment(title = license.name , license = license.content) }
        }
        }
    }

}