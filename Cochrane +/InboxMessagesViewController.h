//
//  InboxMessagesViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/25/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "InboxCell.h"
#import "BottomView.h"
#import "RecordViewController.h"
#import "ScanBussinessViewController.h"
#import "TrackingViewController.h"
#import "PrioritiesViewController.h"
#import "BrochuresViewController.h"
#import "SeeMessageViewController.h"

@interface InboxMessagesViewController : UIViewController<UITableViewDataSource,BottomViewDelegate,UITableViewDelegate>
{
    UIImageView     *background;
    UIImageView     *top;
    UIImageView     *inboxIcon;

    UIButton        *backButton;
    
    NSMutableArray  *messages;
    UITableView     *inboxTableView;

    BottomView      *bottomView;

    BOOL            bottomIsUp;
}


@property (nonatomic,strong) UITextView *mess;
@property (nonatomic,strong) NSString   *text;



@end
