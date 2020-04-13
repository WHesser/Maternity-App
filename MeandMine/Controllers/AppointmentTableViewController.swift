//
//  AppointmentTableViewController.swift
//  Me and Mine
//
//  Created by Tiara Imani Logan on 4/12/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CodableFirebase


class AppointmentTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var appointments: [Appointment] = []
    var appointmentSnapshots: [DocumentSnapshot] = []
    var selectedAppointment: Appointment?
    var selectedAppointmentReference: DocumentReference?
     
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Appointments!"
        fetchAppointments()
    }

    func fetchAppointments() {
        
        // Fetch the Doctor Information and map to `Doctor.swift`
        guard let currentUser = Auth.auth().currentUser?.uid
            else {
                print("Couldn't find user")
                return
        }
        
        let basicQuery = Firestore.firestore().collection("Appointment").whereField("uid", isEqualTo: currentUser).limit(to:100)
        basicQuery.getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results \(error)")
                return
            }
            
            let models = snapshot.documents.map { (document)  -> Appointment in
                
                let model = try! FirestoreDecoder().decode(Appointment.self, from: document.data())
                return model
            }
            
            self.appointments = models
            self.appointmentSnapshots = snapshot.documents
            if let error = error {
                print("Oh no! Got an error! \(error.localizedDescription)")
                return
            }
            
            // make this thisis called on main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myAppointment", for: indexPath)
        
        let appointment = self.appointments[indexPath.row]
        cell.textLabel?.text = appointment.appTitle
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appointment = self.appointments[indexPath.row]
        self.selectedAppointment = appointment
        
        let appointmentRef = self.appointmentSnapshots[indexPath.row].reference
        
        self.selectedAppointmentReference = appointmentRef
        self.tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "editAppointment", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          guard let appointmentViewController = segue.destination as? AppointmentViewController else {
              return}
          
          
          if  segue.identifier == "editAppointment" {
              appointmentViewController.appointment = self.selectedAppointment
              appointmentViewController.documentReference = self.selectedAppointmentReference
          }
    }
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
            self.selectedAppointment = nil
            self.selectedAppointmentReference = nil
          fetchAppointments()
      }
 
}
