//
//  HomeViewController.swift
//  trainverse
//
//  Created by user167991 on 5/13/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit
import Firebase


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let jsonUrl = "http://martinmolina.com.mx/202011/trainverse/data.json"
    var result:[Any]?
    
    @IBOutlet weak var _homeTableView: UITableView!
    
    
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

    @IBAction func logout(_ sender: UIButton){
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error en Logout")
            let alert = UIAlertController(title: "Error", message: "Error en logout", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: jsonUrl) {
                  do {
                      let contents = try String(contentsOf: url)
                      print(contents)
                      let datos = try? Data(contentsOf: url)
                      result = try! JSONSerialization.jsonObject(with: datos!) as? [Any]
                  } catch {
                      // contents could not be loaded
                      print("contents could not be loaded")
                  }
              } else {
                  // the URL was bad!
                  print("the URL was bad!")
              }
        
        
        _homeTableView.dataSource = self
        _homeTableView.delegate = self

    }
    
    
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           var cell = tableView.dequeueReusableCell(withIdentifier: "home", for: indexPath)
             
             
             if (cell == nil) {
                 cell = UITableViewCell(
                     style: UITableViewCell.CellStyle.default, reuseIdentifier: "home")
             }
        
             let objetoMarca = result![indexPath.row] as! [String: Any]
             let name:String = objetoMarca["name"] as! String
             let target:String = objetoMarca["target"] as! String
             cell.textLabel?.text = name + " - " + target
             return cell
    }
    
  

    
    // MARK: - Navigation


    

}

