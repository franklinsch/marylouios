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
        
        var results : Array<String!> = []
        
        DataManager.getTopAppsDataFromFileWithSuccess { (data) -> Void in
            let json = JSON(data: data)
            //print(json);
            if let topResult = json["city1"]["name1"].stringValue as String? {
                print(topResult)
                results.append(topResult);
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

