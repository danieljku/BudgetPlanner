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
    @IBOutlet weak var currentBudgetField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var budgets = [Budget]()
    var dateLabel: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        datePicker.addTarget(self, action: #selector(ViewController.datePickerChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        dateLabel = strDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let historyTableViewController = segue.destinationViewController as! HistoryTableViewController
        if segue.identifier == "History"{
            historyTableViewController.budgetList = budgets
        }
    }

    
    @IBAction func addMoney(sender: AnyObject) {
        var newBudget: Double?
        var addBudget: Double?
        var currentBudget = Double(self.currentBudgetField.text!)
        if (currentBudget != nil){
            currentBudget = Double(self.currentBudgetField.text!)
        }else{
            currentBudget = 0.0
        }

        
        let alertController = UIAlertController(title: "Enter in new amount", message:"$$$", preferredStyle: .Alert)

        alertController.addTextFieldWithConfigurationHandler { (amountField: UITextField!) in
            amountField.placeholder = "Amount"
            amountField.keyboardType = .DecimalPad
        }
        
        let addAction = UIAlertAction(title: "Add", style: .Default){ (action) in
            addBudget = Double((alertController.textFields?.first)!.text!)
            newBudget = currentBudget! + addBudget!
            self.currentBudgetField.text = String(format: "%.2f", newBudget!)
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
        let title = titleField.text
        guard (title != "") else{
            let alertController = UIAlertController(title: titleField.text, message: "You didnt enter in a title!", preferredStyle: .Alert)
            let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
            }
            alertController.addAction(closeAction)
            
            self.presentViewController(alertController, animated: true){
            }
            
            titleField.text = ""
            costField.text = ""
            currentBudgetField.text = ""
            
            return
        }
        
        guard let costAmount = Double(costField.text!) else{
            let alertController = UIAlertController(title: costField.text, message: "You didn't enter in a cost!", preferredStyle: .Alert)
            let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
            }
            alertController.addAction(closeAction)
            
            self.presentViewController(alertController, animated: true){
            }
            
            titleField.text = ""
            costField.text = ""
            currentBudgetField.text = ""
            
            return
        }
        
        //Calculate cost
        if let currentAmount = Double(currentBudgetField.text!){
            let remainingBudget = currentAmount - costAmount
            currentBudgetField.text = String(format: "%.2f", remainingBudget)
        }
        
        
        let alertController = UIAlertController(title: titleField.text, message: "Has been added!", preferredStyle: .Alert)
        let closeAction = UIAlertAction(title: "Close", style: .Default){ (action) in
            //Add to history
            let budget = Budget()
            
            budget.title = title!
            budget.cost = costAmount
            budget.time = self.dateLabel
            self.budgets.append(budget)
        }
        alertController.addAction(closeAction)
        
        self.presentViewController(alertController, animated: true){
        }
    }
    
    

}

