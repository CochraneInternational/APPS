//
//  DetailPrioritiesViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/20/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "DetailPrioritiesViewController.h"
#import "UIView+Genie.h"

#define kAnimationDuration 1.0

@interface DetailPrioritiesViewController ()

@end

@implementation DetailPrioritiesViewController

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
        background.image=[UIImage imageNamed:@"viewPriorityBackground.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"viewPriorityBackground.png"];
    }
    [self.view addSubview:background];
    

    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
  
    
//    nextButton =[UIButton buttonWithType:UIButtonTypeCustom];
//    nextButton.frame=CGRectMake(self.view.frame.size.width- self.view.frame.size.width/5, backButton.frame.origin.y,  self.view.frame.size.width/5, self.view.frame.size.height*0.05);
//    [nextButton setImage:[UIImage imageNamed:@"nextButton.png"] forState:UIControlStateNormal];
//    [nextButton addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:nextButton];
    index=priorities_row_selected-1;

    
    navTitle                        =[[UILabel alloc] init];
    navTitle.frame                  =CGRectMake(self.view.frame.size.width/2-100, 0, 200, 40);
    navTitle.backgroundColor        =[UIColor clearColor];
    navTitle.textAlignment          = NSTextAlignmentCenter;
    navTitle.text                   =[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"headline"];
    navTitle.font                   =[UIFont fontWithName:@"ArialMT" size:18];
    navTitle.textColor              =[UIColor whiteColor];
    navTitle.numberOfLines=1;
    navTitle.minimumFontSize=10;
    navTitle.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:navTitle];

    alert =[[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are you sure you want to delete this priority? Once deleted it cannot be restored!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];

    
    moreDescriptions =[[UITextView alloc ] init];
    moreDescriptions.frame=CGRectMake(10, backButton.frame.size.height+backButton.frame.origin.y+0.09*self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height/2);
    moreDescriptions.font =[UIFont fontWithName:@"AmericanTypewriter" size:18];
    moreDescriptions.textColor=[UIColor blackColor];
    moreDescriptions.textAlignment=NSTextAlignmentLeft;
    [[moreDescriptions layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[moreDescriptions layer] setBorderWidth:0.5];
    [[moreDescriptions layer] setCornerRadius:5];
    [moreDescriptions setClipsToBounds:YES];
    [[moreDescriptions layer] setBackgroundColor:[[UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0]  CGColor]];
    moreDescriptions.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"notes"];
    [moreDescriptions setUserInteractionEnabled:NO];
    [self.view addSubview:moreDescriptions];
    subviewVisible=@"moreDesc";
    
    trashButton =[UIButton buttonWithType:UIButtonTypeCustom];
    trashButton.frame=CGRectMake(self.view.frame.size.width/2-25, moreDescriptions.frame.size.height+moreDescriptions.frame.origin.y+20, 50, 50);
    [trashButton setImage:[UIImage imageNamed:@"deletePriorityButtonNew.png"] forState:UIControlStateNormal];
    [trashButton addTarget:self action:@selector(trashPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:trashButton];
    
    prioritiesArray=[[NSMutableArray alloc] init];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"])
    {
        //        [[NSUserDefaults standardUserDefaults] setObject:prioritiesArray forKey:@"priorities"];
        //        [[NSUserDefaults standardUserDefaults ] synchronize];
    }
    else
    {
        prioritiesArray=[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] mutableCopy];
    }
    
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


- (void) genieToRect: (CGRect)rect edge: (BCRectEdge) edge
{
 
        
    NSTimeInterval duration = 0.69;
    CGRect endRect = CGRectInset(rect, 5.0, 5.0);

    index--;
    if([subviewVisible isEqualToString:@"moreDesc"])
    {
        subviewVisible=@"moreDesc2";
        if([prioritiesArray count]>1)
        {
            moreDescriptions2 =[[UITextView alloc ] init];
            moreDescriptions2.frame=CGRectMake(10, backButton.frame.size.height+backButton.frame.origin.y+0.09*self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height/2);
            moreDescriptions2.font =[UIFont fontWithName:@"AmericanTypewriter" size:18];
            moreDescriptions2.textColor=[UIColor blackColor];
            moreDescriptions2.textAlignment=NSTextAlignmentLeft;
            [[moreDescriptions2 layer] setBorderColor:[[UIColor grayColor] CGColor]];
            [[moreDescriptions2 layer] setBorderWidth:0.5];
            [[moreDescriptions2 layer] setCornerRadius:5];
            [moreDescriptions2 setClipsToBounds:YES];
            [[moreDescriptions2 layer] setBackgroundColor:[[UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0]  CGColor]];
            if(index<0)
            {
                index=[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] count]-1;
                navTitle.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"headline"];
                moreDescriptions2.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"notes"];
            }
            else
            {
                moreDescriptions2.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"notes"];
                navTitle.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"headline"];
                
            }
                      
            [moreDescriptions2 setUserInteractionEnabled:NO];
            
            [self.view insertSubview:moreDescriptions2 belowSubview:moreDescriptions ];
        }
        if(index==-1)
            [prioritiesArray  removeObjectAtIndex:index+1];
        else
            [prioritiesArray  removeObjectAtIndex:index];

        
        [[NSUserDefaults standardUserDefaults] setObject:prioritiesArray forKey:@"priorities"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        


        [moreDescriptions genieInTransitionWithDuration:duration destinationRect:endRect destinationEdge:edge completion:
         ^{
          
             
             [moreDescriptions removeFromSuperview];
             if([prioritiesArray count]==0)
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

         }];
    }
    else
    {
        subviewVisible=@"moreDesc";

        if([prioritiesArray count]>1)
        {
            moreDescriptions =[[UITextView alloc ] init];
            moreDescriptions.frame=CGRectMake(10, backButton.frame.size.height+backButton.frame.origin.y+0.09*self.view.frame.size.height, self.view.frame.size.width-20, self.view.frame.size.height/2);
            moreDescriptions.font =[UIFont fontWithName:@"AmericanTypewriter" size:18];
            moreDescriptions.textColor=[UIColor blackColor];
            moreDescriptions.textAlignment=NSTextAlignmentLeft;
            [[moreDescriptions layer] setBorderColor:[[UIColor grayColor] CGColor]];
            [[moreDescriptions layer] setBorderWidth:0.5];
            [[moreDescriptions layer] setCornerRadius:5];
            [moreDescriptions setClipsToBounds:YES];
            [[moreDescriptions layer] setBackgroundColor:[[UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0]  CGColor]];
            
            if(index<0)
            {
                index=[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] count]-1;
                navTitle.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"headline"];
                
                moreDescriptions.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"notes"];
            }
            else
            {
                moreDescriptions.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"notes"];
                navTitle.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"headline"];
                
            }
                     
            
            [moreDescriptions setUserInteractionEnabled:NO];
            [self.view addSubview:moreDescriptions];
            [self.view insertSubview:moreDescriptions belowSubview:moreDescriptions2 ];
        }
        if(index==-1)
            [prioritiesArray  removeObjectAtIndex:index+1];
        else
            [prioritiesArray  removeObjectAtIndex:index];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:prioritiesArray forKey:@"priorities"];
        [[NSUserDefaults standardUserDefaults] synchronize];


        [moreDescriptions2 genieInTransitionWithDuration:duration destinationRect:endRect destinationEdge:edge completion:
         ^{
             [moreDescriptions2 removeFromSuperview];
             if([prioritiesArray count]==0)
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

             
         }];

    }

}

-(void)refreshView
{
    
}


//-(void)nextPressed:(UIButton *)sender
//{
//    index++;
//    if(index==[prioritiesArray count])
//        index=0;
//    moreDescriptions.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"notes"];
//    navTitle.text=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"] objectAtIndex:index] objectForKey:@"headline"];
//
//}

-(void)trashPressed:(UIButton *)sender
{
    [alert show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {

    }
    else
    {
        [self genieToRect:trashButton.frame edge:BCRectEdgeTop];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
