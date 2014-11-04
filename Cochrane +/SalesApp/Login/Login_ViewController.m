//
//  Login_ViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "Login_ViewController.h"
#import "ASIFormDataRequest.h"
#import "Reachability.h"

#define kAnimationDuration 1.0


@interface Login_ViewController ()

@end

@implementation Login_ViewController


#pragma mark
#pragma mark Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    if(self=[super init])
    {
    }
    return self;
}



#pragma mark
#pragma mark View Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    background          =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"loginScreen_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"loginScreen_iPhone4.png"];
    }

    [self.view addSubview:background];

    if(IS_IPHONE_5)
    {
    middle      =[[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-70, self.view.frame.size.width, 120)];
    middle.image=[UIImage imageNamed:@"*png"];
    [self.view addSubview:middle];
    }
    else
    {
        middle      =[[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-70, self.view.frame.size.width, 120)];
        middle.image=[UIImage imageNamed:@"middle.png"];
        [self.view addSubview:middle];
        
    }

[self.view setBackgroundColor:[UIColor whiteColor]];

self.view.autoresizesSubviews=YES;




    NSLog(@" --> %@",NSStringFromCGRect(self.view.frame));
    
   // UIColor *color = [UIColor blackColor];
  //  enterUserTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText:@{NSForegroundColorAttributeName: color}];
    
    if(IS_IPHONE_5)
    {
    enterUserTextField                    =[[UITextField alloc] initWithFrame:CGRectMake(65, 200, 200, 30)];
    enterUserTextField.frame              =CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2+self.view.frame.origin.y-20-0.076*self.view.frame.size.height, 200, 0.076*self.view.frame.size.height);
    enterUserTextField.borderStyle        =UITextBorderStyleRoundedRect;
    //enterUserTextField.backgroundColor    =[UIColor grayColor];
    enterUserTextField.backgroundColor  =[[UIColor alloc] initWithRed:99.0 /255  green:12.0 /255  blue:11.0 /255 alpha:1.0];
    enterUserTextField.layer.cornerRadius =5.0;
    enterUserTextField.layer.masksToBounds=YES;
    enterUserTextField.delegate           =self;
    enterUserTextField.placeholder        =@"USERNAME";
    enterUserTextField.textAlignment      =NSTextAlignmentCenter;
    enterUserTextField.font               =[UIFont fontWithName:@"Arial-BoldMT" size:22];
    enterUserTextField.textColor          =[UIColor blackColor];
    [self.view addSubview:enterUserTextField];
    
    
    enterIDTextField                    =[[UITextField alloc] initWithFrame:CGRectMake(65, 200, 200, 30)];
    enterIDTextField.text               = @"";
    enterIDTextField.secureTextEntry    = YES;
    enterIDTextField.frame              =CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2+self.view.frame.origin.y+40-0.076*self.view.frame.size.height, 200, 0.076*self.view.frame.size.height);
    enterIDTextField.borderStyle        =UITextBorderStyleRoundedRect;
    //enterIDTextField.backgroundColor    =[UIColor lightGrayColor];
    enterIDTextField.backgroundColor  =[[UIColor alloc] initWithRed:99.0 /255  green:12.0 /255  blue:11.0 /255 alpha:1.0];
    enterIDTextField.layer.cornerRadius =5.0;
    enterIDTextField.layer.masksToBounds=YES;
    enterIDTextField.delegate           =self;
    enterIDTextField.placeholder        =@"PASSCODE";
    enterIDTextField.textAlignment      =NSTextAlignmentCenter;
    enterIDTextField.font               =[UIFont fontWithName:@"Arial-BoldMT" size:22];
    enterIDTextField.textColor          =[UIColor blackColor];
    }
    else
    {
        enterUserTextField                    =[[UITextField alloc] initWithFrame:CGRectMake(65, 200, 200, 30)];
        enterUserTextField.frame              =CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2+self.view.frame.origin.y-20-0.076*self.view.frame.size.height, 200, 0.076*self.view.frame.size.height);
        enterUserTextField.borderStyle        =UITextBorderStyleRoundedRect;
        enterUserTextField.backgroundColor    =[UIColor whiteColor];
        enterUserTextField.layer.cornerRadius =5.0;
        enterUserTextField.layer.masksToBounds=YES;
        enterUserTextField.delegate           =self;
        enterUserTextField.placeholder        =@"USERNAME";
        enterUserTextField.textAlignment      =NSTextAlignmentCenter;
        enterUserTextField.font               =[UIFont fontWithName:@"Arial-BoldMT" size:22];
        enterUserTextField.textColor          =[UIColor blackColor];
        [self.view addSubview:enterUserTextField];
        
        
        enterIDTextField                    =[[UITextField alloc] initWithFrame:CGRectMake(65, 200, 200, 30)];
        enterIDTextField.text               = @"";
        enterIDTextField.secureTextEntry    = YES;
        enterIDTextField.frame              =CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2+self.view.frame.origin.y+40-0.076*self.view.frame.size.height, 200, 0.076*self.view.frame.size.height);
        enterIDTextField.borderStyle        =UITextBorderStyleRoundedRect;
        enterIDTextField.backgroundColor    =[UIColor whiteColor];
        enterIDTextField.layer.cornerRadius =5.0;
        enterIDTextField.layer.masksToBounds=YES;
        enterIDTextField.delegate           =self;
        enterIDTextField.placeholder        =@"PASSCODE";
        enterIDTextField.textAlignment      =NSTextAlignmentCenter;
        enterIDTextField.font               =[UIFont fontWithName:@"Arial-BoldMT" size:22];
        enterIDTextField.textColor          =[UIColor blackColor];
        
    }
        
        [self.view addSubview:enterIDTextField];
    

     if(IS_IPHONE_5)
     {
    loginButton                         =[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame                   =CGRectMake(self.view.frame.size.width/2+self.view.frame.origin.x-50, middle.frame.size.height+middle.frame.origin.y+17, 100, 90);
    [loginButton setImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginPressed:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.showsTouchWhenHighlighted=YES;
     }
    else
    {
        loginButton                         =[UIButton buttonWithType:UIButtonTypeCustom];
        loginButton.frame                   =CGRectMake(self.view.frame.size.width/2+self.view.frame.origin.x-50, middle.frame.size.height+middle.frame.origin.y+10, 100, 35);
        [loginButton setImage:[UIImage imageNamed:@"loginBtn.png"] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginPressed:) forControlEvents:UIControlEventTouchUpInside];
        loginButton.showsTouchWhenHighlighted=YES;
    }
         
//#ifdef DEBUG
//    loginButton.layer.borderColor       =[UIColor blackColor].CGColor;
//    loginButton.layer.borderWidth       =2;
//#endif
    [self.view addSubview:loginButton];
    
    
    
    singleTap       =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutsideTextfield:)];
    [self.view addGestureRecognizer:singleTap];
    [singleTap release];
    
    
    
    name    =[[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
    isAdmin =[[NSUserDefaults standardUserDefaults] valueForKey:@"isAdmin"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutUser) name:@"logoutStopTimer" object:nil];

}



-(void)viewWillAppear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    

    internetReachable =[[Reachability reachabilityForInternetConnection] retain];
    [internetReachable startNotifier];

    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]!=nil)
    {
        //enterIDTextField.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"];
    }
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"User"]!=nil)
    {
        //enterUserTextField.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"User"];
    }

    
    //check if a pathway to a random host exists
    hostReachable =[[Reachability reachabilityWithHostName:@"www.apple.com"] retain];
    [hostReachable startNotifier];
    
    [super viewWillAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated
{
}




#pragma mark
#pragma mark Check Network

-(void)checkNetworkStatus:(NSNotification *)notice
{
    
    NetworkStatus internetStatus =[internetReachable currentReachabilityStatus];
    
    switch (internetStatus)
    {
        case NotReachable:
        {
            internetActive=NO;
        }
            break;
            
        case ReachableViaWiFi:
        {
            internetActive=YES;
        }
            break;
            
        case ReachableViaWWAN:
        {
            internetActive=YES;
        }
            break;
            
        default:
            break;
    }
    
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    
    switch (hostStatus)
    {
        case NotReachable:
        {
            hostActive=NO;
        }
            break;
            
        case ReachableViaWiFi:
        {
            hostActive =YES;
        }
            break;
            
        case ReachableViaWWAN:
        {
            hostActive=YES;
        }
            break;
            
            
        default:
            break;
    }
}






#pragma mark
#pragma mark Move View Up
- (void)keyboardDidShow:(NSNotification *)notification
{
    //Assign new frame to your view
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [self.view setFrame:CGRectMake(0,-60,320,460)];
    
    [UIView commitAnimations];
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    
}


#pragma mark
#pragma mark UIButton's Actions

-(void)loginPressed:(UIButton *)sender
{
    [DejalBezelActivityView activityViewForView:self.view];

    if(internetActive==NO)
    {
        [DejalBezelActivityView removeView];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please connect your device to the internet." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
        
    }
    else
    {
//        [loadingView setHidden:NO];

        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@loginSales.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/loginSales.php"]];
        [request setPostValue:@"qwertyuiop0987654321asdfghjkl" forKey:@"key"];
        [request setPostValue:enterIDTextField.text forKey:@"password"];
        [request setPostValue:enterUserTextField.text forKey:@"username"];
        
        [request setCompletionBlock:^{
            
            NSString *responseString    =request.responseString;
            parsedString                =[[responseString componentsSeparatedByString:@"&&"] retain];
            NSLog(@"Login return %@", responseString);
            

            if([parsedString count]>1)
            {
                [[NSUserDefaults standardUserDefaults] setValue:[parsedString objectAtIndex:0] forKey:@"name"];
                [[NSUserDefaults standardUserDefaults] setValue:[parsedString objectAtIndex:1] forKey:@"isAdmin"];
                
                NSLog(@"Acc Level: %@", [parsedString objectAtIndex:1]);
                
                [self loginSuccess];
            }
            else
            {
                [self loginFailed];
            }
            
        }];
        
        
        [request setFailedBlock:^{
            [DejalBezelActivityView removeViewAnimated:YES];

        }];
        [request startAsynchronous];
        
    }
    
}


#pragma mark
#pragma mark Login/Logout States

-(void)logoutUser
{
    [time invalidate];
    time        =nil;
    
    [uploadTimer invalidate];
    uploadTimer =nil;
}


-(void)loginFailed
{
    [DejalBezelActivityView removeViewAnimated:YES];

    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Wrong user id!Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}


-(void)loginSuccess
{
    name    =[[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
    isAdmin =[[NSUserDefaults standardUserDefaults] valueForKey:@"isAdmin"];
    
    NSLog(@"Name: %@", name);
    NSLog(@"isAdmin: %@", isAdmin);

//    NSLog(@"---> isAdmin : %@",isAdmin);
    if(![isAdmin isEqualToString:@"0"] )
    {
        NSDateFormatter *dateFromatterDate  =[[NSDateFormatter alloc] init];
        dateFromatterDate.dateFormat        =@"yyyy-MM-dd";
        
        NSDateFormatter *dateFormatterTime  =[[NSDateFormatter alloc] init];
        dateFormatterTime.dateFormat        =@"HH:mm:ss";
        
        [[NSUserDefaults standardUserDefaults] setValue:[dateFromatterDate stringFromDate:[NSDate date]] forKey:@"dateWhenUserLoggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
//        [dateFromatterDate release];
        
        [[NSUserDefaults standardUserDefaults] setValue:[dateFormatterTime stringFromDate:[NSDate date]] forKey:@"timeWhenUserLoggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
//        [dateFormatterTime release];
//        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            time=[NSTimer scheduledTimerWithTimeInterval:900.0 target:self selector:@selector(trackUserLocation) userInfo:nil repeats:YES];
            NSLog(@"\n\n\n     time: %f",time.timeInterval);
            
            [[NSRunLoop currentRunLoop] addTimer:time forMode:NSDefaultRunLoopMode];
            
            [[NSRunLoop currentRunLoop] run];
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            uploadTimer=[NSTimer scheduledTimerWithTimeInterval:900.0 target:self selector:@selector(uploadTrackingFileToServer) userInfo:nil repeats:YES];
            
            [[NSRunLoop currentRunLoop] addTimer:uploadTimer forMode:NSDefaultRunLoopMode];
            
            [[NSRunLoop currentRunLoop] run];
        });
        
        NSDate          *now            = [NSDate date];
        NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
//        
//        NSDateFormatter *dateFromatterDate  =[[NSDateFormatter alloc] init];
//        dateFromatterDate.dateFormat        =@"yyyy-MM-dd";
//        
//        NSDateFormatter *dateFormatterTime  =[[NSDateFormatter alloc] init];
//        dateFormatterTime.dateFormat        =@"HH:mm:ss";
//        
        
        [[NSUserDefaults standardUserDefaults] setValue:[dateFromatterDate stringFromDate:[NSDate date]] forKey:@"dateWhenUserLoggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [dateFromatterDate release];
        
        [[NSUserDefaults standardUserDefaults] setValue:[dateFormatterTime stringFromDate:[NSDate date]] forKey:@"timeWhenUserLoggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [dateFormatterTime release];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        
        
        
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@sessionScript.php",SERVER]]];//@"http://www.x-2.info/SalesApp_php/sessionScript.php"]];
        [request setPostValue:enterIDTextField.text forKey:@"idUser"];
        [request setPostValue:[dateFormatter stringFromDate:now] forKey:@"login"];
        [dateFormatter release];
        
        [request setCompletionBlock:^{
            NSLog(@"session script ok");
        }];
        
        
        [request setFailedBlock:^{
        }];
        [request startAsynchronous];
        

    }

//    time=[NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(trackUserLocation) userInfo:nil repeats:YES];
//    uploadTimer=[NSTimer scheduledTimerWithTimeInterval:40.0 target:self selector:@selector(uploadTrackingFileToServer) userInfo:nil repeats:YES];
//    testTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(testFile) userInfo:nil repeats:YES];

    
    [DejalBezelActivityView removeViewAnimated:YES];

    loginID=[enterIDTextField.text retain];
    deviceTok                           =[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    ASIFormDataRequest *requestDevice   =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@updateDeviceToken.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/updateDeviceToken.php"]];
    
    [requestDevice setPostValue:deviceTok forKey:@"device"];
    [requestDevice setPostValue:enterIDTextField.text forKey:@"userID"];
    
    
    [requestDevice setCompletionBlock:^{
        NSLog(@"Token Updated");
    }];
    
    
    [requestDevice setFailedBlock:^{
        
    }];
    [requestDevice startAsynchronous];
    
    
    NSDate          *now            = [NSDate date];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat        = @"yyyy-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];

    
    
    NSDateFormatter *dateFormatter2  = [[NSDateFormatter alloc] init];
    dateFormatter2.dateFormat        = @"HH-mm-ss";
    
    [dateFormatter2 setTimeZone:[NSTimeZone systemTimeZone]];
    
    
    
    [[NSUserDefaults standardUserDefaults] setValue:enterIDTextField.text forKey:@"UserID"];
    
    NSArray     *paths      =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString    *docPath    =[paths objectAtIndex:0];
    txtPath                 =[[docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@_%@_routeTrack.txt",[dateFormatter stringFromDate:now],[dateFormatter2 stringFromDate:now],[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] ]] retain];
    uploadStepsFilePath     =[txtPath retain];
    
    [dateFormatter release];
    [dateFormatter2 release];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:txtPath])
    {
        [[NSFileManager defaultManager] createFileAtPath:txtPath contents:nil attributes:nil];
    }
    
    
    ASIFormDataRequest *request2 =[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@availability.php",SERVER]]];
    [request2 setPostValue:@"1" forKey:@"available"];
    [request2 setPostValue:loginID forKey:@"user"];
    
    
    [request2 setCompletionBlock:^{
        
    }];
    
    [request2 setFailedBlock:^{
    }];
    [request2 startAsynchronous];

    
    if([isAdmin isEqualToString:@"2"] )
    {
//        NSDate          *now            = [NSDate date];
//        NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
//        dateFormatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
//        
//        NSDateFormatter *dateFromatterDate  =[[NSDateFormatter alloc] init];
//        dateFromatterDate.dateFormat        =@"yyyy-MM-dd";
//        
//        NSDateFormatter *dateFormatterTime  =[[NSDateFormatter alloc] init];
//        dateFormatterTime.dateFormat        =@"HH:mm:ss";
//
//        
//        [[NSUserDefaults standardUserDefaults] setValue:[dateFromatterDate stringFromDate:[NSDate date]] forKey:@"dateWhenUserLoggedIn"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [dateFromatterDate release];
//
//        [[NSUserDefaults standardUserDefaults] setValue:[dateFormatterTime stringFromDate:[NSDate date]] forKey:@"timeWhenUserLoggedIn"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [dateFormatterTime release];
//        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//               
//
//        
//        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@sessionScript.php",SERVER]]];//@"http://www.x-2.info/SalesApp_php/sessionScript.php"]];
//        [request setPostValue:enterIDTextField.text forKey:@"idUser"];
//        [request setPostValue:[dateFormatter stringFromDate:now] forKey:@"login"];
//        [dateFormatter release];
//        
//        [request setCompletionBlock:^{
//            NSLog(@"sesseion script ok");
//        }];
//        
//        
//        [request setFailedBlock:^{
//        }];
//        [request startAsynchronous];
        
        
      
        
        FirstPageViewController *vc         =[[[FirstPageViewController alloc] init] autorelease];
        CATransition            *transition =[CATransition animation];
        transition.duration                 =kAnimationDuration;
        transition.timingFunction           =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type =@"cube";
        transition.subtype=kCATransitionFromRight;
        transition.delegate=self;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [loadingView setHidden:YES];
        [loadingView removeFromSuperview];

        FirstScreen_ADMIN_ViewController *vc=[[[FirstScreen_ADMIN_ViewController alloc] init] autorelease];
        CATransition *transition            =[CATransition animation];
        transition.duration                 =kAnimationDuration;
        transition.timingFunction           =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type                     =@"cube";
        transition.subtype                  =kCATransitionFromRight;
        transition.delegate                 =self;
        
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
 
}

-(void)testFile
{
    NSLog(@"testfile  -> %f",testTimer.timeInterval);
}

#pragma mark
#pragma mark Tracking

-(void)trackUserLocation
{    
    
    ASIFormDataRequest *currentLocationRequest =[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@updateCurrentLocation.php",SERVER]]];
    [currentLocationRequest setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"userID"];
    [currentLocationRequest setPostValue:[NSNumber numberWithDouble:currentLocation.coordinate.latitude] forKey:@"latitudeValue"];
    [currentLocationRequest setPostValue:[NSNumber numberWithDouble:currentLocation.coordinate.longitude] forKey:@"longitudeValue"];
    [currentLocationRequest setCompletionBlock:^{
        NSLog(@"updateCurrentLocation: %@",currentLocationRequest.responseString);
    }];
    [currentLocationRequest setFailedBlock:^{
        NSLog(@"updateCurrentLocation -> failed");
    }];
    [currentLocationRequest startAsynchronous];

    
    
    
    NSDate              *now            = [NSDate date];
    NSDateFormatter     *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat            = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    if(coordinatesArray)
    {
            
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
        [tmp setValue:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:now]] forKey:@"trackingDate"];
        [dateFormatter release];
        [tmp setValue: currentLocation forKey:@"trackingLocation"];
        [coordinatesArray addObject:tmp];
        [tmp release];
    }
    else
    {
        coordinatesArray            =[[NSMutableArray alloc] init];
        NSMutableDictionary *tmp    = [[NSMutableDictionary alloc] init];
        [tmp setValue:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:now]] forKey:@"trackingDate"];
        [dateFormatter release];
        [tmp setValue: currentLocation forKey:@"trackingLocation"];
        [coordinatesArray addObject:tmp];
        [tmp release];
    }
        
}

-(void)uploadTrackingFileToServer
{
    
    NSLog(@"upload tracking file to server");
    //upload tracking steps every 15 minutes
    NSFileHandle        *myHandle       =[NSFileHandle  fileHandleForWritingAtPath:uploadStepsFilePath];
    NSLog(@"\n\n\n coordinates : \n%@",coordinatesArray);
    for(int i=0;i<[coordinatesArray count];i++)
    {
        CLLocation *coord =[[coordinatesArray objectAtIndex:i] objectForKey:@"trackingLocation"];
        [myHandle seekToEndOfFile];
        [myHandle writeData:[[NSString stringWithFormat:@"%@^^%f^^%f\n",[[coordinatesArray objectAtIndex:i] objectForKey:@"trackingDate"],coord.coordinate.latitude,coord.coordinate.longitude] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    [coordinatesArray removeAllObjects];
    [myHandle seekToEndOfFile];
    [myHandle writeData:[@"@end\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [myHandle closeFile];
    
    
    ///////*******//////
    
    NSString *dateLogin= [[NSUserDefaults standardUserDefaults] valueForKey:@"dateWhenUserLoggedIn"];
    NSString *timeLogin= [[NSUserDefaults standardUserDefaults] valueForKey:@"timeWhenUserLoggedIn"];
    ///////*******//////
    NSLog(@"\n\n dateLogin: %@   time login: %@ ",dateLogin,timeLogin);
    
    
    NSDate          *now            = [NSDate date];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLoggedOut" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutStopTimer" object:nil];
//    
    
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploadFile.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/uploadFile.php"]];
    
    [request setFile:uploadStepsFilePath forKey:@"file"];
    [request setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"userID"];
    [request setPostValue:uploadStepsFilePath forKey:@"path"];
    [request setPostValue:[dateFormatter stringFromDate:now] forKey:@"logout"];
    [request setPostValue:dateLogin forKey:@"dateLogin"];
    [request setPostValue:timeLogin forKey:@"timeLogin"];
    
    
    [request setCompletionBlock:^{
        NSLog(@"upload file to server ok----> %@",request.responseString);
    }];
    
    
    [request setFailedBlock:^{
        NSLog(@"req failed");
    }];
    [request startAsynchronous];
    
    
//    ASIFormDataRequest *request2 =[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@availability.php",SERVER]]];
//    [request2 setPostValue:@"0" forKey:@"available"];
//    [request2 setPostValue:loginID forKey:@"user"];
//    
//    
//    [request2 setCompletionBlock:^{
//        
//    }];
//    
//    [request2 setFailedBlock:^{
//    }];
//    [request2 startAsynchronous];
//    
    
    //analyze
    [dateFormatter release];
    


    
}


#pragma mark
#pragma mark UITextFieldDelegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    loginID=textField.text;
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
}

#pragma mark
#pragma mark Dismiss Keyboard

-(void)tapOutsideTextfield:(UITapGestureRecognizer *)recognizer
{
    CGPoint location =[recognizer locationInView:[recognizer.view superview]];
    
    if(CGRectContainsPoint(self.view.frame, location) && ( !CGRectContainsPoint(enterIDTextField.frame, location)))
    {
        if([enterIDTextField isFirstResponder])
        {
            
            [enterIDTextField resignFirstResponder];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationDelay:0.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            
            [self.view setFrame:CGRectMake(0,0,320,460)];
            
            [UIView commitAnimations];

        }
    }

}

#pragma mark
#pragma mark Memory Management


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
