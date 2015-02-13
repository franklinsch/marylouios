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
    @IBOutlet weak var safetyView: UIView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var resultCities : Array<String!> = []
    var resultGeoLocs : Array<String!> = []
    
    @IBAction func search(sender: AnyObject) {
        getResultsFromServer()        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    func doHTTPPost() {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://www.freddielindsey.me:3000/getcities")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var params = ["slevel":"I", "plevel" : "like", "wlevel" : "pie"] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
            }
            else {
                if let parseJSON = json {
                    var success = parseJSON["success"] as? Int
                    println("Succes: \(success)")
                }
                else {
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }
    
    func getResultsFromServer() {
        DataManager.getDataFromServerWithSuccess { (ServerData) -> Void in
                let json = JSON(data: ServerData)
                
                 println("json \(json)")
                
                for (key: String, subJson: JSON) in json {
                    if let appName = json[key.toInt()!]["name"].stringValue as String? {
                        self.resultCities.append(appName)
                    }
                    
                    if let appName = json[key.toInt()!]["geo"].stringValue as String? {
                        self.resultGeoLocs.append(appName)
                    }
                }
                
                println("Got cities : \(self.resultCities)")
                println("Got geolocs : \(self.resultGeoLocs)")
                
                
                
                NSUserDefaults.standardUserDefaults().setObject(self.resultCities, forKey:"cities")
                NSUserDefaults.standardUserDefaults().setObject(self.resultGeoLocs, forKey:"geolocs")
                NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    func getResultsFromFileWithValues(NSArray) {
        DataManager.getTopAppsDataFromFileWithSuccess { (FileData) -> Void in
                
                //≈
            
                sleep(10);
                
                let json = JSON(data: FileData)
                
                // println(json)
                
                for (key: String, subJson: JSON) in json {
                    if let appName = json[key.toInt()!]["name"].stringValue as String? {
                        self.resultCities.append(appName)
                    }
                    
                    if let appName = json[key.toInt()!]["geo"].stringValue as String? {
                        self.resultGeoLocs.append(appName)
                    }
                }
                
                println("Got cities : \(self.resultCities)")
                println("Got geolocs : \(self.resultGeoLocs)")
                
                NSUserDefaults.standardUserDefaults().setObject(self.resultCities, forKey:"cities")
                NSUserDefaults.standardUserDefaults().setObject(self.resultGeoLocs, forKey:"geolocs")
                NSUserDefaults.standardUserDefaults().synchronize()
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

