//
//  ViewController.swift
//  CustomCalloutDemo
//
//  Created by Ravi Shankar on 24/07/16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        zoomToRegion()
        addAnnotation()
        
        mapView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func zoomToRegion() {
        let location = CLLocationCoordinate2D(latitude: 13.03297, longitude: 80.26518)
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        mapView.setRegion(region, animated: true)
    }
    
    
    func addAnnotation() {
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 13.03297, longitude: 80.26518)
        point.title = "Mylapore"
        mapView.addAnnotation(point)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }

        let identifer = "Pin"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifer)
        
        if annotationView == nil {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifer)
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "stop")
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if view.annotation is MKUserLocation
        {
            return
        }

        let views = NSBundle.mainBundle().loadNibNamed("CustomAnnotationView", owner: nil, options: nil)
        let calloutView = views[0] as! CustomAnnotationView
        calloutView.center = CGPointMake(view.bounds.size.width / 2, -calloutView.bounds.size.height*0.6)
        
        view.addSubview(calloutView)
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        if view.isKindOfClass(CustomAnnotationView)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
}

