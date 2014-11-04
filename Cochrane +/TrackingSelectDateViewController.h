//
//  TrackingSelectDateViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/23/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "CXCalendarView.h"
#import "ASIFormDataRequest.h"
#import "SeeRouteSalesmanViewController.h"

@interface TrackingSelectDateViewController : UIViewController<CXCalendarViewDelegate>
{
    UIImageView     *background;
    UIButton        *backButton;
    UIImageView     *upView;
    UILabel         *navTitle;
    NSString        *trackingStringResponse;
    NSString        *selectedDate;
    
    
}

@property (nonatomic,strong) NSString *userID;
@property(assign) CXCalendarView *calendarView;

@end
