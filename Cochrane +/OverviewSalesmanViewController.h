//
//  OverviewSalesmanViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/15/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "SeeRouteSalesmanViewController.h"
#import "ASIFormDataRequest.h"
#import "StatsResultsViewController.h"
#import "TrackingSelectDateViewController.h"

@interface OverviewSalesmanViewController : UIViewController
{
    UIImageView *background;
    UIImageView *top;
    UILabel     *salesmanName;
    UIButton    *backButton;
    
    UIButton    *viewStatsButton;
    UIButton    *trackingHistoryButton;
    UIButton    *sendMessageButton;
    

}

@property (nonatomic,strong)    NSString        *name;
@property (nonatomic,strong)           NSString        *salesmanTag;

@end
