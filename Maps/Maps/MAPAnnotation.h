//
//  MAPAnnotation.h
//  Maps
//
//  Created by Jo Albright on 5/21/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface MAPAnnotation : NSObject <MKAnnotation>

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic,readonly,copy) NSString * title;
@property (nonatomic,readonly,copy) NSString * subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;

@end
