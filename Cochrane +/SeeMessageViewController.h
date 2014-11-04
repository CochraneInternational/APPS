//
//  SeeMessageViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/29/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
#import "PopupViewController.h"

@interface SeeMessageViewController : UIViewController
{
    UIImageView *background;
    UITextView  *message;
    UIButton    *backButton;
    UIButton    *replyToSender;
}

@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *sender;
@property (nonatomic) int index;
@end
