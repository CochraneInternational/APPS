//
//  SalesAppDelegate.h
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "Login_ViewController.h"
#import "InboxMessagesViewController.h"


@interface SalesAppDelegate : NSObject <UIApplicationDelegate,UINavigationControllerDelegate,UIAlertViewDelegate, CLLocationManagerDelegate>
{
    NSString            *messageReceived;
//    CLLocationManager   *locationManager;
    CLLocationManager   *locationManager2;
    UIBackgroundTaskIdentifier bgTask;
}

@property (strong, nonatomic) UIWindow                  *window;
@property (strong, nonatomic) UINavigationController    *navigationController;
@property (strong, nonatomic) CLLocationManager         *locationManager;

@end
