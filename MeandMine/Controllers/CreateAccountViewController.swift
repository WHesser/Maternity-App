//
//  CreateAccountViewController.swift
//  Me and Mine
//
//  Created by Tiara Imani Logan on 2/17/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import UIKit
import Firebase


class CreateAccountViewController: UIViewController {
    //MARK: Properties
    @IBOutlet var CreateAccountLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    //Confirm password
    
    /*
     function -- make sure password and confirm password is the same
     func validatePassword() -> Bool {
     if password.text == confirmPassword.text {
     return true
     }
     else
     {
     put alert saying its false
     return false
     }
     return true
     }*/
    
    @IBAction func SignUpButton(_ sender: Any) {
        if email.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            //CREATE ACCOUNT
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                
                
                //create user profile
                //create a new user account
                
                
                /*Confirm Password -- make sure the password and confirm password matches */
                func validPassword(testStr:String?) -> Bool {
                    guard testStr != nil else { return false }
                    // at least one uppercase,
                    // at least one digit
                    // at least one lowercase
                    // 8 characters total
                    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
                    return passwordTest.evaluate(with: testStr)
                }
                
                /*After the program confirms it is the same password - it should successfully create the account    */
                if error == nil {
                    print("You have successfully signed up")
                    
                    
                    /*we want to connect the user uid from firebase to the user's first/last/username by using the changerequest function to do so -- by using the user profile properties  */
                    
                    self.dismiss(animated: true, completion: nil)
                    
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()}
    
    
    
}




