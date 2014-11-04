//
//  DailyResultsViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/2/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ResultsViewController.h"
#import "DailyResultsCell.h"
#import "Global.h"
#import "ASIFormDataRequest.h"

@interface DailyResultsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView     *background;
    UIImageView     *backgroundDown;
    
    UIButton        *cancelBtn;

    UITableView     *dailyTable;
    int cellsNumber;
    
    NSMutableArray  *daysArray;
    NSMutableArray  *dailyResults;
    NSMutableArray  *datesArray;
    
    
    NSMutableString *interval1;
    NSMutableString *interval2;
    NSMutableString *interval3;
    NSMutableString *interval4;
    
    NSMutableArray *bigArray;
    NSMutableArray *resultsBigArray;
    NSMutableArray *targetsBigArray;

}

@property (nonatomic,strong) NSString *userid;
@end
