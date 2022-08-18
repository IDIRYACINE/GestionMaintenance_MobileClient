package com.idir.barcodescanner.data

data class SessionRecord(val sessionId:Int,val workerId:Int,val workerName:String,
    val date:String,val stockId:Int,val inventoryId:Int,val inventoryCount:Int)
