//
//  IndividualViewController.swift
//  trainverse
//
//  Created by user167991 on 5/14/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit

class IndividualViewController: UIViewController {
    
    @IBOutlet weak var individual_image: UIImageView!
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var type_label: UILabel!
    var name: String?
    var type: String?
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if name != nil {
            name_label.text = name
        }
        
        if type != nil {
            type_label.text = type
        }
        
        if url != nil {
            individual_image.load(url: URL(string: url!)!)
        }
    }
    
    




}


extension UIImageView {
    func load(url: URL){
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
