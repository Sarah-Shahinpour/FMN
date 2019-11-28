//
//  JournalEntry.swift
//  FMN
//
//  Created by Sarah Shahinpour on 11/25/19.
//  Copyright © 2019 Sarah Shahinpour. All rights reserved.
//

import UIKit

class JournalEntry: NSObject, NSCoding {
    
    var uuid: String = NSUUID().uuidString
    var date: String = ""
    var entry: String = ""
    
    init(date: String, entry: String) {
        super.init()
        
        self.date = date
        self.entry = entry
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(uuid, forKey: "uuid")
        coder.encode(date, forKey: "date")
        coder.encode(entry, forKey: "entry")
    }
    
    required init?(coder decoder: NSCoder) {
        super.init()
        
        if let archivedUuid = decoder.decodeObject(forKey: "uuid") as? String {
            uuid = archivedUuid
        }
        if let archivedDate = decoder.decodeObject(forKey: "date") as? String {
            uuid = archivedDate
        }
        if let archivedEntry = decoder.decodeObject(forKey: "entry") as? String {
            uuid = archivedEntry
        }
    }
    

}
