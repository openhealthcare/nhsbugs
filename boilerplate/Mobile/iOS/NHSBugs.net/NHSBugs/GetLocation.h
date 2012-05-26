//
//  GetLocation.h
//  NHSBugs
//
//  Created by Colin Wren on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
@class ViewController;
@interface GetLocation : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    ViewController *menu;
    IBOutlet UIButton *manual;
    IBOutlet UIImageView *logo;
}
@property(nonatomic, retain) ViewController *menu;

-(IBAction)manual:(id)sender;
@end
