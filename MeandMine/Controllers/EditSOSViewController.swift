//
//  EditSOSViewController.swift
//  Me and Mine
//
//  Created by Amaya Finklea on 3/18/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import UIKit
import Firebase

class EditSOSViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var sosLabel: UILabel!
    @IBOutlet weak var docName: UITextField!
    @IBOutlet weak var docEmail: UITextField!
    @IBOutlet weak var docEmerNum: UITextField!
    @IBOutlet weak var docAddress: UITextField!
    @IBOutlet weak var docCity: UITextField!
    @IBOutlet weak var docState: UITextField!
    @IBOutlet weak var docZip: UITextField!
    
    var doctor: Doctor?
    var documentReference: DocumentReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateDisplayWithDoctor()
    }
    
    func updateDisplayWithDoctor()  {
        guard let doctor = doctor else {return}
        // all text fields
        docName.text = doctor.name
        docEmail.text = doctor.email
        docEmerNum.text = String(doctor.number)
        docState.text = doctor.state
        docCity.text = doctor.city
        docZip.text = String(doctor.zipcode)
        docAddress.text = doctor.address
    }
    
    @IBAction func EnterButton(_ sender: Any) {
        // User presses enter to save Doctor information
        
        // 1. Extract the values from the text fields
        guard let name = docName.text,
            let email = docEmail.text,
            let city = docCity.text,
            let address = docAddress.text,
            let state = docState.text,
            let number = Int(docEmerNum.text ?? "0"),
            let zipcode = Int(docZip.text ?? "0") else {return}
        
        // 2. Determine if we are saving an existing doctor or creating a new doctor
        if let doctor = doctor, let documentReference = documentReference {
            /// Update existing doctor's info
            let updatedDoctor = Doctor(name: name,
                                       email: email,
                                       city: city,
                                       address: address,
                                       number: number,
                                       zipcode: zipcode,
                                       state: state)
            
           
            documentReference.updateData(updatedDoctor.documentData) { (error) in
                if let error = error {
                    print("Could not update doctor: \(error)")
                    
                } else {
                    print("updated doctor success!")
                }
                
                self.dismiss(animated: true, completion: nil)
            }
            
        } else {
            // creates a  new  doctor on the server
            let newDoctor = Doctor(name: name, email: email, city: city, address: address, number: number, zipcode: zipcode, state: state)
            Firestore.firestore().collection("Doctor").addDocument(data: newDoctor.documentData) { (error) in
                if let error = error {
                    print("Could not update doctor: \(error)")
                    
                } else {
                    print("Added doctor a success!")
                }
                
                 self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
