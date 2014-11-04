//
//  OverviewSalesmanViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/15/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "OverviewSalesmanViewController.h"
#import "PopupViewController.h"
#import "UIViewController+MJPopupViewController.h"
//#import "MJDetailViewController.h"

#define kPopupModalAnimationDuration 0.35
#define kMJPopupViewController @"kMJPopupViewController"
#define kMJPopupBackgroundView @"kMJPopupBackgroundView"
#define kMJSourceViewTag 23941
#define kMJPopupViewTag 23942
#define kMJOverlayViewTag 23945
@interface OverviewSalesmanViewController ()

@end

@implementation OverviewSalesmanViewController

@synthesize name;
@synthesize salesmanTag;

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
    top.image=[UIImage imageNamed:@"ADMIN_pageSelectedSalesman.png"];
#ifdef DEBUG
//    top.layer.borderColor=[UIColor blackColor].CGColor;
//    top.layer.borderWidth=2;
#endif
    [self.view addSubview:top];
    
    
    salesmanName =[[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.view.frame.size.width-70, 36)];
    salesmanName.text=name;
    salesmanName.font=[UIFont fontWithName:@"ArialMT" size:18 ];
    salesmanName.textColor=[UIColor whiteColor];
    salesmanName.textAlignment=NSTextAlignmentCenter;
    salesmanName.backgroundColor=[UIColor clearColor];
//#ifdef DEBUG
//    salesmanName.layer.borderColor=[UIColor blackColor].CGColor;
//    salesmanName.layer.borderWidth=2;
//#endif
    [self.view addSubview:salesmanName];
    
    
    viewStatsButton =[UIButton buttonWithType:UIButtonTypeCustom];
    viewStatsButton.frame=CGRectMake(0, self.view.frame.size.height/3, self.view.frame.size.width, 50);
    [viewStatsButton setImage:[UIImage imageNamed:@"overviewSalesman.png"] forState:UIControlStateNormal];
    [viewStatsButton addTarget:self action:@selector(viewStatsPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:viewStatsButton];
    
    trackingHistoryButton =[UIButton buttonWithType:UIButtonTypeCustom];
    trackingHistoryButton.frame=CGRectMake(0, viewStatsButton.frame.size.height+viewStatsButton.frame.origin.y+5, self.view.frame.size.width, 50);
    [trackingHistoryButton setImage:[UIImage imageNamed:@"overviewSalesman3.png"] forState:UIControlStateNormal];
    [trackingHistoryButton addTarget:self action:@selector(trackingPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:trackingHistoryButton];
    
    
    sendMessageButton =[UIButton buttonWithType:UIButtonTypeCustom];
    sendMessageButton.frame=CGRectMake(0, trackingHistoryButton.frame.size.height+trackingHistoryButton.frame.origin.y+5, self.view.frame.size.width, 50);
    [sendMessageButton setImage:[UIImage imageNamed:@"overviewSalesman2.png"] forState:UIControlStateNormal];
    [sendMessageButton addTarget:self action:@selector(sendMessagePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessageButton];
    [self.view setContentMode:UIViewContentModeScaleAspectFill];
    
}

-(void)downloadSuccedeed:(NSString *)path
{
    
    NSMutableString *mutString  =[[NSMutableString alloc] initWithString:path];
    NSMutableString *md         =[[NSMutableString alloc] initWithContentsOfFile:mutString encoding:NSUTF8StringEncoding error:nil];
    NSLog(@" --> %@",md);
    [mutString release];
    NSArray         *components =[md componentsSeparatedByString:@"\n"];
    [md release];
    pctsArray =[[NSMutableArray alloc] init];
    
    
    
    for(int i=0;i<[components count]-1;i++)
    {
        NSString *component =[components objectAtIndex:i];
        NSArray  *componentArray=[component componentsSeparatedByString:@"^^"];
        [pctsArray addObject:componentArray];
    }
    
    
    
    SeeRouteSalesmanViewController *details =[[[SeeRouteSalesmanViewController alloc] init] autorelease];
    
    
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    [self.navigationController pushViewController:details animated:YES];
    
    
    //    [components removeLastObject];
}

#pragma mark
#pragma mark UIButton's Actions
-(void)viewStatsPressed:(UIButton *)sender
{
    
    StatsResultsViewController *stats =[[[StatsResultsViewController alloc] init] autorelease];
    stats.userID= salesmanTag ;
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:stats animated:YES];
    

}

-(void)trackingPressed:(UIButton *)sender
{
    NSLog(@"salesmanTag");
    
    TrackingSelectDateViewController *track =[[[TrackingSelectDateViewController alloc] init] autorelease];
    track.userID= salesmanTag ;
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:track animated:YES];

    

}

-(void)sendMessagePressed:(UIButton *)sender
{
     PopupViewController *detailViewController = [[[PopupViewController alloc] init] autorelease];
    detailViewController.userID=salesmanTag;
    [self presentPopupViewController:detailViewController animationType:1];
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
