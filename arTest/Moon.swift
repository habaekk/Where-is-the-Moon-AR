//
//  moonHelper.swift
//  arTest
//
//  Created by macbook1 on 2023/05/17.
//

import Foundation

class Moon {
    let latitude: Float
    let time: Float
    let lunDay: Int
    var seasonConstant: Float
    
    init(lat: Float, time: Float, lunDay: Int, seasonConst: Float) {
        self.latitude = lat
        self.time = time
        self.lunDay = lunDay
        self.seasonConstant = seasonConst
    }
}
