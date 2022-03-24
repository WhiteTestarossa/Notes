//
//  Note.swift
//  Notes
//
//  Created by Daniel Belokursky on 24.03.22.
//

import Foundation

struct Note: Hashable {
    var name: String
    var location: String
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
