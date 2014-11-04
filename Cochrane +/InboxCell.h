//
//  InboxCell.h
//  SalesApp
//
//  Created by Diana Mihai on 7/26/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
#import "PopupViewController.h"



@interface InboxCell : UITableViewCell
{
}

@property (nonatomic,strong) UIButton       *readUnread;
@property (nonatomic,strong) UILabel        *messLabel;
@property (nonatomic,strong) UIImageView    *background;
@property (nonatomic,strong) UILabel        *infosLabel;


@end
