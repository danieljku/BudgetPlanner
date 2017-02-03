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
    @IBOutlet weak var dateField: UITextField!
    
    //All the history of spendings
    var budgets = [Budget]()
    var dateLabel: String!
    var newBudget: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func dateField(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(_ sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateField.text = dateFormatter.string(from: sender.date)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let historyTableViewController = segue.destination as! HistoryTableViewController
        if segue.identifier == "History"{
            historyTableViewController.budgetList = budgets
        }
    }
    
    @IBAction func addMoney(_ sender: AnyObject) {
        var addBudget: Double?
        var currentBudget = self.newBudget
        if (currentBudget == nil){
            currentBudget = 0.0
        }

        
        let alertController = UIAlertController(title: "Enter in new amount", message:"$$$", preferredStyle: .alert)

        alertController.addTextField { (amountField: UITextField!) in
            amountField.placeholder = "$0.00"
            amountField.keyboardType = .decimalPad
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default){ (action) in
            addBudget = Double((alertController.textFields?.first)!.text!)
            if (addBudget == nil){
                addBudget = 0.00
            }
            self.newBudget = currentBudget! + addBudget!
            self.currentBudgetField.text = "$" + String(format: "%.2f", self.newBudget!)
        }
        
        alertController.addAction(addAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (action) in
            //Don't change anything
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true){
            
        }
    }
 
    @IBAction func addSpending(_ sender: AnyObject) {
        guard (titleField.text != "") else{
            let alertController = UIAlertController(title: titleField.text, message: "You didnt enter in a title!", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .default){ (action) in
            }
            alertController.addAction(closeAction)
            
            self.present(alertController, animated: true){
            }
            
            titleField.text = ""
            
            return
        }
        
        guard dateField.text != "" else{
            let alertController = UIAlertController(title: "ERROR", message: "You didnt enter in a date!", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .default){ (action) in
            }
            alertController.addAction(closeAction)
            
            self.present(alertController, animated: true){
            }
            
            return
        }

        guard let costAmount = Double(costField.text!) else{
            let alertController = UIAlertController(title: costField.text, message: "You didn't enter in a cost!", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: .default){ (action) in
            }
            alertController.addAction(closeAction)
            
            self.present(alertController, animated: true){
            }
            
            costField.text = ""
            
            return
        }
    
        
        //Calculate cost
        if let currentAmount = newBudget{
            let remainingBudget = currentAmount - costAmount
            newBudget = remainingBudget
            currentBudgetField.text = "$" + String(format: "%.2f", remainingBudget)
        }
        
        
        let alertController = UIAlertController(title: titleField.text, message: "Has been added!", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default){ (action) in
            //Add to history
            let budget = Budget()
            
            budget.title = self.titleField.text!
            budget.cost = costAmount
            budget.time = self.dateField.text!
            
            
            self.budgets.append(budget)
        }
        alertController.addAction(closeAction)
        
        self.present(alertController, animated: true){
        }
    }
    
    

}

