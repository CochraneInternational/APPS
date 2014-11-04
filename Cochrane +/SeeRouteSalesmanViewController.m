//
//  SeeRouteSalesmanViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/5/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "SeeRouteSalesmanViewController.h"
#define kAnimationDuration 1.0

@interface SeeRouteSalesmanViewController ()

@end

@implementation SeeRouteSalesmanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapView =[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mapView.delegate=self;
    [self.view addSubview:mapView];
    
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];

    
    points  = [[NSMutableArray alloc] init];
    countsPCTSS = [[NSMutableArray alloc] init];
    
    NSLog(@"    See route -> points: %@",pctsArray);
    float lat=0,lon=0;
    //int ok=0;
    for(int i=0;i<[pctsArray count];i++)
    {
        //NSMutableArray *pcts    = [[NSMutableArray alloc] init];
        for(int j=0;j<[[pctsArray objectAtIndex:i] count];j++)
        {
            if([[[pctsArray objectAtIndex:i] objectAtIndex:j] length]>0)
            {
                NSArray *sep = [[[pctsArray objectAtIndex:i] objectAtIndex:j] componentsSeparatedByString:@"^^"];
                NSLog(@"[[pctsArray objectAtIndex:i] objectAtIndex:j] : %@",[[pctsArray objectAtIndex:i] objectAtIndex:j]);
                
                if ([sep count] > 2) {
                    lat=[[sep objectAtIndex:1] floatValue];
                    lon=[[sep objectAtIndex:2] floatValue];
                    if (j==0) {
                        MKCoordinateRegion region;
                        region.center.latitude = lat;
                        region.center.longitude = lon;
                        [mapView setRegion:region animated:YES];
                    }
                    MapAnnotation *ann = [[MapAnnotation alloc] init];
                    ann.title = [sep objectAtIndex:0];
                    ann.coordinate = CLLocationCoordinate2DMake(lat, lon);
                    [mapView addAnnotation:ann];
                }
            }
        }
//        if([pcts count])
//        { [points addObject:pcts]; //[NSValue valueWithPointer:pctss]];
//            [pcts release];
//        }
    }
//    NSLog(@"lat: %f     lon: %f",lat,lon);
//
//    NSLog(@"points: %@",points);
    
//    for (int i=0; i<[points count]; i++)
//    {
//        MapAnnotation *annotation = [[MapAnnotation alloc] initWithPoints:points mapView:mapView];
//        [mapView addAnnotation:annotation];
//        [annotation release];
    

//    }

}


-(void)backButtonPressed:(UIButton *)sender
{
    
    CATransition *transition    =[CATransition animation];
    transition.duration         =kAnimationDuration;
    transition.timingFunction   =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type             =@"cube";
    transition.subtype          =kCATransitionFromLeft;
    transition.delegate         =self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(MKAnnotationView *)mapView:(MKMapView *)myMapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
                                          initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
        
        pinView.pinColor = MKPinAnnotationColorPurple;
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
    }
    else {
        [mapView.userLocation setTitle:@"Error"];
    }
    return pinView;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
