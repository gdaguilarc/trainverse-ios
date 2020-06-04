//
//  PaymentCardsViewController.swift
//  trainverse
//
//  Created by user167991 on 5/31/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Card {
    var cardNumber: String = ""
    var date: String = ""
}

class PaymentCardsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let ref: DatabaseReference = Database.database().reference()
    var cards: [NSDictionary] = []

    @IBOutlet var tableCards: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        let userId = Auth.auth().currentUser?.uid
        

        
        let db = Firestore.firestore()
        let refUser = db.collection("users").document(userId!).collection("cards")
        refUser.getDocuments(){
            (querySnapshot, err) in
            if err != nil {
                print("Error")
            }else {
                for document in querySnapshot!.documents {
                    
                    self.cards.append(document.data() as NSDictionary)
                }
                print(self.cards as Any)
                self.tableCards.reloadData()
                
            }
        }
        
        tableCards.dataSource = self
        tableCards.delegate = self
  
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           var cell = tableView.dequeueReusableCell(withIdentifier: "card", for: indexPath) as! CardTableViewCell
             
        
             if (cell == nil) {
                 cell = UITableViewCell(
                    style: UITableViewCell.CellStyle.default, reuseIdentifier: "card") as! CardTableViewCell
             }
                

        
        cell.cardNumberLabel.text = self.cards[indexPath.row]["cardNumber"] as? String
        cell.dateLabel.text = self.cards[indexPath.row]["date"] as? String
        
   
    
        
        return cell
    }
}

class CardTableViewCell: UITableViewCell {
    

    @IBOutlet var cardIcon: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}
