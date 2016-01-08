//
//  FilterCollectionViewCell.m
//  Camera
//
//  Created by Jo Albright on 10/19/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

#import "FilterCollectionViewCell.h"

#import "ImageEditing.h"

@implementation FilterCollectionViewCell

- (void)didMoveToWindow {
    
    [self runFilterInBackground];
    
}

- (void)prepareForReuse {
    
    self.filterImageView.image = nil;
    [self runFilterInBackground];

}

- (void)runFilterInBackground {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        UIImage * filteredImage = filterImage(self.originalImage, self.filterName);
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            self.filterImageView.image = filteredImage;
            
        });
        
    });
    
}


@end
