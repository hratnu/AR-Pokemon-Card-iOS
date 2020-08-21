//
//  ViewController.swift
//  PokeCard 3D
//
//  Created by Harshil Ratnu on 8/6/20.
//  Copyright © 2020 Harshil Ratnu. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 2
            
            print("Images successfully added")
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        guard let imageAnchor = anchor as? ARImageAnchor else {return nil }
        
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width , height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.8)
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi/2
        
        node.addChildNode(planeNode)
       
        if (imageAnchor.referenceImage.name == "eevee" ){
            if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn"){
                let pokeNode = pokeScene.rootNode.childNodes.first!
                pokeNode.eulerAngles.x = .pi/3
                planeNode.addChildNode(pokeNode)
            }
        }
        
        if (imageAnchor.referenceImage.name == "oddish" ){
             if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn"){
                let pokeNode = pokeScene.rootNode.childNodes.first!
                pokeNode.eulerAngles.x = .pi/3
                planeNode.addChildNode(pokeNode)
            }
       
        }

        
        
        
        
        return node
    }
    
}
