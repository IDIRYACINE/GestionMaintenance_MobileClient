package com.idir.barcodescanner.infrastructure.database

import android.content.Context
import android.database.Cursor
import android.database.sqlite.SQLiteDatabase
import com.idir.barcodescanner.data.dataModels.SessionRecord
import java.util.*

class OfflineDatabase(databaseName:String,context:Context) : IDatabase{

    private lateinit var database : SQLiteDatabase

    private var databasePath:String = ""

    private var inventoryColumns : String

    private var stockColumns : String

    init {
        databasePath = "${context.filesDir}/$databaseName.db"

        val stockColumnsArray = arrayOf(
            DatabaseMetaData.StockTable.Attributes.FamilyCode,
            DatabaseMetaData.StockTable.Attributes.ArticleName,

            )
        stockColumns =  selectJoinColumnsHelper(
            DatabaseMetaData.ETables.Stock.name,
            stockColumnsArray.size,
            stockColumnsArray.iterator())

        val inventoryColumnsArray =  DatabaseMetaData.InventoryTable.Attributes.values()
        inventoryColumns = selectJoinColumnsHelper(
            DatabaseMetaData.ETables.Inventory.name,
            inventoryColumnsArray.size,
            inventoryColumnsArray.iterator())
    }

    override fun connect() {
        database= SQLiteDatabase.openDatabase(databasePath,null,SQLiteDatabase.OPEN_READWRITE)
    }

    override fun disconnect() {
        database.close()
    }

    override fun registerSessionRecord(record: SessionRecord) {
        val iterator = DatabaseMetaData.RecordsTable.Attributes.values().iterator()
        val size = DatabaseMetaData.RecordsTable.Attributes.values().size
        val query = "INSERT INTO " +
                "(${columnNamesHelper(iterator,size)}) " +
                "VALUES(${columnValuesHelper(listOf())})"

        database.execSQL(query)
    }

    override fun fetchSessionRecords() : Cursor {
        val query = "SELECT * FROM ${DatabaseMetaData.ETables.Records}"
        return database.rawQuery(query, arrayOf())
    }

    override fun fetchInventoryProduct(barcode: Int): Cursor {

        val joinStockClause = "INNER JOIN ${DatabaseMetaData.ETables.Stock}"+
                "${DatabaseMetaData.ETables.Stock}.${DatabaseMetaData.StockTable.Attributes.ArticleId} = " +
                "${DatabaseMetaData.ETables.Inventory}.${DatabaseMetaData.InventoryTable.Attributes.StockId}"


        val query = "SELECT $inventoryColumns,$stockColumns " +
                "FROM ${DatabaseMetaData.ETables.Inventory} " +
                "INNER JOIN ${DatabaseMetaData.ETables.Stock} $joinStockClause"

        return database.rawQuery(query, arrayOf())
    }

    private fun columnNamesHelper(columns: Iterator<ColumnName>,size:Int):String{
        var result = ""
        val lastElementIndex = size -1
        for (index in 0..size){
            result += if(index != lastElementIndex){
                "${columns.next()},"
            } else{
                "${columns.next()}"
            }
        }
        return result
    }

    private fun columnValuesHelper(values:List<Objects>):String{
        var result = ""
        val lastElementIndex = values.size -1
        for (index in 0..values.size){
            result += if(index != lastElementIndex){
                "${values[index]},"
            } else{
                "${values[index]}"
            }
        }
        return result
    }

    private fun selectJoinColumnsHelper(
        table:String,
        size:Int,
        columns: Iterator<ColumnName>
    ) : String{
        var result = ""

        val lastElementIndex = size -1
        for (index in 0..size){
            result += if(index != lastElementIndex){
                "$table.${columns.next()},"
            } else{
                "$table.${columns.next()}"
            }
        }
        return result
    }
}