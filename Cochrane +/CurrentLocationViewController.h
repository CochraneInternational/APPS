//
//  CurrentLocationViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 10/17/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Global.h"
#import "ASIFormDataRequest.h"

@interface CurrentLocationViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
{
    MKMapView       *myMap;
    NSMutableArray  *responseArray;
    NSTimer         *time;
    UIImageView     *background;
    UIImageView     *upView;
    UILabel         *navTitle;
    UIButton        *backButton;
//    CLLocationManager *locationManager;
}

@property (nonatomic,strong)  CLLocationManager *locationManager;
@end
