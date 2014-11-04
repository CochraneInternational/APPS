//
//  StatsResultsViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/17/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "StatsResultsViewController.h"

@interface StatsResultsViewController ()

@end

@implementation StatsResultsViewController

@synthesize userID;

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
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [background setImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:background];
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    top =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 36)];
    top.image=[UIImage imageNamed:@"statsResultsTop.png"];
#ifdef DEBUG
    //    top.layer.borderColor=[UIColor blackColor].CGColor;
    //    top.layer.borderWidth=2;
#endif
    [self.view addSubview:top];
    
    dailyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    dailyBtn.frame=CGRectMake(0, backButton.frame.size.height+backButton.frame.origin.y+self.view.frame.size.height/10, self.view.frame.size.width, 50);
    [dailyBtn setImage:[UIImage imageNamed:@"dailyResultsBtn.png"] forState:UIControlStateNormal];
    dailyBtn.tag=111;
    [dailyBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dailyBtn];
    
    
    weeklyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    weeklyBtn.frame=CGRectMake(0, dailyBtn.frame.size.height+dailyBtn.frame.origin.y+5, self.view.frame.size.width, 50);
    [weeklyBtn setImage:[UIImage imageNamed:@"weeklyResultsBtn.png"] forState:UIControlStateNormal];
    weeklyBtn.tag=112;
    [weeklyBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weeklyBtn];
    
    monthlyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    monthlyBtn.frame=CGRectMake(0, weeklyBtn.frame.size.height+weeklyBtn.frame.origin.y+5, self.view.frame.size.width, 50);
    [monthlyBtn setImage:[UIImage imageNamed:@"monthlyResultsBtn.png"] forState:UIControlStateNormal];
    monthlyBtn.tag=113;
    [monthlyBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:monthlyBtn];
    
    quarterlyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    quarterlyBtn.frame=CGRectMake(0, monthlyBtn.frame.size.height+monthlyBtn.frame.origin.y+5, self.view.frame.size.width, 50);
    [quarterlyBtn setImage:[UIImage imageNamed:@"quarterlyResultsBtn.png"] forState:UIControlStateNormal];
    quarterlyBtn.tag=114;
    [quarterlyBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quarterlyBtn];
    
    

	// Do any additional setup after loading the view.
}



#pragma mark
#pragma mark UIButton's Actions

-(void)btnPressed:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 111:
        {
            DailyResultsViewController *daily=[[[DailyResultsViewController alloc] init] autorelease];
            daily.userid=userID;
            CATransition *transition =[CATransition animation];
            transition.duration =kAnimationDuration;
            transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type =@"cube";
            transition.subtype=kCATransitionFromRight;
            transition.delegate=self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController pushViewController:daily animated:YES];
        }
            break;
            
        case 112:
        {
            WeeklyResultsViewController *weekly=[[[WeeklyResultsViewController alloc] init] autorelease];
            weekly.userid=userID;
            CATransition *transition =[CATransition animation];
            transition.duration =kAnimationDuration;
            transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type =@"cube";
            transition.subtype=kCATransitionFromRight;
            transition.delegate=self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController pushViewController:weekly animated:YES];

        }
            break;
            
        case 113:
        {
            MonthlyResultsViewController *month=[[[MonthlyResultsViewController alloc] init] autorelease];
            month.userid=userID;
            CATransition *transition =[CATransition animation];
            transition.duration =kAnimationDuration;
            transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type =@"cube";
            transition.subtype=kCATransitionFromRight;
            transition.delegate=self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController pushViewController:month animated:YES];

        }
            break;
            
        case 114:
        {
            QuarterlyViewController *month=[[[QuarterlyViewController alloc] init] autorelease];
            month.userid=userID;
            CATransition *transition =[CATransition animation];
            transition.duration =kAnimationDuration;
            transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type =@"cube";
            transition.subtype=kCATransitionFromRight;
            transition.delegate=self;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            [self.navigationController pushViewController:month animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    

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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
