//
//  ViewController.swift
//  taskIt
//
//  Created by Martin Brunner on 13.11.14.
//  Copyright (c) 2014 Martin Brunner. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fechedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fechedResultsController = getFetchedResultsController()
        fechedResultsController.delegate = self
        fechedResultsController.performFetch(nil)
        
    }

    override  func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSource
    
    func  numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fechedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        println("Count: \(taskArray.count)")
        return fechedResultsController.sections![section].numberOfObjects

    }
    
    // called before segue to ViewControllers occurs
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = fechedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            
            detailVC.detailTaskModel = thisTask
            
        }
//        else if segue.identifier == "showTaskAdd" {
//            let addTaskVC: AddTaskViewController = segue.destinationViewController as AddTaskViewController
//        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        let theTask = fechedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        cell.taskLabel.text = theTask.task
        cell.descriptionLabel.text = theTask.subTask
        cell.dateLabel.text = Date.toString(date: theTask.date)
                
        return cell
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            cell.backgroundColor = UIColor.greenColor()
        }
        else if indexPath.section == 0 {
            cell.backgroundColor = UIColor.yellowColor()
            
        }
    }
    
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
   
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                println("Pressed: \(indexPath.row)")
        performSegueWithIdentifier("showTaskDetail", sender: self)

    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        }
        else {
            return "Completed"
        }
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        if indexPath.section == 0 {
            return "completed"
        }
        else {
            return "re-activate"
        }
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = fechedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        if indexPath.section == 0 {
            thisTask.completed = true
        }
        else if indexPath.section == 1 {
            thisTask.completed = false
        }
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    
    //NSFechedResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
// Helpers
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)

        fetchRequest.sortDescriptors = [completedDescriptor,sortDescriptor]
        
        return fetchRequest
        
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        
        fechedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        return fechedResultsController
    }

}

