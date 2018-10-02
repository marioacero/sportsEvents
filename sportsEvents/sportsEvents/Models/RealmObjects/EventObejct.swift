//
//  EventObejct.swift
//  sportsEvents
//
//  Created by Mario Acero on 9/30/18.
//  Copyright © 2018 MarioAcero. All rights reserved.
//

import Foundation
import RealmSwift

class EventObjectRealm: Object {
    
    @objc dynamic var id: String? = UUID().uuidString
    @objc dynamic var eventName: String? = nil
    var start = RealmOptional<Double>()
    var end = RealmOptional<Double>()
    @objc dynamic var forum: String? = nil
    @objc dynamic var location: String? = nil
    @objc dynamic var descriptionEvent: String? = nil
    @objc dynamic var isPublic: Bool = false
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
