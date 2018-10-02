//
//  AddEventViewModel.swift
//  sportsEvents
//
//  Created by Mario Acero on 9/30/18.
//  Copyright © 2018 MarioAcero. All rights reserved.
//

import Foundation

class AddEventViewModel {
    
    var eventObject: EventObjectRealm
    var closeView: (()->())?
    
    init() {
        eventObject = EventObjectRealm()
    }
    
    func saveEvent() {
        RealmManager.shared.addObject(object: eventObject.self)
        closeView?()
    }
    
}
