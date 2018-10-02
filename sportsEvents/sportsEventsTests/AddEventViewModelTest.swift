//
//  AddEventViewModelTest.swift
//  sportsEventsTests
//
//  Created by Mario Acero on 10/2/18.
//  Copyright © 2018 MarioAcero. All rights reserved.
//

import XCTest
import RealmSwift
@testable import sportsEvents

class AddEventViewModelTest: XCTestCase {
    
    var viewModel: AddEventViewModel?
    override func setUp() {
        continueAfterFailure = false
        viewModel = AddEventViewModel()
    }

    override func tearDown() {
        viewModel = nil
        RealmManager.shared.deleteAllObject(Class: EventObjectRealm.self)
    }
    
    func testAddEvent() {
        viewModel?.eventObject = EventObjectRealm()
        viewModel?.eventObject.eventName = "Event Test"
        viewModel?.eventObject.start.value = 1538457263
        viewModel?.eventObject.end.value = 1538457290
        viewModel?.eventObject.forum = "113"
        viewModel?.eventObject.location = "5 Avenue"
        viewModel?.eventObject.descriptionEvent = "This an test description for the challenge"
        viewModel?.eventObject.isPublic = true
        viewModel?.saveEvent()
        
        let object = RealmManager.shared.getAll(Class: EventObjectRealm.self)
        
        XCTAssertNotNil(object, "the object not should be nil")
        XCTAssertGreaterThan(object.count, 0)
        XCTAssertEqual(viewModel?.eventObject.eventName, "Event Test")
        
        
    }
}
