//
//  DiscoverViewController.swift
//  trainverse
//
//  Created by user167991 on 5/11/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit

struct Person:Decodable {
    let user_id: String
    let name: String
    let type: String
    let thumbnail: String
}

struct Payload:Decodable {
    let people: [Person]
}

class DiscoverViewController: UIViewController {
    var payloadData: Payload?
 
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonUrl = "http://martinmolina.com.mx/202011/trainverse/discover.json"
        guard let result = URL(string: jsonUrl) else { return }
    
        URLSession.shared.dataTask(with: result){
            (data, response, err) in
            
            
            guard let data = data else { return }
            
            do {
                let _payload = try JSONDecoder().decode(Payload.self, from: data)
                self.payloadData = _payload
            }catch let jsonErr {
                print("Error parsing ", jsonErr)
            }
            
        }.resume()
        // Do any additional setup after loading the view.
    
    }
    
    
    
    



}


