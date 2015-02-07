//
//  ViewController.swift
//  MarylouiOS
//
//  Created by Franklin Schrans on 07/02/2015.
//  Copyright (c) 2015 Franklin Schrans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var safetyField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var weatherField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var resultCities : Array<String!> = []
    var resultGeoLocs : Array<String!> = []

    @IBOutlet weak var safetyView: UIView!
    
    @IBAction func search(sender: AnyObject) {
        var values : NSArray = [safetyField.text, priceField.text, weatherField.text]
        
        println("Getting cities with values \(values)")
        
        getResultsFromServerWithValues(values)
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
        dispatch_after(delayTime, dispatch_get_main_queue()){
            println("Got cities : \(self.resultCities)")
            println("Got geolocs : \(self.resultGeoLocs)")
            
            NSUserDefaults.standardUserDefaults().setObject(self.resultCities, forKey:"cities")
            NSUserDefaults.standardUserDefaults().setObject(self.resultGeoLocs, forKey:"geolocs")

            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    

    func getResultsFromServerWithValues(NSArray) {
        DataManager.getDataFromServerWithSuccess { (ServerData) -> Void in
            let json = JSON(data: ServerData)
            for (key: String, subJson: JSON) in json {
                if let appName = json[key.toInt()!]["name"].stringValue as String? {
                    self.resultCities.append(appName)
                }
                
                if let appName = json[key.toInt()!]["geo"].stringValue as String? {
                    self.resultGeoLocs.append(appName)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

