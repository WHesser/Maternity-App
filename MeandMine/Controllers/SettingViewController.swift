//
//  SettingViewController.swift
//  Me and Mine
//
//  Created by Amaya Finklea on 4/12/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class SettingViewController: UIViewController {

    
    
    
    @IBAction func DoneButton(_ sender: Any) {
    }
    
    var userProfile: UserProfile?
      var documentReference: DocumentReference? // oFireStore Reference used to fetch latest values/used to store updates.
    override func viewDidLoad() {
        super.viewDidLoad()
fetchUserInfo()
      
    }
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        fetchUserInfo()
    }
    
    func fetchUserInfo() {
           
           // Fetch the Doctor Information and map to `Doctor.swift`
           guard let currentUser = Auth.auth().currentUser?.uid
               else {
                   print("Couldn't find user")
                   return
           }
        let basicQuery = Firestore.firestore().collection("UserProfile").whereField("uid", isEqualTo: currentUser).limit(to:1)
        basicQuery.getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results \(error)")
                return
            }
            
            let models = snapshot.documents.map { (document)  -> UserProfile in
                
                let model = try! FirestoreDecoder().decode(UserProfile.self, from: document.data())
                return model
                
                /*   if let model = Doctor(dictionary: document.data()) {
                 return model
                 } else {
                 fatalError("Unable to initialize type \(Doctor.self) with dictionary \(document.data()) error: \(error?.localizedDescription)")
                 }*/
            }
            
            self.userProfile = models.first
            self.documentReference = snapshot.documents.first?.reference
            if let error = error {
                print("Oh no! Got an error! \(error.localizedDescription)")
                return
            }
            // make this thisis called on main thread
                       DispatchQueue.main.async {
                           self.updateDisplayOfUserProfile()
                       }
                   }
               }
               
        
        
   func updateDisplayOfUserProfile()  {
           guard let userProfile = userProfile else {return}
           // all text fields
           
       }
     
     // 2. In your prepare segue, pass the self.doctor to your destination controller (EditSOSViewCOntroller)
       
     /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let editSOSViewController = segue.destination as? EditSOSViewController else {
               return}
           
           
           if  segue.identifier == "editSOSDetailSegue" {
               editSOSViewController.doctor = self.doctor
               editSOSViewController.documentReference = self.documentReference
           }
       }
     */

    
    

}

