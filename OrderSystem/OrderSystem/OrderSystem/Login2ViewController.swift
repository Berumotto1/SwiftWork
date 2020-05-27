////
////  LoginViewController.swift
////  OrderSystem
////
////  Created by yang on 2020/5/18.
////  Copyright © 2020 yang. All rights reserved.
////
//
//import UIKit
//
//class LoginViewController: UIViewController {
//
//    @IBOutlet weak var studentID: UITextField!
//    @IBOutlet weak var studentName:UITextField!
//
//
//    var database: OpaquePointer?=nil
//
//    func datafilePath()->String{
//
//       let urls=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let url:String=(urls.first?.appendingPathComponent("student.sqlite").path)!
//        //let url="/Users/yang/Desktop/ios/student.sqlite"
//        //let url=""
//        return url
//
//    }
//
//    func showMessage(_ message:String){
//        let alertController=UIAlertController(title: "提示", message: message, preferredStyle: .alert)
//        let alertAction=UIAlertAction(title: "确定", style: .default, handler: nil)
//        alertController.addAction(alertAction)
//        present(alertController,animated: true,completion: nil)
//
//    }
//    //连接数据库，建表
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        let databasePath=datafilePath()
//        var result=sqlite3_open(databasePath, &database)
//        if(result != SQLITE_OK){
//            sqlite3_close(database)
//            showMessage("数据库打开失败！")
//            return
//        }
//        let createSQL="CREATE TABLE IF NOT EXISTS " +
//        "student(id text primary key, name text);"
//        var err:UnsafeMutablePointer<Int8>?=nil
//        result = sqlite3_exec(database, createSQL, nil, nil, &err)
//        if(result != SQLITE_OK){
//            sqlite3_close(database)
//            showMessage("建表失败！")
//            return
//        }
//
//    }
//
//
//    @IBAction func saveButtonPress(_ sender: UIButton) {
//
//        let id=studentID.text
//        let name=studentName.text
//        if(id != "" && name != ""){
//            let sql="INSERT OR REPLACE INTO student(id,name) values('\(id)','\(name)');"
//            var stmt:OpaquePointer?=nil
//            if sqlite3_prepare_v2(database, sql, -1, &stmt, nil) != SQLITE_OK{
//                sqlite3_close(database)
//                showMessage("数据保存失败！")
//                return
//            }
//            if sqlite3_step(stmt) != SQLITE_DONE{
//                sqlite3_close(database)
//                showMessage("数据更新失败！")
//                return
//            }
//            sqlite3_finalize(stmt)
//            showMessage("数据已经保存")
//            return
//        }
//    }
//
//    @IBAction func loginButtonPress(_ sender: Any) {
//        let id=studentID.text
//        let sql="SELECT id, name FROM student ORDER BY \(id);"
//        var stmt:OpaquePointer?=nil
//        let result=sqlite3_prepare_v2(database, sql, -1, &stmt, nil)
//        if(result == SQLITE_OK){
//             let r_name=sqlite3_column_text(stmt, 1)
//            if(studentName.text == String.init(cString: UnsafePointer<UInt8>(r_name!))){
//                showMessage("登录成功！")
//                return
//            }
//        }else{
//            showMessage("登录失败！")
//            sqlite3_close(database)
//            return
//        }
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
