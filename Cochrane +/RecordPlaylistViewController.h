//
//  RecordPlaylistViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/24/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "RecordPlaylistCell.h"
#import <AVFoundation/AVFoundation.h>

@interface RecordPlaylistViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RecordDelegate,AVAudioPlayerDelegate>
{
    UIButton        *backButton;
    UIImageView     *background;
    UIImageView     *upView;
    
    UILabel         *navTitle;
    UITableView     *playlistTableView;
    
    NSMutableArray  *recordingsArray;
    
    
    UIView          *viewForPlaying;
    UISlider        *slider;
    UILabel         *beginLabel;
    UILabel         *endLabel;
    UILabel         *name;
    AVAudioPlayer   *player;

    NSTimer *timer;
}


//-(void)doSomething;
@end
