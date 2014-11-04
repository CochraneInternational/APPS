//
//  WeeklyResultsCell.h
//  SalesApp
//
//  Created by Diana Mihai on 7/19/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import <QuartzCore/QuartzCore.h>


@interface WeeklyResultsCell : UITableViewCell
{
    UIImageView *blueLine;
    UILabel     *percentageLabel;
    UILabel     *weekLabel;
    
    UIImageView *meetingsImgView;
    UIImageView *timeAttendImgView;
    UIImageView *priceImgView;
    UIImageView *salesImgView;

}


@property (nonatomic,strong) UILabel    *weekLabel;
@property (nonatomic,strong) UILabel    *meetingsLabel;
@property (nonatomic,strong) UILabel    *timeAttendLabel;
@property (nonatomic,strong) UILabel    *priceLabel;
@property (nonatomic,strong) UILabel    *salesLabel;
@property (nonatomic,strong) NSString   *dayPercentageValue;
@property (nonatomic,strong) UIButton   *roundBtn;

@end
