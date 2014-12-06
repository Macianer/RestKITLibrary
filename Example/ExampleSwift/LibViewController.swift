//
//  ViewController.swift
//  ExampleSwift
//
//  Created by Ronny Meißner on 25/11/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

import UIKit

class LibViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataStructure:[NSArray] = [];
    
    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        
        dataStructure = []
    
        
        let dataSet1 = [kLongTitleKey:kGGCTitleKey,
            kURLKey:kGGCAPIUrl]
    
        let dataSet2 = [kLongTitleKey : kGPTitleKey,
            kURLKey: kGPTitleKey]
    
        let googleArray:[NSDictionary] = [dataSet1, dataSet2]

        dataStructure.append(googleArray)
        
        let dataSet3 = [kLongTitleKey : kRMProjectsTitleKey,
            kURLKey: kRMDemoAPIUrl]
        let dataSet4 = [kLongTitleKey : kRMIssuesTitleKey,
            kURLKey: kRMDemoAPIUrl]
        
        let redmineArray = [dataSet3, dataSet4]
        dataStructure.append(redmineArray)

        let nib:UINib = UINib(nibName: NSStringFromClass(RKLIBTableViewCellMain.self), bundle: NSBundle.mainBundle())

        tableView .registerNib(nib, forCellReuseIdentifier: NSStringFromClass(RKLIBTableViewCellMain.self))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: table view dataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return dataStructure.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = dataStructure[section]
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell
        
        cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(RKLIBTableViewCellMain.self), forIndexPath: indexPath) as UITableViewCell
        
        // get sub array 
        let array = dataStructure[indexPath.section];
        
        if let string = array[indexPath.row] as? NSString {
            cell.textLabel?.text = string;
        }
        
        // assign dictionary values to cell labels
        if let dict = array[indexPath.row] as? NSDictionary {
            
            if let string1 = dict[kLongTitleKey] as? NSString {
                cell.textLabel?.text = string1
            }
            else if let attString1 = dict[kLongTitleKey] as? NSAttributedString {
                cell.textLabel?.attributedText = attString1
            }
            if let string2 = dict[kLongTitleKey] as? NSString {
                cell.textLabel?.text = string2
            }
            else if let attString2 = dict[kLongTitleKey] as? NSAttributedString {
                cell.textLabel?.attributedText = attString2
            }
        }
        return cell
    }
}

