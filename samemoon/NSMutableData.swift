//
//  NSMutableData.swift
//  samemoon
//
//  Created by Hector Aguilar on 18/12/17.
//  Copyright © 2017 Hector Aguilar. All rights reserved.
//

import UIKit

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
