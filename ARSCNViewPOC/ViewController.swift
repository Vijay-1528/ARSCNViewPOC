//
//  ViewController.swift
//  ARSCNViewPOC
//
//  Created by VIJAY M on 30/11/22.
//

import UIKit
import ARKit
import RealityKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var dotNode = SphereNode()
    
    let templateView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dotNode = SphereNode.init()
        
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        if #available(iOS 12.0, *) {
            configuration.environmentTexturing = .automatic
        }
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchPosition = SCNVector3(x: 0.32373372, y: 1.0945587, z: -10.8759274)
//        dotNode.geometry?.firstMaterial?.diffuse.contents = getCustomView().layer
//        dotNode.sphereGeometry.firstMaterial?.diffuse.contents = getCustomView().layer
        print("\(searchPosition)")
        dotNode.position = searchPosition
//        if let node = dotNode {
            sceneView.scene.rootNode.addChildNode(dotNode)
//        }
        
        let node = self.sceneView.scene.rootNode.childNode(withName: "first", recursively: true)
        if let position = node?.position {
            print(position)
            
            let points = self.sceneView.projectPoint(position)
            print(points.x)
            print(points.y)
            print(points.z)
            let scnView = SCNView(frame: CGRect(x: 40, y: 40, width: 50, height: 50))
            scnView.backgroundColor = .red
//            scnView.addSubview(getCustomView(Position: CGPoint(x: CGFloat(points.x), y: CGFloat(points.y))))
            print(scnView)
            
            let text = "Hello, Stack Overflow."
//            let font = UIFont(name: UILabel().font.fontName, size: 20.0)
//            let font = UIFont(name: UILabel().font.fontName, size: 20.0)
//            let width = 128.0
//            let height = 128.0
//
//            let fontAttrs: [NSAttributedString.Key: Any] =
//            [NSAttributedString.Key.font: font!]
//
//            let stringSize = text.size(withAttributes: fontAttrs)
//            let rect = CGRect(x: CGFloat((width / 2.0) - (stringSize.width/2.0)), y: CGFloat((height / 2.0) - (stringSize.height/2.0)), width: CGFloat(stringSize.width), height: CGFloat(stringSize.height))
//
//
//            let renderer = UIGraphicsImageRenderer(size: CGSize(width: CGFloat(width), height: CGFloat(height)))
//            let image = renderer.image { context in
//
//                let color = UIColor.blue.withAlphaComponent(CGFloat(0.5))
//
//                color.setFill()
//                context.fill(rect)
//
//                text.draw(with: rect, options: .usesLineFragmentOrigin, attributes: fontAttrs, context: nil)
//            }
            
            let plane = SCNPlane(width: 0.1, height: 0.1)
            plane.firstMaterial?.diffuse.contents = self.getCustomView(Position: CGPoint(x: CGFloat(points.x), y: CGFloat(points.y))).image
//            plane.firstMaterial?.diffuse.contents = image
            let planeNode = SCNNode(geometry: plane)
//            planeNode.position = SCNVector3(x: 0.32373372, y: 2.0945587, z: -0.8759274)
//            planeNode.position = SCNVector3(x: 0.32373372, y: 0.0945587, z: -0.8759274)
            planeNode.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
            sceneView.scene.rootNode.addChildNode(planeNode)
            
        }
    }
    
    func getCustomView(Position: CGPoint) -> UIView {
        
        let textLbl = UILabel()
        textLbl.frame = CGRect(x: 10, y: 10, width: 200, height: 100)
        textLbl.text = "poiuytredfghjk"
        textLbl.font = UIFont(name: UILabel().font.fontName, size: 25.0)
        
        let popupView = UIView()
        popupView.frame = CGRect(x: Position.x-250, y: Position.y-150, width: 500, height: 500)
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 15
        popupView.layer.masksToBounds = true
        popupView.tag = 121
        popupView.addSubview(textLbl)
        
        return popupView
    }
    
}

extension ViewController: ARSCNViewDelegate, ARSessionDelegate {
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("sessions : \(session)")
        print("error : \(error)")
        if error.localizedDescription == "Required sensor failed." {
            restartSessionWithoutDelete()
        }
    }
    
    @objc func restartSessionWithoutDelete() {
    self.sceneView.session.pause()
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravity
        configuration.planeDetection = [.horizontal, .vertical]
        if #available(iOS 12.0, *) {
            configuration.environmentTexturing = .automatic
        }
    self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
}

public extension UIView {
 @available(iOS 10.0, *)
 var image: UIImage {
     let width = 500.0
     let height = 500.0
//     let rect = CGRect(x: CGFloat((width-100)/2.0), y: CGFloat((height-50)/2.0), width: width, height: height)
     let renderer = UIGraphicsImageRenderer(size: CGSize(width: CGFloat(width), height: CGFloat(height)))
    return renderer.image { rendererContext in
        layer.render(in: rendererContext.cgContext)
    }
  }
}
