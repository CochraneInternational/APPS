//
//  DetailPrioritiesViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/20/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"


@interface DetailPrioritiesViewController : UIViewController<UIAlertViewDelegate>
{
    UIButton        *backButton;
    UITableView     *prioritiesTable;
    
    UIImageView     *background;
    UIImageView     *upView;
    
    UILabel         *navTitle;
    UITextView      *moreDescriptions;
    UITextView      *moreDescriptions2;

    UIButton        *trashButton;
    UIButton        *nextButton;
    
    int index;
    NSString        *subviewVisible;
    NSMutableArray  *prioritiesArray;
    UIAlertView     *alert;

}

@end
