//
//  FirstPageViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BottomView.h"
#import "RecordViewController.h"
#import "ScanBussinessViewController.h"
#import "TrackingViewController.h"
#import "PrioritiesViewController.h"
#import "BrochuresViewController.h"
#import "DailyResultsViewController.h"
#import "ASIFormDataRequest.h"
#import "InboxMessagesViewController.h"
#import "ViewStatsSalesmanViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface FirstPageViewController : UIViewController<BottomViewDelegate,UIGestureRecognizerDelegate,MFMailComposeViewControllerDelegate>
{
    int         numberOfDays;
    
    UIButton    *contactAdd;
    NSString    *clockStatus;

    BOOL        bottomIsUp;
    
    BottomView  *bottomView;
    UILabel     *welcomeLabel;
    UIImageView *welcome;
    
    
    UILabel     *daysLeftFront;
    UILabel     *daysLeftBack;

    
    UIButton    *viewStatsButton;
    UIButton    *viewCRMButton;
    UIButton    *timesheet;
    
    UIImageView *background;
    UIImageView *welcomeMiddle;
    UIButton    *logoutButton;
    UIButton *feedbackButton;
    
        
}
@end
