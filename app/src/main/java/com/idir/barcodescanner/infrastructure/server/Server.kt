package com.idir.barcodescanner.infrastructure.server

import com.idir.barcodescanner.data.SessionRecord

class Server : IServer{
    override fun connect(identifier: String, password: String): Boolean {
        TODO("Not yet implemented")
    }

    override fun sendScannedRecord(sessionRecord: SessionRecord) {
        TODO("Not yet implemented")
    }

    override fun sendRecordCollection(sessionRecords: Collection<SessionRecord>) {
        TODO("Not yet implemented")
    }
}