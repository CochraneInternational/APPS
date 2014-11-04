//
//  BrochuresViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/15/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BrochuresCell.h"
#import "Global.h"
#import "ASIFormDataRequest.h"
#import "BrochureVisualisationViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "DejalActivityView.h"


@class MessageComposerViewController;

@interface BrochuresViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
    UIImageView     *background;
    UIImageView     *upView;
    UIButton        *backButton;
    UIButton        *sendButton;
    
    UITableView     *brochuresTableView;
    NSMutableArray  *brochures;
    NSMutableArray  *selectedCells;
    NSMutableArray  *selectedMarks;
    int totalFile;
//    NSString *filePathAndDirectory;

}

@end
