//
//  FirstScreen_ADMIN_ViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/20/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomView.h"
#import "SelectSalesmanViewController.h"
#import "PushNotificationsViewController.h"
#import "AdminInboxViewController.h"
#import "GlobalMapViewController.h"
#import "PrioritiesViewController.h"
#import "BrochuresViewController.h"
#import "ScanBussinessViewController.h"
#import "RecordViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "ViewStatsSalesmanViewController.h"
#import "CurrentLocationViewController.h"

@interface FirstScreen_ADMIN_ViewController : UIViewController<BottomViewDelegate,MFMailComposeViewControllerDelegate>
{
    int         numberOfDays;
    BOOL        bottomIsUp;
    
    NSString    *clockStatus;
    
    BottomView  *bottomView;
    
    UILabel     *welcomeLabel;
    UILabel     *daysLeftFront;
    
    UIImageView *background;
    UIImageView *welcomeMiddle;
    
    UIButton    *selectSalesman;
    UIButton    *logoutButton;
    UIButton    *globalReviewButton;
    UIButton    *viewCRMButton;
    UIButton    *timesheet;
    
    UIButton    *feedbackButton;
    UIButton    *currentLocationButton;


}
@end
