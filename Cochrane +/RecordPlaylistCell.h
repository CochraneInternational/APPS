//
//  RecordPlaylistCell.h
//  SalesApp
//
//  Created by Diana Mihai on 7/24/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecordDelegate <NSObject>

-(void)playEntry :(int)tag;
@end

@interface RecordPlaylistCell : UITableViewCell
{
    UILabel         *name;
    UIImageView     *background;
    UIButton        *playButton;
}


@property (nonatomic,strong) id<RecordDelegate> delegate;
@property (nonatomic,strong) UIButton        *playButton;
@property (nonatomic,strong) UIImageView     *background;
@property (nonatomic,strong) NSString        *imgSet;
@end
