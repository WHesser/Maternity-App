//
//  PersonalViewController.swift
//  Me and Mine
//
//  Created by Amaya Finklea on 3/18/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import UIKit
import Foundation
import EventKit
import FirebaseAuth
import SwiftUI
import Firebase
import CodableFirebase


class PersonalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Outlets
    //MARK: Properties
    
    
    @IBOutlet weak var countDownLabel: UILabel!
    var appointment: Appointment?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let appointment = self.appointment else { return }
        fetchAppointInfo()
    }
    
    // UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = "Appointments"
        
        
        return cell
            
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: "myDueDate", for: indexPath)
        
        cell.textLabel?.text = "Due Date"
      //  cell.detailTextLabel?.text = "orange"
        
        return cell
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
            
            cell.textLabel?.text = "Appointments"
            
   
            return cell
            
        }
    }
    
    
}

func fetchAppointInfo() {

// Fetch the Doctor Information and map to `Doctor.swift`
guard let currentUser = Auth.auth().currentUser?.uid
    else {
        print("Couldn't find user")
        return
}

    let basicQuery = Firestore.firestore().collection("Appointment").whereField("uid",isEqualTo: currentUser)
    basicQuery.getDocuments { (snapshot, error) in
        if let error = error {
            print("Oh no! Got an error! \(error.localizedDescription)")
            return
        }
        guard let snapshot = snapshot else { return }
        guard let appointmentInfo = snapshot.documents.first else {
            print("no doctor found in db.")
            return
        }
 
    }
}

























 
 
 
 
 
 
 
 

