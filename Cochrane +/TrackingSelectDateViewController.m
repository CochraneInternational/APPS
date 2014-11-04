//
//  TrackingSelectDateViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/23/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "TrackingSelectDateViewController.h"

@interface TrackingSelectDateViewController ()

@end

@implementation TrackingSelectDateViewController
@synthesize calendarView;


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



#pragma mark
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [background setImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:background];
    
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    
    upView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    upView.image=[UIImage imageNamed:@"ADMIN_pageSelectedSalesman.png"];
    //    upView.layer.borderColor=[UIColor blackColor].CGColor;
    //    upView.layer.borderWidth=2;
    [self.view addSubview:upView];
    
    
    navTitle                        =[[UILabel alloc] init];
    //    navTitle.frame                  =CGRectMake(self.view.frame.size.width/2-100, 0, 200, 40);
    navTitle.frame                  =CGRectMake(self.view.frame.size.width/2-[UIScreen mainScreen].bounds.size.width*0.31, 0, 0.62*[UIScreen mainScreen].bounds.size.width, 0.07*[UIScreen mainScreen].bounds.size.height);
    //    navTitle.layer.borderWidth      =2;
    //    navTitle.layer.borderColor      =[UIColor blackColor].CGColor;
    navTitle.backgroundColor        =[UIColor clearColor];
    navTitle.textAlignment          = NSTextAlignmentCenter;
    navTitle.text                   =@"Tracking Date Selection";
    navTitle.font                   =[UIFont fontWithName:@"ArialMT" size:18];
    navTitle.textColor              =[UIColor whiteColor];
    [self.view addSubview:navTitle];
    
    
    self.calendarView = [[[CXCalendarView alloc] initWithFrame:CGRectMake(0, backButton.frame.size.height+backButton.frame.origin.y+20,self.view.frame.size.width, self.view.frame.size.height-backButton.frame.size.height-30) ]autorelease];// self.view.bounds] autorelease];
    [self.view addSubview: self.calendarView];
    //    self.calendarView.frame = self.view.bounds;
    self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.calendarView.selectedDate = [NSDate date];
    
    self.calendarView.delegate = self;
    
	// Do any additional setup after loading the view.
}


#pragma mark
#pragma mark UIButton's Actions

-(void)backButtonPressed:(UIButton *)sender
{
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromLeft;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark CXCalendarViewDelegate

- (void) calendarView: (CXCalendarView *) calendarView
        didSelectDate: (NSDate *) date
{
    
    selectedDate=[NSString stringWithFormat:@"%@",date] ;
    
    
    int daysToAdd = 1;
    NSDate *newDate1 = [date dateByAddingTimeInterval:60*60*24*daysToAdd];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"yyyy-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    

    NSLog(@"\n\n userID: %@",self.userID);
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_SalesmanRoute.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/get_SalesmanRoute.php"]];
    
    [request setPostValue:self.userID forKey:@"userID"];
    NSLog(@"\n\n ---- : %@",[dateFormatter stringFromDate:date]);
    [request setPostValue:[dateFormatter stringFromDate:date] forKey:@"date"];

    [request setCompletionBlock:^{
        
        NSLog(@"tracking response: ==%@==",request.responseString);
//        if([trackingStringResponse isEqualToString:@"@end"])
//        {
//            
//        }
        
        trackingStringResponse=request.responseString;
        [self allOkShowMap];
    }];
    
    
    [request setFailedBlock:^{
        NSLog(@"failed  -> %@",request.responseStatusMessage);
    }];
    [request startAsynchronous];
    [dateFormatter release];

    /*TTAlert([NSString stringWithFormat: @"Selected date: %@", date]);*/
}


-(void)allOkShowMap
{
    
    if ([trackingStringResponse isEqualToString:@"Error 2: no entries found"] || [trackingStringResponse isEqualToString:@"@end\n"])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"There is no tracking history for this day"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else
    {
        
        pctsArray=[[NSMutableArray alloc] init];
        NSArray *arr =[trackingStringResponse componentsSeparatedByString:@"@end"];
        for(int i=0;i<[arr count];i++)
        {
            
            NSString    *value=[arr objectAtIndex:i];
            if([value length]>2)
            {
                NSMutableArray     *valueArr=[value componentsSeparatedByString:@"\n"];
                [valueArr removeLastObject];
                [pctsArray addObject:valueArr];
            }
            
        }
        
        NSLog(@"pcts array : %@",pctsArray);
        
        SeeRouteSalesmanViewController *stats =[[[SeeRouteSalesmanViewController alloc] init] autorelease];
        CATransition *transition =[CATransition animation];
        transition.duration =kAnimationDuration;
        transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type =@"cube";
        transition.subtype=kCATransitionFromRight;
        transition.delegate=self;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:stats animated:YES];
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
