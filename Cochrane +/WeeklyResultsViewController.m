//
//  WeeklyResultsViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/19/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "WeeklyResultsViewController.h"

@interface WeeklyResultsViewController ()

@end

@implementation WeeklyResultsViewController
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
    
    background          =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"weeklyResultsBackground_iPhone4"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"weeklyResultsBackground_iPhone4"];
    }
    
    [self.view addSubview:background];
   
    
    cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [cancelBtn setImage:[UIImage imageNamed:@"cancelBtn.png"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.showsTouchWhenHighlighted=YES;
    [self.view addSubview:cancelBtn];
    

    
    bigArray=[[NSMutableArray alloc] init];
    resultsBigArray     =[[NSMutableArray alloc] init];
    targetsBigArray     =[[NSMutableArray alloc] init];
    [self calculateWeeks];
    
    // Commented out because size of image not right
   // backgroundDown          =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
   // backgroundDown.image    =[UIImage imageNamed:@"backgroundDown.png"];
   // [self.view addSubview:backgroundDown];


	// Do any additional setup after loading the view.
}


-(void)calculateWeeks
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]]; //1=sunday, 2=monday, etc
    [calendar release];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    week1=[[NSMutableString alloc] init];
    week2=[[NSMutableString alloc] init];
    week3=[[NSMutableString alloc] init];
    week4=[[NSMutableString alloc] init];
    week5=[[NSMutableString alloc] init];

    
    NSDateComponents *componentsToSubtract= [[[NSDateComponents alloc] init] autorelease];
    NSDateComponents *componentsToAdd;
    NSDate *day =[NSDate date];
    
    if(comps.weekday>4)
    {
        [componentsToSubtract setDay:-(comps.weekday/2+1)];
        
        day = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
        
        [week1 appendString:[dateFormatter stringFromDate:day]];
        [week1 appendString:@"&&&"];
        [week1 appendString:[dateFormatter stringFromDate:[NSDate date]]];
    }
    

    
    //********************** LAST WEEK : MONDAY DATE and FRIDAY DATE (week 2) **********************//
    
    [componentsToSubtract setDay:-7];
    
    componentsToAdd = [[[NSDateComponents alloc] init] autorelease];
    [componentsToAdd setDay:4];
    
    
    NSDate *prevMonday = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToSubtract toDate:day options:0];
    NSDate *prevFriday = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToAdd toDate:prevMonday options:0];
    
    [week2 appendString:[dateFormatter stringFromDate:prevMonday]];
    [week2 appendString:@"&&&"];
    [week2 appendString:[dateFormatter stringFromDate:prevFriday]];
    
    
    //**********************  MONDAY DATE and FRIDAY DATE (week 3) **********************//
    
    NSDate *monday3 = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToSubtract toDate:prevMonday options:0];
    NSDate *friday3 = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToAdd toDate:monday3 options:0];
    
    [week3 appendString:[dateFormatter stringFromDate:monday3]];
    [week3 appendString:@"&&&"];
    [week3 appendString:[dateFormatter stringFromDate:friday3]];
    
    
    
    //**********************  MONDAY DATE and FRIDAY DATE (week 4) **********************//
    
    NSDate *monday4 = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToSubtract toDate:monday3 options:0];
    NSDate *friday4 = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToAdd toDate:monday4 options:0];
    
    [week4 appendString:[dateFormatter stringFromDate:monday4]];
    [week4 appendString:@"&&&"];
    [week4 appendString:[dateFormatter stringFromDate:friday4]];
    
    
    //**************************************************************************************//
    
    
    //**********************  MONDAY DATE and FRIDAY DATE (week 4) **********************//
    
    NSDate *monday5 = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToSubtract toDate:monday4 options:0];
    NSDate *friday5 = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToAdd toDate:monday5 options:0];
    
    [week5 appendString:[dateFormatter stringFromDate:monday5]];
    [week5 appendString:@"&&&"];
    [week5 appendString:[dateFormatter stringFromDate:friday5]];
    
    [dateFormatter release];
    //**************************************************************************************//

    
    NSLog(@"week2: %@",week2);
    NSLog(@"week3: %@",week3);
    NSLog(@"week4: %@",week4);
    NSLog(@"week5: %@",week5);
    
    
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getWeeklyResults.php",SERVER]]];//@"http://www.x-2.info/SalesApp_php/Targets/getWeeklyResults.php"]];
    [request setPostValue:week2 forKey:@"week1"];
    [request setPostValue:week3 forKey:@"week2"];
    [request setPostValue:week4 forKey:@"week3"];
    [request setPostValue:week5 forKey:@"week4"];
    [request setPostValue:userid forKey:@"user"];
    [request setPostValue:@"week" forKey:@"queryType"];

    
    [request setCompletionBlock:^{
        
        NSLog(@"weekly response string: %@",request.responseString);
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

#pragma mark
#pragma mark UIButton's Action


-(void)showTable
{
    weeklyTable =[[UITableView alloc] initWithFrame:CGRectMake(0, cancelBtn.frame.size.height+cancelBtn.frame.origin.y+40, self.view.frame.size.width, self.view.frame.size.height-(cancelBtn.frame.size.height+cancelBtn.frame.origin.y+40))];
    weeklyTable.delegate=self;
    weeklyTable.dataSource=self;
    weeklyTable.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:weeklyTable];

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
        cell.weekLabel.text=[week2 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
    }
    else
        if(indexPath.row==1)
        {
            cell.weekLabel.text=[week3 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
        }
        else
            if(indexPath.row==2)
            {
                cell.weekLabel.text=[week4 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
            }
            else
            {
                cell.weekLabel.text=[week5 stringByReplacingOccurrencesOfString:@"&&&" withString:@" - "];
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
    [percentage3 release];
    [numberFormatter2 release];
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





#pragma mark
#pragma mark Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
