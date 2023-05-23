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
    var body: some View {
        
        
        
        //let currentMinute = Calendar.current.component(.minute, from: currentDate)
        
        
        VStack {
            
            Button(action: {
                // Request location permission again
                CLLocationManager().requestWhenInUseAuthorization()
            }) {
                Text("Request Location Permission")
            }
            .padding()
            
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
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
