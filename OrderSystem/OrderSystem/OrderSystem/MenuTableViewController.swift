//
//  MenuTableViewController.swift
//  OrderSystem
//
//  Created by yang on 2020/5/23.
//  Copyright © 2020 yang. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var dishes = [[String:AnyObject]] ()
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Test.initDB()
//        dishes=Test.GetFood()!
        let sqlite=SQLiteManager.sharedInstance
        if !sqlite.openDB(){
            return
        }
        
        let querysql="SELECT * FROM dishes where diningHall='\(navigationBar.title!)'"
        dishes=sqlite.execQuerySQL(sql: querysql)!
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dishes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id="dish"
//        let dishes=Test.GetFood()
        var cell = tableView.dequeueReusableCell(withIdentifier: id)
        if(cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: id)
        }
        let dish1:[String:String] = dishes[indexPath.row] as! [String : String]
        cell?.textLabel?.text=dish1["name"]
    cell?.imageView?.image=UIImage(named:dish1["image"]!)
        cell?.accessoryType
            = .disclosureIndicator
        return cell!


        // Configure the cell...

      
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC=segue.destination as! DetailViewController
        let path=self.tableView.indexPathForSelectedRow
        detailVC.dish=dishes[path!.row] as! [String : String]

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
