//
//  DiningHalDetailViewController.swift
//  OrderSystem
//
//  Created by yang on 2020/5/23.
//  Copyright © 2020 yang. All rights reserved.
//

import UIKit

class DiningHallViewController: UITableViewController {
    var halls = [[String:AnyObject]] ()
    override func viewDidLoad() {
        super.viewDidLoad()
//        Test.initDB()
        halls=Test.GetHall()!
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id="diningHall"
        var cell = tableView.dequeueReusableCell(withIdentifier: id)
        if(cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: id)
        }
        let hall1:[String:String] = halls[indexPath.row] as! [String : String]
        cell?.textLabel?.text=hall1["name"]
        cell?.imageView?.image=UIImage(named: hall1["image"]!)
        cell?.accessoryType
                   = .disclosureIndicator
        return cell!
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return halls.count
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let detailVC=segue.destination as! MenuTableViewController
         let path=self.tableView.indexPathForSelectedRow
        detailVC.navigationBar.title=halls[path!.row]["name"]! as? String
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
