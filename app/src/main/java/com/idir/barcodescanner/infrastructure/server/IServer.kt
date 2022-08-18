@file:Suppress("unused")

package com.idir.barcodescanner.infrastructure.server

import com.idir.barcodescanner.data.SessionRecord

interface IServer {
    fun connect(identifier:String,password:String) : Boolean
    fun sendScannedRecord(sessionRecord:SessionRecord)
    fun sendRecordCollection(sessionRecords :Collection<SessionRecord>)
}

interface IApi{val api:String}

object ServerApi{
    const val apiVersion = 0
    const val host = "localhost"
    const val port = 3000
    const val apiPath = "v"

    enum class Api(override val api: String) : IApi{
        LoginUser("loginUser"),
        PostSessionRecord("postSessionRecord"),
        PostSessionRecordCollection("postSessionRecordCollection")
    }
}