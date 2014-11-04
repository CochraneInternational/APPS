//
//  TrackingViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/13/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "TrackingViewController.h"
#import "myAnnotation.h"
#define kAnimationDuration 1.0
#define METERS_PER_MILE 1609.344

@interface TrackingViewController ()

@end

@implementation TrackingViewController

@synthesize myMapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Back Button
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    // View loaded, add the map
    //self.myMapView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 40.740848;
    zoomLocation.longitude = -73.991145;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
    [self.myMapView setRegion:viewRegion animated:YES];
}

-(void)backButtonPressed:(UIButton *)sender
{
    
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromLeft;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -MapView Delegate Methods
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *identifier = @"myAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[self.myMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    } else {
        annotationView.annotation = annotation;
    }
    
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}

@end
