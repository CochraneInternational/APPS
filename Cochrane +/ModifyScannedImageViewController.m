//
//  ModifyScannedImageViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/10/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "ModifyScannedImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ModifyScannedImageViewController ()

@end

@implementation ModifyScannedImageViewController
//@synthesize frameView;


-(id)init
{
    if(self=[super init])
    {
        self.cropSize = CGSizeMake(240, 320);
        self.minimumScale = 0.2;
        self.maximumScale = 10;
          }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor blackColor];
   
 
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    
    saveButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(savePressed:) forControlEvents:UIControlEventTouchUpInside];
    saveButton.frame=CGRectMake((self.view.frame.size.width-backButton.frame.size.width)/2-50, 0, 100, 80);
    [self.view addSubview:saveButton];
   //    [self.view addSubview: self.frameView];

    
//    UIImageView *img =[[UIImageView alloc] initWithImage:self.sourceImage];
//    img.frame=CGRectMake(0, backButton.frame.origin.y+backButton.frame.size.height+20, self.view.frame.size.width, 400);
//    [self.view addSubview:img];
	// Do any additional setup after loading the view.
}
-(void)savePressed:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveObject" object:nil];
}


- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel"
                                                    message:@"Nowhere to go my friend. This is a demo."
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  }

#pragma mark Hooks
- (void)startTransformHook
{
//    self.saveButton.tintColor = [UIColor colorWithRed:0 green:49/255.0f blue:98/255.0f alpha:1];
}

- (void)endTransformHook
{
//    self.saveButton.tintColor = [UIColor colorWithRed:0 green:128/255.0f blue:1 alpha:1];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
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
