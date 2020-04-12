//
//  UserProfile.swift
//  Me and Mine
//
//  Created by Amaya Finklea on 4/12/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase


struct UserProfile: Codable {
    var useremail: String
    var phone: Int
    var username: String
    var password: String
    
    init(useremail: String,
         phone:Int,
         username: String,
         password: String) {
        self.useremail = useremail
        self.phone = phone
        self.username = username
        self.password = password
}
 var documentData: [String: Any] {
        
        var uid = ""
        if let currentUser = Auth.auth().currentUser?.uid {
            uid = currentUser
        }
            
        return [
            "useremail":useremail,
            "phone": phone,
            "username": username,
            "password": password,
            "uid": uid,
        ]
    }
}
