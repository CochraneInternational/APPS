//
//  SelectSalesmanViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/20/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SelectSalesmanCell.h"
#import "SelectedSalesmanViewController.h"
#import "ASIFormDataRequest.h"
#import "OverviewSalesmanViewController.h"

@interface SelectSalesmanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *background;
//    UIImageView *upView;
    UIButton    *backButton;
    UITableView *selectSalesmanTableView;
    NSMutableArray     *usersArray;
    NSTimer             *refreshTimer;
}

@end
