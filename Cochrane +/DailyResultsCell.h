//
//  DailyResultsCell.h
//  SalesApp
//
//  Created by Diana Mihai on 7/17/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import <QuartzCore/QuartzCore.h>

@interface DailyResultsCell : UITableViewCell
{
    UIImageView *blueLine;
    UILabel     *percentageLabel;
    UILabel     *dayLabel;
    
    UIImageView *meetingsImgView;
    UIImageView *timeAttendImgView;
    UIImageView *priceImgView;
    UIImageView *salesImgView;
    
    UIButton     *roundBtn;
    UILabel     *meetingsLabel;
    UILabel     *timeAttendLabel;
    UILabel     *priceLabel;
    UILabel     *salesLabel;
}
    
@property (nonatomic,strong) UILabel    *dayLabel;
@property (nonatomic,strong) UILabel    *meetingsLabel;
@property (nonatomic,strong) UILabel    *timeAttendLabel;
@property (nonatomic,strong) UILabel    *priceLabel;
@property (nonatomic,strong) UILabel    *salesLabel;
@property (nonatomic,strong) NSString   *dayPercentageValue;
@property (nonatomic,strong) UIButton   *roundBtn;

@end
