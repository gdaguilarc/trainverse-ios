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
        layout.scrollDirection = .horizontal
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
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    



}


extension DiscoverViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.height/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
}
