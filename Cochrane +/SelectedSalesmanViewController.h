//
//  SelectedSalesmanViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/21/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"

@interface SelectedSalesmanViewController : UIViewController
{
    UIImageView     *background;
    UIImageView     *upView;
    UIButton        *backButton;
    UILabel         *navTitle;
    UIImageView     *middle;
    
    UIButton        *meetingsButton;
    UIButton        *timeAttendanceButton;
    UIButton        *priceEstimateButton;
    UIButton        *salesButton;
    UIButton        *trackingHistoryButton;
    UIButton        *sendMessageButton;
}
@end
