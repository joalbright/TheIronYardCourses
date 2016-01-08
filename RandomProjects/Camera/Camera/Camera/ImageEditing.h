//
//  ImageEditing.h
//  Camera
//
//  Created by Jo Albright on 10/21/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef ImageEditing_h
#define ImageEditing_h

static UIImage * resizeImage(UIImage * image, CGSize newSize) {
    
    // only works if newSize is a square
    
    CGFloat squareWidth = newSize.width;
    
    BOOL isPortrait = image.size.width < image.size.height;
    
    CGFloat scale = isPortrait ? squareWidth / image.size.width : squareWidth / image.size.height;
    
    CGFloat scaleHeight = isPortrait ? image.size.height * scale : squareWidth;
    CGFloat scaleWidth = isPortrait ? squareWidth : image.size.width * scale;
    
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake((squareWidth - scaleWidth) / 2, (squareWidth - scaleHeight) / 2, scaleWidth, scaleHeight)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

static UIImage * flipImage(UIImage * image) {
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(ctx, -1.0, 1.0); // flip horizontal

    [image drawInRect:CGRectMake(-image.size.width, 0, image.size.width, image.size.height)];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

static UIImage * filterImage(UIImage * originalImage, NSString * filterName) {
    
    CIContext * context = [CIContext contextWithOptions:nil];                       // 1
    
    NSLog(@"%@",context);
    
    CIImage * image = [CIImage imageWithCGImage:originalImage.CGImage];                               // 2
    
    CIFilter * filter = [CIFilter filterWithName:filterName];                  // 3
    
    if (![[filter inputKeys] containsObject:kCIInputImageKey]) { return nil; }
    
    [filter setValue:image forKey:kCIInputImageKey];
    //    [filter setValue:@0.8f forKey:kCIInputIntensityKey];
    
    CIImage * filteredImage = [filter valueForKey:kCIOutputImageKey];               // 4
    
//    CGRect extent = [filteredImage extent];
//    
//    CGImageRef cgImage = [context createCGImage:filteredImage fromRect:extent];     // 5
        
    return [UIImage imageWithCIImage:filteredImage];
    
}


#endif /* ImageEditing_h */

