//
//  RoutineTableViewController.swift
//  trainverse
//
//  Created by user167991 on 5/13/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit

class RoutineTableViewController: UITableViewController {

    
    
    var routine: [AnyObject] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return routine.count
    }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        var cell = tableView.dequeueReusableCell(withIdentifier: "routine", for: indexPath)
                  
                  
                  if (cell == nil) {
                      cell = UITableViewCell(
                          style: UITableViewCell.CellStyle.default, reuseIdentifier: "routine")
                  }
             
                  let objetoMarca = routine[indexPath.row] as! [String: Any]
                  let name:String = objetoMarca["name"] as! String
                  let reps:Int = objetoMarca["repetitions"] as! Int
                  let series:Int = objetoMarca["repetitions"] as! Int
                  cell.textLabel?.text = name + " reps: " + String(reps) + " series " + String(series)
                  return cell
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


    // MARK: - Navigation

      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         
         
         let sigVista = segue.destination as! ExerciseViewController
         let indice = self.tableView.indexPathForSelectedRow?.row
                      
        let exercise = routine[indice!] as! [String: Any]
      

         sigVista.exercise = exercise 
     }


}
