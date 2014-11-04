//
//  PushNotificationsViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/9/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIFormDataRequest.h"

@interface PushNotificationsViewController : UIViewController
{
    UITextView     *textField;
    UIImageView     *background;
    UIButton        *sendPushes;
    UIButton        *backButton;
    UITapGestureRecognizer  *singleTap;


}

@end
