//
//  DailyResultsCell.m
//  SalesApp
//
//  Created by Diana Mihai on 7/17/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "DailyResultsCell.h"

@implementation DailyResultsCell
@synthesize dayLabel;
@synthesize meetingsLabel;
@synthesize timeAttendLabel;
@synthesize priceLabel;
@synthesize salesLabel;
@synthesize dayPercentageValue;
@synthesize roundBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

-(id)init
{
    if (self=[super init])
    {
        blueLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 30)];
        blueLine.image=[UIImage imageNamed:@"blueLine.png"];
        [self addSubview:blueLine];
        
     //   weekLabel                   =[[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 30)];
    //    weekLabel.backgroundColor   =[UIColor clearColor];
    //    weekLabel.textColor         =[UIColor whiteColor];
    //    weekLabel.textAlignment     =NSTextAlignmentCenter;
    //    [self addSubview:weekLabel];
        
        
        dayLabel                   =[[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 30)];
        dayLabel.backgroundColor   =[UIColor blackColor];
        dayLabel.textColor         =[UIColor whiteColor];
        dayLabel.textAlignment     =NSTextAlignmentCenter;
        [self addSubview:dayLabel];
        
        meetingsImgView         =[[UIImageView alloc] initWithFrame:CGRectMake(0, blueLine.frame.size.height+blueLine.frame.origin.y+30, [UIScreen mainScreen].bounds.size.width, 60)];
        meetingsImgView.image   =[UIImage imageNamed:@"meetings.png"];
        [self addSubview:meetingsImgView];
        
        timeAttendImgView       =[[UIImageView alloc] initWithFrame:CGRectMake(0, meetingsImgView.frame.size.height+meetingsImgView.frame.origin.y+5, [UIScreen mainScreen].bounds.size.width, meetingsImgView.frame.size.height)];
        timeAttendImgView.image =[UIImage imageNamed:@"timeAttend.png"];
        [self addSubview:timeAttendImgView];
        
        priceImgView        =[[UIImageView alloc] initWithFrame:CGRectMake(0, timeAttendImgView.frame.size.height+timeAttendImgView.frame.origin.y+5, [UIScreen mainScreen].bounds.size.width,  meetingsImgView.frame.size.height)];
        priceImgView.image  =[UIImage imageNamed:@"priceEstimate.png"];
        [self addSubview:priceImgView];
        
        salesImgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, priceImgView.frame.size.height+priceImgView.frame.origin.y+5, [UIScreen mainScreen].bounds.size.width,  meetingsImgView.frame.size.height)];
        salesImgView.image=[UIImage imageNamed:@"sales.png"];
        [self addSubview:salesImgView];
        
        
        
        meetingsLabel =[[UILabel alloc] initWithFrame:CGRectMake(60, blueLine.frame.size.height+blueLine.frame.origin.y+30, [UIScreen mainScreen].bounds.size.width-60, 35)];
        meetingsLabel.backgroundColor=[UIColor clearColor];
        meetingsLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:32];
        meetingsLabel.textColor=[UIColor redColor];
        meetingsLabel.numberOfLines=1;
        meetingsLabel.minimumFontSize=10;
        meetingsLabel.adjustsFontSizeToFitWidth=YES;
        [self addSubview:meetingsLabel];
        
        
        
        timeAttendLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, meetingsImgView.frame.size.height+meetingsImgView.frame.origin.y+5, [UIScreen mainScreen].bounds.size.width-60, 35)];
        timeAttendLabel.backgroundColor=[UIColor clearColor];
        timeAttendLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:32];
        timeAttendLabel.textColor=[UIColor redColor];
        timeAttendLabel.numberOfLines=1;
        timeAttendLabel.minimumFontSize=10;
        timeAttendLabel.adjustsFontSizeToFitWidth=YES;
        [self addSubview:timeAttendLabel];
        
        
        
        priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(60,timeAttendImgView.frame.size.height+timeAttendImgView.frame.origin.y+5, [UIScreen mainScreen].bounds.size.width-60, 35)];
        priceLabel.backgroundColor=[UIColor clearColor];
        priceLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:32];
        priceLabel.textColor=[UIColor redColor];
        priceLabel.numberOfLines=1;
        priceLabel.minimumFontSize=10;
        priceLabel.adjustsFontSizeToFitWidth=YES;
        [self addSubview:priceLabel];
        
        
        
        salesLabel=[[UILabel alloc] initWithFrame:CGRectMake(60,priceImgView.frame.size.height+priceImgView.frame.origin.y+5, [UIScreen mainScreen].bounds.size.width-60, 35)];
        salesLabel.backgroundColor=[UIColor clearColor];
        salesLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:32];
        salesLabel.textColor=[UIColor redColor];
        salesLabel.numberOfLines=1;
        salesLabel.minimumFontSize=10;
        salesLabel.adjustsFontSizeToFitWidth=YES;
        [self addSubview:salesLabel];
        
        roundBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [roundBtn setBackgroundImage:[UIImage imageNamed:@"roundRedButton.png"] forState:UIControlStateNormal];
        roundBtn.frame=CGRectMake(0, 17.5, 55, 55);
        [roundBtn setCenter:CGPointMake(25, 27)];
        [roundBtn setUserInteractionEnabled:NO];
        [self addSubview:roundBtn];
        
        
    }
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end

