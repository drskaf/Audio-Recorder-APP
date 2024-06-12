//
//  InputViewController.swift
//  PinSample
//
//  Created by Ebraham Alskaf on 10/06/2024.
//  Copyright © 2024 Udacity. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol InputViewControllerDelegate: AnyObject {
    func didFindLocation(coordinate: CLLocationCoordinate2D, locationName: String)
}

class InputViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    weak var delegate: InputViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func findLocation(_ sender: UIButton) {
        guard let locationName = locationTextField.text, !locationName.isEmpty else {
            showAlert(message: "Please enter a location")
            return
        }
        
        geocodeAddress(address: locationName)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func geocodeAddress(address: String) {
        print("Geocoding address: \(address)")
        let geocode = CLGeocoder()
        geocode.geocodeAddressString(address) {[weak self] (placemarks, error) in
            guard let self = self else {return}
            if let error = error {
                self.showAlert(message: "Geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first, let location = placemark.location else {
                self.showAlert(message: "No location found")
                return
            }
            
            let coordinate = location.coordinate
            print("Geocoded coordinate: \(coordinate)")
            self.delegate?.didFindLocation(coordinate: coordinate, locationName: address)
            self.performSegue(withIdentifier: "showMapViewWithLink", sender: coordinate)
    
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMapViewWithLink",
           let mapVC = segue.destination as? MapViewWithLinkController,
           let coordinate = sender as? CLLocationCoordinate2D {
            mapVC.coordinate = coordinate
            mapVC.locationName = locationTextField.text
        }
    }
}
