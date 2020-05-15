//
//  DiscoverTableViewController.swift
//  trainverse
//
//  Created by user167991 on 5/12/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController, UISearchResultsUpdating {
    let jsonUrl = "http://martinmolina.com.mx/202011/trainverse/discover.json"
    var nuevoArray:[Any]?
    
    var datosFiltrados = [Any]()
    //paso 3: crear un control de búsqueda
    let searchController = UISearchController(searchResultsController: nil)
    
    //paso 4: crear la función updateSearchResults para cumplir con el protocolo
    //UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
        // si la caja de búsuqeda es vacía, entonces mostrar todos los resultados
        if searchController.searchBar.text! == "" {
            datosFiltrados = nuevoArray!
        } else {
            // Filtrar los resultados de acuerdo al texto escrito en la caja que es obtenido a través del parámetro $0
            datosFiltrados = nuevoArray!.filter{
                let objetoMarca=$0 as! [String:Any]
                let s:String = objetoMarca["name"] as! String;
                return(s.lowercased().contains(searchController.searchBar.text!.lowercased())) }
        }
        
        self.tableView.reloadData()
    }
    
    func JSONParseArray(_ string: String) -> [AnyObject]{
        if let data = string.data(using: String.Encoding.utf8){
            
            do{
                
                if let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as? [AnyObject] {
                    return array
                }
            }catch{
                
                print("error")
                //handle errors here
                
            }
        }
        return [AnyObject]()
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        if let url = URL(string: jsonUrl) {
                  do {
                      let contents = try String(contentsOf: url)
                      print(contents)
                      let datos = try? Data(contentsOf: url)
                      nuevoArray = try! JSONSerialization.jsonObject(with: datos!) as? [Any]
                  } catch {
                      // contents could not be loaded
                      print("contents could not be loaded")
                  }
              } else {
                  // the URL was bad!
                  print("the URL was bad!")
              }
        //paso 5: copiar el contenido del arreglo en el arreglo filtrado
        datosFiltrados = nuevoArray!
        
        //Paso 6: usar la vista actual para presentar los resultados de la búsqueda
        searchController.searchResultsUpdater = self
        //paso 7: controlar el background de los datos al momento de hacer la búsqueda
        searchController.dimsBackgroundDuringPresentation = false
        //Paso 8: manejar la barra de navegación durante la busuqeda
        searchController.hidesNavigationBarDuringPresentation = false
        //Paso 9: Definir el contexto de la búsqueda
        definesPresentationContext = true
        //Paso 10: Instalar la barra de búsqueda en la cabecera de la tabla
        tableView.tableHeaderView = searchController.searchBar
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    	
        
        return datosFiltrados.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        
        
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.default, reuseIdentifier: "zelda")
        }
        let objetoMarca = datosFiltrados[indexPath.row] as! [String: Any]
        let s:String = objetoMarca["name"] as! String
        cell.textLabel?.text=s
        return cell

        // Configure the cell...
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

  
    // MARK: - Navigation

      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        let sigVista = segue.destination as! IndividualViewController
        let indice = self.tableView.indexPathForSelectedRow?.row
                     
        let individuo = datosFiltrados[indice!] as! [String: Any]
        let name = individuo["name"] as! String
        let type = individuo["type"] as! String
        let url = individuo["thumbnail"] as! String

        sigVista.name = name
        sigVista.type = type
        sigVista.url = url
        
    }

}
