//
//  NewPriorityViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 8/13/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"

@interface NewPriorityViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    UIButton        *backButton;
    UIButton        *saveButton;
    UIImageView     *background;
    
    UITextField     *headline;
    UITextView      *notesTextView;

}

@end
