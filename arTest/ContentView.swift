//
//  ContentView.swift
//  arTest
//
//  Created by macbook1 on 2023/05/04.
//

import SwiftUI
import RealityKit
import CoreLocation
import CoreLocationUI

struct ContentView : View {
    @ObservedObject private var locationManager = LocationManager()
    var body: some View {
        let currentDate = Date()
        
        let currentYear = Calendar.current.component(.year, from: currentDate)
        let currentMonth = Calendar.current.component(.month, from: currentDate)
        let currentDay = Calendar.current.component(.day, from: currentDate)
        let currentHour = Calendar.current.component(.hour, from: currentDate)
        //let currentMinute = Calendar.current.component(.minute, from: currentDate)
        
        
        VStack {
            Text("Latitude: \(locationManager.userLatitude)")
                .font(.headline)
                .padding()
            
            Text("Current Year: \(currentYear)")
                .font(.headline)
                .padding()
            
            Text("Current Month: \(currentMonth)")
                .font(.headline)
                .padding()
            
            Text("Current Day: \(currentDay)")
                .font(.headline)
                .padding()
            
            Text("Current Hour: \(currentHour)")
                .font(.headline)
                .padding()
            
            Button(action: {
                // Request location permission again
                CLLocationManager().requestWhenInUseAuthorization()
            }) {
                Text("Request Location Permission")
            }
            .padding()
            
        }
    }
}



#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif


//if (CLLocationManager.headingAvailable()) {
//    Text("Available")
//    //ARViewContainer().edgesIgnoringSafeArea(.all)
//} else {
//    Text("Heading is not available.")
//    }
//}
