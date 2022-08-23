package com.idir.barcodescanner.infrastructure.barcode.manager

import com.idir.barcodescanner.data.Barcode
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeHelper


class BarcodeHelper(
    private val groups:MutableMap<Int,BarcodeGroup>
    ) : IBarcodeHelper() {

    override fun add(rawBarcode: Int) {
        //TODO
    }

    override fun addAll(rawBarcodes: List<String>) {
        rawBarcodes.forEach {
            //TODO
        }
    }


    override fun remove(
        barcode: Barcode,
        group: BarcodeGroup,
        iterator: MutableIterator<MutableMap.MutableEntry<String, Barcode>>,

    ) {
        fun updateRegisterKeyCount(key: String){
           //TODO
        }
        iterator.remove()
    }


    private fun checkGroupExistence(groupId:Int,group: BarcodeGroup){


    }

}