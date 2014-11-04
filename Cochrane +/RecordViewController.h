//
//  RecordViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "RecordPlaylistViewController.h"
#import "Global.h"

@interface RecordViewController : UIViewController<AVAudioRecorderDelegate,AVAudioPlayerDelegate,UIAlertViewDelegate>
{
    UIImageView     *background;
    UIImageView     *recordView;
    
    UIButton        *backButton;
    UIButton        *start;
    UIButton        *stop;
    UIButton        *playlistButton;
    UIButton        *play;
    UIButton        *save;
    
    AVAudioPlayer   *player;
    AVAudioRecorder *recorder;
    
    UIAlertView     *prompt;
    UITextField     *textField;
    
    
}

@end
