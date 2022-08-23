package com.idir.barcodescanner.infrastructure.barcode.manager

import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.Provider
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeBroadcaster
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeGroupHelper
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeHelper
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeSubscriber


class GroupHelper(
    private val groups:MutableMap<Int,BarcodeGroup>,
    private val database
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
        barcodeHelper.add(Integer.parseInt(rawBarcode))
    }

    override fun notify(rawBarcodes: List<String>) {
        //TODO
        barcodeHelper.addAll(rawBarcodes)

    }

    private fun checkGroupExistence(groupId:Int){
        if(!groups.containsKey(groupId)){
            val groupInstance = BarcodeGroup()
            groups.put(groupId,)
        }
    }
}