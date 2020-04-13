//
//  ResourcesViewController.swift
//  Me and Mine
//
//  Created by Tiara Imani Logan on 3/26/20.
//  Copyright © 2020 Logan. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit


struct ResourcesViewControllers : View {
    
    @State var nowDate: Date = Date()
    let referenceDate: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        Text(countDownString(from: referenceDate))
            .font(.largeTitle)
            .onAppear(perform: {
                _ = self.timer
            })
    }

    func countDownString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.day, .hour, .minute, .second],
                            from: nowDate,
                            to: referenceDate)
        return String(format: "%02dd:%02dh:%02dm:%02ds",
                      components.day ?? 00,
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
}
