package com.idir.barcodescanner.infrastructure.licenses

import com.idir.barcodescanner.R
import com.idir.barcodescanner.data.License
import com.idir.barcodescanner.infrastructure.ResourcesLoader

class LicensesManager(private val resourcesLoader: ResourcesLoader) {

    companion object{
        val licensesNames : List<Int> = listOf()
        val licensesContents : List<Int> = listOf()
    }

    private val _licenses : MutableList<License> = mutableListOf()
    val licenses : List<License> = _licenses


    private fun registerLicense(nameId:Int ,contentId:Int){
        val name = resourcesLoader.loadStringResource(nameId)
        val content = resourcesLoader.loadStringResource(contentId)
        _licenses.add(License(name,content))
    }

    fun getTitle(): String{
        return resourcesLoader.loadStringResource(R.string.settings_licenses)
    }

}