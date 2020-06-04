//
//  TutorialViewController.swift
//  trainverse
//
//  Created by user167991 on 5/30/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit
import WebKit

class TutorialViewController: UIViewController {

    var videoUrl: String?;
    @IBOutlet weak var tutorialWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        getVideo(video: videoUrl!)
    }
    
    func getVideo(video: String){
        let urlvideo = URL(string: video)!
        tutorialWebView.load(URLRequest(url: urlvideo))
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
