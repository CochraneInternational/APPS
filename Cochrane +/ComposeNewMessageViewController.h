//
//  ComposeNewMessageViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/29/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownList.h"
#import "ASIFormDataRequest.h"
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
#import "DejalActivityView.h"

@interface ComposeNewMessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DropDownListDelegate>
{
    UITableView     *table;
    DropDownList    *myDropDownList;
	NSMutableArray  *dropDownListItems;

    UIButton        *sendButton;
    UILabel         *toLabel;
    UIButton        *backButton;

    UITextView      *txtView;
    int selectedID;

//    UIButton        *sendButton;
}

@end


@interface ComposeNewMessageViewController (Private)
{
}

- (void) _initDropDownList;
- (void) _initDropDownListContent;
- (void) _initLembergsLogo;
//@property (nonatomic,strong) ;

@end