//
//  GlobalMapViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 8/8/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Global.h"
#import "DejalActivityView.h"
#import "ASIFormDataRequest.h"
#import "DropDownList.h"
#import "UAModalPanel.h"
#import "UAExampleModalPanel.h"
#import "UANoisyGradientBackground.h"
#import "UAGradientBackground.h"
#import "CustomTableCell.h"
#import "ViewForMap.h"

@interface GlobalMapViewController : UIViewController<UIScrollViewDelegate,UAModalPanelDelegate>
{
    UIButton        *backButton;
    UIScrollView    *scroll;
    UIImageView     *imgView;
    UIImageView     *coloredImage;
    UIImageView     *simpleImage;
    UIImageView     *background;
    UIImageView     *selectedImage;
//    int i=0;
    
    UIView  *countriesVIew;
    float original_width;
    float original_height;
    int n;
    
    NSArray *array;
    NSMutableArray  *countriesArray;
    float redSaved;
    float greenSaved;
    float blueSaved;
    
    
    float redDelete;
    float greenDelete;
    float blueDelete;
    
    
    NSMutableArray *globalReviewInfos;
    NSMutableArray *finalArray;
    NSMutableArray *viewRects;
    NSMutableArray *mergedArray;
    
}
@end
