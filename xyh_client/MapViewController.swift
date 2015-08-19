//
//  MapViewController.swift
//  xyh_client
//
//  Created by administrator on 15/8/18.
//  Copyright (c) 2015年 广州创源信息科技有限公司. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //始终允许授权开启位置功能
        if(UIDevice.currentDevice().systemVersion == "8.0") {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        //追踪用户当前位置，会调用定位服务
        mapView.userTrackingMode = MKUserTrackingMode.Follow
        mapView.mapType = MKMapType.Standard
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location:CLLocation = locations[locations.count-1] as! CLLocation
        
        if(location.horizontalAccuracy > 0) {
            println(location.coordinate.latitude)
            println(location.coordinate.longitude)
            var coor2d = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            var span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            var region = MKCoordinateRegion(center: coor2d, span: span)
            mapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
