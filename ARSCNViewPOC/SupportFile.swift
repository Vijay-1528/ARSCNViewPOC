//
//  SupportFile.swift
//  ARSCNViewPOC
//
//  Created by VIJAY M on 30/11/22.
//

import Foundation
import SceneKit

class SphereNode: SCNNode {

    lazy var sphereGeometry: SCNSphere = {
        let sphereGeometry = SCNSphere()
        sphereGeometry.firstMaterial?.diffuse.contents = UIColor.white
        sphereGeometry.firstMaterial?.emission.contents = UIColor.white
        sphereGeometry.firstMaterial?.isDoubleSided = true
        sphereGeometry.firstMaterial?.ambient.contents = UIColor.black
        sphereGeometry.firstMaterial?.lightingModel = .constant
        return sphereGeometry
    }()
    
    override init() {
        super.init()
        geometry = sphereGeometry
        sphereGeometry.radius = 0.015
        self.name = "first"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
