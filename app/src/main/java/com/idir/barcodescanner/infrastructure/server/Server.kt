package com.idir.barcodescanner.infrastructure.server

import android.os.Handler
import android.os.Message
import com.google.gson.Gson
import com.idir.barcodescanner.data.SessionRecord
import okhttp3.*
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.RequestBody.Companion.toRequestBody

class Server(private val handler: Handler) : IServer{

    private val gson = Gson()
    private val jsonType : MediaType = "application/json; charset=utf-8".toMediaType()
    private val client : OkHttpClient = OkHttpClient()
    private val host : String = ServerApi.formatBaseApiUrl()

    override fun connect(identifier: String, password: String): Boolean {
        val responseBody : ResponseBody?
        try {
            val url = HttpUrl.Builder()
                .host(host)
                .addPathSegment(ServerApi.Api.LoginUser.api)
                .addQueryParameter(ServerApi.ApiQueries.Identifier.queryName,identifier)
                .addQueryParameter(ServerApi.ApiQueries.Password.queryName,password)
                .build()

            val request: Request.Builder = Request.Builder()
                .url(url)

            responseBody = getData(request)
            if (responseBody == null){
                return false
            }
        }
        catch (exceptions:Exception){
            onFail(handler)
            return false
        }

        val loginResponse : ServerApi.LoginResponse = gson.fromJson(responseBody.string(),ServerApi.LoginResponse::class.java)
        return loginResponse.isAuthorised
    }

    override fun sendScannedRecord(sessionRecord: SessionRecord) {
        try {
            val url = HttpUrl.Builder()
                .host(host)
                .addPathSegment(ServerApi.Api.PostSessionRecord.api)
                .build()

            val request: Request.Builder = Request.Builder()
                .url(url)

           postData(request,gson.toJson(sessionRecord))
        }
        catch (exceptions:Exception){
            onFail(handler)
        }
    }

    override fun sendRecordCollection(sessionRecords: Collection<SessionRecord>) {
        try {
            val url = HttpUrl.Builder()
                .host(host)
                .addPathSegment(ServerApi.Api.PostSessionRecordCollection.api)
                .build()

            val request: Request.Builder = Request.Builder()
                .url(url)

            postData(request,gson.toJson(sessionRecords))

        }
        catch (exceptions:Exception){
            onFail(handler)
        }
    }

    private fun postData(requestBuilder:Request.Builder,data:String): ResponseBody? {
        val request = requestBuilder
            .addHeader(ServerApi.ApiHeaders.AuthHeader.headerName,ServerApi.accessKey)
            .post(data.toRequestBody(jsonType))
            .build()

        client.newCall(request).execute().use { response -> return response.body }
    }

    private fun getData(requestBuilder:Request.Builder): ResponseBody? {
        val request = requestBuilder
            .addHeader(ServerApi.ApiHeaders.AuthHeader.headerName,ServerApi.accessKey)
            .get().build()

        client.newCall(request).execute().use { response -> return response.body }

    }

    private fun onFail(handler: Handler){
        val message: Message = handler.obtainMessage()
        message.sendToTarget()
    }

    private fun onSuccess(handler: Handler){
        val message: Message = handler.obtainMessage()
        message.sendToTarget()
    }

}