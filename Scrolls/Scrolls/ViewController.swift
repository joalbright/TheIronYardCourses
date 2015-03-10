//
//  ViewController.swift
//  Scrolls
//
//  Created by Jo Albright on 3/10/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let columns = 10
//        
//        var hScrollView = UIScrollView(frame: self.view.frame)
//        
//        hScrollView.contentSize = CGSizeMake(CGFloat(columns) * self.view.frame.width, self.view.frame.height)
//        hScrollView.pagingEnabled = true
//        
//        for c in 0..<columns {
//            
//            let rows = arc4random_uniform(3) + 2
//            
//            var vScrollView = UIScrollView(frame: self.view.frame)
//            vScrollView.frame.origin.x = CGFloat(c) * self.view.frame.width
//            
//            vScrollView.contentSize = CGSizeMake(self.view.frame.width, CGFloat(rows) * self.view.frame.height)
//            vScrollView.pagingEnabled = true
//            
//            for r in 0..<rows {
//                
//                var view = UIView(frame: self.view.frame)
//                view.frame.origin.y = CGFloat(r) * self.view.frame.height
//                
//                let grey = CGFloat(arc4random_uniform(100)) / 100
//                view.backgroundColor = UIColor(white: grey, alpha: 1.0)
//                
//                vScrollView.addSubview(view)
//                
//            }
//            
//            hScrollView.addSubview(vScrollView)
//            
//        }
//        
//        self.view.addSubview(hScrollView)
        
        
        var imageScrollView = UIScrollView(frame: view.frame)
        
        var image = UIImage(named: "Llama")
        
        imageView = UIImageView(image: image)
        
        imageScrollView.addSubview(imageView)
        imageScrollView.contentSize = imageView.frame.size
        imageScrollView.bounces = false

        imageScrollView.minimumZoomScale = 0.5
        imageScrollView.maximumZoomScale = 1.0
        
        imageScrollView.setZoomScale(0.5, animated: true)
        imageScrollView.delegate = self
        
        view.addSubview(imageScrollView)
        
    }
    
    var imageView: UIImageView!
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return imageView
        
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

