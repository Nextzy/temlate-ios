//
//  LocationManager.swift
//  Template
//
//  Created by Thongpak on 6/11/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import Foundation
import Foundation
import CoreLocation
import Contacts

public protocol LocationManagerDelegate: class {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
    func getAddress(geocoder: GeocoderModel, addressDict: String)
}

public protocol LocationManagerAuthorizationDelegate: class {
    func didChangeStatus()
}

public class LocationManager: NSObject, CLLocationManagerDelegate {
    
    public static let sharedInstance = LocationManager()
    
    public var locationManager: CLLocationManager?
    public var lastLocation: CLLocation?
    public weak var delegate: LocationManagerDelegate?
    public weak var delegateAuthorization: LocationManagerAuthorizationDelegate?
    override public init(){
        super.init()
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else{
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        locationManager.distanceFilter = 5
        locationManager.delegate = self
    }
    
    
    public func startUpdatingLocation(){
        self.locationManager?.startUpdatingLocation()
    }
    
    public func stopUpdatingLocation(){
        self.locationManager?.stopUpdatingLocation()
    }
    
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{
            return
        }
        
        //for filter wrong location
        let age = -(location.timestamp.timeIntervalSinceNow)
        if(age > 120){
            return
        }
        if(location.horizontalAccuracy < 0){
            return
        }
        
        self.lastLocation = location
        updateLocation(currentLocation: location)
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // do on error
        updateLocationDidFailWithError(error: error as NSError)
    }
    
    
    public func updateLocation(currentLocation: CLLocation){
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    public func updateLocationDidFailWithError(error: NSError) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocationDidFailWithError(error: error)
    }
    
    public func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                return
            } else if !(placemarks?.isEmpty)! {
                let pm = placemarks!.first
                let geocode = GeocoderModel(pm: pm)
                self.delegate?.getAddress(geocoder: geocode, addressDict: geocode.address1)
            }
        })
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegateAuthorization?.didChangeStatus()
    }
    
    public func checkLocationEnable() {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .restricted, .denied:
                print("No Access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
}

public struct GeocoderModel {
    public var address1 = ""
    public var address2 = ""
    public var name = ""
    public var city = ""
    public var state = ""
    public var zipCode = ""
    public var country = ""
    
    init(pm: CLPlacemark?) {
        address1 = pm?.thoroughfare ?? ""
        address2 = pm?.subThoroughfare ?? ""
        name = pm?.name ?? ""
        city = pm?.locality ?? ""
        state = pm?.administrativeArea ?? ""
        zipCode = pm?.postalCode ?? ""
        country = pm?.country ?? ""
    }
}
