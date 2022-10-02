package com.idir.barcodescanner.infrastructure.barcode.manager

import androidx.compose.runtime.snapshots.SnapshotStateMap
import com.idir.barcodescanner.data.BarcodeGroup
import com.idir.barcodescanner.infrastructure.StorageManager
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeGroupHelper
import com.idir.barcodescanner.infrastructure.barcode.IBarcodeManager
import com.idir.barcodescanner.infrastructure.database.DatabaseHelper
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json


class BarcodeManager(dao:DatabaseHelper) : IBarcodeManager {

    /* Data Structures */
    private lateinit var barcodes : MutableMap<Int,BarcodeGroup>
    private lateinit var groups : SnapshotStateMap<Int,BarcodeGroup>
    private var editableGroup : BarcodeGroup? = null

    /* Actions Mode */
    private val groupHelper : IBarcodeGroupHelper
    private val activeGroups = mutableListOf<BarcodeGroup>()

    init{

        groupHelper = GroupHelper(groups,dao)
    }

    override fun encodeActiveToJson() : String{
        val map = mapOf(
            StorageManager.GROUPS_KEY to activeGroups
        )
        return Json.encodeToString(map)
    }

    override fun clearAll() {
        groups.forEach {
            clearGroup(it.value)
        }
    }

    override fun clearActiveGroups() {
        activeGroups.forEach {
            clearGroup(it)
        }
    }

    override fun clearGroup(group: BarcodeGroup) {
        group.barcodes.clear()
    }

    override fun setActiveGroup(groupEntry: BarcodeGroup) {
        val group = barcodes[groupEntry.id]!!
        editableGroup = group
    }

    override fun getActiveGroup() : BarcodeGroup{
        return editableGroup!!
    }

    override fun getGroups(): List<BarcodeGroup> {
        return groups.values.toList()
    }

}
