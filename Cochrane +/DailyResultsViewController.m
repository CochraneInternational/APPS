//
//  DailyResultsViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/2/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "DailyResultsViewController.h"
#define kAnimationDuration 1.0

@interface DailyResultsViewController ()

@end

@implementation DailyResultsViewController

@synthesize userid;

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
        background.image=[UIImage imageNamed:@"dailyResultsBackground_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"dailyResultsBackground_iPhone4.png"];
    }
    
    [self.view addSubview:background];
    [background release];

    daysArray       =[[NSMutableArray alloc] init];
    datesArray      =[[NSMutableArray alloc] init];
    dailyResults    =[[NSMutableArray alloc] init];
    bigArray        =[[NSMutableArray alloc] init];

    
    interval1=[[NSMutableString alloc] init];
    interval2=[[NSMutableString alloc] init];
    interval3=[[NSMutableString alloc] init];
    interval4=[[NSMutableString alloc] init];

    [self calculateNumberOfDays];
    [self makeDaysArray];
    
    cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [cancelBtn setImage:[UIImage imageNamed:@"cancelBtn.png"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.showsTouchWhenHighlighted=YES;
    [self.view addSubview:cancelBtn];

}

-(void)calculateNumberOfDays
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]]; //1=sunday, 2=monday, etc
    
    if(comps.weekday<5)
    {
        cellsNumber=comps.weekday+1;
        
    }
    else
        if(comps.weekday==5)
        {
            cellsNumber=1;
        }
        else
        {
            cellsNumber=2;
        }
    
    
    
    [calendar release];
    

}


-(void)getResults
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];

    NSString *currentDate =[dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    ASIFormDataRequest *req=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getTargets.php",SERVER]]];//@"http://www.x-2.info/SalesApp_php/Targets/getTargets.php"]];
    [req setPostValue:userid forKey:@"user"];
    [req setPostValue:currentDate forKey:@"data"];
    
    NSLog(@"Date Daily Targets: %@",currentDate);
    
    [req setCompletionBlock:^{
        NSArray *arr=[req.responseString componentsSeparatedByString:@"&&"];
        [dailyResults addObject:arr];
        [self showTable];
        
    }];
    [req setFailedBlock:^{
    }];
    [req startAsynchronous];
}

-(void)showTable
{
    dailyTable =[[UITableView alloc] initWithFrame:CGRectMake(0, cancelBtn.frame.size.height+cancelBtn.frame.origin.y+40, self.view.frame.size.width, self.view.frame.size.height-(cancelBtn.frame.size.height+cancelBtn.frame.origin.y+40))];
    dailyTable.delegate=self;
    dailyTable.dataSource=self;
    dailyTable.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:dailyTable];
  
     // Commented out because size of image not right
    //  backgroundDown          =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
   //   backgroundDown.image    =[UIImage imageNamed:@"woohoo.png"];
  //    [self.view addSubview:backgroundDown];

}


-(void)makeDaysArray
{
    
    resultsBigArray =[[NSMutableArray alloc] init];
    targetsBigArray =[[NSMutableArray alloc] init];
    int minus=0;
    for(int i=1;i<=4;i++)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd.MM.yyyy";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        
        
        minus++;
        NSDateComponents *componentsToSubtract = [[[NSDateComponents alloc] init] autorelease];
        [componentsToSubtract setDay:-minus];
        
        
        NSDate *day = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
        NSDateFormatter *dateFormatter2 = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter2 setDateFormat:@"EEEE"];
        NSString *d= [dateFormatter2 stringFromDate:day];
        
        NSString *dayString =[NSString stringWithFormat:@"%@ - %@",[d uppercaseString],[dateFormatter stringFromDate:day]];
        if([[d uppercaseString] isEqualToString:[@"sunday" uppercaseString]] || [[d uppercaseString] isEqualToString:[@"saturday" uppercaseString]])
        {
            i--;
        }
        else
        {
            if(i==1)
            {
                [interval1 appendString:dayString];
            }
            else
                if(i==2)
                {
                    [interval2 appendString:dayString];
                }
                else
                    if(i==3)
                    {
                        [interval3 appendString:dayString];
                    }
                    else
                    {
                        [interval4 appendString:dayString];
                    }
        }
    }
//    [interval1 substr]

    ASIFormDataRequest *request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getWeeklyResults.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/Targets/getWeeklyResults.php"]];
    [request setPostValue:[interval1 substringFromIndex:[interval1 length]-10] forKey:@"week1"];
    [request setPostValue:[interval2 substringFromIndex:[interval2 length]-10] forKey:@"week2"];
    [request setPostValue:[interval3 substringFromIndex:[interval3 length]-10] forKey:@"week3"];
    [request setPostValue:[interval4 substringFromIndex:[interval4 length]-10] forKey:@"week4"];
    [request setPostValue:userid forKey:@"user"];
    [request setPostValue:@"daily" forKey:@"queryType"];

    NSLog(@"interval : %@ %@ %@ %@",[interval1 substringFromIndex:[interval1 length]-10] ,[interval2 substringFromIndex:[interval2 length]-10],[interval3 substringFromIndex:[interval3 length]-10] ,[interval4 substringFromIndex:[interval4 length]-10] );
    [request setCompletionBlock:^{
        
        NSArray *arr=[request.responseString componentsSeparatedByString:@"^^^^^"];
        NSLog(@"response string: %@",request.responseString);
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
        NSLog(@"results array : %@    targets array : %@",resultsArray,targetsArray);
        
        
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
    DailyResultsCell *cell      =[[[DailyResultsCell alloc] init] autorelease];
    
    double perc1,perc2,perc3,perc4;
    if(indexPath.row==0)
    {
        cell.dayLabel.text=[interval1 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
    }
    else
        if(indexPath.row==1)
        {
            cell.dayLabel.text=[interval2 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
        }
        else
            if(indexPath.row==2)
            {
                cell.dayLabel.text=[interval3 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
            }
            else
            {
                cell.dayLabel.text=[interval4 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
            }

    
    if(([[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue]>0 && [[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue] >0 )||([[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue]>0))
        
        perc1=([[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue] / [[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue])*100;
    else
        perc1=0;
    
    NSLog(@"  --> %f   --> %f   --> %f",[[[resultsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue],[[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue],[[[targetsBigArray objectAtIndex:indexPath.row] objectAtIndex:0] floatValue]);
    
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
    if ([percentage1 intValue] >= 99.9) {
        cell.meetingsLabel.textColor = [UIColor greenColor];
    }
    [percentage1 release];
    
    cell.priceLabel.text=[NSString stringWithFormat:@"%@ / %@",percentage2,[[bigArray objectAtIndex:indexPath.row] objectAtIndex:1]];
    if ([percentage2 intValue] >= 99.9) {
        cell.priceLabel.textColor = [UIColor greenColor];
    }
    [percentage2 release];
    
    cell.salesLabel.text=[NSString stringWithFormat:@"%@ / %@",percentage3,[[bigArray objectAtIndex:indexPath.row] objectAtIndex:2]];
    
    int hours   = floor([[[bigArray objectAtIndex:indexPath.row] objectAtIndex:3]intValue]/3600);
    int minutes = round(([[[bigArray objectAtIndex:indexPath.row] objectAtIndex:3] intValue]- hours * 3600)/60);
    int seconds = round([[[bigArray objectAtIndex:indexPath.row] objectAtIndex:3] intValue] - minutes * 60 -hours*3600);
    
    cell.timeAttendLabel.text=[NSString stringWithFormat:@"%@ / %ih:%im:%is",percentage4,hours,minutes,seconds];
    if ([percentage4 intValue] >= 99.9) {
        cell.timeAttendLabel.textColor = [UIColor greenColor];
    }
    [percentage4 release];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSNumberFormatter *numberFormatter2=[[NSNumberFormatter alloc] init];
    
    [numberFormatter2 setGroupingSize:3];
    
    [numberFormatter2 setGroupingSeparator:@","];
    
    [numberFormatter2 setUsesGroupingSeparator:YES];
    
    int value =[[[bigArray objectAtIndex:indexPath.row] objectAtIndex:2] intValue];
    
    
    [cell.salesLabel  setText:[NSString stringWithFormat:@"%@ / %@",percentage3,[numberFormatter2 stringFromNumber:[NSNumber numberWithInt:value]]] ];
    [numberFormatter2 release];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([percentage3 intValue] >= 99.9) {
        cell.salesLabel.textColor = [UIColor greenColor];
    }
    [percentage3 release];

    
    double roundBtnPercentageValue=(perc1+perc2+perc3+perc4)/4;
    // If the above is 100% or over, change the button to green
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
