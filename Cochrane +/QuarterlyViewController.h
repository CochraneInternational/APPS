//
//  QuarterlyViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/25/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "ASIFormDataRequest.h"
#import "WeeklyResultsCell.h"

@interface QuarterlyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView     *background;
    UIImageView     *backgroundDown;
    
    UIButton        *cancelBtn;
    
    UITableView     *quarterlyTable;
    int             cellsNumber;
    
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
