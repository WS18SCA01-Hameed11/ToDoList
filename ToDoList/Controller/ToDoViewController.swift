//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Hameed Abdullah on 3/4/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    
    //MARK:_ Step 10
    @IBOutlet weak var titleTextField: UITextField!  
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    //MARK:_ Step 19.b
    //to know if the date picker is hidden or not
    var isPickerHidden: Bool = true
    
    //MARK:_ Step 20. a
    //It's optional because the property will be nil until the Save button is tapped and the property can be given a value
    var todo: ToDo? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:_ Step 23
        // Update the Static Table View Controller
        if let todo: ToDo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(60 * 60 * 24)
        }
        
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
        
        //Mark:_ step18
        //Update the Date Picker Starting Value
        //addingTimeInterval(_:) method to add any number of seconds. How many seconds are in 24 hours? Multiply 24 by 60 to convert hours into minutes, then multiply by 60 again to convert minutes into seconds
        //dueDatePickerView.date = Date().addingTimeInterval(24*60*60)

    }
    
    
    //MARK:_ Step 11
    //Disabel the save button, if there's no text in the title text field, the user shouldn't be able to save the item.
    func updateSaveButtonState() {
        //enable it if it is not empty
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    
    //MARK:_ 12
    //fires whenever the Editing Changed control event takes place.
    @IBAction func textEditingChanged(_ sender: UITextField) {
        //prevent the user from creating a ToDo without a title.
        updateSaveButtonState()
    }
    
    //MARK:_ Step 13
    //Dismiss Keyboard on Return
    //event: Primary Action Triggered
    @IBAction func returnButton(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    //MARK:_ Step 14
    //Switch Button Image, you want the image to toggle between the empty circle and the checkmark image. Earlier
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    
    //MARK:_ Step 16
    //a helper method to update dueDateLabel with the date passed into the method as a parameter. This method should be called in viewDidLoad() and whenever the date picker value changes:”
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    //MARK:_ Step 17
    //fires whenever the user changes the date picker
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        //Now the due date label will always display a string of text that matches the value in the date picker.
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    
    //MARK:_ Step 19. a
    //Expand and Collapse the Date Picker Cell, “start the cell at a height of 44, then expand it to 200 when tapped
    //“switch on an IndexPath, each value is an array with two items, where the first element is the cell's section and the second element is the cell's row.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch (indexPath) {
        case [1,0]: //Due date cell
            return isPickerHidden ? normalCellHeight : largeCellHeight
        case [2, 0]:   //Notes Cell
            return largeCellHeight
            
        default:
            return normalCellHeight
        }
    }
    
    //MARK:_ Step 20
    //your app will need to respond to the user tapping the Due Date cell, which will change isPickerHidden to false.
    // updates the text color of dueDateLabel, depending on whether the picker is hidden or not
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath) {
        case [1, 0]:   //Due Date cell
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
    
    //MARK:_ Step 21. b
    // Read Data from Controls
    // read the values from the appropriate controls, store them into constants, and pass the values into your model's initializer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else {
            return
        }
        
        let title: String = titleTextField.text!
        let isComplete: Bool = isCompleteButton.isSelected
        let dueDate: Date = dueDatePickerView.date
        let notes: String = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
