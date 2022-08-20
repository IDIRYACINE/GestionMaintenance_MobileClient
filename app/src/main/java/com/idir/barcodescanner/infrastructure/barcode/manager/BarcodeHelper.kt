package com.idir.barcodescanner.infrastructure.barcode.manager

import com.idir.barcodescanner.data.Barcode
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeHelper


class BarcodeHelper(
    private val groupsRegister:MutableMap<Int,MutableMap<String,Int>>,
    private val activeGroups:MutableList<BarcodeGroup>) : IBarcodeHelper() {

    private lateinit var register :MutableMap<Int,Int>


    override fun add(rawBarcode: Int) {
        //TODO
    }

    override fun addAll(rawBarcodes: List<Int>) {
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


    private fun checkBarcodeExistence(rawBarcode:String,group: BarcodeGroup){
       //TODO

    }

}