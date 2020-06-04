//
//  MLViewController.swift
//  trainverse
//
//  Created by user167991 on 6/3/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit
import CoreML
import Vision

class MLViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    private let mPicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mPicker.delegate = self
    }
    
    @IBAction func execML(){
        let modelFile = TrainVerseML()
        let model = try! VNCoreMLModel(for: modelFile.model)
        
        let imageCI = CIImage(image: imageView.image!)
        let handler = VNImageRequestHandler(ciImage: imageCI!)
        
        let request = VNCoreMLRequest(model: model, completionHandler: modelResults)
        try! handler.perform([request])
        
        
    }
    
    func modelResults(request: VNRequest, error: Error?)
    {
        guard let results = request.results as? [VNClassificationObservation] else { fatalError("No hubo respuesta del modelo")}
        var bestPrediction = ""
        var bestConfidence: VNConfidence = 0
        
        for classification in results {
            if (classification.confidence > bestConfidence){
                bestConfidence = classification.confidence
                bestPrediction = classification.identifier
            }
        }
        let result = bestPrediction+" "+String(bestConfidence)
        print(result)
        resultLabel.text = result
    }
    
      @IBAction func album() {
          mPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
             present(mPicker, animated: true, completion: nil)
         }
         
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          imageView.image = info[.originalImage] as? UIImage
           picker.dismiss(animated: true, completion: nil)
       }
      
         func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
             picker.dismiss(animated: true, completion: nil)
         }

}
