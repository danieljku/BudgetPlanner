//
//  historyViewController.swift
//  BudgetPlanner
//
//  Created by Daniel Ku on 6/23/16.
//  Copyright © 2016 Daniel Ku. All rights reserved.
//

import UIKit


class HistoryTableViewController: UITableViewController{
    
    var budgetHist = [Budget]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // 2
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 1
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryTableViewCell", forIndexPath: indexPath) as! HistoryTableViewCell
        
        let row = indexPath.row
        
        // 2
        let  budget = budgetHist[row]
        
        // 3
        cell.historyTitleLabel.text = budget.title
        
        // 4
        cell.historyCostLabel.text = String(format: "%.2f", budget.cost)
            
        cell.historyTimeLabel.text = String(format: "%f", budget.time)
        
        return cell
    }
    
    
    
    
}
