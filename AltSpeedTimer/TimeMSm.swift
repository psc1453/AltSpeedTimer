//
//  TimeMSm.swift
//  AltSpeedTimer
//
//  Created by 彭世辰 on 2020/6/14.
//  Copyright © 2020 Peng Shichen. All rights reserved.
//

import Foundation
import SwiftUI

class TimeMSm: ObservableObject {
    @Published var pureSeconds: Double = 60
    @Published var minutes: String = "01"
    @Published var seconds: String = "00"
    @Published var milliseconds: String = "00"
    
    init() {
        pureSeconds = 60.0
        minutes = String(format: "%02.0f", floor(pureSeconds / 60.0))
        seconds = String(format: "%02.0f", floor(pureSeconds - floor(pureSeconds / 60.0) * 60.0))
        milliseconds = String(format: "%02.0f", floor((pureSeconds - floor(pureSeconds)) * 60))
    }
    
    
}
