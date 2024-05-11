//
//  SeatReservationDB.swift
//  SeatReservation
//
//  Created by student on 10/5/2024.
//

import Foundation
import SwiftData

@Model
class SeatReservationDB {
    var seat:String = ""
    var time:String = ""
    var name:String = ""
    var phone:String = ""
    var note:String = ""
    var status:String = "" //booked //cancel
    
    init(seat: String, time: String, name: String, phone: String, note: String, status: String) {
        self.seat = seat
        self.time = time
        self.name = name
        self.phone = phone
        self.note = note
        self.status = status
    }
    
  
}
