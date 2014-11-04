//
//  SelectSalesmanViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/20/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "SelectSalesmanViewController.h"
#define kAnimationDuration 1.0

@interface SelectSalesmanViewController ()

@end

@implementation SelectSalesmanViewController

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
        background.image=[UIImage imageNamed:@"overviewSalesmanBackground_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"overviewSalesmanBackground_iPhone4.png"];
    }    [self.view addSubview:background];
    
    
//    upView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/4.5)];
//    upView.image=[UIImage imageNamed:@"ADMIN_selectSalesman.png"];
//    [self.view addSubview:upView];
    
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
//    backButton.layer.borderColor=[UIColor blackColor].CGColor;
//    backButton.layer.borderWidth=3;
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    usersArray =[[NSMutableArray alloc] init];
    
    
    if([isAdmin isEqualToString:@"0"] )
    {
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_SalesmanLast.php",SERVER]]];// @"http://www.x-2.info/SalesApp_php/get_SalesmanLast.php"]];
        
        
        [request setCompletionBlock:^{
            
            [self showTable:request.responseString];
        }];
        
        
        [request setFailedBlock:^{
        }];
        [request startAsynchronous];
    }
    else
    {
        
        NSLog(@"%@",loginID);
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_SalesmanForManager.php",SERVER]]];// @"http://www.x-2.info/SalesApp_php/get_SalesmanLast.php"]];
        [request setPostValue:loginID forKey:@"managerID"];
        
        [request setCompletionBlock:^{
            NSLog(@"SelectSalesmanviewController.m %@",request.responseString);
            
            
            [self showTable:request.responseString];
        }];
        
        
        [request setFailedBlock:^{
        }];
        [request startAsynchronous];

    }
    
    refreshTimer =[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(refreshList) userInfo:nil repeats:YES];

   
	// Do any additional setup after loading the view.
}

-(void)refreshList
{
    if([isAdmin isEqualToString:@"0"] )
    {
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_SalesmanLast.php",SERVER]]];// @"http://www.x-2.info/SalesApp_php/get_SalesmanLast.php"]];
        
        
        [request setCompletionBlock:^{
            
            [self refreshTable:request.responseString];
        }];
        
        
        [request setFailedBlock:^{
        }];
        [request startAsynchronous];
    }
    else
    {
        
        NSLog(@"%@",loginID);
        ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@get_SalesmanForManager.php",SERVER]]];// @"http://www.x-2.info/SalesApp_php/get_SalesmanLast.php"]];
        [request setPostValue:loginID forKey:@"managerID"];
        
        [request setCompletionBlock:^{
            NSLog(@"huuuuh %@",request.responseString);
            
            
            [self refreshTable:request.responseString];
        }];
        
        
        [request setFailedBlock:^{
        }];
        [request startAsynchronous];
        
    }
    

}

-(void)refreshTable:(NSString *)usrs
{
    usersArray =[[usrs componentsSeparatedByString:@"^^^"] retain];
    [selectSalesmanTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
}


-(void)showTable:(NSString *)usrs
{
    
    usersArray =[[usrs componentsSeparatedByString:@"^^^"] retain];
    if ([usersArray count]==1 && [[usersArray objectAtIndex:0] isEqualToString:@"bad"])
    {
    }
    else
    {
        NSLog(@"usersArrary: %@",usersArray);
        [usersArray removeLastObject];
        if(IS_IPHONE_5)
        {
            selectSalesmanTableView =[[UITableView alloc] initWithFrame:CGRectMake(0.07*[UIScreen mainScreen].bounds.size.width,self.view.frame.size.height/4.5+0.03*[UIScreen mainScreen].bounds.size.height, self.view.frame.size.width-0.14*[UIScreen mainScreen].bounds.size.width, self.view.frame.size.height*4/6) style:UITableViewStylePlain];
        }
        else
        {
            selectSalesmanTableView =[[UITableView alloc] initWithFrame:CGRectMake(0.07*[UIScreen mainScreen].bounds.size.width,self.view.frame.size.height/4.5+0.05*[UIScreen mainScreen].bounds.size.height, self.view.frame.size.width-0.14*[UIScreen mainScreen].bounds.size.width, self.view.frame.size.height*4/6) style:UITableViewStylePlain];
            
        }
        selectSalesmanTableView.dataSource=self;
        selectSalesmanTableView.backgroundColor=[UIColor clearColor];
        selectSalesmanTableView.delegate=self;
        
        [selectSalesmanTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [self.view addSubview:selectSalesmanTableView];
    }
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [usersArray removeLastObject];
    return [usersArray count];
//    return 2;
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.09*[UIScreen mainScreen].bounds.size.height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    SelectSalesmanCell *cell    =[[[SelectSalesmanCell alloc] initWithStyle:nil reuseIdentifier:@"identifCell" cellAtIndex:indexPath.row] autorelease];//analyze
    
    NSString *string=[usersArray objectAtIndex:indexPath.row];
    NSArray  *arr =[string componentsSeparatedByString:@"&&"];
    
    cell.textLabel.text         =[arr objectAtIndex:0];//[NSString stringWithFormat:@"Salesman %i",indexPath.row+1];
//    cell.tag =[[arr objectAtIndex:1] integerValue];
    cell.textLabel.textColor    =[UIColor whiteColor];
    cell.textLabel.font         =[UIFont fontWithName:@"AmericanTypewriter" size:20];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    if(indexPath.row %2==0)
    {
//        background.image=[UIImage imageNamed:@"ADMIN_salesmanBlueCell.png"];
//
        if([[arr objectAtIndex:2] isEqualToString:@"1"])
        {
            [cell.background setImage:[UIImage imageNamed:@"selectSalesmanCellBlue_Online.png"]];
        }
        else
        {
            [cell.background setImage:[UIImage imageNamed:@"selectSalesmanCellBlue_Offline.png"]];

        }
    }
    else
    {
        if([[arr objectAtIndex:2] isEqualToString:@"1"])
        {
            [cell.background setImage:[UIImage imageNamed:@"selectSalesmanCellGray_Online.png"]];
        }
        else
        {
            [cell.background setImage:[UIImage imageNamed:@"selectSalesmanCellGray_Offline.png"]];
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    SelectSalesmanCell *cell   =[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    NSString *string=[usersArray objectAtIndex:indexPath.row];
    NSArray  *arr =[string componentsSeparatedByString:@"&&"];
    NSLog(@"arr --> %@",arr);
    NSLog(@"\n\n cell.textlabel.Text : %@",cell.textLabel.text);
    OverviewSalesmanViewController *overview=[[[OverviewSalesmanViewController alloc] init] autorelease];
    overview.name= cell.textLabel.text;
    overview.salesmanTag=[arr objectAtIndex:1];
    
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];    
    [self.navigationController pushViewController:overview animated:YES];
    

}



-(void)dealloc
{
    [selectSalesmanTableView release];
    [super dealloc];
    
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
