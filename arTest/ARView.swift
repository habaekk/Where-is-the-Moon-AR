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
        
        boxAnchor.actions.notifier.onAction = printer
        
//        let moonAnchor = try! Experience.loadMoon()
//        arView.scene.anchors.append(moonAnchor)
        
        return arView
        
    }
    
    func printer(_ entity: Entity?) -> Void {
        let currentLatitude = Int(locationManager.userLatitude)
        let currentHeading = Float(locationManager.userHeading)
        
//        print(currentHeading)
//        entity?.transform.translation.x = sin(MoonHelper().getRadian(degree: (180-currentHeading)))
//        entity?.transform.translation.y = 0
//        entity?.transform.translation.z = -cos(MoonHelper().getRadian(degree: (180-currentHeading)))
        print("Scene Start")
    }
    
//    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        // Do something with the new transform
//        let currentTransform = frame.camera.transform
//        print(currentTransform)
//    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
