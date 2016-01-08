//
//  ViewController.swift
//  Bubbles
//
//  Created by Jo Albright on 3/17/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureAudioDataOutputSampleBufferDelegate {

    var audioSession = AVAudioSession()
    var audioDataOutput = AVCaptureAudioDataOutput()
    var audioCaptureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioSession.setCategory(AVAudioSessionCategoryRecord, error: nil)
        audioSession.setMode(AVAudioSessionModeMeasurement, error: nil)
        audioSession.setActive(true, error: nil)
        audioSession.setPreferredSampleRate(48000, error: nil)
        
        var myDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        
        var audioCaptureInput = AVCaptureDeviceInput(device: myDevice, error: nil)
        
        audioCaptureSession.addInput(audioCaptureInput)
        
        audioDataOutput.setSampleBufferDelegate(self, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
        
        audioCaptureSession.addOutput(audioDataOutput)
        
        audioCaptureSession.startRunning()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(powerCircle)
        powerCircle.backgroundColor = UIColor.cyanColor()
    }
    
    var powerCircle = UIView()
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        for channel in connection.audioChannels as [AVCaptureAudioChannel] {
            
            let pLevel = CGFloat((channel.averagePowerLevel + 50) * 2)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                if channel.averagePowerLevel > -10 {
                    
                    // blow bubble
                    
                    var bubble = UIView(frame: CGRectMake(0, 0, 50, 50))
                    bubble.backgroundColor = UIColor.magentaColor()
                    bubble.layer.cornerRadius = 25
                    bubble.alpha = 0.2
                    
                    bubble.center = CGPointMake(self.view.center.x, self.view.frame.height)
                    
                    self.view.addSubview(bubble)
                    
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        
                        let x = arc4random_uniform(UInt32(self.view.frame.width))
                        let y = self.view.frame.height - pLevel * 10
                        
                        bubble.center = CGPointMake(CGFloat(x), y)
                        
                    }, completion: { (success) -> Void in
                        
                        bubble.removeFromSuperview()
                        
                    })
                    
                    
                }
                
                
//                self.powerCircle.frame = CGRectMake(0, 0, pLevel, pLevel)
//                self.powerCircle.layer.cornerRadius = pLevel / 2
//                self.powerCircle.center = self.view.center
                
            })
            
            
            println("Average Power Level = \(channel.averagePowerLevel) & Peak Hold Level = \(channel.peakHoldLevel)")
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

