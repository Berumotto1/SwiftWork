//
//  SQLiteManager.swift
//  OrderSystem
//
//  Created by yang on 2020/5/24.
//  Copyright © 2020 yang. All rights reserved.
//

import Foundation

class SQLiteManager: NSObject {
    private var dbPath:String!
    private var database:OpaquePointer? = nil
    
    static var sharedInstance:SQLiteManager{
        return SQLiteManager()
    }
    
    override init() {
        super.init()
        let dirpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        dbPath = dirpath.appendingPathComponent("ios3.sqlite").path
    }
    
    func openDB() -> Bool {
        let result = sqlite3_open(dbPath, &database)
        if result != SQLITE_OK{
            print("fail to open database")
            return false
        }
        return true
    }
    
    func closeDB()  {
        sqlite3_close(database)
    }
    
    func execNoneQuerySQL(sql:String) -> Bool{
        var errMsg:UnsafeMutablePointer<Int8>? = nil
        let cSql = sql.cString(using: String.Encoding.utf8)!
        
        if sqlite3_exec(database, cSql, nil, nil, &errMsg) == SQLITE_OK{
            return true
        }
        let msg = String.init(cString: errMsg!)
        print(msg)
        return false
    }
    
    func execQuerySQL(sql:String) -> [[String:AnyObject]]? {
        let cSql = sql.cString(using: String.Encoding.utf8)!
        var statement:OpaquePointer? = nil
            
        
        if sqlite3_prepare_v2(database,cSql, -1, &statement, nil) != SQLITE_OK{
            sqlite3_finalize(statement)
            
            print("执行\(sql)错误\n")
            let errmsg = sqlite3_errmsg(database)
            if errmsg != nil{
                print(errmsg!    )
            }
            return nil
        }
        var rows = [[String:AnyObject]]()
        while sqlite3_step(statement) == SQLITE_ROW {
            rows.append(record(stmt:statement!))
        }
        
        sqlite3_finalize(statement)
        return rows
    }
    
    private func record(stmt:OpaquePointer) -> [String:AnyObject]{
        var row = [String:AnyObject]()
        
        for col in 0 ..< sqlite3_column_count(stmt){
            let cName = sqlite3_column_name(stmt, col)
            let name = String(cString: cName!, encoding:  String.Encoding.utf8)
            
            var value:AnyObject?
            
            switch (sqlite3_column_type(stmt, col)) {
            case SQLITE_FLOAT:
                value = sqlite3_column_double(stmt, col) as AnyObject
            case SQLITE_INTEGER:
                value = Int(sqlite3_column_int(stmt, col)) as AnyObject
            case SQLITE3_TEXT:
                let cText = sqlite3_column_text(stmt, col)
                value = String.init(cString: cText!) as AnyObject
            case SQLITE_NULL:
                value = NSNull()
            default:
                print("不支持数据类型 ")
            }
            row[name!] = value ?? NSNull()
        }
        return row
        
    }
    
    func randomMD5() -> String {
        let identifier=CFUUIDCreate(nil)
        let identifierString=CFUUIDCreateString(nil, identifier) as String
        let cStr = identifierString.cString(using: .utf8)
        
        
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        CC_MD5(cStr, CC_LONG(strlen(cStr!)), &digest)
        
        var output = String()
        
        for i in digest {
            
            output = output.appendingFormat("%02X", i)
        }
        
        return output;
    }
    
}
