//
//  MMMapViewController.m
//  ASCODMap
//
//  Created by James Donner on 2/26/13.
//  Copyright (c) 2013 jdsv650. All rights reserved.
//

#import "MMMapViewController.h"
#import <MapKit/MapKit.h>
#import "MMAnnotation.h"

@interface MMMapViewController ()
{
    __weak IBOutlet MKMapView *mapViewOutlet;
    MMAnnotation *myAnnotation;
}

@end

@implementation MMMapViewController
@synthesize pictDict, selectedImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startLocationUpdates];
    [self startAnnotationUpdates];
    
    //NSLog(@"%@", pictDict);
    
    //    CLLocationCoordinate2D defaultCoordinate =
    //    {
    //        .latitude = 41.894032,
    //        .longitude = -87.634742
    //    };
    //
    //    MKCoordinateSpan defaultSpan =
    //    {
    //        .latitudeDelta = 0.002f,
    //        .longitudeDelta = 0.002f
    //    };
    //
    //    MKCoordinateRegion defaultRegion = {defaultCoordinate, defaultSpan};
    //
    //    myAnnotation = [[MMAnnotation alloc] init];
    //    myAnnotation.title = @"MobileMakers";
    //    myAnnotation.subtitle = @"I am here!";
    //    myAnnotation.coordinate = defaultCoordinate;
    //
    //    [mapViewOutlet setRegion:defaultRegion];
    //    [mapViewOutlet addAnnotation:myAnnotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate Protocols

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    [self updatePhotoCoordinates:newLocation.coordinate];
    [self updateMapViewWithNewCenter:newLocation.coordinate];
}


#pragma mark - Location Methods

- (void)startLocationUpdates
{
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    
    [locationManager startUpdatingLocation];
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void)updatePhotoCoordinates:(CLLocationCoordinate2D)newCoordinate
{
    myAnnotation.coordinate = newCoordinate;
}

- (void)updateMapViewWithNewCenter:(CLLocationCoordinate2D)newCoordinate
{
    MKCoordinateRegion newRegion = {newCoordinate, mapViewOutlet.region.span};
    [mapViewOutlet setRegion:newRegion];
}


#pragma mark - Annotation/Detail Methods

- (void)startAnnotationUpdates
{
    if (myAnnotation == nil)
    {
        myAnnotation = [[MMAnnotation alloc] init];
    }
    
    myAnnotation.title = [pictDict valueForKey:@"ownername"];
    myAnnotation.subtitle = [pictDict valueForKey:@"title"];
    
    
    float photoLat = [[pictDict valueForKey:@"latitude"] floatValue];
    float photoLong = [[pictDict valueForKey:@"longitude"] floatValue];
    
    CLLocationCoordinate2D photoCoordinate =
    {
        .latitude = photoLat,
        .longitude = photoLong
    };
    
    MKCoordinateSpan defaultSpan =
    {
        .latitudeDelta = 0.5f,
        .longitudeDelta = 0.5f
    };
    
    MKCoordinateRegion photoRegion = {photoCoordinate, defaultSpan};
    
    myAnnotation.coordinate = photoCoordinate;
    
    [mapViewOutlet setRegion:photoRegion];
    [mapViewOutlet addAnnotation:myAnnotation];
    
}

- (MKAnnotationView *) mapView:(MKMapView *) mapView
             viewForAnnotation:(id<MKAnnotation>)annotation
{
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation"];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    }
    
    [detailButton addTarget:self
                     action:@selector(showDetails)
           forControlEvents:UIControlEventTouchUpInside];
    
    annotationView.canShowCallout = YES;
    annotationView.image = selectedImage;
    annotationView.rightCalloutAccessoryView = detailButton;
    
    return annotationView;
}

-(void) showDetails
{
    NSLog(@"%@", [pictDict valueForKey:@"description"]);
}

@end
