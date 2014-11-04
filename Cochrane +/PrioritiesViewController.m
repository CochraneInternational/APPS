//
//  PrioritiesViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/14/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "PrioritiesViewController.h"

#define kAnimationDuration 1.0


@interface PrioritiesViewController ()

@end

@implementation PrioritiesViewController
//@synthesize delegate;

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
        background.image=[UIImage imageNamed:@"prioritiesBackground_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"prioritiesBackground.png"];
    }
    
    [self.view addSubview:background];
  
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButton_iPhone4.png"] forState:UIControlStateNormal];

    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];



    
    prioritiesTable =[[UITableView alloc] initWithFrame:CGRectMake(0, backButton.frame.origin.y+backButton.frame.size.height+20, self.view.frame.size.width,self.view.frame.size.height-(backButton.frame.origin.y+backButton.frame.size.height+40)) style:UITableViewStylePlain];
    prioritiesTable.delegate=self;
    prioritiesTable.dataSource=self;
    [prioritiesTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [prioritiesTable setBackgroundColor:[UIColor clearColor]];

    [self.view addSubview:prioritiesTable];
    
    
    noData=[[UILabel alloc] initWithFrame:CGRectMake(0, (prioritiesTable.frame.origin.x+prioritiesTable.frame.size.height)*1/3, self.view.frame.size.width, 0.9*self.view.frame.size.height)];
    noData.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:18.0];
    noData.textColor=[UIColor grayColor];
    noData.textAlignment=NSTextAlignmentCenter;
    noData.text=@"No priorites set and/or asigned!";
    noData.backgroundColor=[UIColor clearColor];
    [self.view addSubview:noData];
    noData.hidden=YES;

    addPriorities =[UIButton buttonWithType:UIButtonTypeCustom];
    addPriorities.frame=CGRectMake(self.view.frame.size.width-self.view.frame.size.width/5, backButton.frame.origin.y,self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [addPriorities setImage:[UIImage imageNamed:@"newButton.png"] forState:UIControlStateNormal];
    [addPriorities addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPriorities];
    
 
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    prioritiesArray=[[NSMutableArray alloc] init];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"])
    {
        //        [[NSUserDefaults standardUserDefaults] setObject:prioritiesArray forKey:@"priorities"];
        //        [[NSUserDefaults standardUserDefaults ] synchronize];
    }
    else
    {
        prioritiesArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"priorities"];
    }
    if( [prioritiesArray count]==0)
    {
        noData.hidden=NO;
    }
    else
    {
        noData.hidden=YES;

    }
    [prioritiesTable reloadData];

}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [prioritiesTable beginUpdates];
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        // Do whatever data deletion you need to do...
//        [prioritiesArray  removeObjectAtIndex:indexPath.row];
//
//        [[NSUserDefaults standardUserDefaults] setObject:prioritiesArray forKey:@"priorities"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade ];
//    }
//    [prioritiesTable endUpdates];
//    [prioritiesTable reloadData];
//} 
//



-(void)add:(UIButton *)sender
{
    NewPriorityViewController *details  =[[[NewPriorityViewController alloc] init] autorelease];
    CATransition *transition            =[CATransition animation];
    transition.duration                 =kAnimationDuration;
    transition.timingFunction           =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type                     =@"cube";
    transition.subtype                  =kCATransitionFromRight;
    transition.delegate                 =self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:details animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:prioritiesArray forKey:@"priorities"];
        [[NSUserDefaults standardUserDefaults ] synchronize];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[prioritiesArray count]-1 inSection:0]];

        [prioritiesTable beginUpdates];
        [prioritiesTable insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
//        [prioritiesTable deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
        [prioritiesTable endUpdates];

    }
}

- (void)closeAlert:(NSTimer*)timer
{
    [(UIAlertView*) timer.userInfo  dismissWithClickedButtonIndex:0 animated:YES];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [prioritiesArray count];
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell       =[[[CustomTableCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"prioritiesCell"] autorelease];
    cell.textLabel.text         =[[prioritiesArray objectAtIndex:indexPath.row] objectForKey:@"headline"]; //[NSString stringWithFormat:@"    Priority %i",indexPath.row+1];
    cell.textLabel.textColor    =[UIColor darkGrayColor];
    cell.textLabel.font         =[UIFont fontWithName:@"AmericanTypewriter" size:20];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailPrioritiesViewController *details =[[[DetailPrioritiesViewController alloc] init] autorelease];

    priorities_row_selected=indexPath.row+1;
    
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];

    [self.navigationController pushViewController:details animated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
