//
//  CurrentLocationViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 10/17/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "CurrentLocationViewController.h"

@interface CurrentLocationViewController ()

@end

@implementation CurrentLocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [background setImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:background];
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    upView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    upView.image=[UIImage imageNamed:@"ADMIN_pageSelectedSalesman.png"];
    //    upView.layer.borderColor=[UIColor blackColor].CGColor;
    //    upView.layer.borderWidth=2;
    [self.view addSubview:upView];
    
    
    navTitle                        =[[UILabel alloc] init];
    //    navTitle.frame                  =CGRectMake(self.view.frame.size.width/2-100, 0, 200, 40);
    navTitle.frame                  =CGRectMake(self.view.frame.size.width/2-[UIScreen mainScreen].bounds.size.width*0.31, 0, 0.62*[UIScreen mainScreen].bounds.size.width, 0.07*[UIScreen mainScreen].bounds.size.height);
    //    navTitle.layer.borderWidth      =2;
    //    navTitle.layer.borderColor      =[UIColor blackColor].CGColor;
    navTitle.backgroundColor        =[UIColor clearColor];
    navTitle.textAlignment          = NSTextAlignmentCenter;
    navTitle.text                   =@"Current Location";
    navTitle.font                   =[UIFont fontWithName:@"ArialMT" size:18];
    navTitle.textColor              =[UIColor whiteColor];
    [self.view addSubview:navTitle];

    myMap =[[MKMapView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-myMap.frame.origin.y)];
    myMap.delegate=self;
    [self.view addSubview:myMap];
    responseArray =[[NSMutableArray alloc] init];
    [self callPHPToGiveLocations];
 
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager startUpdatingLocation];
    
    
    time = [NSTimer scheduledTimerWithTimeInterval: 1800.0 target: self
                                               selector: @selector(callPHPToGiveLocations) userInfo: nil repeats: YES];
	// Do any additional setup after loading the view.
}

-(void)callPHPToGiveLocations
{
    ASIFormDataRequest *req =[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@currentLocation.php",SERVER]]];
    [req setCompletionBlock:^{
        NSArray *resp =[req.responseString componentsSeparatedByString:@"++++"];
        for(int i=0;i<[resp count];i++)
        {
            if([[resp objectAtIndex:i] length]>0)
            {
                NSString *tmp =[resp objectAtIndex:i] ;
                NSArray *arr =[tmp componentsSeparatedByString:@"^^^"];
                [responseArray addObject:arr];
                
            }
        }
        [self addPins];
    }];
    [req setFailedBlock:^{
        NSLog(@"current location failed");
    }];
    [req startAsynchronous];
    
}

-(void)addPins
{
    NSLog(@"responses array: %@    --> count : %i",responseArray,[responseArray count]);
    if([responseArray count]==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"No current location could be retrieved!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else
    {
        //    NSLog(@"pins: %@",responseArray);
        [myMap removeAnnotations:myMap.annotations];
        for(int i=0;i<[responseArray count];i++)
        {
            if(i==0)
            {
                [myMap setCenterCoordinate:CLLocationCoordinate2DMake([[[responseArray objectAtIndex:0] objectAtIndex:2] doubleValue], [[[responseArray objectAtIndex:0] objectAtIndex:3] doubleValue]) animated:YES];
            }
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            [point setCoordinate:CLLocationCoordinate2DMake([[[responseArray objectAtIndex:i] objectAtIndex:2] doubleValue], [[[responseArray objectAtIndex:i] objectAtIndex:3] doubleValue])];
            point.title = [[responseArray objectAtIndex:i] objectAtIndex:1];
            point.subtitle = [[responseArray objectAtIndex:i] objectAtIndex:0];
            [myMap addAnnotation:point];
            
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [time invalidate];
    time=nil;
    [myMap release];
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromLeft;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backButtonPressed:(UIButton *)sender
{
    [time invalidate];
    time=nil;
    [myMap release];
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromLeft;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"locations : %@",locations);
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
