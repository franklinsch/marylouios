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
    
    @IBAction func search(sender: AnyObject) {
        var values : NSArray = [safetyField.text, priceField.text, weatherField.text]
        
        getResultsFromServerWithValues(values)
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
        dispatch_after(delayTime, dispatch_get_main_queue()){
            println(self.results)
        }
        
        
    }
    
    var results : Array<String!> = []

    func getResultsFromServerWithValues(NSArray) {
        DataManager.getDataFromServerWithSuccess { (iTunesData) -> Void in
            let json = JSON(data: iTunesData)
            
            
            if let appName = json["city1"]["name"].stringValue as String? {
                self.results.append(appName)
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

