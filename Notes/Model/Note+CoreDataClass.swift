//
//  Note+CoreDataClass.swift
//  Notes
//
//  Created by Daniel Belokursky on 26.03.22.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    var title: String {
//        return text?.components(separatedBy: CharacterSet.newlines).first ?? ""
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""
    }
    
    var desc: String {
        return "\(date!)"
    }
}
