//
//  MoonHelper.swift
//  arTest
//
//  Created by macbook1 on 2023/05/19.
//

import Foundation

class MoonHelper {
    func getMeridianAltitude(lat: Float) -> Int {
        return Int(90 - lat)
    }
    
    func getRadian(degree: Float) -> Float {
        return (degree * 0.0174533)
    }
    
    func getSeasonConstant(month: Int) -> Float {
        
        var const: Float = 0.0
        // precisly: 0.6625774592
        
        switch month {
        case 12:
            fallthrough
        case 1...2:
            const = -0.6625
        case 3...5:
            const = 0
        case 6...8:
            const = 0.6625
        case 9...11:
            const = 0
        default:
            print("MoonHelper.swift :: default of season constant.")
        }
        
        return const
    }
    
    func getYPos(x: Float, s: Float, r: Float, lat: Float) -> Float
    {
        let theta: Float = getRadian(degree: (90 - lat))
        var a: Float = 1.0
        var b: Float = 1.0
        var c: Float = 1.0
        
        a = 1
        b = 2*s*pow(cos(theta),2)
        c = pow(x,2)*pow(sin(theta),2) + pow(s,2)*pow(cos(theta),2) - pow(sin(theta),2)
        let yPos = ((-b + (pow(b,2)-4*a*c).squareRoot()) / (2*a))
        
        return yPos
    }
    
    func getZPos(x: Float, s: Float, r: Float, lat: Float) -> Float
    {
        let theta: Float = getRadian(degree: (90 - lat))
        var a: Float = 1.0
        var b: Float = 1.0
        var c: Float = 1.0
        
        a = 1
        b = 2*s*sin(theta)*cos(theta)
        c = pow(cos(theta),2)*(pow(s,2)+pow(x,2)-1)
        let zPos = ((-b + (pow(b,2)-4*a*c).squareRoot()) / 2*a)
        
        return zPos
    }
    
    func moonPhase(when day: Int) -> String {
        if day > 0 && day < 4 {
            return "newMoon"
        } else if day >= 4 && day < 6 {
            return "newMoon2"
        } else if day >= 6 && day < 9 {
            return "firstQuarter"
        } else if day >= 9 && day < 14 {
            return "firstQuarter2"
        } else if day >= 14 && day < 16 {
            return "fullMoon"
        } else if day == 16 {
            return "fullMoon2"
        } else if day == 17 {
            return "fullMoon3"
        } else if day == 18 {
            return "fullMoon4"
        } else if day == 19 {
            return "fullMoon5"
        } else if day == 20 {
            return "fullMoon6"
        } else if day >= 21 && day < 23 {
            return "lastQuarter"
        } else if day >= 23 && day < 26 {
            return "lastQuarter2"
        } else if day >= 26 && day < 30 {
            return "lastQuarter3"
        } else {
            return "testMoon"
        }
    }
}
