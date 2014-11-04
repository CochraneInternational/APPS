//
//  Login_ViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FirstPageViewController.h"
#import "Global.h"
#import "FirstScreen_ADMIN_ViewController.h"
#import "DejalActivityView.h"

@class Reachability;

@interface Login_ViewController : UIViewController<UITextFieldDelegate>
{
    UIButton                *loginButton;
    UITextField             *enterIDTextField;
    UITextField             *enterUserTextField;
    UITapGestureRecognizer  *singleTap;
    
    UIImageView             *background;
    UIImageView             *logo;
    UIImageView             *middle;
    UIImageView             *loginImageView;

    Reachability            *internetReachable;
    Reachability            *hostReachable;
    NSTimer                 *time;
    NSTimer                 *uploadTimer;
    NSString                *txtPath;
    UIView                  *loadingView;
    NSTimer                 *testTimer;
    NSAttributedString      *placeholderText;
   
//current Location
//    NSTimer                 *currentLocationTimer;
//    CLLocationManager       *locationManager;
    
}

-(void)checkNetworkStatus:(NSNotification *)notice;

@end
