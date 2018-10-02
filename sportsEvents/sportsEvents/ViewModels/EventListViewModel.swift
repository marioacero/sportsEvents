//
//  EventListViewModel.swift
//  sportsEvents
//
//  Created by Mario Acero on 10/1/18.
//  Copyright © 2018 MarioAcero. All rights reserved.
//

import Foundation

class EventListViewModel {
    
    var dataSource: [EventsDictionary] = []
    var hasTodayEvents: Bool = false
    
    var reloadData: (()->())?
    
    func getData() {
        dataSource = []
        var todayDate = Date()
        let calendar = NSCalendar.current
        let currentYear =  calendar.component(.year,  from: todayDate)
        let currentMonth =  calendar.component(.month,  from: todayDate)
        let currentDay =  calendar.component(.day,  from: todayDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "\(currentYear)-\(currentMonth)-\(currentDay)")!
        todayDate = Date.init(timeIntervalSince1970: date.timeIntervalSince1970)
        let tomorrow = dateFormatter.date(from: "\(currentYear)-\(currentMonth)-\(currentDay+1)")!
        
        var predicate = NSPredicate(format: "start >= %f && end < %f",date.timeIntervalSince1970, tomorrow.timeIntervalSince1970 )
        let todayEvents = RealmManager.shared.getAllWithPredicate(Class: EventObjectRealm.self, equalParam: predicate)
        
        let otherDay = dateFormatter.date(from: "\(currentYear)-\(currentMonth)-\(currentDay+2)")!
        predicate = NSPredicate(format: "start >= %f && end < %f",tomorrow.timeIntervalSince1970, otherDay.timeIntervalSince1970 )
        let tomorrowEvents = RealmManager.shared.getAllWithPredicate(Class: EventObjectRealm.self, equalParam: predicate)
        
        hasTodayEvents = !todayEvents.isEmpty
        if !todayEvents.isEmpty {
            dataSource.append(todayEvents)
        }
        
        if !tomorrowEvents.isEmpty {
            dataSource.append(tomorrowEvents)
        }
        
        reloadData?()
    }
}
