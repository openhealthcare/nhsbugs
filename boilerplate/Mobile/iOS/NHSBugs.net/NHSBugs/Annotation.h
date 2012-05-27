//
//  Annotation.h
//  NHSBugs
//
//  Created by Colin Wren on 27/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
}
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
-initWithCoordinate:(CLLocationCoordinate2D)inCoord;
@end