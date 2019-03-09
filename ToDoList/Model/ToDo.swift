//
//  ToDo.swift
//  ToDoList
//
//  Created by Hameed Abdullah on 3/1/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import Foundation



//MARK:_ Step 1
struct ToDo: Codable {
    
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    //MARK:_ Step 3
    //load data that are saved in desk this will be called in table view controller's viewDidLoad() method
    static func loadToDos() -> [ToDo]? { //page. 734
        
        //MARK:_ Step 27. b
       //load data from disk, Use a PropertyListDecoder and the methods on Data
        guard let codedToDos: Data = try? Data(contentsOf: archiveURL) else {
            return nil
        }
        
        let propertyListDecoder: PropertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode([ToDo].self, from: codedToDos)
    }
    
    //MARK:_ Step 4
    //add some simple logic this will be called in table view controller's viewDidLoad() method that will populate the ToDo array with some initial data if no data is retrieved from disk
    //write a static method that populates the array with sample data
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
         let todo2 = ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
         let todo3 = ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]
    }
    
    //MARK:_ Step 27. a
    //Add Support for Archiving and Unarchiving
    //save data somewhere in the app's Documents directory. Since this directory is accessible by your app and can't be modified by another app, it's a safe place to store your list. You can use the FileManager class to locate your app's Documents directory, create a subfolder for archiving data, and store that path to a constant.
    static let documentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL: URL = documentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
    
    
    //MARK:_ Step 28. a - Save data to desk
    //Write a static method that uses a PropertyListEncoder to encode a [ToDo] collection and then uses the write(to:options:) method on Data to store it in the Documents directory:
    static func saveToDos(_ todos: [ToDo]) {
        
        let propertyListEncoder: PropertyListEncoder = PropertyListEncoder();
        guard let codedToDos: Data = try? propertyListEncoder.encode(todos) else {
            fatalError("could not encode ToDos");
        }
        
        if (try? codedToDos.write(to: archiveURL, options: .noFileProtection)) == nil {
            fatalError("could not save encoded ToDos");
        }
    }
    
    //MARK:_ Step 15
    //Update Date Label
    // create a DateFormatter object to convert a date into a string
    //To ensure that the date object is created only once and isn't tied to a particular instance of your model, use the static keyword
    //“By setting the dateStyle and timeStyle properties to short, the date string will display the date and time in the most succinct format possible. For example, using this date formatter, "January 1st, 1970 at 12:00am" would appear as "1/1/1970, 12:00 AM.
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    
}






























