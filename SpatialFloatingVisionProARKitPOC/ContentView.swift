//
//  ContentView.swift
//  SpatialFloatingVisionProARKitPOC
//
//  Created by Elliot Knight on 07/04/2024.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    var body: some View {
        RealityKitView()
    }
}

#Preview {
    ContentView()
}

// MARK: - RealityKitView

struct RealityKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let view = ARView()
        view.scene.anchors.removeAll()

        // Start AR session
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)

        // Setup entities
        let anchorEntity = AnchorEntity()
        let modelEntity = try! ModelEntity.load(named: "apple_vision_pro" + ".usdz")

        anchorEntity.addChild(modelEntity)
        anchorEntity.position = [0, -0.2, -0.5]

        view.scene.addAnchor(anchorEntity)

        #if DEBUG
        view.debugOptions = [.showFeaturePoints,
                             .showAnchorOrigins,
                             .showAnchorGeometry]
        #endif
        return view
    }

    func updateUIView(_ view: ARView, context: Context) {

    }
}
