//
//  SubmitViewController.m
//  Camera
//
//  Created by Jo Albright on 10/19/15.
//  Copyright © 2015 Jo Albright. All rights reserved.
//

#import "SubmitViewController.h"

#import <Parse/Parse.h>

@interface SubmitViewController ()

@property (weak, nonatomic) IBOutlet UITextView * captionTextView;
@property (weak, nonatomic) IBOutlet UIImageView * filteredImageView;


@end

@implementation SubmitViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.filteredImageView.image = self.filteredImage;
    
}

- (IBAction)submitSelfie:(id)sender {
    
    PFObject * selfie = [PFObject objectWithClassName:@"Selfie"];
    
    // turn UIImage into NSData (basically getting the raw data)
    NSData * imageData = UIImagePNGRepresentation(self.filteredImage);
    
    // create a Parse File with the raw data, so that it can store the image
    PFFile * imageFile = [PFFile fileWithData:imageData];
    
    selfie[@"image"] = imageFile; // pffile column
    selfie[@"caption"] = self.captionTextView.text; // string column
    selfie[@"user"] = [PFUser currentUser]; // pointer -> _User column
    
    [selfie saveInBackground];
    
}

@end
