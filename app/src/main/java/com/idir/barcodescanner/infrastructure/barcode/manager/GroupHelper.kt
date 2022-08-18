package com.idir.barcodescanner.infrastructure.barcode.manager

import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.snapshots.SnapshotStateList
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeBroadcaster
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeGroupHelper
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeHelper
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeSubscriber


class GroupHelper (
    private val register:MutableMap<String,MutableMap<String,Int>>,
    private val data:MutableMap<String,BarcodeGroup>,
    private val groups:SnapshotStateList<BarcodeGroup>,
) : IBarcodeGroupHelper() , IBarcodeSubscriber{

    private lateinit var barcodeHelper: IBarcodeHelper

    override fun add(groupName: String) {
      //TODO
    }

    override fun remove(group: BarcodeGroup) {
        //TODO

    }

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
        //TODO
    }

    override fun notify(rawBarcodes: List<String>) {
        //TODO
    }
}