//
//  PopupViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/24/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "PopupViewController.h"

@interface PopupViewController ()

@end

@implementation PopupViewController

@synthesize userID;
@synthesize textView;
@synthesize sendMessage;

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
    [self.view setAutoresizesSubviews:YES];
    [self.view setClearsContextBeforeDrawing:YES];
    [self.view setBackgroundColor:[UIColor clearColor]];
    self.view.frame = CGRectMake(0, 0, 260, 260);
    self.view.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view setOpaque:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    textView=[[UITextView alloc] initWithFrame:CGRectMake(20, 20, 220, 148)];
    textView.layer.cornerRadius =8;
    textView.layer.masksToBounds=YES;
    textView.text               =@"";
    textView.font               =[UIFont fontWithName:@"Arial-BoldMT" size:16.0];
    [self.view addSubview:textView];
    [textView becomeFirstResponder];
    
    
    sendMessage =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendMessage.frame=CGRectMake(72, 197, 116, 44);
    sendMessage.titleLabel.textColor=[UIColor blackColor];
    [sendMessage setTitle:@"Send Message" forState:UIControlStateNormal];
    [sendMessage addTarget:self action:@selector(sendMessagePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessage];
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}


-(void)sendMessagePressed:(id)sender
{
    ASIFormDataRequest *requestDevice =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sendPushesFromiOS.php",SERVER]]]; // @"http://www.x-2.info/SalesApp_php/sendPushesFromiOS.php"]];
    
    [requestDevice setPostValue:textView.text forKey:@"text"];
    [requestDevice setPostValue:userID forKey:@"userID"];
    [requestDevice setPostValue:loginID forKey:@"sender"];
    [requestDevice setPostValue:[parsedString objectAtIndex:0] forKey:@"senderName"];
    
    NSLog(@"PUSH - To: %@", userID);
    NSLog(@"PUSH - From: %@",loginID);
    NSLog(@"PUSH - Name: %@", [parsedString objectAtIndex:0]);
    NSLog(@"PUSH - Msg: %@", textView.text);
    
    [requestDevice setCompletionBlock:^{
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"messageSent" object:nil];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success!" message:@"Message was sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }];
    
    
    [requestDevice setFailedBlock:^{
    }];
    [requestDevice startAsynchronous];
}

#pragma mark
#pragma mark Move View Up
- (void)keyboardDidShow:(NSNotification *)notification
{
    
    messageKeyboardIsUp=YES;

    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    messageKeyboardIsUp=NO;
    [textView resignFirstResponder];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
