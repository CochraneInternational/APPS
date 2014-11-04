//
//  NewPriorityViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 8/13/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "NewPriorityViewController.h"

@interface NewPriorityViewController ()

@end

@implementation NewPriorityViewController

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
        background.image=[UIImage imageNamed:@"createNewPriority_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"createNewPriority.png"];
    }
    
    [self.view addSubview:background];
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
//    if(IS_IPHONE_5)
//    {
//        [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
//    }
//    else
//    {
        [backButton setImage:[UIImage imageNamed:@"backButton_iPhone4.png"] forState:UIControlStateNormal];
        
//    }
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    
    
    saveButton =[UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame=CGRectMake(self.view.frame.size.width-self.view.frame.size.width/5, backButton.frame.origin.y, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
//    if(IS_IPHONE_5)
//    {
//        [saveButton setImage:[UIImage imageNamed:@"saveButton.png"] forState:UIControlStateNormal];
//    }
//    else
//    {
        [saveButton setImage:[UIImage imageNamed:@"saveButton.png"] forState:UIControlStateNormal];
        
//    }
    [saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    saveButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:saveButton];

    
    
    
    headline =[[UITextField alloc] initWithFrame:CGRectMake(10, backButton.frame.size.height+backButton.frame.origin.y+0.03*self.view.frame.size.height, self.view.frame.size.width-20, 0.065*self.view.frame.size.height)];
    [[headline layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[headline layer] setBackgroundColor:[[UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0] CGColor]];
    [[headline layer] setBorderWidth:0.5];
    [[headline layer] setCornerRadius:5];
    [headline setClipsToBounds:YES];
    [headline setText:@"   HEADLINE"];
    headline.delegate=self;
    [headline setFont:[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:18]];
    [headline setTextColor:[UIColor grayColor]];
    headline.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    [self.view addSubview:headline];
    
    
    notesTextView=[[UITextView alloc] initWithFrame:CGRectMake(10, headline.frame.size.height+headline.frame.origin.y+0.03*self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height/2)];
    [[notesTextView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[notesTextView layer] setBackgroundColor:[[UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0]  CGColor]];
    [[notesTextView layer] setBorderWidth:0.5];
    [[notesTextView layer] setCornerRadius:5];
    [notesTextView setClipsToBounds:YES];
    [notesTextView setText:@" NOTES"];
    notesTextView.delegate=self;
    [notesTextView setTextColor:[UIColor grayColor]];
    [notesTextView setFont:[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:18]];
    [self.view addSubview:notesTextView];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    UITapGestureRecognizer *tap    =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTapped:)];
    [self.view addGestureRecognizer:tap];
    [tap release];
 
}



#pragma mark
#pragma mark Move View Up
- (void)keyboardDidShow:(NSNotification *)notification
{

    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    
}


#pragma mark
#pragma mark UITextView Delegate Mehods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    notesTextView.text=@"   ";
    return YES;
}


#pragma mark
#pragma mark UITextField Delegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    headline.text=@"   ";
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return  YES;
}


#pragma mark
#pragma mark Tapping
-(void)tapTapped:(UITapGestureRecognizer *)tapping
{
    CGPoint pct=[tapping locationInView:self.view];
    
    
    if(CGRectContainsPoint(headline.frame, pct))
    {
    }
    else
        if(CGRectContainsPoint(notesTextView.frame, pct))
        {
        }
        else
        {
            if([headline isFirstResponder])
            {
                [headline resignFirstResponder];
            }
            if([notesTextView isFirstResponder])
            {
                [notesTextView resignFirstResponder];
//                [UIView beginAnimations:nil context:nil];
//                [UIView setAnimationDuration:0.3];
//                [UIView setAnimationDelay:0.0];
//                [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//                
//                [self.view setFrame:CGRectMake(0,0,320,[UIScreen mainScreen].bounds.size.height)];
//                
//                [UIView commitAnimations];
//
            }
        }
}

#pragma mark
#pragma mark UIButton's Actions

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

-(void)saveButtonPressed:(UIButton *)sender
{
    NSMutableArray      *prioritiesArray;
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"]!=NULL)
       prioritiesArray=[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] mutableCopy];
    else
        prioritiesArray=[[NSMutableArray alloc] init];

    NSMutableDictionary *prioritiesDict=[[NSMutableDictionary alloc] init];
    [prioritiesDict setObject:headline.text forKey:@"headline"];
    [prioritiesDict setObject:notesTextView.text forKey:@"notes"];

    
    [prioritiesArray addObject:prioritiesDict];
    [[NSUserDefaults standardUserDefaults] setObject:prioritiesArray forKey:@"priorities"];
    [[NSUserDefaults standardUserDefaults ] synchronize];
    [prioritiesArray release];
    [prioritiesDict release];
    
    if([headline isFirstResponder])
    {
        [headline resignFirstResponder];
    }
    if([notesTextView isFirstResponder])
    {
        [notesTextView resignFirstResponder];
    }

    
    UIView *savedView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    savedView.backgroundColor=[UIColor lightGrayColor];
    savedView.alpha=0.0;
    UILabel *savedLabel =[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-0.09*self.view.frame.size.height, 100, 0.18*self.view.frame.size.height)];
    savedLabel.backgroundColor=[UIColor grayColor];
    savedLabel.layer.cornerRadius=10;
    savedLabel.layer.masksToBounds=YES;
    savedLabel.text=[NSString stringWithFormat:@"Saved"];
    savedLabel.textAlignment=NSTextAlignmentCenter;
    savedLabel.textColor=[UIColor blackColor];
    savedLabel.font=[UIFont fontWithName:@"Georgia-Bold" size:32];
    [savedView addSubview:savedLabel];
    [savedLabel release];
    
    [self.view addSubview:savedView];

    
    [UIView animateWithDuration:1.5
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         savedView.alpha=0.5;

                     }
                     completion:^(BOOL finished){
                         // Wait one second and then fade in the view
                         [UIView animateWithDuration:1.5
                                               delay: 0.0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              savedView.alpha = 0.0;
                                          }
                                          completion:nil];
                     }];
    [headline       setText:@"   HEADLINE"];
    [notesTextView  setText:@" NOTES"];



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
