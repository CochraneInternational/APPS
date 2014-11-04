//
//  SelectedSalesmanViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/21/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "SelectedSalesmanViewController.h"
#define kAnimationDuration 1.0

@interface SelectedSalesmanViewController ()

@end

@implementation SelectedSalesmanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"background.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"background_normal.png"];
    }    [self.view addSubview:background];
    
    upView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    upView.image=[UIImage imageNamed:@"ADMIN_pageSelectedSalesman.png"];
//    upView.layer.borderColor=[UIColor blackColor].CGColor;
//    upView.layer.borderWidth=2;
    [self.view addSubview:upView];
    
    
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
//    backButton.layer.borderColor=[UIColor blackColor].CGColor;
//    backButton.layer.borderWidth=3;
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    navTitle                        =[[UILabel alloc] init];
//    navTitle.frame                  =CGRectMake(self.view.frame.size.width/2-100, 0, 200, 40);
    navTitle.frame                  =CGRectMake(self.view.frame.size.width/2-[UIScreen mainScreen].bounds.size.width*0.31, 0, 0.62*[UIScreen mainScreen].bounds.size.width, 0.07*[UIScreen mainScreen].bounds.size.height);
//    navTitle.layer.borderWidth      =2;
//    navTitle.layer.borderColor      =[UIColor blackColor].CGColor;
    navTitle.backgroundColor        =[UIColor clearColor];
    navTitle.textAlignment          = NSTextAlignmentCenter;
    navTitle.text                   =[NSString stringWithFormat:@"SALESMAN %i",salesman_row_selected];
    navTitle.font                   =[UIFont fontWithName:@"ArialMT" size:18];
    navTitle.textColor              =[UIColor whiteColor];
    [self.view addSubview:navTitle];
    
    middle =[[UIImageView alloc] init];
    [middle setImage:[UIImage imageNamed:@"ADMIN_selectedSalesman_middle.png"]];
    middle.frame=CGRectMake(0, backButton.frame.origin.y+backButton.frame.size.height+0.07*[UIScreen mainScreen].bounds.size.height, self.view.frame.size.width, self.view.frame.size.height/2);
    [self.view addSubview:middle];
    
    
    meetingsButton =[UIButton buttonWithType:UIButtonTypeCustom];
    meetingsButton.frame=CGRectMake(0, backButton.frame.origin.y+backButton.frame.size.height+0.07*[UIScreen mainScreen].bounds.size.height, self.view.frame.size.width, 0.0802*[UIScreen mainScreen].bounds.size.height);
//    meetingsButton.layer.borderColor=[UIColor blackColor].CGColor;
//    meetingsButton.layer.borderWidth=2;
    meetingsButton.tag=1000;
    [meetingsButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:meetingsButton];
   
    
    
    timeAttendanceButton =[UIButton buttonWithType:UIButtonTypeCustom];
    timeAttendanceButton.frame=CGRectMake(0, meetingsButton.frame.origin.y+meetingsButton.frame.size.height+2, self.view.frame.size.width, 0.0802*[UIScreen mainScreen].bounds.size.height);
//    timeAttendanceButton.layer.borderColor=[UIColor blackColor].CGColor;
//    timeAttendanceButton.layer.borderWidth=2;
    timeAttendanceButton.tag=1001;
    [timeAttendanceButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeAttendanceButton];
    
    
    
    priceEstimateButton =[UIButton buttonWithType:UIButtonTypeCustom];
    priceEstimateButton.frame=CGRectMake(0, timeAttendanceButton.frame.origin.y+timeAttendanceButton.frame.size.height+2, self.view.frame.size.width, 0.0802*[UIScreen mainScreen].bounds.size.height);
//    priceEstimateButton.layer.borderColor=[UIColor blackColor].CGColor;
//    priceEstimateButton.layer.borderWidth=2;
    priceEstimateButton.tag=1002;
    [priceEstimateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:priceEstimateButton];
    
    
    
    salesButton =[UIButton buttonWithType:UIButtonTypeCustom];
    salesButton.frame=CGRectMake(0, priceEstimateButton.frame.origin.y+priceEstimateButton.frame.size.height+2, self.view.frame.size.width, 0.0802*[UIScreen mainScreen].bounds.size.height);
//    salesButton.layer.borderColor=[UIColor blackColor].CGColor;
//    salesButton.layer.borderWidth=2;
    salesButton.tag=1003;
    [salesButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:salesButton];
    
    
    
    trackingHistoryButton =[UIButton buttonWithType:UIButtonTypeCustom];
    trackingHistoryButton.frame=CGRectMake(0, salesButton.frame.origin.y+salesButton.frame.size.height+2, self.view.frame.size.width, 0.0802*[UIScreen mainScreen].bounds.size.height);
//    trackingHistoryButton.layer.borderColor=[UIColor blackColor].CGColor;
//    trackingHistoryButton.layer.borderWidth=2;
    trackingHistoryButton.tag=1004;
    [trackingHistoryButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:trackingHistoryButton];
    
    
    
    sendMessageButton =[UIButton buttonWithType:UIButtonTypeCustom];
    sendMessageButton.frame=CGRectMake(0, trackingHistoryButton.frame.origin.y+trackingHistoryButton.frame.size.height+2, self.view.frame.size.width, 0.0802*[UIScreen mainScreen].bounds.size.height);
//    sendMessageButton.layer.borderColor=[UIColor blackColor].CGColor;
//    sendMessageButton.layer.borderWidth=2;
    sendMessageButton.tag=1005;
    [sendMessageButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessageButton];

    


	// Do any additional setup after loading the view.
}

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

-(void)buttonPressed:(UIButton *)sender
{
    switch (sender.tag)
    {
            //meetings
        case 1000:
            break;
            
            //time & attendance
        case 1001:
            break;
            
            //price estimate
        case 1002:
            break;
            
            //sales
        case 1003:
            break;
            
            //tracking history
        case 1004:
            break;
            
            //send message
        case 1005:
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
