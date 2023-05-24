//
//  ARView.swift
//  arTest
//
//  Created by macbook1 on 2023/05/17.
//

import SwiftUI
import RealityKit
//import ARKit

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject private var locationManager = LocationManager()

        
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()

        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        boxAnchor.actions.notifier.onAction = sceneStart
        
//        let moonAnchor = try! Experience.loadMoon()
//        arView.scene.anchors.append(moonAnchor)
        
        return arView
        
    }
    
    func sceneStart(_ entity: Entity?) -> Void {
        
        let moonHelper = MoonHelper()
//        print("Scene Start")
        UrlManager().urlRequest(with: UrlManager().urlManager()) { lunDay in
            
            let currentDate = Date()
            let timediff = moonHelper.getTimeDifferenceSunMoon(lunDay: lunDay)
//            let timediff = moonHelper.getTimeDifferenceSunMoon(lunDay:22)
            let currentLatitude = Float(locationManager.userLatitude)
//            let currentLatitude = Float(37.0)
            let currentHeading = Float(locationManager.userHeading)
            
            let currentMonth = Calendar.current.component(.month, from: currentDate)
            let currentHour = Calendar.current.component(.hour, from: currentDate)
//            let currentHour = 6
            let currentMinute = Calendar.current.component(.minute, from: currentDate)
//            let currentMinute = 0
            let currentTimeFloat = moonHelper.timeToFloat(h: currentHour, m: currentMinute)
            
            let seasonConstant = moonHelper.getSeasonConstant(month: currentMonth)
            
            
            if (moonHelper.isMoonRise(sunTime: currentTimeFloat, timeDifference: timediff)) {
            
//            if (true) {
                
                let x = moonHelper.getXPos(sunTime: currentTimeFloat, timeDifference: timediff)
                let y = moonHelper.getYPos(x: x, s: seasonConstant, lat: currentLatitude)
                let z = moonHelper.getZPos(x: x, s: seasonConstant, lat: currentLatitude)
                
                let rotated = moonHelper.rotation(x: x , y: y, z: z, headingValue: currentHeading)
                let adjusted = moonHelper.cameraPosAdjust(x: rotated[0], y: rotated[1], z: rotated[2])
                
                entity?.transform.translation.x = adjusted[0]
                entity?.transform.translation.y = adjusted[1]
                entity?.transform.translation.z = adjusted[2]
            }
        }
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
