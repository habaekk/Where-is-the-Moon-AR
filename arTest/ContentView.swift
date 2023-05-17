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
        
        VStack {
            Text("Latitude: \(locationManager.userLatitude)")
                .font(.headline)
                .padding()
            
            Button(action: {
                // Request location permission again
                CLLocationManager().requestWhenInUseAuthorization()
            }) {
                Text("Request Location Permission")
            }
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
