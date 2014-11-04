//
//  BrochureVisualisationViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/11/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class MessageComposerViewController;

@interface BrochureVisualisationViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    UIImageView *background;
    UIButton    *backButton;

}

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *path;

@end
