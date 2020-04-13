//
//  DueDateViewController.swift
//  Me and Mine
//
//  Created by Tiara Imani Logan on 4/9/20.
//  Copyright © 2020 Logan. All rights reserved.
//


import Foundation
import UIKit
import SwiftUI

class DueDateViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var datePicker: UIDatePicker!
 
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countDown: UILabel!
    
    @IBAction func dueDatePicker(_ sender: UIDatePicker) {
  
      let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: sender.date)
        dateLabel.text = strDate
        driveReminder(strDate: datePicker.date)

    }
    
    
    func setInitialDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        dateLabel.text = strDate
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialDate()
        
    }
    
    
    func calculateCountdown(today: Date, birthday: Date) -> Int {
    let calendarDifference = Calendar.current.dateComponents([.day, .hour], from: today, to: birthday)
    if let daysRemaining = calendarDifference.day {
        if let hoursRemaining = calendarDifference.hour {
            if (daysRemaining == 0 && hoursRemaining == 0) {
                alert()
                return daysRemaining
            }
            else if (daysRemaining < 0 ) {
                return -100 // sentinel value
            }
            else {
                return daysRemaining + 1
            }
        } else { return daysRemaining }
    } else {
        return -1
    }
}

func alert() {
 
}



func updateCountdown(daysLeft: Int)
{
   countDownLabel.text = "\(daysLeft) Days Until Left"
}

func resetLabels() {
 
}

    func driveReminder(strDate: Date) {
    let dateChosen = datePicker.date
        print(dateChosen)
    let currentDate = Date()
        print(currentDate)
    resetLabels()

            let days = calculateCountdown(today: currentDate, birthday: dateChosen)
        print(days)
            if (days < 0) {
              
            }
            else {
                updateCountdown(daysLeft: days)
            }

    }
}



    
    
    
    
    
    
    
    
    
    
