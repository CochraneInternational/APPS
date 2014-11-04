//
//  AdminInboxViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/29/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "AdminInboxViewController.h"

@interface AdminInboxViewController ()

@end

@implementation AdminInboxViewController

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
        [background setImage:[UIImage imageNamed:@"messagesBackground_iPhone5.png"]];
    }
    else
    {
        [background setImage:[UIImage imageNamed:@"messagesBackground_iPhone4.png"]];
    }
    [self.view addSubview:background];    [self.view addSubview:background];
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];

    composeMessage =[UIButton buttonWithType:UIButtonTypeCustom];
    composeMessage.frame=CGRectMake(self.view.frame.size.width-50, backButton.frame.origin.y-backButton.frame.size.height/2, 50, 50);
    [composeMessage setImage:[UIImage imageNamed:@"createMess.png"] forState:UIControlStateNormal];
    [composeMessage addTarget:self action:@selector(composePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:composeMessage];
    
    adminInboxTable =[[UITableView alloc] initWithFrame:CGRectMake(0, composeMessage.frame.size.height+composeMessage.frame.origin.y+0.03*[UIScreen mainScreen].bounds.size.height, self.view.frame.size.width, self.view.frame.size.height*5/6) style:UITableViewStylePlain];
    adminInboxTable.dataSource=self;
    adminInboxTable.backgroundColor=[UIColor clearColor];
    adminInboxTable.delegate=self;
    [adminInboxTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:adminInboxTable];
    

    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_SalesmanLast.php",SERVER]]];// @"http://www.x-2.info/SalesApp_php/get_SalesmanLast.php"]];
    
    
    [request setCompletionBlock:^{
        
        [self done:request.responseString];
    }];
    
    
    [request setFailedBlock:^{
    }];
    [request startAsynchronous];
    

    
}


-(void)done:(NSString *)users
{
    usersArrayDropdown =[[NSMutableArray alloc] init];
    
    usersArrayDropdown =[[users componentsSeparatedByString:@"^^^"] retain];
    //[usersArrayDropdown removeLastObject];
    
}
-(void)composePressed:(UIButton *)sender
{
    ComposeNewMessageViewController *see =[[[ComposeNewMessageViewController alloc] init] autorelease];//analyze
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:see animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
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
    
   
    
    [adminInboxTable reloadData];
//    mess.text=text;
//
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messages count];
    //    return 2;
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    InboxCell *cell    =[[[InboxCell alloc] initWithStyle:nil reuseIdentifier:@"cell"] autorelease];//analyze
    NSArray *arr=[[[messages objectAtIndex:indexPath.row] objectAtIndex:1] componentsSeparatedByString:@"~~~"];
    cell.messLabel.text=[arr objectAtIndex:0];
    cell.infosLabel.text=[NSString stringWithFormat:@"    %@",[arr objectAtIndex:1]];
    //NSLog(@"Msg Array: %@", arr);

    if([[[messages objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:@"unread"])
    {
        //        cell.readUnread.image= [UIImage imageNamed:@"locked.png"] ;
        [cell.readUnread setTitle:@"Unread" forState:UIControlStateNormal];
        [cell.readUnread setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        cell.background.image=[UIImage imageNamed:@"recordCellRed.png"];
        cell.messLabel.font=[UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:20.0];
    }
    else
    {
        [cell.readUnread setTitle:@"Read" forState:UIControlStateNormal];
        [cell.readUnread setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.background.image=[UIImage imageNamed:@"recordCell.png"];
        
        cell.messLabel.font=[UIFont fontWithName:@"AmericanTypewriter-CondensedLight" size:20.0];
        
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSArray *arr=[[[messages objectAtIndex:indexPath.row] objectAtIndex:1] componentsSeparatedByString:@"~~~"];
    
    SeeMessageViewController *see =[[[SeeMessageViewController alloc] init] autorelease]; //analyze
    see.text=[arr objectAtIndex:0];
    see.sender=[arr objectAtIndex:1];
    see.index=indexPath.row;
  
    
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:see animated:YES];
    
    
    
    
}


#pragma mark
#pragma mark BottomView Delegate Methods

-(void)actionOnSlideUpButton
{
    if(bottomIsUp==NO)
    {
        bottomIsUp=YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];

        bottomView.frame=CGRectMake(bottomView.frame.origin.x, bottomView.frame.origin.y-40, bottomView.frame.size.width, bottomView.frame.size.height);
        
        [UIView commitAnimations];
        
        
    }
    else
    {
        bottomIsUp=NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        bottomView.frame=CGRectMake(bottomView.frame.origin.x, bottomView.frame.origin.y+40, bottomView.frame.size.width, bottomView.frame.size.height);
        [UIView commitAnimations];        
        
    }
    
}


-(void)prioritiesView
{

}


-(void)inboxView
{
    NSLog(@"inbox view3");
    
}


-(void)recordView
{

}


-(void)brochureView
{

    
}


-(void)scanBussiness
{

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
