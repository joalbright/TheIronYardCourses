//
//  ViewController.swift
//  Replay
//
//  Created by Jo Albright on 11/12/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit
import MobileCoreServices

class CaptureController: UIViewController {

    @IBOutlet weak var liveView: UIView!
    
    @IBOutlet weak var recordStatusView: RecordStatus!
    
    @IBOutlet weak var captureProgressView: CaptureProgress!
    
    @IBOutlet weak var progressTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var progressLeftConstraint: NSLayoutConstraint!
    
    let picker = UIImagePickerController()
    
    var captureTimer: NSTimer?
    
    let hasCamera = UIImagePickerController.isSourceTypeAvailable(.Camera)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard hasCamera else { return }
        
        picker.sourceType = .Camera
        picker.showsCameraControls = false
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.delegate = self
    
        liveView.addSubview(picker.view)
    
    }
    
    override func viewDidLayoutSubviews() {
    
        picker.view.frame = liveView.frame
        
    }
    
    var captureTime: Double = 0.0
    let maxCaptureTime: Double = 10.0
    
    func updateCaptureTime() {
        
        captureTime += 0.05
        
        captureProgressView.progressAmount = CGFloat(captureTime / maxCaptureTime) * 100
        
        if captureTime >= maxCaptureTime {
            
            // stop capture
            endCapture()
            
        }
        
    }
    
    var isCapturing: Bool = false
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if captureTime < 1 { captureTime = 0 } else { return }
        
        moveProgress(touches)
        
        isCapturing = true
        
        captureTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "updateCaptureTime", userInfo: nil, repeats: true)
        
        recordStatusView.isRecording = true
        
        guard hasCamera else { return }
        
        picker.startVideoCapture()
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        moveProgress(touches)
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        captureProgressView.hidden = true
        endCapture()
        
    }
    
    func moveProgress(touches: Set<UITouch>) {
        
        guard let touch = touches.first else { return }
        
        captureProgressView.hidden = false
        
        let point = touch.locationInView(view)
        
        progressLeftConstraint.constant = point.x - captureProgressView.frame.width / 2
        progressTopConstraint.constant = point.y - captureProgressView.frame.height / 2
        
//        captureProgressView.center = touch.locationInView(view)
        
    }
    
    func endCapture() {
        
        // keep from firing more than once per recording
        guard isCapturing else { return }
        isCapturing = false
        
        captureTimer?.invalidate()
        captureTimer = nil
        
        recordStatusView.isRecording = false
        
        guard hasCamera else { return }
        
        picker.stopVideoCapture()
        
    }

}

extension CaptureController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        guard captureTime > 1 else { return }
        
        // collect the file path for the video that was captured
        guard let url = info[UIImagePickerControllerMediaURL] as? NSURL else { return }
        
        guard let replayVC = storyboard?.instantiateViewControllerWithIdentifier("ReplayVC") as? ReplayController else { return }
        
        // pass the nsurl to the replay view controller
        replayVC.url = url
        
        // push to the replay view controller
        navigationController?.pushViewController(replayVC, animated: true)
        
    }
    
}



