package com.idir.barcodescanner.data

import androidx.compose.runtime.mutableStateOf
import com.idir.barcodescanner.data.dataModels.FamilyCode
import com.idir.barcodescanner.data.dataModels.InventoryProduct
import com.idir.barcodescanner.data.dataModels.StockProduct

object ProductsRegister {
    private val scannedInventoryProducts : MutableMap<Int,BarcodeGroup> = mutableMapOf()
    private val cachedFamilyCodes : MutableMap<Int,FamilyCode> = mutableMapOf()


    fun getFamilyCode(familyCode:Int) : FamilyCode?{
        return cachedFamilyCodes[familyCode]
    }

    fun getStockProduct(stockId:Int): StockProduct?{
        return scannedInventoryProducts[stockId]?.productInstance
    }

    fun getInventoryProduct(stockId:Int,articleId:Int): InventoryProduct?{
        return scannedInventoryProducts[stockId]?.barcodes?.get(articleId)
    }

    fun registerFamilyCode(familyCode:FamilyCode) {
        if(cachedFamilyCodes.containsKey(familyCode.familyCode)){
            return
        }
        cachedFamilyCodes.put(familyCode.familyCode,familyCode)
    }

    fun registerStockProduct(stockProduct:StockProduct){
        if(scannedInventoryProducts.containsKey(stockProduct.articleId)){
            return
        }

        val group = BarcodeGroup(
            stockProduct.articleId,
            stockProduct,
            mutableStateOf(0),
            mutableMapOf()
        )

        scannedInventoryProducts.put(stockProduct.articleId,group)
    }

    fun registerInventoryProduct(inventoryProduct:InventoryProduct) {
        if(scannedInventoryProducts.containsKey(inventoryProduct.stockId)){
            val group = scannedInventoryProducts[inventoryProduct.stockId]!!

            if(group.barcodes.containsKey(inventoryProduct.articleId)){
                return
            }

            group.barcodes.put(inventoryProduct.articleId,inventoryProduct)

        }
    }


}