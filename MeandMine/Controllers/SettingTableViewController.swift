//
//  SettingTableViewController.swift
//  Me and Mine
//
//  Created by Amaya Finklea on 3/27/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import UIKit
class SettingProfile {
    var username: String?
    var email: String?
    
    init(username: String, email: String) {
        self.username = username
        self.email = email 
    }
}
class SettingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
  
}
