//
//  Appointment.swift
//  Me and Mine
//
//  Created by Tiara Imani Logan on 4/12/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

struct Appointment: Codable {
    var appTitle: String
    var addLineOne: String
    var addLineTwo: String
    var addCity: String
    var addState: String
    var addZip: Int
    var uid: String
}
