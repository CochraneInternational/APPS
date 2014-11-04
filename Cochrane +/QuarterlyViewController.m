//
//  QuarterlyViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/25/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "QuarterlyViewController.h"

@interface QuarterlyViewController ()

@end

@implementation QuarterlyViewController

@synthesize userid;

#pragma mark
#pragma mark Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}


#pragma mark
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"quarterlyResultsBackground_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"quarterlyResultsBackground_iPhone4.png"];
    }    [self.view addSubview:background];
    [background release];

    cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [cancelBtn setImage:[UIImage imageNamed:@"cancelBtn.png"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.showsTouchWhenHighlighted=YES;
    [self.view addSubview:cancelBtn];

    
    bigArray=[[NSMutableArray alloc] init];
    resultsBigArray     =[[NSMutableArray alloc] init];
    targetsBigArray     =[[NSMutableArray alloc] init];
    
     // Commented out because size of image not right    backgroundDown          =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    // backgroundDown.image    =[UIImage imageNamed:@"backgroundDown.png"];
   // [self.view addSubview:backgroundDown];
    
    interval1=[[NSMutableString alloc] init];
    interval2=[[NSMutableString alloc] init];
    interval3=[[NSMutableString alloc] init];
    interval4=[[NSMutableString alloc] init];
    
    [self calculateQuarters];

	// Do any additional setup after loading the view.
}

-(void)calculateQuarters
{
    
    NSString *lastDatePrevQuarter;
    NSString *firstDayPrevQuarter;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    //********************** Quarter 1 *************************//
    NSDate              *firstDayOfCurrentQuarter = [self firstDayOfCurrentQuarter];
    NSDateComponents    *minusOneDayComponent = [[NSDateComponents alloc] init];
    [minusOneDayComponent setDay:-1];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *firstDayOfPreviousQuarter = [gregorianCalendar dateByAddingComponents:minusOneDayComponent
                                                                           toDate:firstDayOfCurrentQuarter
                                                                          options:0];
    lastDatePrevQuarter=[dateFormatter stringFromDate:firstDayOfPreviousQuarter];
    
    NSDate *lastDayOfPreviousQuarter = [gregorianCalendar dateByAddingComponents:minusOneDayComponent
                                                                          toDate:firstDayOfCurrentQuarter
                                                                         options:0];
    firstDayPrevQuarter =[dateFormatter stringFromDate:[self firstDayOfQuarterFromDate:lastDayOfPreviousQuarter]];
    
    [interval1 appendString:firstDayPrevQuarter];
    [interval1 appendString:@" &&& "];
    [interval1 appendString:lastDatePrevQuarter];
    
    
    
    //********************** Quarter 2 *************************//
    firstDayOfCurrentQuarter = [self firstDayOfQuarterFromDate:lastDayOfPreviousQuarter];
    firstDayOfPreviousQuarter = [gregorianCalendar dateByAddingComponents:minusOneDayComponent
                                                                   toDate:firstDayOfCurrentQuarter
                                                                  options:0];
    lastDatePrevQuarter=[dateFormatter stringFromDate:firstDayOfPreviousQuarter];
    lastDayOfPreviousQuarter = [gregorianCalendar dateByAddingComponents:minusOneDayComponent
                                                                  toDate:firstDayOfCurrentQuarter
                                                                 options:0];
    firstDayPrevQuarter =[dateFormatter stringFromDate:[self firstDayOfQuarterFromDate:lastDayOfPreviousQuarter]];
    [interval2 appendString:firstDayPrevQuarter];
    [interval2 appendString:@" &&& "];
    [interval2 appendString:lastDatePrevQuarter];
    
    
    //********************** Quarter 3 *************************//
    
    firstDayOfCurrentQuarter = [self firstDayOfQuarterFromDate:lastDayOfPreviousQuarter];
    firstDayOfPreviousQuarter = [gregorianCalendar dateByAddingComponents:minusOneDayComponent
                                                                   toDate:firstDayOfCurrentQuarter
                                                                  options:0];
    lastDatePrevQuarter=[dateFormatter stringFromDate:firstDayOfPreviousQuarter];
    lastDayOfPreviousQuarter = [gregorianCalendar dateByAddingComponents:minusOneDayComponent
                                                                  toDate:firstDayOfCurrentQuarter
                                                                 options:0];
    firstDayPrevQuarter =[dateFormatter stringFromDate:[self firstDayOfQuarterFromDate:lastDayOfPreviousQuarter]];
    [interval3 appendString:firstDayPrevQuarter];
    [interval3 appendString:@" &&& "];
    [interval3 appendString:lastDatePrevQuarter];
    
    //********************** Quarter 4 *************************//
    
    firstDayOfCurrentQuarter = [self firstDayOfQuarterFromDate:lastDayOfPreviousQuarter];
    firstDayOfPreviousQuarter = [gregorianCalendar dateByAddingComponents:minusOneDayComponent
                                                                   toDate:firstDayOfCurrentQuarter
                                                                  options:0];
    lastDatePrevQuarter=[dateFormatter stringFromDate:firstDayOfPreviousQuarter];
    lastDayOfPreviousQuarter = [gregorianCalendar dateByAddingComponents:minusOneDayComponent
                                                                  toDate:firstDayOfCurrentQuarter
                                                                 options:0];
    firstDayPrevQuarter =[dateFormatter stringFromDate:[self firstDayOfQuarterFromDate:lastDayOfPreviousQuarter]];
    [interval4 appendString:firstDayPrevQuarter];
    [interval4 appendString:@" &&& "];
    [interval4 appendString:lastDatePrevQuarter];
    
  
    
    [gregorianCalendar      release];
    [minusOneDayComponent   release];
    [dateFormatter          release];
    
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getWeeklyResults.php",SERVER]]];//@"http://www.x-2.info/SalesApp_php/Targets/getWeeklyResults.php"]];
    [request setPostValue:interval1 forKey:@"week1"];
    [request setPostValue:interval2 forKey:@"week2"];
    [request setPostValue:interval3 forKey:@"week3"];
    [request setPostValue:interval4 forKey:@"week4"];
    [request setPostValue:userid forKey:@"user"];
    [request setPostValue:@"quarter" forKey:@"queryType"];
    
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



-(NSDate *)firstDayOfCurrentQuarter
{
    return [self firstDayOfQuarterFromDate:[NSDate date]];
}

-(NSDate *)firstDayOfQuarterFromDate:(NSDate *)date
{
    NSCalendar *gregorianCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];//analyze
    NSDateComponents *components = [gregorianCalendar components:NSMonthCalendarUnit | NSYearCalendarUnit
                                                        fromDate:date];
    
    NSInteger quarterNumber = floor((components.month - 1) / 3) + 1;
    
    NSInteger firstMonthOfQuarter = (quarterNumber - 1) * 3 + 1;
    [components setMonth:firstMonthOfQuarter];
    [components setDay:1];
    
    // Zero out the time components so we get midnight.
    [self zeroOutTimeComponents:&components];
    return [gregorianCalendar dateFromComponents:components];
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


-(void)zeroOutTimeComponents:(NSDateComponents **)components {
    [*components setHour:0];
    [*components setMinute:0];
    [*components setSecond:0];
}


-(void)showTable
{
    quarterlyTable =[[UITableView alloc] initWithFrame:CGRectMake(0, cancelBtn.frame.size.height+cancelBtn.frame.origin.y+40, self.view.frame.size.width, self.view.frame.size.height-(cancelBtn.frame.size.height+cancelBtn.frame.origin.y+40))];
    quarterlyTable.delegate=self;
    quarterlyTable.dataSource=self;
    quarterlyTable.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:quarterlyTable];
    
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
    WeeklyResultsCell *cell      =[[[WeeklyResultsCell alloc] init] autorelease]; // analyze
    
    if(indexPath.row==0)
    {
        cell.weekLabel.text=[interval1 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
    }
    else
        if(indexPath.row==1)
        {
            cell.weekLabel.text=[interval2 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
        }
        else
            if(indexPath.row==2)
            {
                cell.weekLabel.text=[interval3 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
            }
            else
            {
                cell.weekLabel.text=[interval4 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
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
    cell.priceLabel.text=[NSString stringWithFormat:@"%@ / %@",percentage2,[[bigArray objectAtIndex:indexPath.row] objectAtIndex:1]];
    cell.salesLabel.text=[NSString stringWithFormat:@"%@ / %@",percentage3,[[bigArray objectAtIndex:indexPath.row] objectAtIndex:2]];

    
    int hours   = floor([[[bigArray objectAtIndex:indexPath.row] objectAtIndex:3]intValue]/3600);
    int minutes = round(([[[bigArray objectAtIndex:indexPath.row] objectAtIndex:3] intValue]- hours * 3600)/60);
    int seconds = round([[[bigArray objectAtIndex:indexPath.row] objectAtIndex:3] intValue] - minutes * 60 -hours*3600);
    
    cell.timeAttendLabel.text=[NSString stringWithFormat:@"%@ / %ih:%im:%is",percentage4,hours,minutes,seconds];

    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSNumberFormatter *numberFormatter2=[[NSNumberFormatter alloc] init];
    
    [numberFormatter2 setGroupingSize:3];
    
    [numberFormatter2 setGroupingSeparator:@","];
    
    [numberFormatter2 setUsesGroupingSeparator:YES];
    
    int value =[[[bigArray objectAtIndex:indexPath.row] objectAtIndex:2] intValue];
    
    
    [cell.salesLabel  setText:[NSString stringWithFormat:@"%@ / %@",percentage3,[numberFormatter2 stringFromNumber:[NSNumber numberWithInt:value]]] ];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    double roundBtnPercentageValue=(perc1+perc2+perc3+perc4)/4;
    NSMutableString *percRound=[[NSMutableString alloc] init];
    [percRound appendString:[NSString stringWithFormat:@"%.0f",roundBtnPercentageValue]] ;
    [percRound appendString:@"%"];
    [cell.roundBtn setTitle:percRound forState:UIControlStateNormal];
    [cell.roundBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cell.roundBtn.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
    [cell.roundBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];

    
    //analyze
    [percentage1 release];
    [percentage2 release];
    [percentage3 release];
    [percentage4 release];
    [numberFormatter2 release];
    [percRound release];
    
    
    
    return cell;
}



#pragma mark
#pragma mark Memory Mangement

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
