//
//  moonHelper.swift
//  arTest
//
//  Created by macbook1 on 2023/05/17.
//

import Foundation

class MoonHelper {
    let latitude: Float
    let time: DateComponents
    
    init(lat: Float, time: DateComponents) {
        self.latitude = lat
        self.time = time
    }
    
    func meridianAltitude() -> Int {
        return 1
    }
}
