//
//  ARView.swift
//  arTest
//
//  Created by macbook1 on 2023/05/17.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    
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
        print("Scene Start")
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
