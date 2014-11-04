//
//  ScanBussinessViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "CameraFocusSquare.h"
#import "Global.h"
#import "ModifyScannedImageViewController.h"
#import "CaptureSessionManager.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ScanBussinessViewController : UIViewController<UIScrollViewDelegate,AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureFileOutputRecordingDelegate>
{
    UIImageView                 *background;
    UIImageView                 *businessView;
    UIImageView                 *frameView;
    
    UIButton                    *backButton;
    UIButton                    *cameraButton;
    UIView                      *cameraView;
    UIScrollView                *cameraViewScroll;
    AVCaptureDevice             *device;
    CameraFocusSquare           *camFocus;
    AVCaptureVideoPreviewLayer  *captureVideoPreviewLayer;
    AVCaptureVideoDataOutput    *frameOutput;
    
    

    UIImage *image;
}
@property (nonatomic, strong) UIView *containerView;
@property (retain) CaptureSessionManager *captureManager;
@property(nonatomic,retain) ALAssetsLibrary *library;

//- (void)centerScrollViewContents;
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

@end
