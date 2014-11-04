//
//  ResultsViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/3/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "ResultsViewController.h"
#define kAnimationDuration 1.0

@interface ResultsViewController ()

@end

@implementation ResultsViewController

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
    
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"woohoo.jpg"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"woohoo.png"];
    }    [self.view addSubview:background];
    [background release];
    
    
    upView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    upView.image=[UIImage imageNamed:@"resultsTop.png"];
    [self.view addSubview:upView];
    [upView release];
    
    
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    
    dailyBtn =[UIButton buttonWithType: UIButtonTypeCustom];
    dailyBtn.frame=CGRectMake(0, backButton.frame.origin.y+backButton.frame.size.height+50, self.view.frame.size.width, 60);
    [dailyBtn setImage:[UIImage imageNamed:@"results_dailyResults.png"] forState:UIControlStateNormal];
    [self.view addSubview:dailyBtn];
    
    weeklyBtn=[UIButton buttonWithType: UIButtonTypeCustom];
    weeklyBtn.frame=CGRectMake(0, dailyBtn.frame.origin.y+dailyBtn.frame.size.height, self.view.frame.size.width, dailyBtn.frame.size.height);
    [weeklyBtn setImage:[UIImage imageNamed:@"results_weeklyResults.png"] forState:UIControlStateNormal];
    [self.view addSubview:weeklyBtn];
    
    
    monthlyBtn=[UIButton buttonWithType: UIButtonTypeCustom];
    monthlyBtn.frame=CGRectMake(0, weeklyBtn.frame.origin.y+weeklyBtn.frame.size.height, self.view.frame.size.width, dailyBtn.frame.size.height);
    [monthlyBtn setImage:[UIImage imageNamed:@"results_monthlyResults.png"] forState:UIControlStateNormal];
    [self.view addSubview:monthlyBtn];

    
    quarterlyBtn=[UIButton buttonWithType: UIButtonTypeCustom];
    quarterlyBtn.frame=CGRectMake(0, monthlyBtn.frame.origin.y+monthlyBtn.frame.size.height, self.view.frame.size.width, dailyBtn.frame.size.height);
    [quarterlyBtn setImage:[UIImage imageNamed:@"results_quarterlyResults.png"] forState:UIControlStateNormal];
    [self.view addSubview:quarterlyBtn];

    
     [super viewDidLoad];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
