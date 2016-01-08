//
//  FilterCollectionViewCell.h
//  Camera
//
//  Created by Jo Albright on 10/19/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterCollectionViewCell : UICollectionViewCell

@property UIImage * originalImage;
@property NSString * filterName;

@property (weak, nonatomic) IBOutlet UIImageView * filterImageView;

@end
