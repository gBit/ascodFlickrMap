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
    
}

@end

@implementation MMMapViewController
@synthesize pictDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@", pictDict);
  
    CLLocationCoordinate2D mmCoordinate = {.latitude = 41.894032,.longitude = -87.634742};
    
    MKCoordinateSpan span =
    {
        .latitudeDelta = 0.002f,  //0.00001
        .longitudeDelta = 0.002f
    };
    
    MKCoordinateRegion myRegion = {mmCoordinate, span};
    
    MMAnnotation *myAnnotation = [[MMAnnotation alloc] init];
    myAnnotation.title = @"MobileMakers";
    myAnnotation.subtitle = @"I am here!";
    myAnnotation.coordinate = mmCoordinate;
    
    [mapViewOutlet setRegion:myRegion];
    [mapViewOutlet addAnnotation:myAnnotation];
}


-(void) showDetails
{
    //new view controller etc...
    NSLog(@"ASCOD Rules!");
}


-(MKAnnotationView *) mapView:(MKMapView *) mapView
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
    
    
    NSString *farmString = [pictDict valueForKey:@"farm"];
    NSString *serverString = [pictDict valueForKey:@"server"];
    NSString *idString = [pictDict valueForKey:@"id"];
    NSString *secretString = [pictDict valueForKey:@"secret"];
    
    NSString *flickrURLString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_s.jpg", farmString, serverString, idString, secretString];
    
    // NSLog(@"%@", flickrURLString);
    
    NSURL *flickrURL = [NSURL URLWithString:flickrURLString];
    NSData *flickrData = [NSData dataWithContentsOfURL:flickrURL];
    UIImage *myImage = [UIImage imageWithData:flickrData];// Do any additional setup after loading the view.
    
    annotationView.canShowCallout = YES;
    annotationView.image = myImage;
    annotationView.rightCalloutAccessoryView = detailButton;
    
    return annotationView;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
