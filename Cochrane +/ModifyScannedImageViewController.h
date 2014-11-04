//
//  ModifyScannedImageViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/10/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "HFImageEditorFrameView.h"
#import "HFImageEditorViewController.h"


@interface ModifyScannedImageViewController : HFImageEditorViewController<UIImagePickerControllerDelegate>
{
    UIButton                    *backButton;
    UIButton                    *saveButton;
   
}
//@property (nonatomic,strong)  HFImageEditorFrameView      *frameView;
@end
