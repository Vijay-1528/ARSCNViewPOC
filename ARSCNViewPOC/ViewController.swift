//
//  ViewController.swift
//  ARSCNViewPOC
//
//  Created by VIJAY M on 30/11/22.
//

import UIKit
import ARKit
import RealityKit
import SpriteKit

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
        
        let plane = SCNPlane(width: 0.5, height: 0.5)
        let planeImage = self.getCustomView(Position: CGPoint(x: 0.0, y: 0.0)).image
        let imageRatio = planeImage.size.height / planeImage.size.width
        debugPrint("imageRatio: \(imageRatio)")
        let desiredPlaneWidth: CGFloat = 1
//            let plane = SCNPlane(width: desiredPlaneWidth, height: desiredPlaneWidth * imageRatio)
        let planeNode = SCNNode(geometry: plane)
//            plane.firstMaterial?.diffuse.contents = planeImage
//            planeNode.position = SCNVector3(x: 0.32373372, y: 1.0945587, z: -10.8759274)
        planeNode.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        self.sceneView.scene.rootNode.addChildNode(planeNode)
        
        let node = self.sceneView.scene.rootNode.childNode(withName: "first", recursively: true)
        if let position = node?.position {
            print(position)
            
            let points = self.sceneView.projectPoint(position)
            print(points.x)
            print(points.y)
            print(points.z)
            let scnView = SCNView(frame: CGRect(x: 40, y: 40, width: 50, height: 50))
            scnView.backgroundColor = .red
            print(scnView)
            
            let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
            cubeNode.position = SCNVector3(x: 0.32373372, y: 0.0945587, z: -0.8759274) // SceneKit/AR coordinates are in meters
            self.sceneView.scene.rootNode.addChildNode(cubeNode)
            
//            let plane = SCNPlane(width: 0.2, height: 0.2)
//            let planeImage = self.getCustomView(Position: CGPoint(x: CGFloat(points.x), y: CGFloat(points.y))).image
//            plane.firstMaterial?.diffuse.contents = planeImage
//            //            plane.firstMaterial?.diffuse.contents = image
//            let planeNode = SCNNode(geometry: plane)
//            plane.heightSegmentCount = 10
//            planeNode.physicsBody = .static()
//            //            planeNode.position = SCNVector3(x: 0.32373372, y: 2.0945587, z: -0.8759274)
//            planeNode.position = SCNVector3(x: 0.32373372, y: 0.0945587, z: -0.8759274)
////            planeNode.position = SCNVector3(x: 0.32373372, y: 1.0945587, z: -10.8759274)
//            sceneView.scene.rootNode.addChildNode(planeNode)
            
//            let nodeHeight = planeImage.size
//            let sk = SKScene(size: CGSize(width: 400, height: 100))
//            sk.backgroundColor = UIColor.clear
//
//            let button = ButtonNode(text: "  " + title + "  ")
//            button.name = "button"
//            button.setBackgroundColor(.white)
//            button.setClickedTarget(self, action: #selector(tapped))
//
//            sk.addChild(button)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+5.0) {
//                for item in self.sceneView.scene.rootNode.childNodes {
//                    item.position = SCNVector3(x: 0.32373372, y: 2.0945587, z: -0.8759274)
//                    item.removeFromParentNode()
//                    self.sceneView.scene.rootNode.addChildNode(item)
//                }
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        if let touchLocation = touches.first?.location(in: self.sceneView), let hit = sceneView.hitTest(touchLocation, types: .featurePoint).first {
        //            let anchor = ARAnchor(transform: hit.worldTransform)
        //            let node = sceneView.node(for: anchor)
        //            node?.removeFromParent()
        //        }
//        if let touchLocation = touches.first?.location(in: self.sceneView), let node = nodes(at: touchLocation).first {
//            node.removeFromParent()
//        }
    }
    
    func getCustomView(Position: CGPoint) -> UIView {
        
        let textLbl = UILabel()
        textLbl.frame = CGRect(x: 10, y: 10, width: 200, height: 100)
        textLbl.text = "poiuytredfghjk"
        textLbl.font = UIFont(name: UILabel().font.fontName, size: 25.0)
        
        let popupView = UIView()
        popupView.frame = CGRect(x: Position.x-250, y: Position.y-150, width: 500, height: 500)
        popupView.backgroundColor = UIColor(red: 119.0/255, green: 204.0/255, blue: 255.0/255.0, alpha: 1.0)
        popupView.layer.cornerRadius = 20
        popupView.layer.masksToBounds = true
        popupView.tag = 121
        
        let topLbl = UILabel()
        topLbl.frame = CGRect(x: 0, y: 0, width: popupView.frame.size.width, height: 50)
        topLbl.text = "New Popups"
        topLbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        topLbl.textAlignment = .center
        topLbl.textColor = .white
        popupView.addSubview(topLbl)
        
        let imgView = UIImageView()
        imgView.frame = CGRect(x: 0, y: 50, width: popupView.frame.size.width, height: 350)
        imgView.image = UIImage(named: "tinder")
        imgView.backgroundColor = .white
        popupView.addSubview(imgView)
        
        let ratingLbl = UILabel()
        ratingLbl.text = "Rating: 4.0"
        ratingLbl.frame = CGRect(x: 0, y: 400, width: popupView.frame.size.width, height: 100)
        ratingLbl.textColor = .white
        ratingLbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        popupView.addSubview(ratingLbl)
        
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
    
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        guard let imageAnchor = anchor as? ARImageAnchor else { return }
//        let referenceImage = imageAnchor.referenceImage
//        DispatchQueue.main.async {
//
//            let plane = SCNPlane(width: referenceImage.physicalSize.width,
//                                 height: referenceImage.physicalSize.height)
//            let planeNode = SCNNode(geometry: plane)
//            planeNode.opacity = 0.25
//
//            /*
//             `SCNPlane` is vertically oriented in its local coordinate space, but
//             `ARImageAnchor` assumes the image is horizontal in its local space, so
//             rotate the plane to match.
//             */
//            planeNode.eulerAngles.x = -.pi / 2
//
//            /*
//             Image anchors are not tracked after initial detection, so create an
//             animation that limits the duration for which the plane visualization appears.
//             */
//            node.addChildNode(planeNode)
//        }
//        DispatchQueue.main.async {
//            let imageName = referenceImage.name ?? ""
//        }
//    }
    
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
