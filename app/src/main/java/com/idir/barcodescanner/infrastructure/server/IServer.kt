@file:Suppress("unused")

package com.idir.barcodescanner.infrastructure.server

import com.idir.barcodescanner.data.SessionRecord

interface IServer {

    fun connect(identifier:String,password:String) : Boolean
    fun sendScannedRecord(sessionRecord:SessionRecord)
    fun sendRecordCollection(sessionRecords :Collection<SessionRecord>)
}

interface IApi{val api:String}
interface IApiQuery{ val queryName: String }
interface IApiHeaders{val headerName:String}

object ServerApi{
    private const val apiVersion = 0
    private const val host = "localhost"
    private const val port = 3000
    private const val apiPath = "v"
    const val accessKey = ""

    fun formatBaseApiUrl(): String {
        return "$host:$port/$apiPath/$apiVersion"
    }

    enum class Api(override val api: String) : IApi{
        LoginUser("loginUser"),
        PostSessionRecord("postSessionRecord"),
        PostSessionRecordCollection("postSessionRecordCollection")
    }

    enum class ApiQueries(override val queryName: String):IApiQuery{
        Identifier("username"),
        Password("password"),
    }

    enum class ApiHeaders(override val headerName: String):IApiHeaders{
        AuthHeader("access-token"),
        ContentType("content-type"),
    }

    data class LoginResponse(val isAuthorised:Boolean)
    data class OperationResponse(val success:Boolean)

}