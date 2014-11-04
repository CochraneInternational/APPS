//
//  InboxMessagesViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/25/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "InboxMessagesViewController.h"
#import "PopupViewController.h"
#import "UIViewController+MJPopupViewController.h"



#define kPopupModalAnimationDuration 0.35
#define kMJPopupViewController @"kMJPopupViewController"
#define kMJPopupBackgroundView @"kMJPopupBackgroundView"
#define kMJSourceViewTag 23941
#define kMJPopupViewTag 23942
#define kMJOverlayViewTag 23945



@interface InboxMessagesViewController ()

@end



@implementation InboxMessagesViewController@synthesize mess;
@synthesize text;



#pragma mark 
#pragma mark View Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if(IS_IPHONE_5)
        {
        [background setImage:[UIImage imageNamed:@"messagesBackground_iPhone5.png"]];
    }
    else
    {
        [background setImage:[UIImage imageNamed:@"messagesBackground_iPhone4.png"]];
    }
    [self.view addSubview:background];
    
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
#ifdef DEBUG
    backButton.layer.borderColor=[UIColor blackColor].CGColor;
    backButton.layer.borderWidth=2;
#endif
    
    
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];

    

    
    
//    
//    inboxIcon =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
//    inboxIcon.center =CGPointMake(self.view.frame.size.width/2, backButton.frame.origin.y);
//    inboxIcon.image=[UIImage imageNamed:@"inboxIcon.png"];
//    [self.view addSubview:inboxIcon];

      
    inboxTableView =[[UITableView alloc] initWithFrame:CGRectMake(0,backButton.frame.origin.y+ backButton.frame.size.height+0.03*[UIScreen mainScreen].bounds.size.height, self.view.frame.size.width, self.view.frame.size.height*5/6) style:UITableViewStylePlain];
    inboxTableView.dataSource=self;
    inboxTableView.backgroundColor=[UIColor clearColor];
    inboxTableView.delegate=self;
    [inboxTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:inboxTableView];



}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([messages count]>0)
    {
        [messages removeAllObjects];
    }
    else
        messages =[[NSMutableArray alloc] init];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"])
    {
        for(int i=0;i<[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] count];i++)
        {
            [messages addObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] objectAtIndex:i]];
        }
        
    }
    

    [inboxTableView reloadData];
}



#pragma mark
#pragma mark UITableViewDelegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@" \n\n messages.count: ->> %i",[messages count]);
    return [messages count];    
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    InboxCell   *cell       =[[[InboxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
    
    NSLog(@"messages: %@ ",messages);
    NSArray     *arr        =[[[messages objectAtIndex:indexPath.row] objectAtIndex:1] componentsSeparatedByString:@"~~~"];
    
    
    cell.messLabel.text=[arr objectAtIndex:0];
    cell.infosLabel.text=[NSString stringWithFormat:@"    %@",[arr objectAtIndex:1]];
    
    if([[[messages objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:@"unread"])
    {
        [cell.readUnread setTitle:@"Unread" forState:UIControlStateNormal];
        [cell.readUnread setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
//        cell.background.image   =[UIImage imageNamed:@"recordCellRed.png"];
        cell.messLabel.font     =[UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:20.0];
    }
    else
    {
        [cell.readUnread setTitle:@"Read" forState:UIControlStateNormal];
        [cell.readUnread setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        cell.background.image   =[UIImage imageNamed:@"recordCell.png"];
        cell.messLabel.font     =[UIFont fontWithName:@"AmericanTypewriter-CondensedLight" size:20.0];
    }
    
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSArray     *arr=[[[messages objectAtIndex:indexPath.row] objectAtIndex:1] componentsSeparatedByString:@"~~~"];

    SeeMessageViewController *see   =[[[SeeMessageViewController alloc] init] autorelease];
    see.text                        =[arr objectAtIndex:0];
    see.sender                      =[arr objectAtIndex:1];
    see.index                       =indexPath.row;
    
    CATransition *transition    =[CATransition animation];
    transition.duration         =kAnimationDuration;
    transition.timingFunction   =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type             =@"cube";
    transition.subtype          =kCATransitionFromRight;
    transition.delegate         =self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:see animated:YES];
}




#pragma mark
#pragma mark UIButton's Actions

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




#pragma mark 
#pragma mark Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
