//
//  SOSPageViewController.swift
//  Me and Mine
//
//  Created by Amaya Finklea on 2/19/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

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
    
    var doctor: Doctor? // 
    var documentReference: DocumentReference? // oFireStore Reference used to fetch latest values/used to store updates. SeeMore: https://firebase.google.com/docs/reference/js/firebase.firestore.DocumentReference
    
    
    @IBAction func EditButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDocInfo()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDocInfo()
        
    }
    
    func fetchDocInfo() {
        
        // Fetch the Doctor Information and map to `Doctor.swift`
        guard let currentUser = Auth.auth().currentUser?.uid
            else {
                print("Couldn't find user")
                return
        }
        
        let basicQuery = Firestore.firestore().collection("Doctor").whereField("uid", isEqualTo: currentUser).limit(to:1)
        basicQuery.getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results \(error)")
                return
            }
            
            let models = snapshot.documents.map { (document)  -> Doctor in
                
                let model = try! FirestoreDecoder().decode(Doctor.self, from: document.data())
                return model
            }
            
            self.doctor = models.first
            self.documentReference = snapshot.documents.first?.reference
            if let error = error {
                print("Oh no! Got an error! \(error.localizedDescription)")
                return
            }
            
            // make this thisis called on main thread
            DispatchQueue.main.async {
                self.updateDisplayWithDoctor()
            }
        }
    }
    
    // 1.
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
    
    
    // 2. In your prepare segue, pass the self.doctor to your destination controller (EditSOSViewCOntroller)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editSOSViewController = segue.destination as? EditSOSViewController else {
            return}
        
        
        if  segue.identifier == "editSOSDetailSegue" {
            editSOSViewController.doctor = self.doctor
            editSOSViewController.documentReference = self.documentReference
        }
    }
    
    
} //END OF CLASS
