//
//  AppointmentViewController.swift
//  Me and Mine
//
//  Created by Tiara Imani Logan on 4/9/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
//import Firebase
import CodableFirebase
import Firebase


class AppointmentViewController: UIViewController {
    //MARK: Properties
    var datePicker = UIDatePicker()
    // var doctor: Doctor?
    var appointment: Appointment?
    
    
    var documentReference: DocumentReference?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var appointmentTitle: UITextField!
    @IBOutlet weak var appointmentAddOne: UITextField!
    @IBOutlet weak var appointmentAddTwo: UITextField!
    @IBOutlet weak var appointmentCity: UITextField!
    @IBOutlet weak var appointmentState: UITextField!
    @IBOutlet weak var appointmentZipcode: UITextField!
    
    
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: sender.date)
        dateLabel.text = strDate
    }
    
    
    func setInitialDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        dateLabel.text = strDate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialDate()
        updateDisplayWitAppointment()
        
    }
    
    func updateDisplayWitAppointment()  {
        guard let appointment = appointment else {return}
        // all text fields
        appointmentTitle.text = appointment.appTitle
        appointmentAddOne.text = appointment.addLineOne
        appointmentAddTwo.text = appointment.addLineTwo
        appointmentCity.text = appointment.addCity
        appointmentState.text = appointment.addState
        appointmentZipcode.text = String(appointment.addZip)
        
    }
    
    
    
    @IBAction func saveAppointment(_ sender: UIBarButtonItem) {
        
        guard let title = appointmentTitle.text,
            let addressL1 = appointmentAddOne.text,
            let addressL2 = appointmentAddTwo.text,
            let city = appointmentCity.text,
            let state = appointmentState.text,
            let zipcode = Int(appointmentZipcode.text ?? "0") else {return}
        
        
        
        
        
        // 2. Determine if we are saving an existing doctor or creating a new doctor
        if let appointment = appointment, let documentReference = documentReference {
            /// Update existing doctor's info
            let updatedAppointment = Appointment(appTitle: title, addLineOne: addressL1, addLineTwo: addressL2, addCity: city, addState: state, addZip: zipcode)
            
            // Updates the existing doctor info to the server
            
            documentReference.updateData(updatedAppointment.documentData) { (error) in
                if let error = error {
                    print("Could not update appointment: \(error)")
                    
                } else {
                    print("updated appointment success!")
                }
                
                self.navigationController?.popViewController(animated: true)
            }
            
        } else {
            // creates a  new  doctor on the server
            let newAppointment = Appointment(appTitle: title, addLineOne: addressL1, addLineTwo: addressL2, addCity: city, addState: state, addZip: zipcode)
            Firestore.firestore().collection("Appointment").addDocument(data: newAppointment.documentData) { (error) in
                if let error = error {
                    print("Could not update appointment: \(error)")
                    
                } else {
                    print("Added appointment a success!")
                }
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
}



