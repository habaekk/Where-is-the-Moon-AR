//
//  urlManager.swift
//  arTest
//
//  Created by macbook1 on 2023/05/23.
//

import Foundation

class urlManager {
    func urlRequest(with str: String, completion:@escaping(Int) -> ()){
        let url = URL(string: str)!
        var req = ""
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let err = error {
                print (err)
                return
            }
            guard let data = data else { return }
            req = String(data: data, encoding: .utf8)!
            completion(self.dataParsing(with: req))
        }
        task.resume()
    }
    
    func urlManager() -> String {
        let key = K.api.key
        let api = "https://apis.data.go.kr/B090041/openapi/service/LrsrCldInfoService/getLunCalInfo?"
        let date = Date()
        
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        
        let d = calendarDate.day!
        let m = calendarDate.month!
        let year = String(calendarDate.year!)
        
        var day: String
        var month: String
        
        if d < 10 {
            day = "0" + String(d)
        } else {
            day = String(d)
        }
        
        if m < 10 {
            month = "0" + String(m)
        } else {
            month = String(m)
        }
        
        let url = "\(api)solYear=\(year)&solMonth=\(month)&solDay=\(day)&ServiceKey=\(key)"
        return url
    }
    
    func dataParsing(with str: String) -> Int {
        
        if let range: Range<String.Index> = str.range(of: "lunDay") {
            let index: Int = str.distance(from: str.startIndex, to: range.lowerBound)
            var lunDay: Int
            var idx = str.index(str.startIndex, offsetBy:index+8)
            if str[idx] == "<" {
                idx = str.index(str.startIndex, offsetBy:index+7)
                lunDay = Int(String(str[idx]))!
            } else {
                idx = str.index(str.startIndex, offsetBy:index+7)
                let ten = Int(String(str[idx]))! * 10
                idx = str.index(str.startIndex, offsetBy:index+8)
                let one = Int(String(str[idx]))!
                lunDay = ten + one
            }
            return lunDay
        }
        else {
            print("substring not found")
            return 0
        }
    }
}
