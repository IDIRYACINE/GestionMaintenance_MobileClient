@file:Suppress("unused")
package com.idir.barcodescanner.infrastructure.database

import android.database.Cursor
import com.idir.barcodescanner.data.dataModels.SessionRecord


interface IDatabase {
    fun connect()
    fun disconnect()
    fun registerSessionRecord(record: SessionRecord)
    fun fetchSessionRecords() : Cursor
    fun fetchInventoryProduct(barcode:Int) : Cursor
}

interface ColumnType { val type: String }
interface ColumnName { val columnName: String }

object DatabaseMetaData{
    enum class ETables{
        Stock,
        Inventory,
        FamilyCodes,
        Records
    }

    object StockTable{
        enum class Attributes(override val columnName:String):ColumnName{
            ArticleId("articleId"),
            FamilyCode("familyCode"),
            ArticleName("articleName"),
        }

        enum class AttributesTypes(override val type:String):ColumnType{
            ArticleId("INTEGER PRIMARY KEY"),
            ArticleName("VARCHAR"),
            FamilyCode("INTEGER FOREIGN KEY (${Attributes.FamilyCode.columnName})" +
                    "REFERENCES ${ETables.FamilyCodes} (${FamilyCodesTable.Attributes.FamilyCode.columnName})"),
        }
    }

    object InventoryTable{
        enum class Attributes(override val columnName:String):ColumnName{
            ArticleId("articleId"),
            Barcode("barcode"),
            StockId("stockId"),
        }

        enum class AttributesTypes(override val type:String):ColumnType{
            ArticleId("INTEGER PRIMARY KEY"),
            Barcode("INTEGER"),
            StockId("INTEGER FOREIGN KEY (${Attributes.StockId.columnName})" +
                    "REFERENCES ${ETables.Stock} (${StockTable.Attributes.ArticleId.columnName})"),
        }
    }

    object FamilyCodesTable{
        enum class Attributes(override val columnName:String):ColumnName{
            FamilyCode("familyCode"),
            FamilyName("familyName")
        }

        enum class AttributesTypes(override val type:String):ColumnType{
            FamilyCode("INTEGER"),
            FamilyName("VARCHAR")
        }
    }

    object RecordsTable{
        enum class Attributes(override val columnName:String):ColumnName{
            SessionId("sessionId"),
            RecordId("recordId"),
            WorkerId("workerId"),
            WorkerName("workerName"),
            StockId("stockId"),
            InventoryId("inventoryId"),
            InventoryCount("inventoryCount"),
            Date("recordDate"),
        }

        enum class AttributesTypes(override val type:String):ColumnType{
            SessionId("INTEGER"),
            RecordId("INTEGER PRIMARY KEY"),
            WorkerId("INTEGER"),
            WorkerName("VARCHAR"),
            StockId("INTEGER"),
            InventoryId("INTEGER FOREIGN KEY (${InventoryTable.Attributes.ArticleId.columnName})" +
                    "REFERENCES ${ETables.Inventory} (${InventoryTable.Attributes.ArticleId.columnName})"),
            InventoryCount("INTEGER"),
            Date("DATE"),
        }
    }

}
