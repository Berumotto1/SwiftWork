//
//  DetailViewController.swift
//  OrderSystem
//
//  Created by yang on 2020/5/15.
//  Copyright © 2020 yang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var dishPicture: UIImageView!
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishPrice: UILabel!
    @IBOutlet weak var dishIntroduction: UITextView!
    var dish=[String:String]()
    
    
    func showMessage(_ message:String){
        let alertController=UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let alertAction=UIAlertAction(title: "确定", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController,animated: true,completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishName.text=dish["name"]
        dishPrice.text=dish["price"]
        dishIntroduction.text=dish["description"]
        dishPicture.image=UIImage(named: dish["image"]!)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addButtonPress(_ sender: Any) {
        let sqlite=SQLiteManager.sharedInstance
        if !sqlite.openDB(){
            return
        }
        let id=sqlite.randomMD5();
        print(id)
        let insertsql = "INSERT INTO orders(id,name,price,image) VALUES('\(id)','\(dishName.text!)','\(dishPrice.text!)','\(dishPrice.text!)')"
        
        if !sqlite.execNoneQuerySQL(sql: insertsql)
        {
            sqlite.closeDB();
            showMessage("添加订单失败！")
            return
            
        }else{
            sqlite.closeDB();
            showMessage("添加订单成功！")
            return
        }
        
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
