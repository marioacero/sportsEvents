//
//  AddEventTableViewController.swift
//  sportsEvents
//
//  Created by Mario Acero on 9/30/18.
//  Copyright © 2018 MarioAcero. All rights reserved.
//

import UIKit

class AddEventTableViewController: UITableViewController {

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    
    @IBOutlet weak var forum: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var isPublicSwitch: UISwitch!
    
    var datePicker:UIDatePicker!
    
    lazy var viewModel: AddEventViewModel = {
        return AddEventViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBindingViewModel()
    }
   
    
    func setBindingViewModel() {
        viewModel.closeView = { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.cancelAction(strongSelf)
        }
    }
    
    func showAlertError() {
        let alert = UIAlertController(title: "All field requireds", message: "Please complete all fields to add an event", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func setDatePicker( sender: UITextField) {
        datePicker = UIDatePicker()
        datePicker.minimumDate = Date()
        datePicker.tag = sender.tag
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(AddEventTableViewController.doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("cancelDatePicker")))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePicker
    }
    
    @objc func doneDatePicker() {
        
        var sender: UITextField = startDate
        if datePicker.tag == 2 {
            sender = endDate
            viewModel.eventObject.end.value = datePicker.date.timeIntervalSince1970
        }else {
            viewModel.eventObject.start.value = datePicker.date.timeIntervalSince1970
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        sender.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard let eventName = eventNameTextField.text, !eventName.isEmpty,
                let description = eventDescription.text, !description.isEmpty,
                let forumPlace = forum.text, !forumPlace.isEmpty,
                let location = locationText.text, !location.isEmpty,
                (viewModel.eventObject.start.value != nil && viewModel.eventObject.end.value != nil)
        else {
            showAlertError()
            return
        }
        
        viewModel.eventObject.eventName = eventName
        viewModel.eventObject.descriptionEvent = description
        viewModel.eventObject.forum = forumPlace
        viewModel.eventObject.location = location
        viewModel.eventObject.isPublic = isPublicSwitch.isOn
        
        viewModel.saveEvent()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func initialPicker(_ sender: UITextField) {
        setDatePicker(sender: sender)
    }
    
    @IBAction func endPicker(_ sender: UITextField) {
        setDatePicker(sender: sender)
    }
    
    
}
