//
//  GlobalMapViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 8/8/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "GlobalMapViewController.h"
#import "DejalActivityView.h"

@interface GlobalMapViewController ()

@end

@implementation GlobalMapViewController


#pragma mark
#pragma mark Init


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}


#pragma mark
#pragma mark View Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if(IS_IPHONE_5)
    {
        [background setImage:[UIImage imageNamed:@"globalReviewBackground_iPhone5.png"]];
    }
    else
    {
        [background setImage:[UIImage imageNamed:@"globalReviewBackground_iPhone4.png"]];

    }
    [self.view addSubview:background];
    
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    
    [self.view addSubview:backButton];
    
    viewRects =[[NSMutableArray alloc] init];
    
    
    
    n=0;
    scroll =[[UIScrollView alloc] initWithFrame:CGRectMake(0, backButton.frame.origin.y+backButton.frame.size.height+10, self.view.frame.size.width, self.view.frame.size.height-backButton.frame.origin.y+backButton.frame.size.height-10)];
    //    scroll.pagingEnabled=YES;
    scroll.scrollEnabled=YES;
    [scroll setBackgroundColor:[UIColor whiteColor]];
    
    scroll.delegate=self;
    scroll.maximumZoomScale=5.0f;
    scroll.minimumZoomScale=1.0f;
    

    countriesArray=[[NSMutableArray alloc] init];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"countriesArray"])
    {
        countriesArray =[[NSUserDefaults standardUserDefaults] objectForKey:@"countriesArray"];
    }
    else
    {
        NSString *path =[[NSBundle mainBundle] pathForResource:@"finalCountryFile" ofType:@"txt"];
        NSString *conntent=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        
        NSArray *array2 =[conntent componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        
        for(int i=0;i<[array2 count];i++)
        {
            NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] init];
            
            NSArray *item =[[array2 objectAtIndex:i] componentsSeparatedByString:@" Code: "];
            [dictionary setValue:[item objectAtIndex:1] forKey:@"countryCode"];
            
            
            NSArray *item2=[[item objectAtIndex:0] componentsSeparatedByString:@" bounds : "];
            [dictionary setValue:[item2 objectAtIndex:1] forKey:@"countryCenter"];
            
            
            NSArray *item3=[[item2 objectAtIndex:0] componentsSeparatedByString:@" : "];
            [dictionary setValue:[item3 objectAtIndex:1] forKey:@"countryName"];
            [dictionary setValue:[item3 objectAtIndex:0] forKey:@"countryRGB"];
            
            [countriesArray addObject:dictionary];
            [[NSUserDefaults standardUserDefaults] setObject:countriesArray forKey:@"countriesArray"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            

        }
        

    }
    finalArray=[[NSMutableArray alloc]init];
    mergedArray=[[NSMutableArray alloc] init];

    ASIFormDataRequest *req=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getGlobalReviewInfo.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_PHPFinal/iOS_Scripts/getGlobalReviewInfo.php"]];
    [req setCompletionBlock:^{
//        NSLog(@"req.  : %@",req.responseString);
        globalReviewInfos=[NSMutableArray arrayWithArray:[req.responseString componentsSeparatedByString:@"^^^"]]  ;
        [self requestCompleted];
    }];
    [req setFailedBlock:^{
    }];
    [req startAsynchronous];
      
    
    
  	// Do any additional setup after loading the view.
}



-(void)viewDidAppear:(BOOL)animated
{
//    [DejalActivityView activityViewForView:self.view ];
    
}

-(void)requestCompleted
{
    
    for(int i=0;i<[globalReviewInfos count]-1;i++)
    {
        NSString *string=[[globalReviewInfos objectAtIndex:i] substringFromIndex:[[globalReviewInfos objectAtIndex:i] rangeOfString:@"&&"].location];
        bool found=false;
        for(int k=0;k<[finalArray count];k++)
        {
            if ([[[finalArray objectAtIndex:k] objectForKey:@"countryCode"] rangeOfString:string].location!=NSNotFound)
            {
                found=true;
            }
        }
        
        
        if(found==false)
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
            [dict setValue:string forKey:@"countryCode"];
            NSMutableArray *arrayHep=[[NSMutableArray alloc] init];
            
            for(int j=0;j<[globalReviewInfos count]-1;j++)
            {
                if ([[globalReviewInfos objectAtIndex:j] rangeOfString:string].location!=NSNotFound)
                {
                    [arrayHep addObject:[globalReviewInfos objectAtIndex:j] ];
                }
            }
            
            [dict setObject:arrayHep forKey:@"array"];
            [finalArray addObject:dict];
        }
    }
    
    
    [self loadMap];
    
}


-(void)loadMap
{
    
    array=[[NSArray arrayWithObjects:
            @"coloredCountriesNewColors.png",
            @"worldMap.png"
            , nil] retain];
    
    
    scroll.contentSize = CGSizeMake(1425, 700);
    original_width=scroll.contentSize.width;
    original_height=scroll.contentSize.height;
    
    
    countriesVIew=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1425, 625)];
    
    
    coloredImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1425, 625)];
    [coloredImage setImage:[UIImage imageNamed:[array objectAtIndex:0]]];
    coloredImage.tag=1;
    [countriesVIew addSubview:coloredImage];
    
    
    simpleImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1425, 625)];
    [simpleImage setImage:[UIImage imageNamed:[array objectAtIndex:1]]];
    simpleImage.tag=2;
    [countriesVIew addSubview:simpleImage];
    
    selectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1425, 625)];
    selectedImage.tag=3;
    [countriesVIew addSubview:selectedImage];
    
    scroll.autoresizesSubviews=NO;
//    scroll.contentMode                       = UIViewContentModeRedraw;
//    scroll.autoresizingMask                  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [scroll addSubview:countriesVIew];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [scroll addGestureRecognizer:singleTap];
    
    [DejalActivityView removeView];
    [self.view addSubview:scroll];
    
    [self mergeArrays];
}

-(void)mergeArrays
{
    for(int i=0;i<[finalArray count];i++)
    {
        NSMutableDictionary    *dict=[[NSMutableDictionary alloc] init];

        [dict setObject:[[finalArray objectAtIndex:i] objectForKey:@"countryCode"] forKey:@"countryCode2"];
        [dict setObject:[[finalArray objectAtIndex:i] objectForKey:@"array"] forKey:@"array"];
        
        for(int j=0;j<[countriesArray count];j++)
        {
            if([[[finalArray objectAtIndex:i] objectForKey:@"countryCode"] isEqualToString:[[NSString stringWithFormat:@"&&%@",[[countriesArray objectAtIndex:j] valueForKey:@"countryCode"]] uppercaseString]])
            {
                [dict setObject:[[countriesArray objectAtIndex:j] objectForKey:@"countryCenter"] forKey:@"countryCenter"];
                [dict setObject:[[countriesArray objectAtIndex:j] objectForKey:@"countryCode"] forKey:@"countryCode"];
                [dict setObject:[[countriesArray objectAtIndex:j] objectForKey:@"countryName"] forKey:@"countryName"];
                [dict setObject:[[countriesArray objectAtIndex:j] objectForKey:@"countryRGB"] forKey:@"countryRGB"];

            }
        }
        [mergedArray addObject:dict];
    }
    
        
        
  /*  for(int i=0;i<[countriesArray count];i++)
    {
        int j=0;
        while ( j<[finalArray count] &&![[[finalArray objectAtIndex:j] objectForKey:@"countryCode"] isEqualToString:[[NSString stringWithFormat:@"&&%@",[[countriesArray objectAtIndex:i] valueForKey:@"countryCode"]] uppercaseString]])
        {
            j++;
        }
        if(j>=[finalArray count])
        {
            
        }
        else
        {
            NSMutableDictionary    *dict=[[NSMutableDictionary alloc] init];
            [dict setObject:[[countriesArray objectAtIndex:i] objectForKey:@"countryCenter"] forKey:@"countryCenter"];
            [dict setObject:[[countriesArray objectAtIndex:i] objectForKey:@"countryCode"] forKey:@"countryCode"];
            [dict setObject:[[countriesArray objectAtIndex:i] objectForKey:@"countryName"] forKey:@"countryName"];
            [dict setObject:[[countriesArray objectAtIndex:i] objectForKey:@"countryRGB"] forKey:@"countryRGB"];
            [dict setObject:[[finalArray objectAtIndex:j] objectForKey:@"countryCode"] forKey:@"countryCode2"];
            [dict setObject:[[finalArray objectAtIndex:j] objectForKey:@"array"] forKey:@"array"];
            
            [mergedArray addObject:dict];
            

        }
    }
    NSLog(@"merged array : %@ \n\n ",mergedArray);
   */
    
     NSLog(@"merged array : %@ \n\n ",mergedArray);
    [self colorMapAndPlacePins];
}


-(void)colorMapAndPlacePins
{

    [selectedImage setImage:[self inImage:coloredImage.image withTolerance:2.0f]];
    [self addPinsAndLabels];

}




#pragma mark
#pragma mark Intercepting Touches


- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{

    NSLog(@"view rects: %@",viewRects);
    CGPoint touchPoint=[gesture locationInView:scroll];
    bool found=false;
    for(int i=0;i<[viewRects count];i++)
    {
        if([[viewRects objectAtIndex:i] count]>0)
        {    if(CGRectContainsPoint(CGRectMake([[[viewRects objectAtIndex:i] objectAtIndex:0] floatValue], [[[viewRects objectAtIndex:i] objectAtIndex:1] floatValue], 200, 66), touchPoint))
            {
                
                if([[[viewRects objectAtIndex:i] objectAtIndex:2]  count]>1)
                {
                    found=true;
                    [self showModalPanel:i];
                    i=[viewRects count];
                }
                else
                {
                    NSString *tmp=[[[viewRects objectAtIndex:i] objectAtIndex:2]  objectAtIndex:0];
                    NSArray *arr=[tmp componentsSeparatedByString:@"~~~"];
                    OverviewSalesmanViewController *overview=[[[OverviewSalesmanViewController alloc] init] autorelease];
                    overview.name           =[arr objectAtIndex:0];
                    overview.salesmanTag    =[arr objectAtIndex:1];

                    
                    CATransition *transition =[CATransition animation];
                    transition.duration =kAnimationDuration;
                    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type =@"cube";
                    transition.subtype=kCATransitionFromRight;
                    transition.delegate=self;
                    [self.navigationController.view.layer addAnimation:transition forKey:nil];
                    [self.navigationController pushViewController:overview animated:YES];

                }
 
            }
        }

    }
  

    
}



#pragma mark
#pragma mark Popup

-(void)showModalPanel:(int)var
{
    UAExampleModalPanel *modalPanel = [[[UAExampleModalPanel alloc] initWithFrame:self.view.bounds title:var] autorelease];
	// Add the panel to our view
    modalPanel.parent=self;
//    NSLog(@"--> viewrect:S %@",viewRects);
    modalPanel.array=viewRects;
    modalPanel.position=var;
	[self.view addSubview:modalPanel];
	
	///////////////////////////////////
	// Show the panel from the center of the button that was pressed
	[modalPanel showFromPoint:CGPointMake(56, 38)];
}



#pragma mark - UAModalDisplayPanelViewDelegate


- (void)willShowModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"willShowModalPanel called with modalPanel: %@", modalPanel);
}

- (void)didShowModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"didShowModalPanel called with modalPanel: %@", modalPanel);
}

- (BOOL)shouldCloseModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"shouldCloseModalPanel called with modalPanel: %@", modalPanel);
	return YES;
}

- (void)didSelectActionButton:(UAModalPanel *)modalPanel {
	UADebugLog(@"didSelectActionButton called with modalPanel: %@", modalPanel);
}

- (void)willCloseModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"willCloseModalPanel called with modalPanel: %@", modalPanel);
}

- (void)didCloseModalPanel:(UAModalPanel *)modalPanel {
	UADebugLog(@"didCloseModalPanel called with modalPanel: %@", modalPanel);
}




-(UIImage*)inImage:(UIImage*)image withTolerance:(float)tolerance
{
    
    
    CGImageRef imageRef = [image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    NSUInteger bitmapByteCount = bytesPerRow * height;
    
    unsigned char *rawData = (unsigned char*) calloc(bitmapByteCount, sizeof(unsigned char));
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    //    CGContextSetAlpha();
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    NSMutableArray *colorArray =[[NSMutableArray alloc] init];

    for(int i=0;i<[mergedArray count];i++)
    {
        NSArray *rgb=[[[mergedArray objectAtIndex:i] objectForKey:@"countryRGB"] componentsSeparatedByString:@" "];
        [colorArray addObject:[UIColor colorWithRed:[[rgb objectAtIndex:0] floatValue]/255 green:[[rgb objectAtIndex:1] floatValue]/255 blue:[[rgb objectAtIndex:2] floatValue]/255 alpha:1.0]];

    }
    
    
    int byteIndex = 0;
    CGColorRef cgColor;
    float r,g,b;
    
    
    while (byteIndex < bitmapByteCount)
    {
        unsigned char red   = rawData[byteIndex];
        unsigned char green = rawData[byteIndex + 1];
        unsigned char blue  = rawData[byteIndex + 2];

        if(red==0 && green==0 && blue==0)
        {
        
        }
        else
        {
            for(int i=0;i<[colorArray count];i++)
            {
                cgColor= [[colorArray objectAtIndex:i] CGColor];
                const CGFloat *components = CGColorGetComponents(cgColor);
                r = components[0];
                g = components[1];
                b = components[2];
                //float a = components[3]; // not needed
                
                r = r * 255.0;
                g = g * 255.0;
                b = b * 255.0;
                
                const float redRange[2] = {
                    MAX(r - (tolerance / 2.0), 0.0),
                    MIN(r + (tolerance / 2.0), 255.0)
                };
                
                const float greenRange[2] = {
                    MAX(g - (tolerance / 2.0), 0.0),
                    MIN(g + (tolerance / 2.0), 255.0)
                };
                
                const float blueRange[2] = {
                    MAX(b - (tolerance / 2.0), 0.0),
                    MIN(b + (tolerance / 2.0), 255.0)
                };
                
                
                if (((red >= redRange[0]) && (red <= redRange[1])) &&
                    ((green >= greenRange[0]) && (green <= greenRange[1])) &&
                    ((blue >= blueRange[0]) && (blue <= blueRange[1])))
                    
                {
  
                        rawData[byteIndex] = r;
                        rawData[byteIndex + 1] = g;
                        rawData[byteIndex + 2] = b;
                        rawData[byteIndex + 3] = 255;
                    
                    

                    
//                    i=[countriesArray count];
                    
                    
                        i=[colorArray count];

                }
                else
                {

                        rawData[byteIndex] = 0;
                        rawData[byteIndex + 1] = 0;
                        rawData[byteIndex + 2] = 0;
                        rawData[byteIndex + 3] = 0;
                }
                
                
            }

        }
        
        byteIndex += 4;


    }
    //    CGImageRelease(imageRef);
    UIImage *result = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    free(rawData);
    return result;
    
}


#pragma mark
#pragma mark Add Pins
-(void)addPinsAndLabels
{
    for(int i=0;i<[mergedArray count];i++)
    {
        
        NSLog(@"   --> %@",[[mergedArray objectAtIndex:i] valueForKey:@"countryCode"]);
//        NSLog(@"\n\n\n i: %i ",i);
        NSArray *arr=[[[mergedArray objectAtIndex:i] valueForKey:@"countryCenter"] componentsSeparatedByString:@"_"];
    
        float centerx=[[arr objectAtIndex:0] floatValue];
        float centery=[[arr objectAtIndex:1] floatValue];
    
                
        NSMutableArray *arrAux=[[NSMutableArray alloc]init];


        NSString *lbl;
    if([[[mergedArray objectAtIndex:i] objectForKey:@"array"] count]>1)
    {
        
        lbl=[NSString stringWithFormat:@"MULTIPLE USERS - %@",[[[mergedArray objectAtIndex:i] valueForKey:@"countryCode"] uppercaseString]]  ;

//        lbl=@"";
        
        [arrAux addObject:[NSString stringWithFormat:@"%f",centerx - 175.5] ];
        [arrAux addObject:[NSString stringWithFormat:@"%f",centery-66] ];
        
        
        [arrAux addObject:[[mergedArray objectAtIndex:i] objectForKey:@"array"]];
        
        
        [viewRects addObject:arrAux];
        [arrAux release];
//        NSLog(@"multiple users: - %@ ",[[[mergedArray objectAtIndex:i] valueForKey:@"countryCode"] uppercaseString]);
    }
    else
        {

            NSArray *arr=[[[[[mergedArray objectAtIndex:i] objectForKey:@"array"] objectAtIndex:0] substringToIndex:[[[[mergedArray objectAtIndex:i] objectForKey:@"array"] objectAtIndex:0] rangeOfString:@"&&"].location] componentsSeparatedByString:@"~~~"];
            
            lbl=[NSString stringWithFormat:@"%@ - %@",[[arr objectAtIndex:0] uppercaseString],[[[mergedArray objectAtIndex:i] valueForKey:@"countryCode"] uppercaseString]];
//            NSLog(@" %@ : - %@ ",[[arr objectAtIndex:0] uppercaseString],[[[mergedArray objectAtIndex:i] valueForKey:@"countryCode"] uppercaseString]);

            [arrAux addObject:[NSString stringWithFormat:@"%f",centerx - 175.5] ];
            [arrAux addObject:[NSString stringWithFormat:@"%f",centery-66] ];
            
            
            [arrAux addObject:[[mergedArray objectAtIndex:i] objectForKey:@"array"]];
            
            
            [viewRects addObject:arrAux];
            [arrAux release];

        }
 
        
        ViewForMap *view=[[ViewForMap alloc] initWithFrame:CGRectMake(centerx -75, centery-25, 150, 49.5) label:lbl];

//        NSLog(@"           v.frame: %@",NSStringFromCGRect(view.frame));
        
        view.layer.anchorPoint  = CGPointMake(0.5, 0.5);
        view.tag                =123456;
        view.autoresizesSubviews=YES;
        
//#ifdef DEBUG
//        view.layer.borderColor=[UIColor blueColor].CGColor;
//        view.layer.borderWidth=2;
//#endif

    
        [countriesVIew addSubview:view];

    
//    [[scroll.subviews objectAtIndex:0] addSubview:view];
    }
}



-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{    

    
    for (UIView *dropPinView in countriesVIew.subviews) {
        
        if (dropPinView.tag==123456)
        {
            
            CGRect oldFrame = dropPinView.frame;
            dropPinView.frame = oldFrame;
            
            dropPinView.transform = CGAffineTransformMakeScale(1.0/scrollView.zoomScale, 1.0/scrollView.zoomScale);
        }
    }
}



- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{

    return [scroll.subviews objectAtIndex:0];
}



#pragma mark
#pragma mark UIButton's Actions

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

-(void)dealloc
{

    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
