//
//  historyViewController.swift
//  BudgetPlanner
//
//  Created by Daniel Ku on 6/23/16.
//  Copyright © 2016 Daniel Ku. All rights reserved.
//

import UIKit


class HistoryTableViewController: UITableViewController{
    
    var budgetList:[Budget]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgetList!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryTableViewCell", forIndexPath: indexPath) as! HistoryTableViewCell
        
        let row = indexPath.row
        
        let  budget = budgetList![row]

        cell.historyTitleLabel.text = budget.title
        
        cell.historyCostLabel.text = "$" +  String(format: "%.2f", budget.cost)
            
        cell.historyTimeLabel.text = String(budget.time)
        
        return cell
    }
    
}
