//
//  PushNotificationsViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/9/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "PushNotificationsViewController.h"

@interface PushNotificationsViewController ()

@end

@implementation PushNotificationsViewController

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
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"background.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"background_normal.png"];
    }
    
    [self.view addSubview:background];
    
    textField =[[UITextView alloc] initWithFrame:CGRectMake(0.07*[UIScreen mainScreen].bounds.size.width, 0.20*[UIScreen mainScreen].bounds.size.height, 0.84*[UIScreen mainScreen].bounds.size.width, 0.27*[UIScreen mainScreen].bounds.size.height)];
    textField.layer.cornerRadius=5.0;
    textField.layer.masksToBounds=YES;
//#ifdef DEBUG
//    textField.layer.borderColor=[UIColor blackColor].CGColor;
//    textField.layer.borderWidth=2;
//#endif
    textField.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:textField];
    
    
    sendPushes =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendPushes.frame=CGRectMake(self.view.frame.size.width/2-100, textField.frame.size.height+textField.frame.origin.y, 200, 50);
    [sendPushes setTitle:@"Send Message" forState:UIControlStateNormal];
    [sendPushes addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendPushes];


    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    
    singleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutsideTextfield:)];
    [self.view addGestureRecognizer:singleTap];
    [singleTap release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];


}


-(void)send:(UIButton *)sender
{
    ASIFormDataRequest *requestDevice =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sendPushesFromiOS.php",SERVER]]];// @"http://www.x-2.info/SalesApp_php/sendPushesFromiOS.php"]];
    
    [requestDevice setPostValue:textField.text forKey:@"text"];
    
    [requestDevice setCompletionBlock:^{
        
    }];
    
    
    [requestDevice setFailedBlock:^{
    }];
    [requestDevice startAsynchronous];
    

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


#pragma mark
#pragma mark Dismiss Keyboard

-(void)tapOutsideTextfield:(UITapGestureRecognizer *)recognizer
{
    CGPoint location =[recognizer locationInView:[recognizer.view superview]];
    
    if(CGRectContainsPoint(self.view.frame, location) && ( !CGRectContainsPoint(textField.frame, location)))
    {
        if([textField isFirstResponder])
        {
            
            [textField resignFirstResponder];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationDelay:0.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            
            [self.view setFrame:CGRectMake(0,0,320,460)];
            
            [UIView commitAnimations];
            
        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
