//
//  BottomView.h
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"

@protocol BottomViewDelegate <NSObject>

-(void)actionOnSlideUpButton;
@optional
-(void)prioritiesView;
-(void)inboxView;
-(void)recordView;
-(void)brochureView;
-(void)scanBussiness;

@end

@interface BottomView : UIView
{
    UIButton *slideUpAndDown;
    UIButton *prioritiesButton;
    UIButton *inboxButton;
    UIButton *recordButton;
    UIButton *brochuresButton;
    UIButton *scanBusinnessCard;
    UIImageView *bottomImageView;
    
    UIImageView *messUnreadImgView;
    UILabel     *noOfMessUnread;
    
}

@property (nonatomic,strong) id<BottomViewDelegate> delegate;
@property (nonatomic,strong) UIImageView *messUnreadImgView;
@property (nonatomic,strong) UILabel     *noOfMessUnread;

@end
