//
//  ViewController.swift
//  Level
//
//  Created by Jo Albright on 6/29/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import CoreMotion
import SpriteKit

class MotionViewController: UIViewController {
    
    let manager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let motionScene = MotionScene()
        let sceneView = SKView(frame: view.frame)
        view.addSubview(sceneView)
        
        sceneView.presentScene(motionScene)
        
        manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { (deviceMotion, error) -> Void in
            
            let quat = deviceMotion.attitude.quaternion
            let myRoll = RadiansToDegrees(atan2(2*(quat.y*quat.w - quat.x*quat.z), 1 - 2*quat.y*quat.y - 2*quat.z*quat.z))
            let myPitch = RadiansToDegrees(atan2(2*(quat.x*quat.w + quat.y*quat.z), 1 - 2*quat.x*quat.x - 2*quat.z*quat.z))
            let myYaw = RadiansToDegrees(asin(2*quat.x*quat.y + 2*quat.w*quat.z))
            
            
            println("\(RadiansToDegrees(deviceMotion.attitude.yaw)) \(myYaw)")
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                motionScene.physicsWorld.gravity = CGVector(dx: -myYaw, dy: -8.0)
                
                println("x : \(motionScene.physicsWorld.gravity.dx) y : \(motionScene.physicsWorld.gravity.dy)")
                
            })
            
            
        })
        
        
//        manager.startMagnetometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (magnetometerMotion, error) -> Void in
//            
//            println(magnetometerMotion)
//            
//        })
        
//        manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) { (deviceMotion, error) -> Void in
//            
////            println("rotation x : \(deviceMotion!.rotationRate.x)")
////            println("rotation y : \(deviceMotion!.rotationRate.y)")
////            println("rotation z : \(deviceMotion!.rotationRate.z)")
//            
//            motionScene.physicsWorld.gravity = CGVector(dx: -deviceMotion.rotationRate.y * 10, dy: deviceMotion.rotationRate.x * 10)
//            
//        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

func RadiansToDegrees (value:Double) -> Double {
    return value * 180.0 / M_PI
}

