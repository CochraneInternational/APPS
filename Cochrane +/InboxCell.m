//
//  InboxCell.m
//  SalesApp
//
//  Created by Diana Mihai on 7/26/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "InboxCell.h"


@implementation InboxCell
@synthesize readUnread;
@synthesize messLabel;
@synthesize background;
@synthesize infosLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        background         =[[UIImageView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 60)];
        background.image   =[UIImage imageNamed:@"priorityCell.png"];
        [self addSubview:background];
        
//        [self sendSubviewToBack:background];
        
        
        infosLabel      =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        infosLabel.font     =[UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:18.0];
        infosLabel.backgroundColor=[UIColor clearColor];
        [infosLabel setTextColor:[UIColor blackColor]];
        [self addSubview:infosLabel];
        
//        readUnread=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//        readUnread.frame=CGRectMake(self.frame.size.width-80, 5, 80, 50);
//        [readUnread setUserInteractionEnabled:NO];
//        [self addSubview:readUnread];
        
        messLabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 30, self.frame.size.width-60, 60)];
        [messLabel setBackgroundColor:[UIColor clearColor]];
        [messLabel setTextColor:[UIColor blackColor]];
        [self addSubview:messLabel];
        
    }
    return self;
}

-(id)init
{
    if (self=[super init])
    {
              
    }
    return self;

}
-(void)readUnreadPressed:(UIButton *)sender
{
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
