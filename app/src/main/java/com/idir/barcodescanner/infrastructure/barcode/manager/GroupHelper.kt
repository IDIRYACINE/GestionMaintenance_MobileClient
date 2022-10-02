package com.idir.barcodescanner.infrastructure.barcode.manager

import androidx.compose.runtime.mutableStateOf
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.Provider
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeBroadcaster
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeGroupHelper
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeHelper
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeSubscriber
import com.idir.barcodescanner.infrastructure.database.DatabaseHelper
import com.idir.barcodescanner.infrastructure.database.LoadedCursorResult


class GroupHelper(
    private val groups:MutableMap<Int,BarcodeGroup>,
    private val dao : DatabaseHelper
    ): IBarcodeGroupHelper() , IBarcodeSubscriber{

    private lateinit var barcodeHelper: IBarcodeHelper

    override fun subscribeToBarcodeBroadcaster(broadcaster: IBarcodeBroadcaster) {
        broadcaster.subscribeToBarcodeStream(this)
    }

    override fun unsubscribeFromBarcodeBroadcaster(broadcaster: IBarcodeBroadcaster) {
        broadcaster.unsubscribeFromBarcodeStream(this)
    }

    override fun setBarcodeHelper(helper: IBarcodeHelper) {
        barcodeHelper = helper
    }

    override fun getId(): String {
        return ""
    }

    override fun notify(rawBarcode: String) {
        //TODO retrieve from database,parse,make server call , register on ui
        val parsedBarcode = Integer.parseInt(rawBarcode)
        val cursorResult = dao.loadProduct(parsedBarcode)
        if(cursorResult != null){
            checkGroupExistence(parsedBarcode , cursorResult)

        }
    }

    override fun notify(rawBarcodes: List<String>) {
        //TODO
        barcodeHelper.addAll(rawBarcodes)

    }

    private fun checkGroupExistence(groupId:Int,queryResult : LoadedCursorResult){
        if(!groups.containsKey(groupId)){
            val groupInstance = BarcodeGroup(groupId,queryResult.stockProduct, mutableStateOf(1),
                mutableMapOf(queryResult.inventoryProduct.barcode to queryResult.inventoryProduct))
            groups[groupId] = groupInstance
            return
        }
        val groupInstance = groups[groupId]!!
        groupInstance.count.value  += 1
        groupInstance.barcodes[queryResult.inventoryProduct.barcode] = queryResult.inventoryProduct
    }
}