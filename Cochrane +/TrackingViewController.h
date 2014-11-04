//
//  TrackingViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 6/13/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>


@interface TrackingViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    MKMapView *myMapView; // map view
    UIButton *backButton;
}

@property (nonatomic, retain) MKMapView *myMapView;

@end
