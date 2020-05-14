//
//  ProfileViewController.swift
//  trainverse
//
//  Created by user167991 on 5/13/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var Avatar: UIImageView!

    @IBOutlet weak var cameraBoton: UIButton!
    private let myPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            cameraBoton.isHidden = true
        }
        myPicker.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
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
