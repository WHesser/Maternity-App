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
    /* Edit Setting Display -- we want the user to be able to update their userprofile if needed and it will update in the Firebase cloud firestore */
 
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var firstName: UITextField!

    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    var userProfile: UserProfile?
    var documentReference: DocumentReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplayOfUser()
    }
    
    func updateDisplayOfUser(){
        guard let userProfile = userProfile else { return}
        username.text = userProfile.username
        firstName.text = userProfile.firstName
        lastName.text = userProfile.lastName
        email.text = userProfile.email
       
    }
    
    
    @IBAction func DoneButton2(_ sender: Any) {
        guard let username = username.text,
                let firstName = firstName.text,
                let lastName = lastName.text,
                let email = email.text else {return }
            
            
            if let userProfile = userProfile, let documentReference = documentReference{
                
                let updatedUser = UserProfile(username:username,
                                                email: email,
                                               firstName: firstName,
                                               lastName: lastName)
                
                documentReference.updateData(updatedUser.documentData) { (error) in
                    if let error = error {
                        print("Could not update user profile: \(error)")
                        
                    } else {
                        print("updated user profile success!")
                    }
                    
                    self.dismiss(animated: true, completion: nil)
                }
                
            } else {
                // creates a  new profile on the server
                let newUserProfile = UserProfile(username: username, email: email, firstName: firstName,
                                                 lastName: lastName)
                Firestore.firestore().collection("UserProfile").addDocument(data: newUserProfile.documentData) { (error) in
                    if let error = error {
                        print("Could not update user profile : \(error)")
                        
                    } else {
                        print("Added user profile a success!")
                    }
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            self.navigationController?.popViewController(animated: true)
        
    }
    
    
    /* Setting Display -- we want the user to be able to display their user profile once they have updated it */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchUserInfo()
        
    }
    func fetchUserInfo() {
        // Fetch the User Information and map to `UserProfile.swift`
        guard let currentUser = Auth.auth().currentUser?.uid
            else {
                print("Couldn't find user")
                return}
        print("Current User \(currentUser) ")
        let basicQuery = Firestore.firestore().collection("UserProfile").whereField("uid", isEqualTo: currentUser).limit(to:1)
        basicQuery.getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results \(error)")
                return
            }
            
            let models = snapshot.documents.map { (document)  -> UserProfile in
                
                let model = try! FirestoreDecoder().decode(UserProfile.self, from: document.data())
                return model
                
            }
            
            self.userProfile = models.first
            self.documentReference = snapshot.documents.first?.reference
            if let error = error {
                print("Oh no! Got an error! \(error.localizedDescription)")
                return
            }
            
            // make this thisis called on main thread
            DispatchQueue.main.async {
                self.updateDisplayOfUser()
            }
        }
    }
    
   
}





