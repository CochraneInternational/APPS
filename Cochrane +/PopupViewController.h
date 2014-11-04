//
//  PopupViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/24/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ASIFormDataRequest.h"
#import "Global.h"

@interface PopupViewController : UIViewController<UITextViewDelegate>
{
    UITextView    *textView;
    UIButton      *sendMessage;
}

@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong)  UITextView    *textView;
@property (nonatomic,strong) UIButton      *sendMessage;
@end
