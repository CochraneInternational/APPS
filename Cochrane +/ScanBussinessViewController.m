//
//  ScanBussinessViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "ScanBussinessViewController.h"

#define kAnimationDuration 1.0


@interface ScanBussinessViewController ()

@end

@implementation ScanBussinessViewController
@synthesize captureManager;
@synthesize library = _library;

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
    
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"scanBusinessCardBackground_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"scanBusinessCardBackground_iPhone4.png"];
    }
        
    [self.view addSubview:background];
    
    
//    businessView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-0.03*self.view.frame.size.height)];
//    businessView.image=[UIImage imageNamed:@"scanBusiness.png"];
//    [self.view addSubview:businessView];
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];

       
   
    frameView =[[UIImageView alloc] initWithFrame:CGRectMake(0.07*[UIScreen mainScreen].bounds.size.width-5, 0.22*[UIScreen mainScreen].bounds.size.height-0.009*self.view.frame.size.height, 0.84*[UIScreen mainScreen].bounds.size.width+10, 0.40*[UIScreen mainScreen].bounds.size.height+0.018*self.view.frame.size.height)];
    [frameView setImage:[UIImage imageNamed:@"frameBrochuresCameraView.png"]];
    [self.view addSubview:frameView];
    
    
    cameraButton =[UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.frame=CGRectMake(self.view.frame.size.width/2-(self.view.frame.size.width/5/2), frameView.frame.size.height+frameView.frame.origin.y+0.03*self.view.frame.size.height, self.view.frame.size.width/5, self.view.frame.size.height*0.06);
    
    [cameraButton setImage:[UIImage imageNamed:@"scanCamera.png"] forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(cameraPressed:) forControlEvents:UIControlEventTouchUpInside];
    cameraButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:cameraButton];

    [self setCaptureManager:[[[CaptureSessionManager alloc] init] autorelease]];
    
	[[self captureManager] addVideoInputFrontCamera:NO]; // set to YES for Front Camera, No for Back camera
    
    [[self captureManager] addStillImageOutput];
    
	[[self captureManager] addVideoPreviewLayer];
	CGRect layerRect =   CGRectMake(0.07*[UIScreen mainScreen].bounds.size.width, 0.22*[UIScreen mainScreen].bounds.size.height, 0.84*[UIScreen mainScreen].bounds.size.width, 0.40*[UIScreen mainScreen].bounds.size.height);

    [[[self captureManager] previewLayer] setBounds:layerRect];
    [[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
	[self.view.layer addSublayer:[[self captureManager] previewLayer]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveImageToPhotoAlbum) name:kImageCapturedSuccessfully object:nil];
    
	[[captureManager captureSession] startRunning];

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

-(void)cameraPressed:(UIButton *)sender
{
    [[self captureManager] captureStillImage];
}


- (void)saveImageToPhotoAlbum
{
    NSLog(@"Saving photo...");
    image =[[self captureManager] stillImage];
    
    [[captureManager captureSession] stopRunning];
    
    // Save to Camera Roll
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success!" message:@"Bussiness Card was succesfully saved to Camera Roll" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
    
    /* Upload files from Filemanager here */
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = 320.0/480.0;
    
    if (imgRatio!=maxRatio) {
        if (imgRatio < maxRatio) {
            imgRatio = 480.0 / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = 480.0;
        } else {
            imgRatio = 320.0 / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = 320.0;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    //UIImage *uploadImg = image;
    NSData *imageData = UIImagePNGRepresentation(img);
    NSString *urlString = @"http://cochraneplus.cochrane.co/iOS_Scripts/uploadBusinessCard.php";
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    // Atributes
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"appPass\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", [[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"ipodfile.jpg\"\r\n"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"BC Upload: %@",returnString);
    /* End file upload to backend */
    [[captureManager captureSession] startRunning];

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else
    {
        NSLog(@"\n\n\n saved ok\n\n\n");
    }
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection
{
    
    image = [self imageFromSampleBuffer:sampleBuffer];
//    rotatedScreenImage = rotateUIImage(image, 90.0);
}


- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *imageF = [UIImage imageWithCGImage:quartzImage];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (imageF);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

   /* UITouch *touch =[[event allTouches] anyObject];
    CGPoint touchPoint =[touch locationInView:touch.view];
    
    [self focus:touchPoint];

 
    
    CGPoint transfPoint;// =[captureVideoPreviewLayer captureDevicePointOfInterestForPoint:touchPoint];
    transfPoint =[self.view.layer convertPoint:touchPoint toLayer:captureVideoPreviewLayer];
    
    
    if(camFocus)
    {
        [camFocus removeFromSuperview];
    }
        camFocus =[[CameraFocusSquare alloc] initWithFrame:CGRectMake(transfPoint.x-40, transfPoint.y -40, 80, 80)];
        [camFocus setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:camFocus];
        [camFocus setNeedsDisplay];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.5];
        [camFocus setAlpha:0.0];
        [UIView commitAnimations];
    */
}


-(void)focus:(CGPoint)aPoint
{
    Class captureDeviceClass =NSClassFromString(@"AVCaptureDevice");
    if(captureDeviceClass!=nil)
    {
//        device = [captureDeviceClass defaultDeviceWithMediaType:AVMediaTypeVideo];
        if([device isFocusPointOfInterestSupported] &&
           [device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
        {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            double screenWidth = screenRect.size.width;
            double screenHeight = screenRect.size.height;
            double focus_x = aPoint.x/screenWidth;
            double focus_y = aPoint.y/screenHeight;
            if([device lockForConfiguration:nil]) {
                [device setFocusPointOfInterest:CGPointMake(focus_x,focus_y)];
                if(camFocus)
                {
                    [camFocus removeFromSuperview];
                }
                //    if([[touch view] isKindOfClass:[CameraFocusSquare class]])
                //    {
                camFocus =[[CameraFocusSquare alloc] initWithFrame:CGRectMake(focus_x-40, focus_y -40, 80, 80)];
                [camFocus setBackgroundColor:[UIColor redColor]];
                [captureVideoPreviewLayer addSublayer:camFocus.layer];
                [camFocus setNeedsDisplay];
                
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationDuration:1.5];
                [camFocus setAlpha:0.0];
                [UIView commitAnimations];

                [device setFocusMode:AVCaptureFocusModeAutoFocus];
                if ([device isExposureModeSupported:AVCaptureExposureModeAutoExpose]){
                    [device setExposureMode:AVCaptureExposureModeAutoExpose];
                }
                [device unlockForConfiguration];
            }
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
