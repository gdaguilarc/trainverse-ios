//
//  ProfileViewController.swift
//  trainverse
//
//  Created by user167991 on 5/13/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var Avatar: UIImageView!

    @IBOutlet weak var cameraBoton: UIButton!
    private let myPicker = UIImagePickerController()
    
    
    
    
    
    let jsonUrl = "http://martinmolina.com.mx/202011/trainverse/profile.json"
    var result:AnyObject?
    

    
    
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

        // Do any additional setup after loading the view.
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            cameraBoton.isHidden = true
        }
        myPicker.delegate = self
        
        
        
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
        
        
        if result?["name"] != nil {
            name.text = result?["name"] as? String
        }
        
        if result?["age"] != nil {
            age.text = (result?["age"] as? Float)?.description
        }
        
        if result?["weight"] != nil {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let w = formatter.string(from: ((result?["weight"] as? NSNumber)!))
            weight.text = w!.description + " KG"
        }
        if result?["height"] != nil {
            height.text = (result?["height"] as? Float)!.description + " CM"
        }
        
    }
    


    
    
    
    @IBAction func camara() {
        myPicker.sourceType = UIImagePickerController.SourceType.camera
           present(myPicker, animated: true, completion: nil)
       }
       
       @IBAction func album() {
        myPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
           present(myPicker, animated: true, completion: nil)
       }
       
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        Avatar.image = info[.originalImage] as? UIImage
         picker.dismiss(animated: true, completion: nil)
     }
    
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }

}
