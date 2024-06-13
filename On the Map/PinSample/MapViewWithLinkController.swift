//
//  MapViewWithLinkController.swift
//  PinSample
//
//  Created by Ebraham Alskaf on 11/06/2024.
//  Copyright © 2024 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol MapViewWithLinkControllerDelegate: AnyObject {
    func didSubmitLocation(coordinate: CLLocationCoordinate2D, locationName: String, linkedinURL: String)
}

class MapViewWithLinkController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var linkedinTextField: UITextField!
    var coordinate: CLLocationCoordinate2D?
    var locationName: String?
    weak var delegate: MapViewWithLinkControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        if let coordinate = coordinate, let locationName = locationName {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = locationName
            mapView.addAnnotation(annotation)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }

    @IBAction func submitLocation(_ sender: UIButton) {
        guard let coordinate = coordinate,
              let locationName = locationName,
              let linkedinURL = linkedinTextField.text, !linkedinURL.isEmpty else {
            showAlert(message: "Please enter your LinkedIn URL.")
            return
        }
        
        print("Submitted coordinate: \(coordinate), LinkedIn URL: \(linkedinURL)")
        
        delegate?.didSubmitLocation(coordinate: coordinate, locationName: locationName, linkedinURL: linkedinURL)

        performSegue(withIdentifier: "showOriginalMapView", sender: self)  // Perform the segue instead of popping the view controller
        //navigationController?.popViewController(animated: true)
    }
    

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension Notification.Name {
    static let didAddLocation = Notification.Name("didAddLocation")
}
