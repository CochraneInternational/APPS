//
//  WeeklyResultsViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/19/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "ASIFormDataRequest.h"
#import "WeeklyResultsCell.h"


@interface WeeklyResultsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{ UIImageView     *background;
    UIImageView     *backgroundDown;
    
    UIButton        *cancelBtn;
    
    UITableView     *weeklyTable;
    int             cellsNumber;
    
    NSMutableString *week1;
    NSMutableString *week2;
    NSMutableString *week3;
    NSMutableString *week4;
    NSMutableString *week5;
    
    NSMutableArray *bigArray;
    NSMutableArray *resultsBigArray;
    NSMutableArray *targetsBigArray;

}


@property (nonatomic,strong) NSString *userid;

@end
