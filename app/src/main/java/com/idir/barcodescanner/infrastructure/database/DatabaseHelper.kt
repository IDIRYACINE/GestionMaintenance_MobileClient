package com.idir.barcodescanner.infrastructure.database

import android.database.Cursor
import com.idir.barcodescanner.data.dataModels.FamilyCode
import com.idir.barcodescanner.data.dataModels.InventoryProduct
import com.idir.barcodescanner.data.dataModels.StockProduct

class DatabaseHelper(private val database:IDatabase) {

    fun loadProduct(barcode:Int) : LoadedCursorResult? {
        val cursor = database.fetchInventoryProduct(barcode)
        if(cursor.moveToFirst()){
            return LoadedCursorResult(
                constructFamilyCode(cursor),
                constructStockProduct(cursor),
                constructInventoryProduct(cursor)
            )
        }
        return null
    }

    private fun constructFamilyCode(cursor: Cursor): FamilyCode {
        val familyCodeIndex =
            cursor.getColumnIndex(DatabaseMetaData.FamilyCodesTable.Attributes.FamilyCode.columnName)
        val familyNameIndex =
            cursor.getColumnIndex(DatabaseMetaData.FamilyCodesTable.Attributes.FamilyName.columnName)

        return FamilyCode(
            cursor.getInt(familyCodeIndex),
            cursor.getString(familyNameIndex)
        )
    }

    private fun constructInventoryProduct(cursor: Cursor): InventoryProduct {
        val articleIdIndex =
            cursor.getColumnIndex(DatabaseMetaData.InventoryTable.Attributes.ArticleId.columnName)
        val barcodeIndex =
            cursor.getColumnIndex(DatabaseMetaData.InventoryTable.Attributes.Barcode.columnName)
        val stockIdIndex =
            cursor.getColumnIndex(DatabaseMetaData.InventoryTable.Attributes.StockId.columnName)

        val scanTime = null

        return InventoryProduct(
            cursor.getInt(articleIdIndex),
            cursor.getInt(barcodeIndex),
            cursor.getInt(stockIdIndex),
            scanTime
        )
    }

    private fun constructStockProduct(cursor: Cursor): StockProduct {
        val articleIdIndex =
            cursor.getColumnIndex(DatabaseMetaData.StockTable.Attributes.ArticleId.columnName)
        val articleNameIndex =
            cursor.getColumnIndex(DatabaseMetaData.StockTable.Attributes.ArticleName.columnName)
        val familyCodeIndex =
            cursor.getColumnIndex(DatabaseMetaData.StockTable.Attributes.FamilyCode.columnName)

        return StockProduct(
            cursor.getInt(articleIdIndex),
            cursor.getString(articleNameIndex),
            cursor.getInt(familyCodeIndex)
        )
    }

    private fun getCurrentDate(){

    }

}

data class LoadedCursorResult(val familyCode: FamilyCode, val stockProduct: StockProduct, val inventoryProduct: InventoryProduct)