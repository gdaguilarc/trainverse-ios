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
    
    fileprivate let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonUrl = "http://martinmolina.com.mx/202011/trainverse/discover.json"
        guard let result = URL(string: jsonUrl) else { return }
    
        URLSession.shared.dataTask(with: result){
            (data, response, err) in
            
            
            guard let data = data else { return }
            
            do {
                let _payload = try JSONDecoder().decode(Payload.self, from: data)
            }catch let jsonErr {
                print("Error parsing ", jsonErr)
            }
            
        }.resume()
        // Do any additional setup after loading the view.
    
        view.addSubview(collectionView)
        collectionView.backgroundColor = .red
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
    }
    



}


extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        <#code#>
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
