//
//  MapViewController.swift
//  trainverse
//
//  Created by user167991 on 5/14/20.
//  Copyright © 2020 itesm. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import UIKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let jsonUrl="http://martinmolina.com.mx/202011/trainverse/jsonMapaGYM.json"
    var result:[Any]?
    private let locationManager = CLLocationManager()

    func JSONParseArray(_ string: String) -> [AnyObject]{
        if let data = string.data(using: String.Encoding.utf8){
            
            do{
                
                if let array = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)  as? [AnyObject] {
                    return array
                }
            }catch{
                
                print("error")
                //handle errors here
                
            }
        }
        return [AnyObject]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //CARGA DATOS JSON
        if let url = URL(string: jsonUrl) {
            do {
                //let contents = try String(contentsOf: url)
                //print(contents)
                let datos = try? Data(contentsOf: url)
                result = try! JSONSerialization.jsonObject(with: datos!) as? [Any]
            } catch {
                // contents could not be loaded
                print("contents could not be loaded")
            }
        } else {
            // the URL was bad!
            print("the URL was bad!")
        }
        
        
        
        
        for i in result!{
             let objetoGym = i as! [String: Any]
            let name:String = objetoGym["name"] as! String
             let lat:NSNumber = objetoGym["lat"] as! NSNumber
             let lon:NSNumber = objetoGym["lon"] as! NSNumber
       
         }
        
         //MAPA
                   
                   locationManager.delegate = self
                   locationManager.desiredAccuracy = kCLLocationAccuracyBest
                   //locationManager.requestWhenInUseAuthorization()
                   
                       //let contents = try String(contentsOf: url)
                       //print(contents)
                   map.mapType=MKMapType.hybrid
                   let cl=CLLocationCoordinate2DMake(19.283280,-99.136388)
                   map.region=MKCoordinateRegion(center: cl, latitudinalMeters: 2000, longitudinalMeters: 2000)
                   let delta=CLLocationDegrees(0.01)
                   let span=MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
                   map.region=MKCoordinateRegion(center: cl, span: span)
                  
               //Annotations
               for i in result! {
                   let objetoGym = i as! [String: Any]
                   let title = objetoGym["name"] as! String
                   let lat = objetoGym["lat"] as! Double
                   let lon = objetoGym["lon"] as! Double
                   
                   let rest = MKPointAnnotation()
                   
                   let cc = CLLocationCoordinate2DMake(lat, lon)
                   rest.coordinate = cc
                   rest.title = title
                   
                    map.addAnnotation(rest)
               }
               
                   map.showsCompass=true
                   map.showsScale=true
                   map.showsTraffic=true
                   map.isZoomEnabled=true

        
    }
    
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
        } else {
            locationManager.stopUpdatingLocation()
            map.showsUserLocation = false
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
