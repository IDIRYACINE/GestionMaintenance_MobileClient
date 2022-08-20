package com.idir.barcodescanner.ui.components.barcodes

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.idir.barcodescanner.application.HomeController
import com.idir.barcodescanner.data.ActionsIcons
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.ui.Mocks.Mocks
import com.idir.barcodescanner.ui.components.ActionsGroupDrop


@Composable
fun BarcodeGroupCard(group : BarcodeGroup, controller:HomeController){
    val context = LocalContext.current
    val visibleGroupAction = remember{ mutableStateOf(false) }

    fun toggleGroupActions(){
        visibleGroupAction.value = !visibleGroupAction.value
    }

    Card(
        modifier = Modifier
            .padding(15.dp)
            .clickable {
                controller.startGroupContentActivity(context, group)
            },
        elevation = 10.dp
    ) {
        Row(
            modifier = Modifier.fillMaxWidth().padding(15.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {

            Text(text = group.name.value)

            Row(
               horizontalArrangement = Arrangement.End
            ) {

                IconButton(onClick = {
                    toggleGroupActions()
                }) {
                    Icon(imageVector = ActionsIcons.More ,contentDescription =  null)
                }
                DropdownMenu(
                    expanded = visibleGroupAction.value,
                    onDismissRequest = { visibleGroupAction.value = false }
                ) {
                    ActionsGroupDrop(controller = controller, barcodeGroup = group,visibleGroupAction)
                }

            }
            }
        }
    }

@Preview
@Composable
fun GroupPreview(){
    val controller = Mocks.mockHomeController()
    val group = Mocks.mockBarcodeGroup()

BarcodeGroupCard(group = group, controller = controller)
}
