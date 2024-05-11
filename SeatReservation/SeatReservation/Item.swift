//
//  Item.swift
//  SeatReservation
//
//  Created by l on 2024/5/11.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
