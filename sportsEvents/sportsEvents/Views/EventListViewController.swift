//
//  eventListViewController.swift
//  sportsEvents
//
//  Created by Mario Acero on 9/29/18.
//  Copyright © 2018 MarioAcero. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    lazy var viewModel: EventListViewModel = {
        return EventListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.registerNib(ListEventTableViewCell.stringRepresentation)
        setDataBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getData()
    }
    
    func setDataBinding() {
        viewModel.reloadData = { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.listTableView.reloadData()
            
        }
    }

}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListEventTableViewCell = tableView.dequeueReusableCell(withIdentifier: ListEventTableViewCell.stringRepresentation) as! ListEventTableViewCell
        let row =  viewModel.dataSource[indexPath.section][indexPath.row]
        cell.eventName.text = row.eventName
        cell.locationLabel.text = row.location
        cell.participantsLabel.text = "0/\(row.forum!)"
        let calendar = NSCalendar.current
        let startHour = calendar.component(.hour, from: Date.init(timeIntervalSince1970: row.start.value!))
        let startMinute = calendar.component(.minute, from: Date.init(timeIntervalSince1970: row.start.value!))
        let endHour = calendar.component(.hour, from: Date.init(timeIntervalSince1970: row.end.value!))
        let endMinute = calendar.component(.minute, from: Date.init(timeIntervalSince1970: row.end.value!))
        cell.durationLabel.text = "\(startHour):\(startMinute) - \(endHour):\(endMinute)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if viewModel.hasTodayEvents {
            title = "TODAY"
        }else {
            title = "TOMORROW"
            return title
        }
        
        if section == 1 {
            title = "TOMORROW"
        }
        
        return title
    }
}
