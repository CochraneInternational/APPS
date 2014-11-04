//
//  CustomTableCell.m
//  SalesApp
//
//  Created by Diana Mihai on 6/15/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        
        background =[[UIImageView alloc] init];
        background.frame=CGRectMake(0,0, super.frame.size.width,  55);
        background.image=[UIImage imageNamed:@"priorityCell.png"];
       
        
        [self addSubview:background];
        [self sendSubviewToBack:background];
        [self setBackgroundColor:[UIColor clearColor]];
        

    }
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
