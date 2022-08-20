package com.idir.barcodescanner.infrastructure.barcode.manager

import android.content.Context
import androidx.compose.runtime.snapshots.SnapshotStateList
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.StorageManager
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeGroupHelper
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeHelper
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeManager
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.encodeToJsonElement


class BarcodeManager : IBarcodeManager {

    /* Data Structures */
    private lateinit var register:MutableMap<Int,MutableMap<String,Int>>
    private lateinit var barcodesRegister : MutableMap<String,Int>
    private lateinit var barcodes : MutableMap<Int,BarcodeGroup>
    private lateinit var groups : SnapshotStateList<BarcodeGroup>
    private var editableGroup : BarcodeGroup? = null

    /* Actions Mode */
    private var groupHelper : IBarcodeGroupHelper? = null
    private lateinit var barcodeHelper: IBarcodeHelper
    private val activeGroups = mutableListOf<BarcodeGroup>()

    fun load(context: Context,storageManager: StorageManager) {

    }

    override fun encodeToJson() : String{
        val map = mapOf(
            StorageManager.GROUPS_REGISTER_KEY to Json.encodeToJsonElement(register),
            StorageManager.BARCODES_REGISTER_KEY to  Json.encodeToJsonElement(barcodesRegister),
            StorageManager.GROUPS_KEY to Json.encodeToJsonElement(barcodes)
        )
        return Json.encodeToString(map)
    }

    override fun encodeActiveToJson() : String{
        val map = mapOf(
            StorageManager.GROUPS_KEY to activeGroups
        )
        return Json.encodeToString(map)
    }

    override fun clearAll() {
        groups.forEach {
            clearGroup(it)
        }
    }

    override fun clearActiveGroups() {
        activeGroups.forEach {
            clearGroup(it)
        }
    }

    override fun clearGroup(group: BarcodeGroup) {
        register[group.id]?.clear()
        group.barcodes.clear()
    }


    override fun addGroup(groupName: String) {
        groupHelper!!.add(groupName)
    }

    override fun editGroup( newName:String) {
        editableGroup!!.name.value = newName
    }

    override fun removeGroup(groupEntry: BarcodeGroup) {
        activeGroups.remove(groupEntry)
        groupHelper!!.remove(groupEntry)
    }

    override fun setActiveGroup(groupEntry: BarcodeGroup) {
        val group = barcodes[groupEntry.id]!!
        editableGroup = group
    }

    override fun getActiveGroup() : BarcodeGroup{
        return editableGroup!!
    }

    override fun getGroups(): List<BarcodeGroup> {
        return groups
    }

}
