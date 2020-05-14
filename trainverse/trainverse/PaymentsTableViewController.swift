//
//  PaymentsTableViewController.swift
//  trainverse
//
//  Created by user167991 on 5/14/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit

class PaymentsTableViewController: UITableViewController {
    
    
    let jsonUrl = "http://martinmolina.com.mx/202011/trainverse/payment_methods.json"
    var result:AnyObject?
    var cards: [AnyObject]?
         

         
         
         func JSONParseArray(_ string: String) -> [String: Any]{
             if let data = string.data(using: String.Encoding.utf8){
                 
                 do{
                     
                     if let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as? [String: Any] {
                         return array
                     }
                 }catch{
                     
                     print("error")
                     //handle errors here
                     
                 }
             }
             return [String: Any]()
         }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    if let url = URL(string: jsonUrl) {
                         do {
                             let contents = try String(contentsOf: url)
                             print(contents)
                             let datos = try? Data(contentsOf: url)
                           result = try! JSONSerialization.jsonObject(with: datos!) as! [String: Any] as AnyObject
                         } catch {
                             // contents could not be loaded
                             print("contents could not be loaded")
                         }
                     } else {
                         // the URL was bad!
                         print("the URL was bad!")
                     }
        
        cards = result?["cards"] as! [AnyObject]?
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cards!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


         var cell = tableView.dequeueReusableCell(withIdentifier: "payment", for: indexPath)
                   
                   
                   if (cell == nil) {
                       cell = UITableViewCell(
                           style: UITableViewCell.CellStyle.default, reuseIdentifier: "payment")
                   }
              
                   let objetoMarca = cards![indexPath.row] as! [String: Any]
                   let name:String = objetoMarca["number"] as! String
                   let target:String = objetoMarca["type"] as! String
                   let exp:String = objetoMarca["expiration"] as! String
                   cell.textLabel?.text = name + " " + target + " Exp. " + exp
                   return cell
     }

    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
