//
//  RKLIBTableVIewController.swift
//  RestKITLibrary
//
//  Created by Ronny Meißner on 25/11/14.
//  Copyright (c) 2014 ronnymeissner. All rights reserved.
//

import Foundation
import UIKit


class RKLIBTableViewControllerSwift:UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var dataStructure : NSMutableArray?
    
    override func viewDidLoad() {
        self.dataStructure = []
            
//        UINib *nib = [UINib nibWithNibName:NSStringFromClass([RKLIBTableViewCellMain class]) bundle:[NSBundle mainBundle]];
//        [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([RKLIBTableViewCellMain class])];
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //TODO:
        return UITableViewCell();
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO:
        return 0;
    }
    
}