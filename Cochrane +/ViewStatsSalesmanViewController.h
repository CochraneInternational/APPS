//
//  ViewStatsSalesmanViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 8/2/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "Global.h"
#import <UIKit/UIKit.h>
//#import "ClientStatsViewController.h"
#import "DailyResultsViewController.h"
#import "WeeklyResultsViewController.h"
#import "MonthlyResultsViewController.h"
#import "QuarterlyViewController.h"
#define kAnimationDuration 1.0


@interface ViewStatsSalesmanViewController : UIViewController
{
    UIButton        *daily;         //meetings
    UIButton        *weekly;        //timeAttendance
    UIButton        *monthly;       //priceEstimate
    UIButton        *quarterly;     //sales
    
    UIImageView     *background;

    UIButton        *backButton;

}

@end
