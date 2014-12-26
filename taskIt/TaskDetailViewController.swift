//
//  TaskDetailViewController.swift
//  taskIt
//
//  Created by Martin Brunner on 17.11.14.
//  Copyright (c) 2014 Martin Brunner. All rights reserved.
//

import UIKit


@objc protocol TaskDetailViewControllerDelegate {
    optional func taskDetailEdited()
}

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var delegate:TaskDetailViewControllerDelegate?
    
    var detailTaskModel: TaskModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)        
        taskTextField.text = self.detailTaskModel.task
        subTaskTextField.text = detailTaskModel.subTask
        dueDatePicker.date = detailTaskModel.date
        dueDatePicker.datePickerMode = UIDatePickerMode.Date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtomTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        detailTaskModel.task = taskTextField.text
        detailTaskModel.subTask = subTaskTextField.text
        detailTaskModel.date = dueDatePicker.date
        detailTaskModel.completed = detailTaskModel.completed
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
        delegate?.taskDetailEdited!()
        
    }
    
    
}
