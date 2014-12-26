//
//  AddTaskViewController.swift
//  taskIt
//
//  Created by Martin Brunner on 18.11.14.
//  Copyright (c) 2014 Martin Brunner. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
    func addTask(message: String)
    func addTaskCanceled(message: String)
}


class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    var delegate: AddTaskViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTaskCanceled("Task was not added")        
        
    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {
   
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
            task.task = taskTextField.text.capitalizedString
        }
        else {
            task.task = taskTextField.text
        }
    

        task.subTask = subTaskTextField.text
        task.date = dueDatePicker.date
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
            task.completed = true
        }
        else {
            task.completed = false
        }
        appDelegate.saveContext()

        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        var result: NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        if let err = error {
            println("error: \(error)")
        }
        else {
            println("no error")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("Task added")
    }
   

}
