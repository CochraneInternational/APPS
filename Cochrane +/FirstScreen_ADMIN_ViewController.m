//
//  FirstScreen_ADMIN_ViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/20/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "FirstScreen_ADMIN_ViewController.h"
#define kAnimationDuration 1.0

@interface FirstScreen_ADMIN_ViewController ()

@end

@implementation FirstScreen_ADMIN_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"welcomeScreen_iPhone5_new.png"];
    }
    else
    {

        background.image=[UIImage imageNamed:@"welcomeScreen_iPhone4.png"];
    }
    

    [self.view addSubview:background];
    
    bottomIsUp =NO;
    
    bottomView =[[BottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y+self.view.frame.size.height-self.view.frame.size.height*0.09+20, self.view.frame.size.width, self.view.frame.size.height*0.23)];
    bottomView.delegate=self;
    [self.view addSubview:bottomView];

    feedbackButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [feedbackButton setImage:[UIImage imageNamed:@"feedback.png"] forState:UIControlStateNormal];
    [feedbackButton setFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height*1.3/8, 100, 0.09*self.view.frame.size.height)];
    [feedbackButton addTarget:self action:@selector(sendFeedback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:feedbackButton];
    
    /* Code block for Timesheet */
    NSDate          *now            = [NSDate date];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat        = @"yyyy-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    ASIFormDataRequest *req=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getTimesheetStatus.php",SERVER]]];
    [req setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"userID"];
    [req setPostValue:[dateFormatter stringFromDate:now] forKey:@"date"];
    
    [req setCompletionBlock:^{
        NSLog(@"Timesheet: %@",req.responseString);
        timesheet =[UIButton buttonWithType:UIButtonTypeCustom];
        if ([req.responseString  isEqual: @"red"]) {
            [timesheet setImage:[UIImage imageNamed:@"icon_ClockOut.png"] forState:UIControlStateNormal];
            clockStatus = @"red";
        } else {
            [timesheet setImage:[UIImage imageNamed:@"icon_ClockIn.png"] forState:UIControlStateNormal];
            clockStatus = @"green";
        }
        if(IS_IPHONE_5) {
           [timesheet setFrame:CGRectMake(self.view.frame.size.width*2/2, self.view.frame.size.height*0.615, 45, 45)];
                    } else {
            [timesheet setFrame:CGRectMake(self.view.frame.size.width*2/250, self.view.frame.size.height*1.5/8, 36, 36)];
        }
        [self.view addSubview:timesheet];
        [timesheet addTarget:self action:@selector(doClock:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [req setFailedBlock:^{
        NSLog(@"Timesheet - Failed@");
    }];
    [req startAsynchronous];
    /* End Timesheet */
    
    
    welcomeMiddle =[[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*1.3/5, self.view.frame.size.width, self.view.frame.size.height/8)];
    welcomeMiddle.image =[UIImage imageNamed:@"topAdminFirstPage.png"];
//#ifdef DEBUG
//    welcomeMiddle.layer.borderColor=[UIColor blackColor].CGColor;
//    welcomeMiddle.layer.borderWidth=2;
//#endif
    [self.view addSubview:welcomeMiddle];
    
    
    selectSalesman =[UIButton buttonWithType:UIButtonTypeCustom];
    if([isAdmin isEqualToString:@"0"] )
    {
        selectSalesman.frame=CGRectMake(0,  welcomeMiddle.frame.origin.y+welcomeMiddle.frame.size.height+0.05*self.view.frame.size.height, self.view.frame.size.width, 0.08*self.view.frame.size.height);

    }
    else
    {
        selectSalesman.frame=CGRectMake(0,  welcomeMiddle.frame.origin.y+welcomeMiddle.frame.size.height+0.01*self.view.frame.size.height, self.view.frame.size.width, 0.09*self.view.frame.size.height);
    }
    [selectSalesman addTarget:self action:@selector(selectSalesman:) forControlEvents:UIControlEventTouchUpInside];
    [selectSalesman setImage:[UIImage imageNamed:@"overviewSalesmanButton.png"] forState:UIControlStateNormal];
    [self.view addSubview:selectSalesman];
    

 

    globalReviewButton =[UIButton buttonWithType: UIButtonTypeCustom];
    if([isAdmin isEqualToString:@"0"] )
    {
        globalReviewButton.frame=CGRectMake(0, selectSalesman.frame.origin.y+selectSalesman.frame.size.height+0.009*self.view.frame.size.height,self.view.frame.size.width, 0.08*self.view.frame.size.height);

        [globalReviewButton setImage:[UIImage imageNamed:@"globalReviewBtn.png"] forState:UIControlStateNormal];
    }
    else
    {
        globalReviewButton.frame=CGRectMake(0, selectSalesman.frame.origin.y+selectSalesman.frame.size.height+0.009*self.view.frame.size.height,self.view.frame.size.width, 0.09*self.view.frame.size.height);

        [globalReviewButton setImage:[UIImage imageNamed:@"viewStats_iPhone4.png"] forState:UIControlStateNormal];

    }

    [globalReviewButton addTarget:self action:@selector(globalPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:globalReviewButton];
    
//    
    if([isAdmin isEqualToString:@"0"] )
    {
        currentLocationButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [currentLocationButton setFrame:CGRectMake(0, globalReviewButton.frame.size.height+globalReviewButton.frame.origin.y+5, self.view.frame.size.width,  0.08*self.view.frame.size.height)];
        [currentLocationButton setImage:[UIImage imageNamed:@"currentLocationButton.png"] forState:UIControlStateNormal];
        [currentLocationButton setTitle:@"Current Location" forState:UIControlStateNormal];
        [currentLocationButton addTarget:self action:@selector(currentLocationpressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:currentLocationButton];
    }
    

    welcomeLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, welcomeMiddle.frame.origin.y+15,self.view.frame.size.width, self.view.frame.size.height*0.09)];
    welcomeLabel.text =[[NSString stringWithFormat:@"WELCOME %@",[parsedString objectAtIndex:0]]uppercaseString];
    welcomeLabel.textAlignment=NSTextAlignmentCenter;
    [welcomeLabel setBackgroundColor:[UIColor clearColor]];
    welcomeLabel.textColor=[UIColor whiteColor];
    welcomeLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:22];
    [self.view addSubview:welcomeLabel];
    
    //// LINK FOR CRM
    
    viewCRMButton            =[UIButton buttonWithType:UIButtonTypeCustom];
    
    viewCRMButton.frame=CGRectMake(0,  globalReviewButton.frame.origin.y+globalReviewButton.frame.size.height+0.01*self.view.frame.size.height, self.view.frame.size.width, 0.09*self.view.frame.size.height);
    
    [viewCRMButton setImage:[UIImage imageNamed:@"viewCRM_iPhone4.png"] forState:UIControlStateNormal];
    
    [viewCRMButton setTitle:@"Logout" forState:UIControlStateNormal];
    [viewCRMButton addTarget:self action:@selector(gotoCRMLink:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:viewCRMButton];
    
    //// END LINK
      
    [self calculateNumberOfDays];
    
    daysLeftFront =[[UILabel alloc] init];
    if(IS_IPHONE_5)
    {
        if([isAdmin isEqualToString:@"0"] )
        {
            daysLeftFront.frame =CGRectMake(self.view.frame.size.width*5/8, currentLocationButton.frame.origin.y+currentLocationButton.frame.size.height+0.12*[UIScreen mainScreen].bounds.size.height,self.view.frame.size.height*0.12, self.view.frame.size.height*0.08);

        }
        else
        {
            daysLeftFront.frame =CGRectMake(self.view.frame.size.width*5/8, globalReviewButton.frame.origin.y+globalReviewButton.frame.size.height+0.2*[UIScreen mainScreen].bounds.size.height,self.view.frame.size.height*0.14, self.view.frame.size.height*0.08);

        }
    }
    else
    {
        if([isAdmin isEqualToString:@"0"] )
        {
            daysLeftFront.frame =CGRectMake(self.view.frame.size.width*5/8, currentLocationButton.frame.origin.y+currentLocationButton.frame.size.height+0.06*[UIScreen mainScreen].bounds.size.height,self.view.frame.size.height*0.14, self.view.frame.size.height*0.08);

        }
        else
        {
            daysLeftFront.frame =CGRectMake(self.view.frame.size.width*5/8, globalReviewButton.frame.origin.y+globalReviewButton.frame.size.height+0.2*[UIScreen mainScreen].bounds.size.height-16,self.view.frame.size.height*0.14, self.view.frame.size.height*0.08);

        }
    }
    

 //   daysLeftFront.frame =CGRectMake(self.view.frame.size.width*5/8, globalReviewButton.frame.origin.y+globalReviewButton.frame.size.height+0.115*[UIScreen mainScreen].bounds.size.height,self.view.frame.size.height*0.14, self.view.frame.size.height*0.08);
    daysLeftFront.textAlignment=NSTextAlignmentCenter;
    daysLeftFront.font=[UIFont fontWithName:@"GillSans-Bold" size:34];
    daysLeftFront.text=[NSString stringWithFormat:@"%i",numberOfDays];
    daysLeftFront.backgroundColor =[UIColor clearColor];
    daysLeftFront.alpha=1.0;
    daysLeftFront.textColor=[UIColor whiteColor];
    [self.view addSubview:daysLeftFront];
    
    
    logoutButton            =[UIButton buttonWithType:UIButtonTypeCustom];
    
    if(IS_IPHONE_5)
    {
        if([isAdmin isEqualToString:@"0"] )
        {
            logoutButton.frame      =CGRectMake(self.view.frame.size.width/2-25, currentLocationButton.frame.origin.y+currentLocationButton.frame.size.height+self.view.frame.size.height*0.01, 45, self.view.frame.size.height*0.08); //height: self.view.frame.size.height*0.178

        }
        else
        {
            logoutButton.frame      =CGRectMake(self.view.frame.size.width/2-25, viewCRMButton.frame.origin.y+viewCRMButton.frame.size.height+self.view.frame.size.height*0.01, 45, self.view.frame.size.height*0.08); //height: self.view.frame.size.height*0.178

        }
        
    }
    else
    {
        if([isAdmin isEqualToString:@"0"] )
        {
            logoutButton.frame      =CGRectMake(self.view.frame.size.width, currentLocationButton.frame.origin.y+currentLocationButton.frame.size.height, 30, self.view.frame.size.height*0.06); //height: self.view.frame.size.height*0.178

        }
        else
        {
            logoutButton.frame      =CGRectMake(self.view.frame.size.width/2-20, viewCRMButton.frame.origin.y+viewCRMButton.frame.size.height+self.view.frame.size.height*0.01, 35, self.view.frame.size.height*0.07); //height: self.view.frame.size.height*0.178
        }
        
    }

    [logoutButton setImage:[UIImage imageNamed:@"roundRedButton.png"] forState:UIControlStateNormal];


    [logoutButton setTitle:@"" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];


}



-(void)pushButtonPress:(UIButton *)sender
{

    PushNotificationsViewController *prio=[[[PushNotificationsViewController alloc] init] autorelease];
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    [self.navigationController pushViewController:prio animated:YES];
    

}


-(void)globalPressed:(UIButton *)sender
{
    if([isAdmin isEqualToString:@"0"] )
    {
        GlobalMapViewController *prio=[[[GlobalMapViewController alloc] init] autorelease];
        CATransition *transition =[CATransition animation];
        transition.duration =kAnimationDuration;
        transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type =@"cube";
        transition.subtype=kCATransitionFromRight;
        transition.delegate=self;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        
        
        [self.navigationController pushViewController:prio animated:YES];
    }
    else
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

}

-(void)currentLocationpressed
{
    CurrentLocationViewController *prio=[[[CurrentLocationViewController alloc] init] autorelease];
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    [self.navigationController pushViewController:prio animated:YES];
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


-(void)sendFeedback:(UIButton *)sender
{
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Set the subject of email
    [picker setSubject:@"Brochure"];
    
    // Fill out the email body text
    //    NSString *emailBody = @"I just took this picture, check it out.";
    NSArray *toRecipients = [NSArray arrayWithObjects:@"app@cochrane.co",nil];
    
    [picker setToRecipients:toRecipients];    [picker setSubject:@"Cochrane+ Feedback"];
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



#pragma mark
#pragma mark Number Of Days
-(void)calculateNumberOfDays
{
    NSCalendar          *calendar       =[NSCalendar currentCalendar];
    
    NSDate              *currentDate    = [NSDate date];
    NSUInteger          componentFlags  = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents    *components     = [[NSCalendar currentCalendar] components:componentFlags fromDate:currentDate];
    
    NSInteger year          = [components year]; //year from current date
    
    
    NSDateComponents    *comp =[[NSDateComponents alloc] init];
    [comp setYear:year];
    [comp setMonth:12];
    [comp setDay:31];
    
    NSDate *endYearDate=[calendar dateFromComponents:comp];
    [comp release];
    unsigned flags = NSDayCalendarUnit;
    NSDateComponents *difference =[[NSCalendar currentCalendar] components:flags fromDate:currentDate toDate:endYearDate options:0];
    int daydiff=(int)[difference day];
    
    numberOfDays =daydiff+1;
    
}



#pragma mark
#pragma mark BottomView Delegate Methods
-(void)actionOnSlideUpButton
{
    if(bottomIsUp==NO)
    {
        bottomIsUp=YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
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



-(void)prioritiesView
{
    PrioritiesViewController *prio=[[[PrioritiesViewController alloc] init] autorelease];
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    [self.navigationController pushViewController:prio animated:YES];
}


-(void)inboxView

{
    NSLog(@"inbox1");
    SeeMessageViewController     *record         =[[[SeeMessageViewController alloc] init] autorelease];
    CATransition            *transition     =[CATransition animation];
    transition.duration                     =kAnimationDuration;
    transition.timingFunction               =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type                         =@"cube";
    transition.subtype                      =kCATransitionFromRight;
    transition.delegate                     =self;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:record animated:YES];
    
}


//{
  //  NSLog(@"inbox2");
   // AdminInboxViewController *inbox =[[[AdminInboxViewController alloc] init] autorelease];
    //CATransition *transition =[CATransition animation];
    //transition.duration =kAnimationDuration;
    //transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //transition.type =@"cube";
    //transition.subtype=kCATransitionFromRight;
    //transition.delegate=self;
    //[self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    //[self.navigationController pushViewController:inbox animated:YES];

//}


-(void)recordView
{
    RecordViewController *record= [[[RecordViewController alloc] init] autorelease];
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:record animated:YES];
}


-(void)brochureView
{
    BrochuresViewController *brochure =[[[BrochuresViewController alloc] init] autorelease];
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:brochure animated:YES];
    
}


-(void)scanBussiness
{
    ScanBussinessViewController *scan =[[[ScanBussinessViewController alloc] init] autorelease];
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:scan animated:YES];
}





#pragma mark
#pragma mark UIButton's Actions
-(void)selectSalesman:(UIButton *)sender
{

    SelectSalesmanViewController *vc=[[[SelectSalesmanViewController alloc] init] autorelease];
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)logoutPressed:(UIButton *)sender
{
    if(![isAdmin isEqualToString:@"0"] )
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
        [dateFormatter release];

    }

    
        ASIFormDataRequest *request2 =[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@availability.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/availability.php"]];
        [request2 setPostValue:@"0" forKey:@"available"];
        [request2 setPostValue:loginID forKey:@"user"];
        
        
        [request2 setCompletionBlock:^{
            
        }];
        
        [request2 setFailedBlock:^{
        }];
        [request2 startAsynchronous];
        
        
        //analyze
    
    CATransition *transition    =[CATransition animation];
    transition.duration         =kAnimationDuration;
    transition.timingFunction   =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type             =@"cube";
    transition.subtype          =kCATransitionFromLeft;
    transition.delegate         =self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
