//
//  ResultsViewController.swift
//  MarylouiOS
//
//  Created by Franklin Schrans on 07/02/2015.
//  Copyright (c) 2015 Franklin Schrans. All rights reserved.
//

import UIKit
import MapKit

class ResultsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var avgLoc : CLLocationCoordinate2D!
    var cities : NSArray! = []
    var geoLocs : NSArray! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cities = NSUserDefaults.standardUserDefaults().objectForKey("cities") as NSArray!
        geoLocs = NSUserDefaults.standardUserDefaults().objectForKey("geolocs") as NSArray!
        
        println("Fetched \(cities)")
        println("Fetched \(geoLocs)")
    }
    
    func calculateAvg(locations : Array<CLLocationCoordinate2D>) {
        var avgX : Int = 0
        var avgY : Int = 0
        let length = locations.count
        
        println(length)
        
        for var i : Int = 0; i < length; i++ {
            avgX += Int(locations[i].longitude)
            avgY += Int(locations[i].latitude)
        }
        
        avgX /= length
        avgY /= length
        
        println(avgX)
        println(avgY)
        
        var newX  : CLLocationDegrees = CLLocationDegrees(avgX)
        var newY : CLLocationDegrees = CLLocationDegrees(avgY)

        println(newX)
        println(newY)
        
        self.avgLoc = CLLocationCoordinate2D(latitude: newX, longitude: newY)
    }
    
    func initialiseMap() {
        
        for var i : Int = 0 ; i < cities.count; i++ {
            cities[i]
        }
        
        var location1 = CLLocationCoordinate2D(
            latitude: 10,
            longitude: 10
        )
        
        var location2 = CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        )
        
        var location3 = CLLocationCoordinate2D(
            latitude: -60,
            longitude: 35
        )
        
        calculateAvg([location1, location2, location3])
        
        var span1 : MKCoordinateSpan = MKCoordinateSpanMake(100, 100)
        
        var region1 = MKCoordinateRegion(center: avgLoc, span: span1 )
        
        mapView.setRegion(region1, animated: true)
        
        var annotation1 = MKPointAnnotation()
        annotation1.setCoordinate(location1)
        annotation1.title = "Roatan"
        annotation1.subtitle = "Honduras"
        
        mapView.addAnnotation(annotation1)
        
        var region2 = MKCoordinateRegion(center: avgLoc, span: span1)
        
        mapView.setRegion(region2, animated: true)
        
        var annotation2 = MKPointAnnotation()
        annotation2.setCoordinate(location2)
        annotation2.title = "Roatan"
        annotation2.subtitle = "Honduras"
        
        mapView.addAnnotation(annotation2)
        
        var annotation3 = MKPointAnnotation()
        annotation3.setCoordinate(location3)
        annotation3.title = "Roatan"
        annotation3.subtitle = "Honduras"
        
        mapView.addAnnotation(annotation3)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "test"
        
        return cell
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
