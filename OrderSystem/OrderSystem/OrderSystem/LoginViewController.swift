//
//  LoginViewController.swift
//  OrderSystem
//
//  Created by yang on 2020/5/18.
//  Copyright © 2020 yang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var studentID: UITextField!
    @IBOutlet weak var studentName:UITextField!


    var database: OpaquePointer?=nil



    func showMessage(_ message:String){
        let alertController=UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let alertAction=UIAlertAction(title: "确定", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController,animated: true,completion: nil)

    }
    //连接数据库，建表
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let sqlite=SQLiteManager.sharedInstance
        if !sqlite.openDB(){
            return
        }

        let createSQL="CREATE TABLE IF NOT EXISTS " +
        "student('id' text primary key, 'name' text);"

        if !(sqlite.execQuerySQL(sql: createSQL) != nil)
        {
            sqlite.closeDB()
            return
        }

    }


    @IBAction func saveButtonPress(_ sender: UIButton) {

        let id=studentID.text
        let name=studentName.text
        let sqlite=SQLiteManager.sharedInstance
             if !sqlite.openDB(){
                 return
             }
        if(id != "" && name != ""){
            let sql="INSERT OR REPLACE INTO student(id,name) values('\(id)','\(name)');"
            let result=sqlite.execNoneQuerySQL(sql: sql)
            if(result != true)
            {
                showMessage("数据保存失败！")
                sqlite.closeDB()
                return
            }else{
                showMessage("数据保存成功！")
                sqlite.closeDB()
                return
            }
            
        }
    }

    @IBAction func showButoonPress(_ sender: Any) {
        let sqlite=SQLiteManager.sharedInstance
        if !sqlite.openDB(){
            return
        }
        let queryResult=sqlite.execQuerySQL(sql: "SELECT * FROM student")
        print(queryResult!)
         for row in queryResult!
        {
            print(row["name"]!)
        }

        sqlite.closeDB()


    }
    @IBAction func loginButtonPress(_ sender: Any) {
        let id=studentID.text
        let sql="SELECT id, name FROM student WHERE student.id='\(id)'"
        
        let sqlite=SQLiteManager.sharedInstance
        if !sqlite.openDB(){
            return
        }
        let queryResult=sqlite.execQuerySQL(sql: sql)
        
        let queryName=queryResult?[0]["name"]
        let Name=queryName as! String as! String
        print(queryResult)
        print(queryName)
        print("Name:"+Name)
        print("Text:"+studentName.text!)
        if(Name == studentName.text){
           
            showMessage("登录成功！")
            sqlite.closeDB()
                return
            
        }
            else{
            showMessage("登录失败！")
            sqlite.closeDB()
            return
        }
       sqlite.closeDB()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
