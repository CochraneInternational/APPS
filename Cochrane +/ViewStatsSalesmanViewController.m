//
//  ViewStatsSalesmanViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 8/2/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "ViewStatsSalesmanViewController.h"

@interface ViewStatsSalesmanViewController ()

@end

@implementation ViewStatsSalesmanViewController

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
    
    self.view.backgroundColor   =[UIColor whiteColor];
    
    background                  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"viewStatsBackground_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"viewStatsBackground_iPhone4.png"];
    }

    [self.view addSubview:background];
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    

    
    
    daily        =[UIButton buttonWithType:UIButtonTypeCustom];
    daily.frame  =CGRectMake(0, 0.27*[UIScreen mainScreen].bounds.size.height, self.view.frame.size.width, self.view.frame.size.height*0.1);
    daily.showsTouchWhenHighlighted=YES;
    daily.tag=401;
    [daily setImage:[UIImage imageNamed:@"dailyResultsButton.png"] forState:UIControlStateNormal];
    [daily addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    daily.showsTouchWhenHighlighted=YES;
    [self.view addSubview:daily];
    
    
    
    weekly      =[UIButton buttonWithType:UIButtonTypeCustom];
    weekly.frame=CGRectMake(0, daily.frame.origin.y+daily.frame.size.height+self.view.frame.size.height*0.007, self.view.frame.size.width, self.view.frame.size.height*0.1);//meetings.frame.origin.y+meetings.frame.size.height+4
    weekly.showsTouchWhenHighlighted=YES;
    weekly.tag=402;
    [weekly setImage:[UIImage imageNamed:@"weeklyResultsButton.png"] forState:UIControlStateNormal];
    [weekly addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    weekly.showsTouchWhenHighlighted=YES;
    [self.view addSubview:weekly];
    
    
    
    monthly       =[UIButton buttonWithType:UIButtonTypeCustom];
    monthly.frame =CGRectMake(0, weekly.frame.origin.y+weekly.frame.size.height+self.view.frame.size.height*0.007, self.view.frame.size.width, self.view.frame.size.height*0.1);
    monthly.showsTouchWhenHighlighted=YES;
    monthly.tag=403;
    [monthly setImage:[UIImage imageNamed:@"monthlyResultsButton.png"] forState:UIControlStateNormal];
    [monthly addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    monthly.showsTouchWhenHighlighted=YES;
    [self.view addSubview:monthly];
    
    
    
    quarterly       =[UIButton buttonWithType:UIButtonTypeCustom];
    quarterly.frame =CGRectMake(0, monthly.frame.origin.y+monthly.frame.size.height+self.view.frame.size.height*0.007, self.view.frame.size.width, self.view.frame.size.height*0.1);
    quarterly.showsTouchWhenHighlighted=YES;
    quarterly.tag=404;
    [quarterly setImage:[UIImage imageNamed:@"quarterlyResultsButton.png"] forState:UIControlStateNormal];
    [quarterly addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    quarterly.showsTouchWhenHighlighted=YES;
    [self.view addSubview:quarterly];
//
	// Do any additional setup after loading the view.
}





-(void)backButtonPressed:(UIButton *)sender
{
    
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
#pragma mark Logout

-(void)btnPressed:(UIButton *)sender
{

    switch (sender.tag)
    {
        case 401:
        {
            DailyResultsViewController *dailyvc=[[[DailyResultsViewController alloc] init] autorelease];
            dailyvc.userid=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserID"];
            CATransition *transition =[CATransition animation];
            transition.duration =kAnimationDuration;
            transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type =@"cube";
            transition.subtype=kCATransitionFromRight;
            transition.delegate=self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController pushViewController:dailyvc animated:YES];
        }
            break;
            
        case 402:
        {
            WeeklyResultsViewController *weeklyvc=[[[WeeklyResultsViewController alloc] init] autorelease];
            weeklyvc.userid=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserID"];
            CATransition *transition =[CATransition animation];
            transition.duration =kAnimationDuration;
            transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type =@"cube";
            transition.subtype=kCATransitionFromRight;
            transition.delegate=self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController pushViewController:weeklyvc animated:YES];
            
        }
            break;
            
        case 403:
        {
            MonthlyResultsViewController *monthvc=[[[MonthlyResultsViewController alloc] init] autorelease];
            monthvc.userid=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserID"];
            CATransition *transition =[CATransition animation];
            transition.duration =kAnimationDuration;
            transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type =@"cube";
            transition.subtype=kCATransitionFromRight;
            transition.delegate=self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController pushViewController:monthvc animated:YES];
            
        }
            break;
            
        case 404:
        {
            QuarterlyViewController *monthvc=[[[QuarterlyViewController alloc] init] autorelease];
            monthvc.userid=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserID"];
            CATransition *transition =[CATransition animation];
            transition.duration =kAnimationDuration;
            transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type =@"cube";
            transition.subtype=kCATransitionFromRight;
            transition.delegate=self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController pushViewController:monthvc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
//    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
