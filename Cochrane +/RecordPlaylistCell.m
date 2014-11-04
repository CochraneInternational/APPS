//
//  RecordPlaylistCell.m
//  SalesApp
//
//  Created by Diana Mihai on 7/24/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "RecordPlaylistCell.h"

@implementation RecordPlaylistCell
@synthesize playButton;
@synthesize delegate;
@synthesize background;
@synthesize imgSet;

#pragma mark
#pragma mark Init

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        background =[[UIImageView alloc] init];
        background.frame=CGRectMake(0,0, super.frame.size.width,  50);
        background.image=[UIImage imageNamed:@"recordListCell_play.png"];
        
        
        [self addSubview:background];
        [self sendSubviewToBack:background];

        imgSet=@"play";
    }
    return self;
}


#pragma mark
#pragma mark UIButton's Actions

//-(void)playRecording:(UIButton *)sender
//{
//    [self.delegate playEntry:sender.tag];
//}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
