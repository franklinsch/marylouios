//
//  DataManager.swift
//  MarylouiOS
//
//  Created by Franklin Schrans on 07/02/2015.
//  Copyright (c) 2015 Franklin Schrans. All rights reserved.
//

import Foundation

class DataManager{
    
    func getResultsForValues(values: Array<String!>) -> Array<String!> {
        var results : Array<String!> = [];
        
        getResultsFromFile { (data) -> Void in
            let json = JSON(data: data)
            if let topResult = json["city1"]["name"].stringValue as String? {
                results.append(topResult);
            }
        }
        
        return results;
    }
    
    func getResultsFromFile(success: ((data: NSData) -> Void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let filePath = NSBundle.mainBundle().pathForResource("SampleData",ofType:"json")
            
            var readError:NSError?
            if let data = NSData(contentsOfFile:filePath!,
                options: NSDataReadingOptions.DataReadingUncached,
                error:&readError) {
                    success(data: data)
            }
        })
    }

    
}

