//
//  ViewController.swift
//  ARKit_WorldTracking
//
//  Created by IJke Botman on 25/01/2018.
//  Copyright © 2018 IJke Botman. All rights reserved.
//

import UIKit
import ARKit


class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    @IBOutlet var nodeShapeButtons: [UIButton]!
    
    let node = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.session.run(configuration)
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.autoenablesDefaultLighting = true
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: Any) {
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.position = SCNVector3(0, 0, -0.3)
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    @IBAction func nodeShapeButtonPress(_ sender: UIButton) {
        for button in nodeShapeButtons {
            button.backgroundColor = UIColor.lightGray
        }
        
        sender.backgroundColor = UIColor.white
        
        if sender.tag == 100 {
            node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        } else if sender.tag == 200 {
            node.geometry = SCNSphere(radius: 0.1)
        } else if sender.tag == 300 {
            node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        } else if sender.tag == 400 {
            node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.2, height: 0.2)
        } else if sender.tag == 500 {
            node.geometry = SCNCylinder(radius: 0.1, height: 0.2)
        } else if sender.tag == 600 {
            node.geometry = SCNTube(innerRadius: 0.06, outerRadius: 0.1, height: 0.3)
        } else if sender.tag == 700 {
            node.geometry = SCNTorus(ringRadius: 0.1, pipeRadius: 0.02)
        } else if sender.tag == 800 {
            node.geometry = SCNPlane(width: 0.2, height: 0.2)
        } else if sender.tag == 900 {
            node.geometry = SCNPyramid(width: 0.1, height: 0.2, length: 0.1)
        } else if sender.tag == 1000 {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0.2))
            path.addLine(to: CGPoint(x: 0.1, y: 0.3))
            path.addLine(to: CGPoint(x: 0.2, y: 0.2))
            path.addLine(to: CGPoint(x: 0.2, y: 0.0))
            let shape = SCNShape(path: path, extrusionDepth: 0.2)
            node.geometry = shape
        }
        
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
            node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        }
    }
    
    
    
}

