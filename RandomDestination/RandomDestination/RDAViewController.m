//
//  RDAViewController.m
//  RandomDestination
//
//  Created by Jo Albright on 6/5/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "RDAViewController.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "RDAFourSquareRequest.h"

#import "RDATableViewController.h"

#import "RDAAnnotation.h"

@interface RDAViewController () <CLLocationManagerDelegate>

@end

@implementation RDAViewController
{
    MKMapView * fsMap;
    
    CLLocationManager * lManager;
    
    CLLocation * currentLocation;
    
    RDATableViewController * venuesTVC;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        lManager = [[CLLocationManager alloc] init];
        lManager.delegate = self;
    
        [lManager startUpdatingLocation];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    fsMap = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    
    [self.view addSubview:fsMap];
    
    venuesTVC = [[RDATableViewController alloc] init];
    
    venuesTVC.tableView.frame = CGRectMake(0, 320, 320, [UIScreen mainScreen].bounds.size.height - 320);
    
    [self.view addSubview:venuesTVC.tableView];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations firstObject];
    
    NSArray * venues = [RDAFourSquareRequest getVenuesWithLat:currentLocation.coordinate.latitude andLong:currentLocation.coordinate.longitude];
    
    [self createMapAnnotationsWithVenues:venues andLocation:currentLocation.coordinate];
    
    [lManager stopUpdatingLocation];
}

- (void)createMapAnnotationsWithVenues:(NSArray *)venues andLocation:(CLLocationCoordinate2D)coordinate
{
//    NSLog(@"%@",venues);
    
    venuesTVC.venues = venues;
    [venuesTVC.tableView reloadData];
    
    double minLat = coordinate.latitude,
    minLong = coordinate.longitude,
    maxLat = coordinate.latitude,
    maxLong = coordinate.longitude;
    
    for (NSDictionary * venue in venues)
    {
        
//    venue: {
//        id: "4d2f2dff4377224bcf071538",
//        name: "Mestia | მესტია",
//        contact: { },
//        location: {
//            lat: 43.043625064722086,
//            lng: 42.72593427812867,
//            distance: 22827,
//            postalCode: "3200",
//            cc: "GE",
//            state: "Samegrelo and Zemo Svaneti",
//            country: "Georgia"
//        }
//    }
        
        NSDictionary * venueInfo = venue[@"venue"];
        NSDictionary * locationInfo = venueInfo[@"location"];
        
        NSLog(@"%@",locationInfo);
        
        double latitude = [locationInfo[@"lat"] doubleValue];
        double longitude = [locationInfo[@"lng"] doubleValue];
        
        if (latitude < minLat) minLat = latitude;
        if (latitude > maxLat) maxLat = latitude;
        if (longitude < minLong) minLong = longitude;
        if (longitude > maxLong) maxLong = longitude;
        
        RDAAnnotation * annotation = [[RDAAnnotation alloc] init];
        
        [annotation setCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
        
        [fsMap addAnnotation:annotation];
        
    }
    
    double centerLat = (maxLat - minLat) / 2.0 + minLat;
    double centerLong = (maxLong - minLong) / 2.0 + minLong;
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(centerLat, centerLong);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, MKCoordinateSpanMake((maxLat - minLat) / 5 * 6, (maxLong - minLong) / 5 * 6));
    
    [fsMap setRegion:region animated:YES];
}

@end
