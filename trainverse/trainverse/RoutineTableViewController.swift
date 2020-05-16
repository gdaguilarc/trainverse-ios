//
//  RoutineTableViewController.swift
//  trainverse
//
//  Created by user167991 on 5/13/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit

class RoutineTableViewController: UITableViewController, UISearchResultsUpdating {

    var datosFiltrados = [Any]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var routine: [AnyObject] = []
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // si la caja de búsuqeda es vacía, entonces mostrar todos los resultados
        if searchController.searchBar.text! == "" {
            datosFiltrados = routine
        } else {
            // Filtrar los resultados de acuerdo al texto escrito en la caja que es obtenido a través del parámetro $0
            datosFiltrados = routine.filter{
                let objetoMarca=$0 as! [String:Any]
                let s:String = objetoMarca["name"] as! String;
                return(s.lowercased().contains(searchController.searchBar.text!.lowercased())) }
        }
        
        self.tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        datosFiltrados = routine
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datosFiltrados.count
    }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "routine", for: indexPath)
                            
                  let exercise = datosFiltrados[indexPath.row] as! [String: Any]
                  let name:String = exercise["name"] as! String
                  let reps:Int = exercise["repetitions"] as! Int
                  let series:Int = exercise["repetitions"] as! Int
    
                  cell.textLabel?.text = name + " reps: " + String(reps) + " series " + String(series)
    
                  return cell
    }

 



    // MARK: - Navigation

      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

         let nextView = segue.destination as! ExerciseViewController
         let index = self.tableView.indexPathForSelectedRow?.row
         let exercise = datosFiltrados[index!] as! [String: Any]
         nextView.exercise = exercise
     }


}
