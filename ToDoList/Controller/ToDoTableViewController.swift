//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Hameed Abdullah on 3/1/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit

//MARK:_ Step 25. c
//The cell's delegate should be the ToDoTableViewController, which doesn't conform to the protocol you defined earlier. Update the view controller's class definition so that it can be set as the delegate -> ToDoCellDelegate

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    
    //MARK:_ Step 2
    //Create an empty array of your model objects
    var todos: [ToDo] = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK:_ Step 5
        //write some conditional logic to load items from disk; if there aren't any, use the loadSampleToDos() method to fill the array with data:
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }

        //MARK:_ Step 8
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoTableViewCell else {
            fatalError("Could not deque a cell")
        }
     
        
        let todo = todos[indexPath.row]
        
        cell.titleLabel?.text   = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        
        
        //MARK:_ Step 25. E
        //Whenever a cell is dequeued, the To Do table view controller should set itself as the cell's delegate.
        cell.delegate = self

        return cell
    }
 

    //MARK:_ Step 6
    // add swipe-to-delete functionality - use the indexPath property to choose which cells are editable
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // since all cells can be selected in this app, you can simply return true.
        return true
    }
 

    //MARK:_ Step 7
    // Override to support editing the table view.
    // verify that the Delete button triggered the method call, then delete the model from the array, as well as from the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //MARK:_ Step 28. c - Save data to desk
            //the appropriate time to write your collection of models to disk? whenever the collection changes in some way
            ToDo.saveToDos(todos)
            
        }

    }
    
    //MARK:_ Step 25. D
    //To satisfy the conditions of the protocol, this view controller must implement all of its methods. Since there's only one method defined in the protocol, you can add the method declaration, but leave the method body blank:
    //This error accurs if we dont implement the delegate method
    //Type 'ToDoTableViewController' does not conform to protocol 'ToDoCellDelegate' Do you want to add protocol stubs?
    func checkmarkTapped(sender: ToDoTableViewCell) {
        
        //MARK:_ Step 26
        //determine the index path of the cell, which you'll use to flip the isComplete Boolean of the corresponding ToDo. Once you've updated the model, reload the cell so that its appearance is up to date with the data
        if let indexPath: IndexPath = tableView.indexPath(for: sender) {
            var todo: ToDo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
            //MARK:_ Step 28. b - Save data to desk
            //the appropriate time to write your collection of models to disk? whenever the collection changes in some way
            ToDo.saveToDos(todos)
        }
        
    }
 
    
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        
        //MARK:_ Step 20. c
        //the model is stored in a property(var todo: ToDo? = nil in ToDoViewController), how does the list view controller access the property and add it to the collection? The unwind segue defined in the ToDo Table view controller can access data from the ToDoViewController that's being dismissed
        
        guard segue.identifier == "saveUnwind" else {
            return
        }
        let sourceViewController: ToDoViewController = segue.source as! ToDoViewController
        
        if let todo: ToDo = sourceViewController.todo {
            if let selectedIndexPath: IndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath: IndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
        //MARK:_ Step 28. D - Save data to desk
        //The collection may also be updated when the user taps the Save button
        ToDo.saveToDos(todos)
    

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //MARK:_ Step 22
        // pass the model object from the list to the static table view controller. Use the prepare(for:sender:) method to downcast the destination to your view controller subclass. Then, use the index path of the selected row to access the corresponding model, and set the model property in the destination:
        if segue.identifier == "showDetails" {
            // Get the new view controller using segue.destination.
            let todoViewController = segue.destination as! ToDoViewController
            // Pass the selected object to the new view controller.
            let indexPath: IndexPath = tableView.indexPathForSelectedRow!
            todoViewController.todo = todos[indexPath.row]
        }

        
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
