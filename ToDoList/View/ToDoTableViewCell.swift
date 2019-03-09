//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Hameed Abdullah on 3/1/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit

//MARK:_ Step 25. a
//Add a Cell Delegate Method
//a protocol with a method that passes the cell back to the delegate
protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoTableViewCell)
}


class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:_ Step 25. b
    //Add a delegate property to your cell subclass so that the cell has something to inform
    var delegate: ToDoCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    //a method that handles the checkmark button tap, and update the isComplete Boolean
    //inform the delegate that the button tap has occurred, passing in self as the parameter to the method
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
