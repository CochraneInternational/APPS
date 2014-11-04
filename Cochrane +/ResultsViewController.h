//
//  ResultsViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/3/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"

@interface ResultsViewController : UIViewController
{
    UIImageView *upView;
    UIImageView *background;
    UIButton    *backButton;
    
    UIButton    *dailyBtn;
    UIButton    *monthlyBtn;
    UIButton    *weeklyBtn;
    UIButton    *quarterlyBtn;
}
@end
