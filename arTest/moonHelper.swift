//
//  MoonHelper.swift
//  arTest
//
//  Created by macbook1 on 2023/05/19.
//

import Foundation

class MoonHelper {
    
    // 태양의 남중고도
    func getMeridianAltitude(lat: Float) -> Int {
        return Int(90 - lat)
    }
    
    // '각' 을 래디안 값으로 변환
    func getRadian(degree: Float) -> Float {
        return (degree * 0.0174533)
    }
    
    // 계절마다 남중고도가 변화함
    // 여름에 76.5도, 겨울에 29.5도, 봄가을에 53도
    // 계절 마다 변하는 남중고도를 위한 상수값
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
    
    // 달의 현재 위치 x, y, z
    // x 값에 따라 달의 궤도에 y, z 값을 구함
    // 현재 시간에 따라 x 값을 구함
    
    // 카메라 위치는 <0,0,0.5>
    // 카메라 방향은 -z 쪽을 바라 봄.
    
    // '달의 일주 궤도'를 포함하는 평면이 있고
    // 가상의 하늘(구) 인 천구가 있음
    // 평면과 천구상의 교선을 통해 '달의 일주 궤도(원)' 을 구함
    // 남중고도와 x 값이 주어지면, y z 를 구할 수 있음
    
    func getXPos(sunTime: Float, timeDifference: Double) -> Float {
        var moonTime = Double(sunTime) - timeDifference
        
        if moonTime < 0 {
            moonTime += 24
        }
        
        return -cos(getRadian(degree: Float((moonTime - 6) * 15)))
    }
    
    func getYPos(x: Float, s: Float, lat: Float) -> Float
    {
        let theta: Float = getRadian(degree: (90 - lat))
        var a: Float = 1.0
        var b: Float = 1.0
        var c: Float = 1.0
        
        a = pow(tan(theta), 2) + 1
        b = -2*s
        c = pow(x, 2) * pow(tan(theta), 2) + pow(s, 2) - pow(tan(theta), 2)

        let yPos = ((-b + (pow(b,2)-4*a*c).squareRoot()) / (2*a))
        
        return yPos
    }
    
    func getZPos(x: Float, s: Float, lat: Float) -> Float
    {
        let theta: Float = getRadian(degree: (90 - lat))
        var a: Float = 1.0
        var b: Float = 1.0
        var c: Float = 1.0
        
        a = pow(tan(theta), 2) + 1
        b = -2*s*tan(theta)
        c = pow(x, 2) + pow(s, 2) - 1

        let zPos = ((-b - (pow(b,2)-4*a*c).squareRoot()) / (2*a))
        
        return zPos
    }
    
    // 달의 위상에 따른 태양과의 상대적인 위치를 보정하기 위함
    func getTimeDifferenceSunMoon(lunDay: Int) -> Double {
        return (Double(lunDay) * (360/29.5)) * (1/15)
    }
    
    
    // 하늘에서 달이 안 보이면 AR월드 에서도 달을 띄우지 않기 위함
    func isMoonRise(sunTime: Float, timeDifference: Double) -> Bool {
        
        var moonTime = Double(sunTime) - timeDifference
        
        if moonTime < 0 {
            moonTime += 24
        }
        
        if (sunTime >= 18) || (sunTime <= 6) {
            if (moonTime >= 6) && (moonTime <= 18) {
                return true
            }
        }
        
        return false
    }
    
    // y 축을 기준으로 로테이션 수행
    // 디바이스가 바라보는 방향(동서남북) 에 따라 달의 위치를 보정하기 위함
    func rotation(x: Float, y: Float, z: Float, headingValue: Float) -> [Float] {
        let theta = headingValue - 180.0
        
        let rX = x * cos(getRadian(degree: theta)) + z * sin(getRadian(degree: theta))
        let rY = y
        let rZ = -x * sin(getRadian(degree: theta)) + z * cos(getRadian(degree: theta))
        
        return [rX, rY, rZ]
    }
    
    // 카메라 위치에 따른 좌표값 수정
    func cameraPosAdjust(x: Float, y: Float, z: Float) -> [Float] {
        let aX = x
        let aY = y
        let aZ = z + 0.5
        
        return [aX, aY, aZ]
    }
    
    // 시간을 십진수로 바꿈
    func timeToFloat(h: Int, m: Int) -> Float {
        let result = Float(h) + (Float(m) / 60.0)
        return result
    }
    
}
