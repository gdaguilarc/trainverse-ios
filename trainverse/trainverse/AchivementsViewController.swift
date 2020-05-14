//
//  AchivementsViewController.swift
//  trainverse
//
//  Created by user167991 on 5/14/20.
//  Copyright © 2020 itesm. All rights reserved.
//achivement

import UIKit

class AchivementsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var name_level: UILabel!
    
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var table: UITableView!

    
    
    let jsonUrl = "http://martinmolina.com.mx/202011/trainverse/profile.json"
    var profile:AnyObject?
    var achivements: [Any]?
    var stats: AnyObject?

    
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
                    profile = try! JSONSerialization.jsonObject(with: datos!) as! [String: Any] as AnyObject
                    
                    
                    
                    
                  } catch {
                      // contents could not be loaded
                      print("contents could not be loaded")
                  }
              } else {
                  // the URL was bad!
                  print("the URL was bad!")
              }
        
        
        achivements = profile!["achivements"] as? [Any]
        stats = profile!["stats"] as AnyObject?
        let level_stats = stats?["level"] as AnyObject
        
        level.text = "LEVEL " + (level_stats["lvl"]! as! Int).description
        name_level.text = level_stats["name"]! as? String
        
        
        table.dataSource = self
        table.delegate = self

    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achivements!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           var cell = tableView.dequeueReusableCell(withIdentifier: "achivement", for: indexPath)
             
             
             if (cell == nil) {
                 cell = UITableViewCell(
                     style: UITableViewCell.CellStyle.default, reuseIdentifier: "achivement")
             }
        
             let ach = achivements![indexPath.row] as! [String: Any]
             let name:String = ach["description"] as! String
             let done:Bool = ach["done"] as! Bool
        
            var done_str: String = "NOT COMPLETED"
            
            if done == true {
                done_str = "COMPLETED"
                
            }
        
             cell.textLabel?.text = name + " - " + done_str
             return cell
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
