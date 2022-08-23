package com.idir.barcodescanner.data.dataModels

data class SessionRecord(val sessionId:Int,val workerId:Int,val workerName:String,
    val date:String,val stockId:Int,val inventoryId:Int,val inventoryCount:Int)

data class SessionRecordJson(val sessionRecord: SessionRecord)

data class SessionRecordCollectionJson(val sessionRecords:Collection<SessionRecord>)
