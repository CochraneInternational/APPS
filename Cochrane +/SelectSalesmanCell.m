//
//  SelectSalesmanCell.m
//  SalesApp
//
//  Created by Diana Mihai on 6/20/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "SelectSalesmanCell.h"

@implementation SelectSalesmanCell
@synthesize background;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellAtIndex:(int)index
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        background =[[UIImageView alloc] init];
        background.frame=CGRectMake(0,2, super.frame.size.width-0.15*[UIScreen mainScreen].bounds.size.width,  0.08*[UIScreen mainScreen].bounds.size.height);
//        if(index%2==0)
//        {
//            background.image=[UIImage imageNamed:@"ADMIN_salesmanBlueCell.png"];
//        }
//        else
//        {
//            background.image=[UIImage imageNamed:@"ADMIN_salesmanGrayCell.png"];
//        }
        
        [self addSubview:background];
        [self sendSubviewToBack:background];

        
        // Initialization code
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
