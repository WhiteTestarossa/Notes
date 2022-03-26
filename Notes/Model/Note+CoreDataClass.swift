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
        return text.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    var desc: String {
        var pureLines = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: CharacterSet.newlines)
        pureLines.removeFirst()
        return "\(date.format())  \(pureLines.first ?? "")"
    }
}
