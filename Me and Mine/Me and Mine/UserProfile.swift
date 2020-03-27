//
//  Item.swift
//  Me and Mine
//
//  Created by Amaya Finklea on 3/20/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import Foundation


class UserProfile {

    var uid: String
    var username: String
    var firstName: String
    var lastName:String
    
    init(uid:String, username:String,firstName: String, lastName:String){
        self.uid = uid
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
    }

}
