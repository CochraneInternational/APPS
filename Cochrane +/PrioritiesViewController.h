//
//  PrioritiesViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/14/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CustomTableCell.h"
#import "Global.h"
#import "DetailPrioritiesViewController.h"
#import "NewPriorityViewController.h"


@interface PrioritiesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UIButton        *backButton;
    UITableView     *prioritiesTable;
    
    UIImageView     *background;
    UIImageView     *upView;
    
    UIButton        *addPriorities;
    NSMutableArray  *prioritiesArray;
    UILabel *noData;
    
    
}



@end
