package com.idir.barcodescanner.infrastructure

import android.content.Context
import android.content.res.Resources
import androidx.lifecycle.ViewModel

class ResourcesLoader(context: Context):ViewModel(){

    private val resources : Resources = context.resources
    private val stringResources = mutableMapOf<String,String>()

    fun loadStringResource(resourceId:Int) : String{
        val resourceName = resources.getResourceName(resourceId)

        if(stringResources.containsKey(resourceName)){
            return stringResources[resourceName]!!
        }
        val resourceValue = resources.getString(resourceId)
        stringResources[resourceName] = resourceValue

        return resourceValue
    }


}