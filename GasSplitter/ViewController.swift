//
//  ViewController.swift
//  GasSplitter
//
//  Created by Anna Resnick on 5/23/17.
//  Copyright © 2017 AnnaResnick. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GooglePlaces

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    var placesClient: GMSPlacesClient!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var peopleTextField: UITextField!
    
    @IBOutlet weak var milesPerGallon: UITextField!
    
    @IBOutlet weak var milesDriven: UITextField!
    
    @IBOutlet weak var calculatePrice: UIButton!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    // Add a UIButton in Interface Builder, and connect the action to this function.
    @IBAction func getCurrentPlace(_ sender: UIButton) {
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel.text = "No current place"
            self.addressLabel.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    self.nameLabel.text = place.name
                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n")
                }
            }
        })

    }
    
    @IBAction func calcPrice(_ sender: AnyObject) {
        
        let numOfPeople = Int(peopleTextField.text!)
        
        let mpg = Int(milesPerGallon.text!)
        
        let miles = Int(milesDriven.text!)
        
        let pricePerPerson = ((miles! * 3) / mpg!) / numOfPeople!
        
        print(pricePerPerson)
        
        priceLabel.text = "Price is: $" + String(pricePerPerson) + " per person"
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesClient = GMSPlacesClient.shared() 
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
    }
    


}

