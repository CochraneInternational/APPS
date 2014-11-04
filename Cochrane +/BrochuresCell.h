//
//  BrochuresCell.h
//  SalesApp
//
//  Created by Diana Mihai on 6/15/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BrochuresCell : UITableViewCell
{
    UILabel         *name;
    UIImageView     *background;
    NSString        *brochurePath;
    
    UIButton        *checkbox;
}

@property (nonatomic,strong) UILabel         *name;
@property (nonatomic,strong) UIImageView     *background;
@property (nonatomic,strong) NSString        *brochurePath;
@property (nonatomic,assign) BOOL   isSelected;
@property (nonatomic,assign) float  fileSize;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellAtIndex:(int)index;
-(void)setIsSelected:(BOOL)isSelected cellAtIndex:(int)index;

@end
