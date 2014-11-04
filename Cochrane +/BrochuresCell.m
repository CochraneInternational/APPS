//
//  BrochuresCell.m
//  SalesApp
//
//  Created by Diana Mihai on 6/15/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "BrochuresCell.h"

@implementation BrochuresCell

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self)
//    {
//        // Initialization code
//    }
//    return self;
//}

@synthesize name;
@synthesize brochurePath;
@synthesize background;
@synthesize isSelected = _isSelected;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellAtIndex:(int)index
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        name =[[UILabel alloc] initWithFrame:CGRectMake(0,5, super.frame.size.width-0.20*[UIScreen mainScreen].bounds.size.width,  0.09*[UIScreen mainScreen].bounds.size.height)];

        
        background =[[UIImageView alloc] init];
        background.frame=CGRectMake(0,5, super.frame.size.width-0.10*[UIScreen mainScreen].bounds.size.width,  0.09*[UIScreen mainScreen].bounds.size.height);
        if(index%2==0)
        {
            background.image=[UIImage imageNamed:@"brochuresCellBlueNew.png"];
            name.textColor =[UIColor whiteColor];
        }
        else
        {
            background.image=[UIImage imageNamed:@"brochurescCellGrayNew.png"];
            name.textColor =[UIColor blackColor];

        }
        
        [self addSubview:background];
//#ifdef DEBUG
//        name.layer.borderColor=[UIColor blackColor].CGColor;
//        name.layer.borderWidth=2;
//#endif
        name.backgroundColor=[UIColor clearColor];
        [name setFont:[UIFont fontWithName:@"ArialMT" size:20]];
        [self addSubview:name];
        
        self.layer.cornerRadius=6;
        self.layer.masksToBounds=YES;

    }
    return self;
}


-(void)setIsSelected:(BOOL)isSelected cellAtIndex:(int)index
{
    _isSelected = isSelected;
    
    if(index%2==0)
    {
        background.image = (isSelected) ? [UIImage imageNamed:@"brochuresChecked.png"] : [UIImage imageNamed:@"brochuresCellBlueNew.png"];
    }
    else
    {
        background.image = (isSelected) ? [UIImage imageNamed:@"brochuresChecked.png"] : [UIImage imageNamed:@"brochurescCellGrayNew.png"];
    }
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
