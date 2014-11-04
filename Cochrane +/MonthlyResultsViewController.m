//
//  MonthlyResultsViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/25/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "MonthlyResultsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "ASIFormDataRequest.h"

@interface MonthlyResultsViewController ()

@end

@implementation MonthlyResultsViewController
@synthesize userid;

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
        background.image=[UIImage imageNamed:@"monthlyResultsBackground_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"monthlyResultsBackground_iPhone4.png"];
    }
    [self.view addSubview:background];
    [background release];

    
    cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [cancelBtn setImage:[UIImage imageNamed:@"cancelBtn.png"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.showsTouchWhenHighlighted=YES;
    [self.view addSubview:cancelBtn];

    
    bigArray            =[[NSMutableArray alloc] init];
    resultsBigArray     =[[NSMutableArray alloc] init];
    targetsBigArray     =[[NSMutableArray alloc] init];

     // Commented out because size of image not right    backgroundDown          =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //backgroundDown.image    =[UIImage imageNamed:@"backgroundDown.png"];
    //[self.view addSubview:backgroundDown];

    [self calculateMonths];

	// Do any additional setup after loading the view.
}


-(void)calculateMonths
{
    NSCalendar          *calendar =[NSCalendar currentCalendar];    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    month1=[[NSMutableString alloc] init];
    month2=[[NSMutableString alloc] init];
    month3=[[NSMutableString alloc] init];
    month4=[[NSMutableString alloc] init];
    
    NSDate *firstDayDate;
    NSDate *lastDayDate;

    NSDateComponents *comp3 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    [comp3 setDay:0];
    lastDayDate = [calendar dateFromComponents:comp3];
    
    
    NSDateComponents *comp4 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    [comp4 setDay:1];
    [comp4 setMonth:([comp4 month]-1)];
    firstDayDate = [calendar dateFromComponents:comp4];


    [month1 appendString:[dateFormatter stringFromDate:firstDayDate]];
    [month1 appendString:@"&&&"];
    [month1 appendString:[dateFormatter stringFromDate:lastDayDate]];
    
    
    NSDateComponents *comp5 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    [comp5 setDay:0];
    [comp5 setMonth:([comp5 month]-1)];
    lastDayDate = [calendar dateFromComponents:comp5];
    
    
    NSDateComponents *comp6 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    [comp6 setDay:1];
    [comp6 setMonth:([comp6 month]-2)];
    firstDayDate = [calendar dateFromComponents:comp6];
    
    
    [month2 appendString:[dateFormatter stringFromDate:firstDayDate]];
    [month2 appendString:@"&&&"];
    [month2 appendString:[dateFormatter stringFromDate:lastDayDate]];
   
    
    [comp5 setMonth:([comp5 month]-1)];
    lastDayDate = [calendar dateFromComponents:comp5];
    [comp6 setMonth:([comp6 month]-1)];
    firstDayDate = [calendar dateFromComponents:comp6];
    
    [month3 appendString:[dateFormatter stringFromDate:firstDayDate]];
    [month3 appendString:@"&&&"];
    [month3 appendString:[dateFormatter stringFromDate:lastDayDate]];


    [comp5 setMonth:([comp5 month]-1)];
    lastDayDate = [calendar dateFromComponents:comp5];
    [comp6 setMonth:([comp6 month]-1)];
    firstDayDate = [calendar dateFromComponents:comp6];
    
    [month4 appendString:[dateFormatter stringFromDate:firstDayDate]];
    [month4 appendString:@"&&&"];
    [month4 appendString:[dateFormatter stringFromDate:lastDayDate]];
    [dateFormatter release];

    
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getWeeklyResults.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/Targets/getWeeklyResults.php"]];
    [request setPostValue:month1 forKey:@"week1"];
    [request setPostValue:month2 forKey:@"week2"];
    [request setPostValue:month3 forKey:@"week3"];
    [request setPostValue:month4 forKey:@"week4"];
    [request setPostValue:userid forKey:@"user"];
    [request setPostValue:@"month" forKey:@"queryType"];

    
    NSLog(@"month1: %@",month1);
    NSLog(@"month2: %@",month2);
    NSLog(@"month3: %@",month3);
    NSLog(@"month4: %@",month4);
    

    [request setCompletionBlock:^{
        
        NSArray *arr=[request.responseString componentsSeparatedByString:@"^^^^^"];
        for(int i=0;i<[arr count];i++)
        {
            NSString *str=[arr objectAtIndex:i];
            NSArray *array=[str componentsSeparatedByString:@"--"];
            [bigArray addObject:array];
            
        }
        [bigArray removeLastObject];
        
        
        NSArray     *arrayF         =[request.responseString componentsSeparatedByString:@"~~"];
        NSString    *resultObj      =[arrayF objectAtIndex:0];
        NSString    *targetsObj     =[arrayF objectAtIndex:1];

        NSArray     *resultsArray   =[resultObj componentsSeparatedByString:@"^^^^^"];
        NSArray     *targetsArray   =[targetsObj componentsSeparatedByString:@"^^^^^"];


        for(int i=0;i<[resultsArray count];i++)
        {
            NSString    *str    =[resultsArray objectAtIndex:i];
            NSArray     *array  =[str componentsSeparatedByString:@"--"];
            [resultsBigArray addObject:array];
            
        }
        [resultsBigArray removeLastObject];
        
        
        for(int i=0;i<[targetsArray count];i++)
        {
            NSString    *str    =[targetsArray objectAtIndex:i];
            NSArray     *array  =[str componentsSeparatedByString:@"--"];
            [targetsBigArray addObject:array];
            
        }
        [targetsBigArray removeLastObject];

        [self showTable];
        
    }];
    [request setFailedBlock:^{
    }];
    [request startAsynchronous];


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

-(void)showTable
{
    monthlyTable =[[UITableView alloc] initWithFrame:CGRectMake(0, cancelBtn.frame.size.height+cancelBtn.frame.origin.y+40, self.view.frame.size.width, self.view.frame.size.height-(cancelBtn.frame.size.height+cancelBtn.frame.origin.y+40))];
    monthlyTable.delegate=self;
    monthlyTable.dataSource=self;
    monthlyTable.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:monthlyTable];
    
}


#pragma mark
#pragma mark Table View Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeeklyResultsCell *cell      =[[[WeeklyResultsCell alloc] init] autorelease];
    
    if(indexPath.row==0)
    {
        cell.weekLabel.text=[month1 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
    }
    else
        if(indexPath.row==1)
        {
            cell.weekLabel.text=[month2 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
        }
        else
            if(indexPath.row==2)
            {
                cell.weekLabel.text=[month3 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
            }
            else
            {
                cell.weekLabel.text=[month4 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
            }
    
    double perc1,perc2,perc3,perc4;
    
    if(([[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue]>0 && [[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue] >0 )||([[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue]>0))
        perc1=([[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue] / [[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue])*100;
    else
        perc1=0;
    
    if(([[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:1] floatValue]>0 && [[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:1] floatValue] >0 )||([[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:1] floatValue]>0))
        perc2=([[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:1] floatValue] / [[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:1] floatValue])*100;
    else
        perc2=0;
    
    
    if(([[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:2] floatValue]>0 && [[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:2] floatValue] >0 )||([[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:2] floatValue]>0))
        perc3=([[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:2] floatValue] / [[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:2] floatValue])*100;
    else
        perc3=0;
    
    if(([[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:3] floatValue]>0 && [[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:3] floatValue] >0 )||([[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:3] floatValue]>0))
        perc4=([[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:3] floatValue] / [[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:3] floatValue])*100;
    else
        perc4=0;

    NSMutableString *percentage1=[[NSMutableString alloc] init];
    [percentage1 appendString:[NSString stringWithFormat:@"%.0f",perc1]] ;
    [percentage1 appendString:@"%"];
    
    NSMutableString *percentage2=[[NSMutableString alloc] init];
    [percentage2 appendString:[NSString stringWithFormat:@"%.0f",perc2]] ;
    [percentage2 appendString:@"%"];
    
    NSMutableString *percentage3=[[NSMutableString alloc] init];
    [percentage3 appendString:[NSString stringWithFormat:@"%.0f",perc3]] ;
    [percentage3 appendString:@"%"];
    
    NSMutableString *percentage4=[[NSMutableString alloc] init];
    [percentage4 appendString:[NSString stringWithFormat:@"%.0f",perc4]] ;
    [percentage4 appendString:@"%"];

    
    cell.meetingsLabel.text= [NSString stringWithFormat:@"%@ / %@",percentage1,[[bigArray objectAtIndex:indexPath.row] objectAtIndex:0]];
    [percentage1 release];
    cell.priceLabel.text=[NSString stringWithFormat:@"%@ / %@",percentage2,[[bigArray objectAtIndex:indexPath.row] objectAtIndex:1]];
    [percentage2 release];
    cell.salesLabel.text=[NSString stringWithFormat:@"%@ / %@",percentage3,[[bigArray objectAtIndex:indexPath.row] objectAtIndex:2]];
    int hours   = floor([[[bigArray objectAtIndex:indexPath.row] objectAtIndex:3]intValue]/3600);
    int minutes = round(([[[bigArray objectAtIndex:indexPath.row] objectAtIndex:3] intValue]- hours * 3600)/60);
    int seconds = round([[[bigArray objectAtIndex:indexPath.row] objectAtIndex:3] intValue] - minutes * 60 -hours*3600);
    
    cell.timeAttendLabel.text=[NSString stringWithFormat:@"%@ / %ih:%im:%is",percentage4,hours,minutes,seconds];
    [percentage4 release];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSNumberFormatter *numberFormatter2=[[NSNumberFormatter alloc] init];
    
    [numberFormatter2 setGroupingSize:3];
    
    [numberFormatter2 setGroupingSeparator:@","];
    
    [numberFormatter2 setUsesGroupingSeparator:YES];
    
    int value =[[[bigArray objectAtIndex:indexPath.row] objectAtIndex:2] intValue];
    
    
    [cell.salesLabel  setText:[NSString stringWithFormat:@"%@ / %@",percentage3,[numberFormatter2 stringFromNumber:[NSNumber numberWithInt:value]]] ];
       [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [numberFormatter2 release];
    [percentage3 release];
    double roundBtnPercentageValue=(perc1+perc2+perc3+perc4)/4;
    NSMutableString *percRound=[[NSMutableString alloc] init];
    [percRound appendString:[NSString stringWithFormat:@"%.0f",roundBtnPercentageValue]] ;
    [percRound appendString:@"%"];
    [cell.roundBtn setTitle:percRound forState:UIControlStateNormal];
    [cell.roundBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [percRound release];
    [cell.roundBtn.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
    [cell.roundBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    

    
    return cell;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
