package com.idir.barcodescanner.ui.components

import android.os.Handler
import androidx.annotation.StringRes
import androidx.compose.material.BottomNavigation
import androidx.compose.material.BottomNavigationItem
import androidx.compose.material.Icon
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import com.google.accompanist.permissions.ExperimentalPermissionsApi
import com.idir.barcodescanner.R
import com.idir.barcodescanner.ui.screens.*


@Composable
fun NavigationGraph(navController: NavHostController,handler: Handler) {
    NavHost(navController, startDestination = BottomNavItem.Home.screen_route) {
        composable(BottomNavItem.Home.screen_route) {
            HomeScreen()
        }
        composable(BottomNavItem.Scan.screen_route) {
            CameraScreen()
        }
        composable(BottomNavItem.Settings.screen_route) {
            SettingsScreen()
        }
    }
}


@Composable
fun BottomNavigationBar (navController : NavController){
    val items = listOf(
        BottomNavItem.Home,
        BottomNavItem.Scan,
        BottomNavItem.Settings
    )
    BottomNavigation {
        val navBackStackEntry by navController.currentBackStackEntryAsState()
        val currentRoute = navBackStackEntry?.destination?.route

        items.forEach{item ->
            BottomNavigationItem(
                selected = currentRoute == item.screen_route,
                icon = {
                    Icon(
                        painterResource(id = item.icon), contentDescription = item.screen_route)
                },
                label = { Text(text = stringResource(id = item.title), fontSize = 9.sp) },
                selectedContentColor = Color.White,
                unselectedContentColor = Color.White.copy(0.4f),
                alwaysShowLabel = true,
                onClick = {
                    navController.navigate(item.screen_route) {

                        navController.graph.startDestinationRoute?.let { screen_route ->
                            popUpTo(screen_route) {
                                saveState = true
                            }
                        }
                        launchSingleTop = true
                        restoreState = true
                    }
                }
            )
        }

    }
}

sealed class BottomNavItem(@StringRes var title:Int, var icon: Int, var screen_route:String){
    object Home : BottomNavItem(R.string.home_item , R.drawable.ic_home , "home")
    object Scan : BottomNavItem(R.string.scan_item , R.drawable.ic_crop,"scan")
    object Settings : BottomNavItem(R.string.settings_item , R.drawable.ic_settings,"settings")
}