//
//  Annotation.h
//  ASCODMap
//
//  Created by James Donner on 2/26/13.
//  Copyright (c) 2013 jdsv650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MMAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* subtitle;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end
