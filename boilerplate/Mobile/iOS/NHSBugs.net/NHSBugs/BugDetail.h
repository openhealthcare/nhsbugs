//
//  BugDetail.h
//  NHSBugs
//
//  Created by Colin Wren on 27/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BugDetail : UIViewController{
    IBOutlet UIImageView *bugPic;
    NSString *title, *description, *pic, *reportDate, *status;
    NSMutableData *picData;
    NSURLConnection *picDownload;
    IBOutlet UITextView *descriptiontext;
    IBOutlet UILabel *statusdisplay;
    IBOutlet UILabel *datedisplay;
}
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *description;
@property(nonatomic, copy) NSString *pic;
@property(nonatomic, copy) NSString *reportDate;
@property(nonatomic, copy) NSString *status;
@end
