//
//  ResultsViewController.swift
//  MarylouiOS
//
//  Created by Franklin Schrans on 07/02/2015.
//  Copyright (c) 2015 Franklin Schrans. All rights reserved.
//

import UIKit
import MapKit

class ResultsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    
    var avgLoc : CLLocationCoordinate2D!
    var cities : Array<String!> = []
    var geoLocs : Array<String!> = []
    var geoLocsCoords : Array<(Double!, Double!)> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cities = NSUserDefaults.standardUserDefaults().objectForKey("cities") as Array<String!>
        geoLocs = NSUserDefaults.standardUserDefaults().objectForKey("geolocs") as Array<String!>
        
        println("Fetched \(cities)")
        println("Fetched \(geoLocs)")
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "protoCell")
        
        geoLocsCoords = [];
        
        convertGeoLocs()
        
        println(geoLocsCoords);
    }
    
    func convertGeoLocs() {
        for var i : Int = 0 ; i < geoLocs.count ; i++ {
            geoLocsCoords.append(processLocs(geoLocs[i]))
        }
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
        
        var newX  : CLLocationDegrees = CLLocationDegrees(avgX)
        var newY : CLLocationDegrees = CLLocationDegrees(avgY)
        
        self.avgLoc = CLLocationCoordinate2D(latitude: newX, longitude: newY)

    }
    
    func initialiseMap() {
        
//        for var i : Int = 0 ; i < cities.count; i++ {
//            cities[i]
//        }
        
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
        return cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("protoCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.cities[indexPath.row]
        cell.imageView?.image = UIImage(named: (String(indexPath.row + 1)) + "circle.png")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedIndexPath : NSIndexPath = tableView.indexPathForSelectedRow()!
        
        updateMapWithFocusOn(selectedIndexPath.row)
    }
    
    func updateMapWithFocusOn(index : Int) {
        
        let (lat,long) = geoLocsCoords[index]
        
        var focusLoc : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        var region1 = MKCoordinateRegion(center: focusLoc, span: MKCoordinateSpanMake(50, 50))
        
        mapView.setRegion(region1, animated: true)
        
    }
    
    func processLocs(s : String) -> (Double!, Double!) {
        println(s)
        
        var tmpLat : String  = ""
        var tmpLong : String = ""
        var lat : Double = 0
        var long : Double = 0
        
        for var i : Int = 0 ; i < countElements(s) ; i++ {
            if (s[i] == ",") {
                lat = (tmpLat as NSString).doubleValue
                tmpLong = "";
                continue
            }
            
            tmpLat += s[i]
            tmpLong += s[i]
        }
        
        long = (tmpLong as NSString).doubleValue
        
        return (lat, long)
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}

