//
//  LocationHelper.swift
//  SwiftStorage
//
//  Created by new on 29/05/18.
//  Copyright © 2018 yuvraj. All rights reserved.
//

import Foundation

class LocationHelper{
    var location = String()
    var lattitude = Double()
    var longitude = Double()
    
    init(location : String, lat : Double , long : Double) {
        self.location = location
        self.lattitude = lat
        self.longitude = long
    }
}
