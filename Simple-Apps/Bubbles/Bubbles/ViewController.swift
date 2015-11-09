//
//  ViewController.swift
//  Bubbles
//
//  Created by Jo Albright on 11/9/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

import AVFoundation

class ViewController: UIViewController, AVCaptureAudioDataOutputSampleBufferDelegate {

    var session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
    
        let captureInput = try? AVCaptureDeviceInput(device: captureDevice!)
        
        if session.canAddInput(captureInput) {
            
            session.addInput(captureInput)
            
        }
        
        let captureOutput = AVCaptureAudioDataOutput()
        
        if session.canAddOutput(captureOutput) {
            
            session.addOutput(captureOutput)
            
        }
        
        captureOutput.setSampleBufferDelegate(self, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))

//        captureOutput.setSampleBufferDelegate(self, queue: dispatch_get_main_queue())
        
        session.startRunning()
    
    }

    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        guard let channel = connection.audioChannels.first where channel.averagePowerLevel > -5 else { return print("Not Blowing") }
        
        print("Blowing")
        
        // randomize width & height
        let bubble = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 50, height: 50)))
        
        // change based on width / height
        bubble.layer.cornerRadius = 25
        
        // randomize color between blue and purple
        bubble.layer.borderColor = UIColor.cyanColor().CGColor
        bubble.layer.borderWidth = 1
        bubble.center = CGPoint(x: view.frame.midX, y: view.frame.maxY)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.view.addSubview(bubble)
            
            // change based on the APL
            let randomDuration = 2.0
            
            UIView.animateWithDuration(randomDuration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                
                // randomize the bubble.center x & y
                bubble.center.y = self.view.center.y
                
            }) { (finished) -> Void in
                
                bubble.removeFromSuperview()
                // play pop sound
                    
            }
            
        }
        
        
    }

}

