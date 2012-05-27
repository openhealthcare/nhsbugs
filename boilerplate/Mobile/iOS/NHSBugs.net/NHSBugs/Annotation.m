//
//  Annotation.m
//  NHSBugs
//
//  Created by Colin Wren on 27/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "Annotation.h"


@implementation Annotation
@synthesize coordinate, title;
-init
{
	return self;
}

-(NSString *)title{
    return title;
}

-initWithCoordinate:(CLLocationCoordinate2D)inCoord
{
	coordinate = inCoord;
	return self;
}

@end

