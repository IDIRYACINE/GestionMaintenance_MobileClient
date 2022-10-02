package com.idir.barcodescanner.infrastructure.database

import android.database.Cursor
import com.idir.barcodescanner.data.dataModels.SessionRecord

class RemoteDatabase : IDatabase{
    override fun connect() {
        TODO("Not yet implemented")
    }

    override fun disconnect() {
        TODO("Not yet implemented")
    }

    override fun registerSessionRecord(record: SessionRecord) {
        TODO("Not yet implemented")
    }

    override fun fetchSessionRecords(): Cursor {
        TODO("Not yet implemented")
    }

    override fun fetchInventoryProduct(barcode: Int): Cursor {
        TODO("Not yet implemented")
    }

}