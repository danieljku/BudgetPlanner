//
//  ViewController.swift
//  BudgetPlanner
//
//  Created by Daniel Ku on 6/23/16.
//  Copyright © 2016 Daniel Ku. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var remainingBudgetField: UITextField!
    @IBOutlet weak var currentBudgetField: UITextField!
    
    var budget = Budget()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func addMoney(sender: AnyObject) {
        var newBudget: Double! = 0.0
        
        let alertController = UIAlertController(title: "Enter in new amount", message:"$$$", preferredStyle: .Alert)

        alertController.addTextFieldWithConfigurationHandler { (amountField) in
            amountField.placeholder = "Amount"
            amountField.keyboardType = .DecimalPad
            //newBudget = NSString(string: alertController.textFields![0]).doubleValue
        }
        
        let addAction = UIAlertAction(title: "Add", style: .Default){ (action) in
          self.currentBudgetField.text = String(format: "%.2f", newBudget)
        }
        
        alertController.addAction(addAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel){ (action) in
            //Don't change anything
        }
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true){
            
        }
    }
 
    @IBAction func addSpending(sender: AnyObject) {
        guard let title = Optional(titleField.text!) else{
            print("You didnt enter in a title!")
            
            titleField.text = ""
            costField.text = ""
            dateField.text = ""
            remainingBudgetField.text = ""
            currentBudgetField.text = ""
            
            return
        }
        
        guard let costAmount = Double(costField.text!) else{
            print("You didn't enter a cost!")
            
            titleField.text = ""
            costField.text = ""
            dateField.text = ""
            remainingBudgetField.text = ""
            currentBudgetField.text = ""

            
            return
        }
        
        //Calculate cost
        if let currentAmount = Double(currentBudgetField.text!){
            let remainingBudget = currentAmount - costAmount
            remainingBudgetField.text = String(format: "%.2f", remainingBudget)
        }
        
        
        let alertController = UIAlertController(title: titleField.text, message: "Has been added!", preferredStyle: .Alert)
        let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
            //Add to history
            //budget.title = titleField.text
            //budget.cost = costFiel
        }
        alertController.addAction(closeAction)
        
        self.presentViewController(alertController, animated: true){
        }
        
        
        
        
    }
    
    

}

