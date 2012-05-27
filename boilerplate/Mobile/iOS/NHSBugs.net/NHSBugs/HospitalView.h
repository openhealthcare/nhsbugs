//
//  HospitalView.h
//  NHSBugs
//
//  Created by Colin Wren on 27/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class BugDetail;
@class UploadBug;
@interface HospitalView : UIViewController<MKMapViewDelegate>{
    NSURLConnection *updates;
    NSMutableData *updateData;
    IBOutlet UITableView *bugs;
    IBOutlet MKMapView *map;
    NSMutableArray *bugslist, *bugdetaillist, *descriptlist,*piclist, *reportDatelist, *statuslist;
    BugDetail *bug;
    UploadBug *uploadbug;
    NSMutableDictionary *updatesDict;
}
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *longitude;
@property(nonatomic, copy) NSString *latitude;
@property(nonatomic, retain) MKMapView *map;

-(void)location;
-(void)marker;
-(void)upload:(id)sender;
@end
