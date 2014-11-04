//
//  SeeRouteSalesmanViewController.h
//  SalesApp
//
//  Created by Diana Mihai on 7/5/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"
#import "Global.h"
#import <QuartzCore/QuartzCore.h>

@interface SeeRouteSalesmanViewController : UIViewController<MKMapViewDelegate>
{
    MKMapView       *mapView;
    UIButton        *backButton;
    UIImageView     *background;

    MKPolyline* _routeLine;
    
    // the view we create for the line on the map
    MKPolylineView* _routeLineView;
    
    // the rect that bounds the loaded points
    MKMapRect _routeRect;
    NSMutableArray *points;
    NSMutableArray *countsPCTSS;
}

@end
