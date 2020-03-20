//
//  Item.swift
//  Me and Mine
//
//  Created by Amaya Finklea on 3/20/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Item {

    var ref: DatabaseReference?
    var title: String?

    init (snapshot: DataSnapshot) {
        ref = snapshot.ref

        let data = snapshot.value as! Dictionary<String, String>
        title = data["title"]! as String
    }

}
