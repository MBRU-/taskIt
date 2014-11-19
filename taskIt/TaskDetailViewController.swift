//
//  TaskDetailViewController.swift
//  taskIt
//
//  Created by Martin Brunner on 17.11.14.
//  Copyright (c) 2014 Martin Brunner. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var detailTaskModel: TaskModel!
    var mainVC: ViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        var task = TaskModel(task: taskTextField.text, subTask: subTaskTextField.text, date: dueDatePicker.date, completed: false)
        mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow()!.row] = task
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    
}
