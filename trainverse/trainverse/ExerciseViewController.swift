//
//  ExerciseViewController.swift
//  trainverse
//
//  Created by user167991 on 5/14/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    

    @IBOutlet weak var exercise_photo: UIImageView!
    @IBOutlet weak var exercise_title: UILabel!
    @IBOutlet weak var rest: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var reps: UILabel!
    @IBOutlet weak var series: UILabel!
    
    var exercise:[String: Any]?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if exercise != nil {
            exercise_title.text = exercise?["name"] as? String
            rest.text = (exercise?["restTime"] as? Int)?.description
            difficulty.text = (exercise?["difficulty"] as? Int)?.description
            reps.text = (exercise?["repetitions"] as? Int)?.description
            series.text = (exercise?["series"] as? Int)?.description
            
            exercise_photo.load2(url: URL(string: (exercise?["thumbnail"] as? String)!)!)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let nextView = segue.destination as! TutorialViewController
        let video = exercise?["video"] as? String
        nextView.videoUrl = video
    }
    
    

  

}


extension UIImageView {
    func load2(url: URL){
        DispatchQueue.global().async{[weak self] in
            
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
            
        }
        
    }
}






