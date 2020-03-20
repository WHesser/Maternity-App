//
//  SOSPageViewController.swift
//  Me and Mine
//
//  Created by Amaya Finklea on 2/19/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import UIKit
import Firebase

class SOSDisplayViewController: UIViewController {
//MARK: Properties
    
    @IBOutlet weak var sosLabel: UILabel!
    @IBOutlet weak var docName: UILabel!
    @IBOutlet weak var docEmail: UILabel!
    @IBOutlet weak var docEmerNum: UILabel!
    @IBOutlet weak var docAddress: UILabel!
    @IBOutlet weak var docCity: UILabel!
    @IBOutlet weak var docState: UILabel!
    @IBOutlet weak var docZip: UILabel!
    
    @IBAction func EditButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = Auth.auth().currentUser
        print(userID) 

    }
    

  
} //END OF CLASS
