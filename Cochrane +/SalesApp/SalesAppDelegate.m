//
//  SalesAppDelegate.m
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "SalesAppDelegate.h"
#define kDOCSFOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


@implementation SalesAppDelegate


- (void)dealloc
{
    [_window release];
    [super dealloc];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]autorelease];
 
//    self.window =[[[UIWindow alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)] autorelease];
    
    NSFileManager           * fileManager   = [[[NSFileManager alloc] init] autorelease];
    NSDirectoryEnumerator   * en            = [fileManager enumeratorAtPath:kDOCSFOLDER];
    NSString* file;
    while (file = [en nextObject])
    {
        
        NSError     *error      = nil;
        NSString    *filepath   =[NSString stringWithFormat:[kDOCSFOLDER stringByAppendingString:@"/%@"],file];
        
        
        NSDate      *creationDate   =[[fileManager attributesOfItemAtPath:filepath error:nil] fileCreationDate];
        NSDate      *d              =[[NSDate date] dateByAddingTimeInterval:-1*24*60*60];
        
        NSDateFormatter *df=[[NSDateFormatter alloc]init];        [df setDateFormat:@"EEEE d"];
        
        [df release];
        
        if ([creationDate compare:d] == NSOrderedAscending)
        {

            [[NSFileManager defaultManager] removeItemAtPath:[kDOCSFOLDER stringByAppendingPathComponent:file] error:&error];
        }
        else
        {
        }
    }
   
    NSDictionary *pushDic = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if (pushDic != nil)
    {
        NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        
        
        messageReceived=[[NSString stringWithFormat:@"%@~~~%@",
                          [[pushDic objectForKey:@"aps"] objectForKey:@"body"],[dateFormatter stringFromDate:[NSDate date]]] retain];

        NSLog(@"Notification --> %@",pushDic);
        inboxMess =[[NSMutableArray alloc] init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"])
        {
            for(int i=0;i<[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] count];i++)
            {
                [inboxMess addObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] objectAtIndex:i]];
            }
            
        }
        
        NSMutableArray*dict= [[NSMutableArray alloc] init];
        [dict addObject:@"unread"];
        [dict addObject:messageReceived];
        
        
        [inboxMess addObject:dict];
        
        [[NSUserDefaults standardUserDefaults] setObject:inboxMess forKey:@"inboxMessages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBottomViewInbox" object:nil];
        [dict release];

    }
    else
    {
        
    }
    
    
    UIViewController *rootVC =[[[Login_ViewController alloc] init] autorelease];
    self.navigationController =[[UINavigationController alloc] initWithRootViewController:rootVC];
    [[self window] setRootViewController:self.navigationController];
    self.navigationController.navigationBarHidden=YES;
    
    
    self.locationManager =[[CLLocationManager alloc] init] ;
    self.locationManager.delegate=self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
//    [self.locationManager startUpdatingLocation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopThings) name:@"userLoggedOut" object:nil];
    [self.window makeKeyAndVisible];

    
    //popup that asks the user if they wish to receive notifications
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    

    return YES;
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{    
    
    NSString *str       = [NSString stringWithFormat:@"%@",deviceToken];
    NSString *newString = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    newString           = [newString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    newString           = [newString stringByReplacingOccurrencesOfString:@">" withString:@""];

    [[NSUserDefaults standardUserDefaults] setObject:newString forKey:@"deviceToken"];

    deviceTok=newString;
}




-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{    
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];


    messageReceived=[[NSString stringWithFormat:@"%@~~~%@",
                     [[userInfo objectForKey:@"aps"] objectForKey:@"body"],[dateFormatter stringFromDate:[NSDate date]]] retain];
    NSLog(@"messageReceived: %@",messageReceived);
    application.applicationIconBadgeNumber = 0;
    if (application.applicationState == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Inbox"
                                                            message:@"New message received!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        inboxMess =[[NSMutableArray alloc] init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"])
        {
            for(int i=0;i<[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] count];i++)
            {
                [inboxMess addObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] objectAtIndex:i]];
            }
            
        }
        
        NSMutableArray*dict= [[NSMutableArray alloc] init];
        [dict addObject:@"unread"];
        [dict addObject:messageReceived];
        
        
        [inboxMess addObject:dict];
        
        [[NSUserDefaults standardUserDefaults] setObject:inboxMess forKey:@"inboxMessages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBottomViewInbox" object:nil];
        [dict release];

    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        //make it unread
        inboxMess =[[NSMutableArray alloc] init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"])
        {
            for(int i=0;i<[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] count];i++)
            {
                [inboxMess addObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] objectAtIndex:i]];
            }

        }
        
        NSMutableArray*dict= [[NSMutableArray alloc] init];
        [dict addObject:@"unread"];
        [dict addObject:messageReceived];

        
        [inboxMess addObject:dict];

        [[NSUserDefaults standardUserDefaults] setObject:inboxMess forKey:@"inboxMessages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBottomViewInbox" object:nil];
        [dict release];
    }

}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
    
    //@"Failed to register with Apple Push Service. Device Token failed."
}


-(void)stopThings
{
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //NSLog(@"\n ***** background time: %f", [UIApplication sharedApplication].backgroundTimeRemaining);

 /*   BOOL isInBackground = NO;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        isInBackground = YES;
    }
    
    // Handle location updates as normal, code omitted for brevity.
    // The omitted code should determine whether to reject the location update for being too
    // old, too close to the previous one, too inaccurate and so forth according to your own
    // application design.
    
    if (isInBackground)
    {
        [self sendBackgroundLocationToServer:[locations lastObject]];
    }
    else
    {
        // ...
    }
  */
    currentLocation=[[locations lastObject] retain];
//    NSLog(@"latitude: %f       longitude: %f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);


}

//-(void) sendBackgroundLocationToServer:(CLLocation *)location
//{
//    // REMEMBER. We are running in the background if this is being executed.
//    // We can't assume normal network access.
//    // bgTask is defined as an instance variable of type UIBackgroundTaskIdentifier
//    
//    // Note that the expiration handler block simply ends the task. It is important that we always
//    // end tasks that we have started.
//    
//    bgTask = [[UIApplication sharedApplication]
//              beginBackgroundTaskWithExpirationHandler:
//              ^{
//                  [[UIApplication sharedApplication] endBackgroundTask:bgTask];
//                   }];
//    
//                    currentLocation=[location retain];
//    NSFileHandle        *myHandle       =[NSFileHandle  fileHandleForWritingAtPath:uploadStepsFilePath];
//    for(int i=0;i<[coordinatesArray count];i++)
//    {
//        CLLocation *coord =[[coordinatesArray objectAtIndex:i] objectForKey:@"trackingLocation"];
//        [myHandle seekToEndOfFile];
//        [myHandle writeData:[[NSString stringWithFormat:@"%@^^%f^^%f\n",[[coordinatesArray objectAtIndex:i] objectForKey:@"trackingDate"],coord.coordinate.latitude,coord.coordinate.longitude] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//    }
//    [coordinatesArray removeAllObjects];
//    [myHandle seekToEndOfFile];
//    [myHandle writeData:[@"@end\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [myHandle closeFile];
//    
//    
//    ///////*******//////
//    
//    NSString *dateLogin= [[NSUserDefaults standardUserDefaults] valueForKey:@"dateWhenUserLoggedIn"];
//    NSString *timeLogin= [[NSUserDefaults standardUserDefaults] valueForKey:@"timeWhenUserLoggedIn"];
//    ///////*******//////
//    
//    
//    NSDate          *now            = [NSDate date];
//    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
//    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//    
//    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLoggedOut" object:nil];
//    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutStopTimer" object:nil];
//    //
//    
//    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploadFile.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/uploadFile.php"]];
//    
//    [request setFile:uploadStepsFilePath forKey:@"file"];
//    [request setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"userID"];
//    [request setPostValue:uploadStepsFilePath forKey:@"path"];
//    [request setPostValue:[dateFormatter stringFromDate:now] forKey:@"logout"];
//    [request setPostValue:dateLogin forKey:@"dateLogin"];
//    [request setPostValue:timeLogin forKey:@"timeLogin"];
//    
//    
//    [request setCompletionBlock:^{
//        NSLog(@"\n\n\n\n upload file to server ok----> %@",request.responseString);
//    }];
//    
//    
//    [request setFailedBlock:^{
//        NSLog(@"req failed");
//    }];
//    [request startAsynchronous];
//    
//    
//    //    ASIFormDataRequest *request2 =[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@availability.php",SERVER]]];
//    //    [request2 setPostValue:@"0" forKey:@"available"];
//    //    [request2 setPostValue:loginID forKey:@"user"];
//    //
//    //
//    //    [request2 setCompletionBlock:^{
//    //
//    //    }];
//    //
//    //    [request2 setFailedBlock:^{
//    //    }];
//    //    [request2 startAsynchronous];
//    //
//    
//    //analyze
//    [dateFormatter release];
//    
//    
//    
//
//                  // ANY CODE WE PUT HERE IS OUR BACKGROUND TASK
//                  
//                  // For example, I can do a series of SYNCHRONOUS network methods (we're in the background, there is
//                  // no UI to block so synchronous is the correct approach here).
//                  
//                  // ...
//                  
//                  // AFTER ALL THE UPDATES, close the task
//                  
//                  if (bgTask != UIBackgroundTaskInvalid)
//                  {
//                      [[UIApplication sharedApplication] endBackgroundTask:bgTask];
//                       bgTask = UIBackgroundTaskInvalid;
//                       
//                  }
//                    }


- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"appplication did enter background");

    bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"ending background task");
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
  NSTimer * Timer = [NSTimer scheduledTimerWithTimeInterval:1200.0
                                                  target:self.locationManager
                                                selector:@selector(startUpdatingLocation)
                                                userInfo:nil
                                                 repeats:YES];

    [locationManager2 startMonitoringSignificantLocationChanges];
    // Usethis method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"will enter foreground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
//    NSLog(@"application did become active");
//    [locationManager2 stopMonitoringSignificantLocationChanges];
//    [locationManager2 startUpdatingLocation];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
