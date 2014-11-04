//
//  StatsResultsViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/17/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "ASIFormDataRequest.h"
#import "DailyResultsViewController.h"  
#import "WeeklyResultsViewController.h"
#import "MonthlyResultsViewController.h"
#import "QuarterlyViewController.h"

@interface StatsResultsViewController : UIViewController
{
    UIImageView *background;
    UIImageView *top;
    UIButton    *backButton;
    
    UIButton    *dailyBtn;
    UIButton    *weeklyBtn;
    UIButton    *monthlyBtn;
    UIButton    *quarterlyBtn;
    UIButton    *yearlyBtn;
    

}

@property (nonatomic,strong) NSString *userID;
@end
