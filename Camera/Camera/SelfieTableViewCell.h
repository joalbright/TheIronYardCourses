//
//  SelfieTableViewCell.h
//  Camera
//
//  Created by Jo Albright on 10/19/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SelfieTableViewCell : UITableViewCell

@property (nonatomic) PFObject * selfie;

@end
