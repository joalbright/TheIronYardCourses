//
//  ViewController.swift
//  SaveImages
//
//  Created by Jo Albright on 11/11/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var savedImages: [String] = []
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBAction func pressedCapture(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageCollectionView.dataSource = self
        
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        defer { picker.dismissViewControllerAnimated(true, completion: nil) }
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        let s3manager = AFAmazonS3Manager(accessKeyID: accessID, secret: secretKey)
        
        s3manager.requestSerializer.bucket = "jo-photos"
        s3manager.requestSerializer.region = AFAmazonS3USStandardRegion
        

        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let filepath = paths[0] + "/image.png"
        
        UIImagePNGRepresentation(image)?.writeToFile(filepath, atomically: true)
        
        let date = Int(NSDate().timeIntervalSince1970)
        
        s3manager.putObjectWithFile(filepath, destinationPath: "image_\(date).png", parameters: nil, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
            
            let percent = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
            
            print("loaded \(percent)")
            
        }, success: { (response) -> Void in
            
            print(response)
            
            if let urlResponse = response as? AFAmazonS3ResponseObject {
                
                print(urlResponse.URL)
                
                if let url = urlResponse.URL?.absoluteString {
                    
                    print(url)
                    
                    self.savedImages.append(url)
                    self.imageCollectionView.reloadData()
                    
                }
                
            }
            
        }) { (error) -> Void in
            
            print(error)
            
        }
        
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return savedImages.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath)

        for v in cell.contentView.subviews { v.removeFromSuperview() }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        
        // TODO: Add image from URL
        
        let imageURLString = savedImages[indexPath.item]
        
        print(imageURLString)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            
            // run code on background thread
            let data = NSData(contentsOfURL: NSURL(string: imageURLString)!)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                // run code on main thread
                imageView.image = UIImage(data: data!)
                
            })
            
        }
        
        cell.contentView.addSubview(imageView)
        
        return cell
        
    }
    
}

