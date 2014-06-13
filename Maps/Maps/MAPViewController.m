//
//  MAPViewController.m
//  Maps
//
//  Created by Jo Albright on 5/21/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "MAPViewController.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "MAPAnnotation.h"

@interface MAPViewController () <CLLocationManagerDelegate,MKMapViewDelegate>

@end

@implementation MAPViewController
{
    CLLocationManager * lManager;
    MKMapView * myMapView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        lManager = [[CLLocationManager alloc] init];
        lManager.delegate = self;
        
        lManager.distanceFilter = 1000;
        
        [lManager startUpdatingLocation];
        
        
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [myMapView removeAnnotations:myMapView.annotations];
    
    for (CLLocation * location in locations)
    {
        MAPAnnotation * annotation = [[MAPAnnotation alloc] initWithCoordinate:location.coordinate];
        
        annotation.title = @"Marker";
        annotation.subtitle = @"This is a marker";
        
        [myMapView addAnnotation:annotation];
        
//        [mapView setCenterCoordinate:location.coordinate animated:YES];
        
        MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(1.0, 1.0));
        
        [myMapView setRegion:region animated:YES];
        
//        [mapView selectAnnotation:annotation animated:YES];
        
//        NSLog(@"%@",location);
        
        
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
           
            for (CLPlacemark * placemark in placemarks)
            {
                NSLog(@"%@",placemark);
                
                NSString * cityState = [NSString stringWithFormat:@"%@, %@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
                
                [annotation setTitle:cityState];
                [annotation setSubtitle:placemark.country];
            }
            
        }];
        
    }
//    [lManager stopUpdatingLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    myMapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    myMapView.delegate = self;
    
    [self.view addSubview:myMapView];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    if (annotationView == nil)
    {
        
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
        
    } else {
        
        annotationView.annotation = annotation;
        
    }
    
    annotationView.draggable = YES;
    annotationView.canShowCallout = YES;
//    annotationView.image = [UIImage imageNamed:@"yellow0"];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
    NSLog(@"%@",view.annotation.title);
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    NSLog(@"new state : %d and old state %d",(int)newState,(int)oldState);
    
    switch ((int)newState)
    {
        case 0: // not dragging
        {
            [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
            
            CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
            
            CLLocation * location = [[CLLocation alloc] initWithLatitude:view.annotation.coordinate.latitude longitude:view.annotation.coordinate.longitude];
            
            [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                
                for (CLPlacemark * placemark in placemarks)
                {
                    NSLog(@"%@",placemark.addressDictionary);
                    
                    NSString * cityState = [NSString stringWithFormat:@"%@, %@",placemark.addressDictionary[@"City"],placemark.addressDictionary[@"State"]];
                    
                    [(MAPAnnotation *)view.annotation setTitle:cityState];
                    [(MAPAnnotation *)view.annotation setSubtitle:placemark.country];
                }
                
            }];
        }
            break;
            
        case 1: // starting drag
            
            break;
            
        case 2: // dragging
            
            break;
            
        case 4: // ending drag
            
            break;
            
        default:
            break;
    }
}

@end
