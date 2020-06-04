//
//  NewCardViewController.swift
//  trainverse
//
//  Created by user167991 on 5/31/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CardPayload {
    var cardNumber: String = ""
    var date: String = ""
}

class NewCardViewController: UIViewController {
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var date: UITextField!
    
    
    var ref = Database.database().reference()
    var cards = [CardPayload]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveData(_ sender: UIButton){
        
        let userId = Auth.auth().currentUser?.uid
        
        let data = ["cardNumber": self.cardNumber.text!, "date": self.date.text!]
        
        let db = Firestore.firestore()
        let refUser = db.collection("users").document(userId!).collection("cards")
        
        refUser.addDocument(data: data)
        
        
        let alert = UIAlertController(title: "Guardar", message: "Card is successfully saved!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "continue", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}
