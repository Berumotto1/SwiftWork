//
//  Test.swift
//  OrderSystem
//
//  Created by yang on 2020/5/25.
//  Copyright © 2020 yang. All rights reserved.
//

import Foundation

class Test {
    static func initDB(){
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB(){return}
        
//        let queryTable1="SELECT COUNT(*) FROM sqlite_master where type='table' and name='orders'"
       
        
//        let cleanAllOrder = "DELETE FROM orders"
//        if !sqlite.execNoneQuerySQL(sql: cleanAllOrder){sqlite.closeDB(); return}
//
//        let resetOrder = "DELETE FROM sqlite_sequence WHERE name = 'orders';"
//        if !sqlite.execNoneQuerySQL(sql: resetOrder){sqlite.closeDB(); return}
//
//
//        let cleanAllDish = "DELETE FROM dishes"
//        if !sqlite.execNoneQuerySQL(sql: cleanAllDish){sqlite.closeDB(); return}
//
//        let resetDish = "DELETE FROM sqlite_sequence WHERE name = 'dishes';"
//        if !sqlite.execNoneQuerySQL(sql: resetDish){sqlite.closeDB(); return}
//
//
//        let cleanAllHall = "DELETE FROM diningHall"
//         if !sqlite.execNoneQuerySQL(sql: cleanAllHall){sqlite.closeDB(); return}
//
//         let resetHall = "DELETE FROM sqlite_sequence WHERE name = 'diningHall';"
//         if !sqlite.execNoneQuerySQL(sql: resetHall){sqlite.closeDB(); return}
        
        //餐厅表
        let createDiningSql = "CREATE TABLE IF NOT EXISTS diningHall ('name' TEXT,  'image' TEXT);"
         if !sqlite.execNoneQuerySQL(sql: createDiningSql){sqlite.closeDB(); return}
        
        //菜品表
        let createDishSql = "CREATE TABLE IF NOT EXISTS dishes ('diningHall' TEXT, 'name' TEXT, 'price' TEXT, 'image' TEXT,'description' TEXT);"
        
        if !sqlite.execNoneQuerySQL(sql: createDishSql){sqlite.closeDB(); return}
        
        //订单表
        let createOrderSql = "CREATE TABLE IF NOT EXISTS orders ('id' TEXT,'name' TEXT, 'price' TEXT, 'image' TEXT);"
               
        if !sqlite.execNoneQuerySQL(sql: createOrderSql){sqlite.closeDB(); return}
        
        let hall1="INSERT INTO diningHall(name,image) VALUES('梅园食堂','meiyuan')"
        
        let hall2="INSERT INTO diningHall(name,image) VALUES('湖滨食堂','hubin')"
        
        let hall3="INSERT INTO diningHall(name,image) VALUES('枫园食堂','fengyuan')"
        if !sqlite.execNoneQuerySQL(sql: hall1){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: hall2){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: hall3){sqlite.closeDB();return}
        
        let dish0 = "INSERT INTO dishes(diningHall,name,price,image,description) VALUES('梅园食堂','水煮鱼','16','fish','水煮鱼也称为江水煮江鱼、水煮鱼片，最早流行于重庆市渝北区翠云乡。水煮鱼通常由新鲜草鱼、豆芽、辣椒等食材制作而成。油而不腻、辣而不燥、麻而不苦、肉质滑嫩”是其特色')"
        let dish1 = "INSERT INTO dishes(diningHall,name,price,image,description) VALUES('梅园食堂','烩面','18','noodle','烩面是一种荤、素、汤、菜、饭兼而有之的河南传统美食，以优质高筋面粉为原料，辅以高汤及多种配菜，类似宽面条，以味道鲜美，汤好面筋，经济实惠，营养丰富，享誉中原，遍及全国。有羊肉烩面、三鲜烩面、五鲜烩面等多种类型，是河南三大小吃之一。')"
        let dish2 = "INSERT INTO dishes(diningHall,name,price,image,description) VALUES('湖滨食堂','蛋炒饭','15','rice','蛋炒饭是常见的一种食物，它是用煮好的米饭、一些菜肴、鸡蛋爆炒而成')"
        let dish3 = "INSERT INTO dishes(diningHall,name,price,image,description) VALUES('湖滨食堂','毛血旺','40','duckBlood','毛血旺以鸭血为制作主料，烹饪技巧以煮菜为主，口味属于麻辣味。起源于重庆，流行于重庆和西南地区，是一道著名的传统菜式。这道菜是将生血旺现烫现吃，且毛肚杂碎为主料，遂得名。')"
        let dish4 = "INSERT INTO dishes(diningHall,name,price,image,description) VALUES('枫园食堂','香辣鸡腿汉堡','10','hamburger','诱人的香辣气味，辣味纯正清爽，引人食欲；能非常好的衬托出鸡肉的香味，辣度偏低，可接受度广，辣味在口中持续时间较长；')"
        let dish5 = "INSERT INTO dishes(diningHall,name,price,image,description) VALUES('枫园食堂','东北水饺','20','dumplings','东北常见菜品，有鲜明的北方特色。')"
        
        let dish6 = "INSERT INTO dishes(diningHall,name,price,image,description) VALUES('梅园食堂','玉米排骨汤','24','chop','玉米排骨汤是一道食补汤品，主要食材是玉米和排骨，主要烹饪工艺是炖。玉米可降低血液胆固醇浓度并防止其沉积于血管壁，营养丰富，促进人们对维生素和钙的吸收。')"

        
        
        
        if !sqlite.execNoneQuerySQL(sql: dish0){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish1){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish2){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish3){sqlite.closeDB();return}
        
        
        if !sqlite.execNoneQuerySQL(sql: dish4){sqlite.closeDB();return}
        if !sqlite.execNoneQuerySQL(sql: dish5){sqlite.closeDB();return}
        
        
        if !sqlite.execNoneQuerySQL(sql: dish6){sqlite.closeDB();return}

        
        sqlite.closeDB()
    }
    
    static func GetFood() -> [[String:AnyObject]]? {
        let sqlite = SQLiteManager.sharedInstance
        if !sqlite.openDB(){return nil}
        
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM dishes")
        
//        print(queryResult!)
        
        for row in queryResult!
        {
            print(row["name"]!)
        }
        
        
        sqlite.closeDB()
        return queryResult
        
        
    }
    
    static func GetHall() -> [[String:AnyObject]]? {
            let sqlite = SQLiteManager.sharedInstance
            if !sqlite.openDB(){return nil}
            
            let querysql="SELECT * FROM diningHall"
           
            let halls=sqlite.execQuerySQL(sql: querysql)
            
    //        print(queryResult!)
            
//            for row in halls!
//            {
//                print(row["name"]!)
//            }
            
            
            sqlite.closeDB()
            return halls
        }
    
    static func GetOrder() -> [[String:AnyObject]]? {
                let sqlite = SQLiteManager.sharedInstance
                if !sqlite.openDB(){return nil}
                
                let querysql="SELECT * FROM orders"
               
                let orders=sqlite.execQuerySQL(sql: querysql)
                
        //        print(queryResult!)
                
    //            for row in halls!
    //            {
    //                print(row["name"]!)
    //            }
                
                
                sqlite.closeDB()
                return orders
                
            }
    
   
  
}
