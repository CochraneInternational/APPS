//
//  FirstPageViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "FirstPageViewController.h"
#import "ASIFormDataRequest.h"
#import "Reachability.h"

#define kAnimationDuration 1.0

@interface FirstPageViewController ()

@end

@implementation FirstPageViewController



#pragma mark
#pragma mark Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}



#pragma mark 
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor   =[UIColor whiteColor];

    background                  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"welcomeScreen_iPhone5_new.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"welcomeScreen_iPhone4.png"];
    }
    
    [self.view addSubview:background];
    
    bottomIsUp          =NO;

    
    
    bottomView          =[[BottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y+self.view.frame.size.height-self.view.frame.size.height*0.09+20, self.view.frame.size.width, self.view.frame.size.height*0.24)];
    bottomView.delegate =self;
    [self.view addSubview:bottomView];

    
    feedbackButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [feedbackButton setImage:[UIImage imageNamed:@"feedback_new.png"] forState:UIControlStateNormal];
    [feedbackButton setFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height*1.3/8, 100, 0.09*self.view.frame.size.height)];
    [feedbackButton addTarget:self action:@selector(sendFeedback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:feedbackButton];
    
    /* Code block for Timesheet */
    NSDate          *now            = [NSDate date];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat        = @"yyyy-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Africa/Johannesburg"]];
    
    ASIFormDataRequest *req=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getTimesheetStatus.php",SERVER]]];
    [req setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"userID"];
    [req setPostValue:[dateFormatter stringFromDate:now] forKey:@"date"];
    
    [req setCompletionBlock:^{
        NSLog(@"Timesheet: %@",req.responseString);
        timesheet =[UIButton buttonWithType:UIButtonTypeCustom];
        if ([req.responseString  isEqual: @"red"]) {
            [timesheet setImage:[UIImage imageNamed:@"icon_ClockOut_new.png"] forState:UIControlStateNormal];
            clockStatus = @"red";
        } else {
            [timesheet setImage:[UIImage imageNamed:@"icon_ClockIn_new.png"] forState:UIControlStateNormal];
            clockStatus = @"green";
        }
        [timesheet setFrame:CGRectMake(self.view.frame.size.width/2-145, self.view.frame.size.height*0.615, 45, 45)]; //
        [self.view addSubview:timesheet];
        [timesheet addTarget:self action:@selector(doClock:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [req setFailedBlock:^{
        NSLog(@"Timesheet - Failed@");
    }];
    [req startAsynchronous];
    /* End Timesheet */
    
     welcomeMiddle =[[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*1.3/5, self.view.frame.size.width, self.view.frame.size.height/8)];
    welcomeMiddle.image     =[UIImage imageNamed:@"topAdminFirstPage_new.png"];
    [self.view addSubview:welcomeMiddle];
    
    
    welcomeLabel    =[[UILabel alloc] initWithFrame:CGRectMake(0, welcomeMiddle.frame.origin.y+self.view.frame.size.height*0.027,self.view.frame.size.width, self.view.frame.size.height*0.09)];
    welcomeLabel.text               =[[NSString stringWithFormat:@"WELCOME %@",[parsedString objectAtIndex:0]] uppercaseString];
    welcomeLabel.numberOfLines=1;
    welcomeLabel.minimumFontSize=8;
    welcomeLabel.adjustsFontSizeToFitWidth=YES;
    welcomeLabel.textAlignment      =NSTextAlignmentCenter;
    [welcomeLabel setBackgroundColor:[UIColor clearColor]];
    welcomeLabel.textColor          =[UIColor whiteColor];
    welcomeLabel.font               =[UIFont fontWithName:@"Arial-BoldMT" size:22];
    [self.view addSubview:welcomeLabel];
    
    [self calculateNumberOfDays];
    

    viewStatsButton =[UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        viewStatsButton.frame=CGRectMake(0, welcomeLabel.frame.origin.y+welcomeLabel.frame.size.height+0*self.view.frame.size.height, self.view.frame.size.width,0.09*self.view.frame.size.height);
    }
    else
    {

        viewStatsButton.frame=CGRectMake(0, welcomeLabel.frame.origin.y+welcomeLabel.frame.size.height+0*self.view.frame.size.height, self.view.frame.size.width,0.11*self.view.frame.size.height);
    }
    
    
    [viewStatsButton setImage:[UIImage imageNamed:@"viewStats_iPhone4_new.png"] forState:UIControlStateNormal];
   
    [viewStatsButton addTarget:self action:@selector(viewStatsPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:viewStatsButton];
    
    //// LINK FOR CRM
    
    viewCRMButton            =[UIButton buttonWithType:UIButtonTypeCustom];
    
    viewCRMButton.frame=CGRectMake(0,  viewStatsButton.frame.origin.y+viewStatsButton.frame.size.height+0.01*self.view.frame.size.height, self.view.frame.size.width, 0.09*self.view.frame.size.height);
    
    [viewCRMButton setImage:[UIImage imageNamed:@"viewCRM_iPhone4_new.png"] forState:UIControlStateNormal];
    
    [viewCRMButton setTitle:@"Logout" forState:UIControlStateNormal];
    [viewCRMButton addTarget:self action:@selector(gotoCRMLink:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:viewCRMButton];
    
    //// END LINK
    
    
    daysLeftFront                   =[[UILabel alloc] init];
    
    if(IS_IPHONE_5)
    {
        daysLeftFront.frame             =CGRectMake(self.view.frame.size.width*5/8, viewCRMButton.frame.origin.y+self.view.frame.size.height*0.32,self.view.frame.size.height*0.14, self.view.frame.size.height*0.08);
    }
    else
    {
        daysLeftFront.frame             =CGRectMake(self.view.frame.size.width*5/7, viewCRMButton.frame.origin.y+self.view.frame.size.height*0.285,self.view.frame.size.height*0.14, self.view.frame.size.height*0.08);
    }

    daysLeftFront.textAlignment     =NSTextAlignmentCenter;
    if(IS_IPHONE_5)
    {
        daysLeftFront.font              =[UIFont fontWithName:@"GillSans-Bold" size:38];
    }
    else
    {
        daysLeftFront.font              =[UIFont fontWithName:@"GillSans-Bold" size:36];
    }
    daysLeftFront.text              =[NSString stringWithFormat:@"%i",numberOfDays];
    daysLeftFront.backgroundColor   =[UIColor clearColor];
    daysLeftFront.alpha             =1.0;
    daysLeftFront.textColor         =[UIColor whiteColor];
//#ifdef DEBUG
//    daysLeftFront.layer.borderColor =[UIColor blackColor].CGColor;
//    daysLeftFront.layer.borderWidth =2;
//#endif
    [self.view addSubview:daysLeftFront];

    logoutButton            =[UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        logoutButton.frame      =CGRectMake(self.view.frame.size.width/1-60, viewStatsButton.frame.origin.y+viewStatsButton.frame.size.height+self.view.frame.size.height*0.14, 45, self.view.frame.size.height*0.09); //height: self.view.frame.size.height*0.178

    }
    else
    {
        logoutButton.frame      =CGRectMake(self.view.frame.size.width/1-60, viewStatsButton.frame.origin.y+viewStatsButton.frame.size.height+self.view.frame.size.height*0.17, 45, self.view.frame.size.height*0.09); //height: self.view.frame.size.height*0.178

    }
    
    [logoutButton setImage:[UIImage imageNamed:@"roundRedButton.png"] forState:UIControlStateNormal];

    [logoutButton setTitle:@"" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveViewUp) name:@"viewUp" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveViewDown) name:@"viewDown" object:nil];

}


-(void)viewStatsPressed:(UIButton *)sender
{
    ViewStatsSalesmanViewController *viewStats  = [[[ViewStatsSalesmanViewController alloc] init] autorelease];
    CATransition                *transition     =[CATransition animation];
    transition.duration                         =kAnimationDuration;
    transition.timingFunction                   =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type                             =@"cube";
    transition.subtype                          =kCATransitionFromRight;
    transition.delegate                         =self;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:viewStats animated:YES];

}

-(void)viewCRMButton:(UIButton *)sender
{
    NSLog(@"CRM Button@");
    
}


-(void)sendFeedback:(UIButton *)sender
{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Fill out the email body text
    //    NSString *emailBody = @"I just took this picture, check it out.";
    NSArray *toRecipients = [NSArray arrayWithObjects:@"app@cochrane.co",nil];
    
    [picker setToRecipients:toRecipients];
    [picker setSubject:@"Cochrane+ Feedback"];
    // This is not an HTML formatted email
    //    [picker setMessageBody:emailBody isHTML:NO];
    
    
    //    NSData *pdfData = [NSData dataWithContentsOfFile:file];
    //    [picker addAttachmentData:pdfData mimeType:@"application/pdf" fileName:name];
    
    
    [self presentModalViewController:picker animated:YES];
    
    // Release picker
    [picker release];
    
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
    
}



-(void)logoutPressed:(UIButton *)sender
{
    NSFileHandle        *myHandle       =[NSFileHandle  fileHandleForWritingAtPath:uploadStepsFilePath];

    for(int i=0;i<[coordinatesArray count];i++)
    {
        CLLocation *coord =[[coordinatesArray objectAtIndex:i] objectForKey:@"trackingLocation"];        
        [myHandle seekToEndOfFile];
        [myHandle writeData:[[NSString stringWithFormat:@"%@^^%f^^%f\n",[[coordinatesArray objectAtIndex:i] objectForKey:@"trackingDate"],coord.coordinate.latitude,coord.coordinate.longitude] dataUsingEncoding:NSUTF8StringEncoding]];

    }
    [myHandle seekToEndOfFile];
    [myHandle writeData:[@"@end\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [myHandle closeFile];
    
  
    
    NSString *dateLogin= [[NSUserDefaults standardUserDefaults] valueForKey:@"dateWhenUserLoggedIn"];
    NSString *timeLogin= [[NSUserDefaults standardUserDefaults] valueForKey:@"timeWhenUserLoggedIn"];
    
    
    NSDate          *now            = [NSDate date];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLoggedOut" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutStopTimer" object:nil];

    
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploadFile.php",SERVER]]];// @"http://www.x-2.info/SalesApp_php/uploadFile.php"]];

    [request setFile:uploadStepsFilePath forKey:@"file"];
    [request setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"userID"];
    [request setPostValue:uploadStepsFilePath forKey:@"path"];
    [request setPostValue:[dateFormatter stringFromDate:now] forKey:@"logout"];
    [request setPostValue:dateLogin forKey:@"dateLogin"];
    [request setPostValue:timeLogin forKey:@"timeLogin"];

    
    [request setCompletionBlock:^{
        
    }];
    
    
    [request setFailedBlock:^{
    }];
    [request startAsynchronous];
    
    
    ASIFormDataRequest *request2 =[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@availability.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/availability.php"]];
    [request2 setPostValue:@"0" forKey:@"available"];
    [request2 setPostValue:loginID forKey:@"user"];
    
    
    [request2 setCompletionBlock:^{
        
    }];
    
    [request2 setFailedBlock:^{
    }];
    [request2 startAsynchronous];
    
    
    //analyze
    [dateFormatter release];


    CATransition *transition    =[CATransition animation];
    transition.duration         =kAnimationDuration;
    transition.timingFunction   =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type             =@"cube";
    transition.subtype          =kCATransitionFromLeft;
    transition.delegate         =self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];

}



#pragma mark
#pragma mark Swipe Gestures
-(void)oneSwipeGesture:(UITapGestureRecognizer *)recognizer
{
    DailyResultsViewController  *record     = [[[DailyResultsViewController alloc] init] autorelease];//analyze
    CATransition                *transition =[CATransition animation];
    transition.duration                     =kAnimationDuration;
    transition.timingFunction               =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type                         =@"cube";
    transition.subtype                      =kCATransitionFromRight;
    transition.delegate                     =self;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:record animated:YES];

}



#pragma mark
#pragma mark ColorWithHex

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


#pragma mark






-(void)calculateNumberOfDays
{
    NSCalendar          *calendar       =[NSCalendar currentCalendar];
    NSDate              *currentDate    = [NSDate date];
    NSUInteger          componentFlags  = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents    *components     = [[NSCalendar currentCalendar] components:componentFlags fromDate:currentDate];
    NSInteger           year            = [components year]; //year from current date
    
    
    NSDateComponents    *comp =[[NSDateComponents alloc] init];
    [comp setYear:year];
    [comp setMonth:12];
    [comp setDay:31];
    
    NSDate              *endYearDate=[calendar dateFromComponents:comp];
    
    [comp release];
    unsigned            flags       = NSDayCalendarUnit;
    
    NSDateComponents    *difference =[[NSCalendar currentCalendar] components:flags fromDate:currentDate toDate:endYearDate options:0];
    
    NSInteger daydiff=[difference day];
    numberOfDays =(int)daydiff-40;
#pragma mark Number Of Days
}

#pragma mark 
#pragma mark UIButton's Actions




#pragma mark
#pragma mark BottomView Delegate Methods

-(void)actionOnSlideUpButton
{
    if(bottomIsUp==NO)
    {
        bottomIsUp=YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"])
        {
            int count=0;
            
            inboxMess=[[NSMutableArray alloc] init];
            
            for(int i=0;i<[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] count];i++)
            {
                [inboxMess addObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] objectAtIndex:i]];
            }

            
            for(int i=0;i<[inboxMess count];i++)
            {
                if([[[inboxMess objectAtIndex:i] objectAtIndex:0]  isEqualToString:@"unread"])
                    count++;
            }
            
            if(count>0)
            {
                bottomView.noOfMessUnread.text=[NSString stringWithFormat:@"%i",count];
                bottomView.noOfMessUnread.hidden=NO;
                bottomView.messUnreadImgView.hidden=NO;
            }
        }
        else
        {
            NSLog(@"\n\n there is nothing in user defaults");
        }
        
        bottomView.frame=CGRectMake(bottomView.frame.origin.x, bottomView.frame.origin.y-40, bottomView.frame.size.width, bottomView.frame.size.height);
        [self.view exchangeSubviewAtIndex:[[self.view subviews] indexOfObject:bottomView] withSubviewAtIndex:[[self.view subviews] indexOfObject:logoutButton] ];

        [UIView commitAnimations];


    }
    else
    {
        bottomIsUp=NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        bottomView.frame=CGRectMake(bottomView.frame.origin.x, bottomView.frame.origin.y+40, bottomView.frame.size.width, bottomView.frame.size.height);
        [UIView commitAnimations];
        [self.view exchangeSubviewAtIndex:[[self.view subviews] indexOfObject:logoutButton] withSubviewAtIndex:[[self.view subviews] indexOfObject:bottomView]];

        
    }

}

-(void)gotoCRMLink:(UIButton *)sender
{
    NSLog(@"Clicked!@");
    /* Do a Query to the Backend to get the http link for the CRM */
    ASIFormDataRequest *req=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getCrmLink.php",SERVER]]];
    
    [req setCompletionBlock:^{
        NSLog(@"CRM Link: %@",req.responseString);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:req.responseString]];
        // Do nothing
    }];
    [req setFailedBlock:^{
        NSLog(@"CRM Link - Failed@");
    }];
    [req startAsynchronous];
}

/* Function to clock in/out */
-(void)doClock:(UIButton *)sender
{
    NSLog(@"Clock Status: %@", clockStatus); // This gives us the status of clockin
    NSDate          *time            = [NSDate date];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat        = @"HH:mm";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate          *nowDate            = [NSDate date];
    NSDateFormatter *dateFormatter2  = [[NSDateFormatter alloc] init];
    dateFormatter2.dateFormat        = @"yyyy-MM-dd";
    [dateFormatter2 setTimeZone:[NSTimeZone systemTimeZone]];
    
    ASIFormDataRequest *req=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@doClock.php",SERVER]]];
    [req setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"userID"];
    [req setPostValue:[dateFormatter2 stringFromDate:nowDate] forKey:@"date"];
    [req setPostValue:[dateFormatter stringFromDate:time] forKey:@"time"];
    [req setPostValue:clockStatus forKey:@"status"];
    
    [req setCompletionBlock:^{
        NSLog(@"Clock Action: %@",req.responseString);
        if ([req.responseString  isEqual: @"red"]) {
            [timesheet setImage:[UIImage imageNamed:@"icon_ClockOut.png"] forState:UIControlStateNormal];
            clockStatus = @"red";
        } else {
            [timesheet setImage:[UIImage imageNamed:@"icon_ClockIn.png"] forState:UIControlStateNormal];
            clockStatus = @"green";
        }
    }];
    [req setFailedBlock:^{
        NSLog(@"Clock - Failed@");
    }];
    [req startAsynchronous];
    
}


-(void)prioritiesView
{
    PrioritiesViewController    *prio       =[[[PrioritiesViewController alloc] init] autorelease];
    CATransition                *transition =[CATransition animation];
    transition.duration                     =kAnimationDuration;
    transition.timingFunction               =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type                         =@"cube";
    transition.subtype                      =kCATransitionFromRight;
    transition.delegate                     =self;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:prio animated:YES];
}


-(void)inboxView
{
    NSLog(@"inbox1");
    InboxMessagesViewController    *record         =[[[InboxMessagesViewController alloc] init] autorelease];
    CATransition            *transition     =[CATransition animation];
    transition.duration                     =kAnimationDuration;
    transition.timingFunction               =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type                         =@"cube";
    transition.subtype                      =kCATransitionFromRight;
    transition.delegate                     =self;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:record animated:YES];

}


-(void)recordView
{
    RecordViewController    *record         =[[[RecordViewController alloc] init] autorelease];
    CATransition            *transition     =[CATransition animation];
    transition.duration                     =kAnimationDuration;
    transition.timingFunction               =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type                         =@"cube";
    transition.subtype                      =kCATransitionFromRight;
    transition.delegate                     =self;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:record animated:YES];
}


-(void)brochureView
{
    BrochuresViewController *brochure   =[[[BrochuresViewController alloc] init] autorelease];
    CATransition            *transition =[CATransition animation];
    transition.duration                 =kAnimationDuration;
    transition.timingFunction           =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type                     =@"cube";
    transition.subtype                  =kCATransitionFromRight;
    transition.delegate                 =self;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:brochure animated:YES];

}


-(void)scanBussiness
{
    ScanBussinessViewController *scan       =[[[ScanBussinessViewController alloc] init] autorelease];
    CATransition                *transition =[CATransition animation];
    transition.duration                     =kAnimationDuration;
    transition.timingFunction               =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type                         =@"cube";
    transition.subtype                      =kCATransitionFromRight;
    transition.delegate                     =self;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:scan animated:YES];
}



#pragma mark
#pragma mark Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
