//
//  SeeMessageViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/29/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "SeeMessageViewController.h"

@interface SeeMessageViewController ()

@end

@implementation SeeMessageViewController

@synthesize text;
@synthesize sender;
@synthesize index;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
         }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if(IS_IPHONE_5)
    {
        [background setImage:[UIImage imageNamed:@"viewMessageBackground_iPhone5.png"]];
    }
    else
    {
        [background setImage:[UIImage imageNamed:@"viewMessageBackground_iPhone4.png"]];
    }
    [self.view addSubview:background];
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    replyToSender =[UIButton buttonWithType:UIButtonTypeCustom];
    replyToSender.frame=CGRectMake(self.view.frame.size.width-self.view.frame.size.width/5, backButton.frame.origin.y,self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [replyToSender setImage:[UIImage imageNamed:@"replyToMessageButton.png"] forState:UIControlStateNormal];
    [replyToSender addTarget:self action:@selector(replyPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:replyToSender];

    
    
    message                     =[[UITextView alloc] initWithFrame:CGRectMake(10, backButton.frame.size.height+backButton.frame.origin.y+10, self.view.frame.size.width-20, 300)];
    message.text                =text;
    message.editable            =NO;
    message.dataDetectorTypes   = UIDataDetectorTypeAll;
    
    [[message layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[message layer] setBackgroundColor:[[UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0]  CGColor]];
    [[message layer] setBorderWidth:0.5];
    [[message layer] setCornerRadius:5];

    message.font =[UIFont fontWithName:@"Courier" size:18.0];
    

    [self.view addSubview:message];
    
    NSMutableArray* messages =[[NSMutableArray alloc] init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"])
    {
        for(int i=0;i<[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] count];i++)
        {
            if(i==index)
            {
                NSMutableArray*dict= [[NSMutableArray alloc] init];
                [dict addObject:@"read"];
                [dict addObject:[[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] objectAtIndex:i] objectAtIndex:1] ];
                [messages addObject:dict];
                [dict release];

            }
            else
                [messages addObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] objectAtIndex:i]];
        }
        
    }
    

    [[NSUserDefaults standardUserDefaults] setObject:messages forKey:@"inboxMessages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [messages release];
    // Custom initialization

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

-(void)replyPressed:(UIButton *)btnSender
{
    
    PopupViewController *detailViewController = [[[PopupViewController alloc] init] autorelease];
    detailViewController.userID=sender;
    [self presentPopupViewController:detailViewController animationType:1];


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
