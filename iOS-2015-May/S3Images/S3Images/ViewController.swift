//
//  ViewController.swift
//  S3Images
//
//  Created by Jo Albright on 6/18/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit
import AmazonS3RequestManager
import AFNetworking
import AFAmazonS3Manager

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        dispatch_after(DISPATCH_TIME_NOW + NSEC_PER_SEC * 5, dispatch_get_main_queue()) { () -> Void in
            
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            saveImageToS3(image)
            
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
//    let amazonS3Manager = AmazonS3RequestManager(bucket: "mycoolimages",
//        region: .USStandard,
//        accessKey: "AKIAIL3HKOKTULPVRX7A",
//        secret: "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")
    
    let s3Manager = AFAmazonS3Manager(accessKeyID: accessKey, secret: secret)
    
    //AFAmazonS3Manager *s3Manager = [[AFAmazonS3Manager alloc] initWithAccessKeyID:@"..." secret:@"..."];
    //s3Manager.requestSerializer.region = AFAmazonS3USWest1Region;
    //s3Manager.requestSerializer.bucket = @"my-bucket-name";
    //
    //NSString *destinationPath = @"/pathOnS3/to/file.txt";
    //

    func saveImageToS3(image: UIImage) {
        
        s3Manager.requestSerializer.bucket = bucket
        s3Manager.requestSerializer.region = AFAmazonS3USStandardRegion
//        s3Manager.requestSerializer.setValue("public-read", forHTTPHeaderField: "x-amz-acl")
        
        
        let timestamp = Int(NSDate().timeIntervalSince1970)
        
        let imageName = "myImage_\(timestamp)"
        
        let imageData = UIImagePNGRepresentation(image)
        
//        amazonS3Manager.putObject(imageData, destinationPath: imageName + ".png", acl: nil)
        
        if let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as? String {
            
            let filePath = documentPath.stringByAppendingPathComponent(imageName + ".png")
            
            println(filePath)
            
            imageData.writeToFile(filePath, atomically: false)
            
            let fileURL = NSURL(fileURLWithPath: filePath)
            
//            amazonS3Manager.putObject(fileURL!, destinationPath: imageName + ".png", acl: AmazonS3PredefinedACL.Public)
            
            
            s3Manager.putObjectWithFile(filePath, destinationPath: imageName + ".png", parameters: nil, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
                
                let percentageWritten = (CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)) * 100.0
                
                println("Uploaded \(percentageWritten)%")
                
            }, success: { (responseObject) -> Void in
                
                let info = responseObject as! AFAmazonS3ResponseObject
                
                println(info)
//                println("\(info.URL)")
                
            }, failure: { (error) -> Void in
                
                println("\(error)")
                
            })
            
        }
        
    }

}

