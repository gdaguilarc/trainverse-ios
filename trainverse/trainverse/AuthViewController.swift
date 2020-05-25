//
//  AuthViewController.swift
//  trainverse
//
//  Created by user167991 on 5/24/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  @IBAction func signIn(_ sender: UIButton) {
    if let email = emailField.text,
          let password = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: password){(user, error) in
                if error != nil{
                    print(error!)
                    let alert = UIAlertController(title: "Error", message: error.debugDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }else{
                    print("Login Exitoso!")
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                }
            
            
            
            }
        }
      }
    
    @IBAction func signUp(_ sender: UIButton){
        if let email = emailField.text,
            let password = passwordField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print(error!)
                }else{
                    print("Registro de usuario exitoso!")
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                }
            
            }
            
            
        }
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
