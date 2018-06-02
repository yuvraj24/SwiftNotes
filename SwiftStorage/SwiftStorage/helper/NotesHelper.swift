//
//  NotesHelper.swift
//  SwiftStorage
//
//  Created by new on 29/05/18.
//  Copyright © 2018 yuvraj. All rights reserved.
//

import Foundation

class NotesHelper {
    var photo : String = ""
    var location : LocationHelper
    var content : String = ""
    
    init(photo : String, location : LocationHelper, content : String) {
        self.photo = photo
        self.location = location
        self.content = content
    }
}
