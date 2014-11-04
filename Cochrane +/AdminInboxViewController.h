//
//  AdminInboxViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/29/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "InboxCell.h"
#import "BottomView.h"
#import "SeeMessageViewController.h"
#import "ComposeNewMessageViewController.h"

@interface AdminInboxViewController : UIViewController<UITableViewDataSource,BottomViewDelegate,UITableViewDelegate>
{
    UIImageView     *background;
//    UIImageView *top;
    UIButton        *backButton;
    UIButton        *composeMessage;
    
    NSMutableArray  *messages;
    UITableView     *adminInboxTable;
    BottomView      *bottomView;
    BOOL            bottomIsUp;


}
@end
