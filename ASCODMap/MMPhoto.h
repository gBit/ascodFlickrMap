//
//  MMPhoto.h
//  ASCODMap
//
//  Created by gBit on 2/28/13.
//  Copyright (c) 2013 gBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface MMPhoto : NSObject

@property (strong, nonatomic) NSString *photoID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *ownername;
@property (strong, nonatomic) NSString *description;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSURL *url;

@end
