//
//  BrochureVisualisationViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/11/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "BrochureVisualisationViewController.h"

@interface BrochureVisualisationViewController ()

@end

@implementation BrochureVisualisationViewController
@synthesize     name;
@synthesize     path;

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
    }
    
    [self.view addSubview:background];

    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    //    backButton.layer.borderColor=[UIColor blackColor].CGColor;
    //    backButton.layer.borderWidth=3;
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    
    
      [self presetThings];
 }


-(void)presetThings
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Set the subject of email
    [picker setSubject:@"Picture from my iPhone!"];
    
    // Add email addresses
    // Notice three sections: "to" "cc" and "bcc"
//    [picker setToRecipients:[NSArray arrayWithObjects:@"emailaddress1@domainName.com", @"emailaddress2@domainName.com", nil]];
//    [picker setCcRecipients:[NSArray arrayWithObject:@"emailaddress3@domainName.com"]];
//    [picker setBccRecipients:[NSArray arrayWithObject:@"emailaddress4@domainName.com"]];
    
    // Fill out the email body text
    NSString *emailBody = @"I just took this picture, check it out.";
    
    // This is not an HTML formatted email
    [picker setMessageBody:emailBody isHTML:NO];
    

    NSData *pdfData = [NSData dataWithContentsOfFile:path];
    [picker addAttachmentData:pdfData mimeType:@"application/pdf" fileName:name];
   
    
    [self presentModalViewController:picker animated:YES];
    
    // Release picker
    [picker release];
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

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Called once the email is sent
    // Remove the email view controller
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
