//
//  RecordViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "RecordViewController.h"

#define kAnimationDuration 1.0


@interface RecordViewController ()

@end

@implementation RecordViewController


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
        [background setImage:[UIImage imageNamed:@"recordEventBackground_iPhone5.png"]];

    }
    else
    {
        [background setImage:[UIImage imageNamed:@"recordEventBackground_iPhone4.png"]];

    }
    [self.view addSubview:background];

    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];

//record stop play save
    start=[UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        start.frame=CGRectMake((self.view.frame.size.width-300)/5+0, self.view.frame.size.height*3/4, 75, 0.07*self.view.frame.size.height);
    }
    else
    {
        start.frame=CGRectMake((self.view.frame.size.width-300)/5+0, self.view.frame.size.height*3/4+0.03*self.view.frame.size.height, 75, 0.07*self.view.frame.size.height);
    }
    [start setImage:[UIImage imageNamed:@"recordButtonNew.png"] forState:UIControlStateNormal];
    [start addTarget:self action:@selector(startRecording:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
    
    stop=[UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        stop.frame=CGRectMake((self.view.frame.size.width-300)/5+start.frame.size.width+start.frame.origin.x, self.view.frame.size.height*3/4, 75, 0.07*self.view.frame.size.height);

    }
    else
    {
        stop.frame=CGRectMake((self.view.frame.size.width-300)/5+start.frame.size.width+start.frame.origin.x, self.view.frame.size.height*3/4+0.03*self.view.frame.size.height, 75, 0.07*self.view.frame.size.height);

    }

    [stop setImage:[UIImage imageNamed:@"stopButtonNew.png"] forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stopRecording:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];

    
    play=[UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        play.frame=CGRectMake((self.view.frame.size.width-300)/5+stop.frame.size.width+stop.frame.origin.x, self.view.frame.size.height*3/4, 75, 0.07*self.view.frame.size.height);
    }
    else
    {
        play.frame=CGRectMake((self.view.frame.size.width-300)/5+stop.frame.size.width+stop.frame.origin.x, self.view.frame.size.height*3/4+0.03*self.view.frame.size.height, 75, 0.07*self.view.frame.size.height);
    }
    [play setImage:[UIImage imageNamed:@"playButtonNew.png"] forState:UIControlStateNormal];
    [play addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:play];
    
    save=[UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        save.frame=CGRectMake((self.view.frame.size.width-300)/5+play.frame.size.width+play.frame.origin.x, self.view.frame.size.height*3/4, 75, 0.07*self.view.frame.size.height);
    }
    else
    {
        save.frame=CGRectMake((self.view.frame.size.width-300)/5+play.frame.size.width+play.frame.origin.x, self.view.frame.size.height*3/4+0.03*self.view.frame.size.height, 75, 0.07*self.view.frame.size.height);
    }

    [save setImage:[UIImage imageNamed:@"saveButtonNew.png"] forState:UIControlStateNormal];
    [save addTarget:self action:@selector(saveToPlaylist:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:save];
    
    
    [stop setEnabled:NO];
    [play setEnabled:NO];
    [save setEnabled:NO];
    
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"audio.m4a",
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];

    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    [recordSetting release];

    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    
    playlistButton =[UIButton buttonWithType:UIButtonTypeCustom];
    playlistButton.frame=CGRectMake(self.view.frame.size.width-35, backButton.frame.origin.y, 35, 0.07*self.view.frame.size.height);
    playlistButton.center=CGPointMake(self.view.frame.size.width-25, backButton.center.y);
    [playlistButton setImage:[UIImage imageNamed:@"recordingsLibrary.png"] forState:UIControlStateNormal];
    [playlistButton addTarget:self action:@selector(loadPlaylist:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playlistButton];
    
	// Do any additional setup after loading the view.
}


#pragma mark
#pragma mark Recording

-(void)startRecording:(UIButton *)sender
{
    if(player.playing)
    {
        [player stop];
    }
    
    if(!recorder.recording)
    {
        AVAudioSession *session =[AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [recorder record];
        [start setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else
    {
        [recorder pause];
        [start setTitle:@"Record" forState:UIControlStateNormal];
    }
    
    [stop setEnabled:YES];
    [play setEnabled:NO];
    [save setEnabled:NO];
    
}


-(void)stopRecording:(UIButton *)sender
{
    [recorder stop];
    if(player.playing)
    {
        [player stop];
    }
    AVAudioSession *audioSession =[AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

-(void)play:(UIButton *)sender
{
    if (!recorder.recording)
    {
        // Set AudioSession
        NSError *sessionError = nil;
        [[AVAudioSession sharedInstance] setDelegate:self];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
        // Changing the default output audio route
        UInt32 doChangeDefaultRoute = 1;
        AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setDelegate:self];
        [player setVolume: 1.0];
        [player play];
        [stop setEnabled:YES];
    }
}


- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Audio File"
                                                    message: @"In order to save the audio file , please press Save Button."
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag
{
    [start setTitle:@"Record" forState:UIControlStateNormal];
    
    [stop setEnabled:NO];
    [play setEnabled:YES];
    [save setEnabled:YES];
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


-(void)saveToPlaylist:(UIButton *)sender
{
    float currentVersion = 7.0;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= currentVersion)
    {
        NSLog(@"Running in IOS-6");
        prompt                          =[[UIAlertView alloc] initWithTitle:@"Please enter a name:" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        prompt.alertViewStyle           =UIAlertViewStylePlainTextInput;
        [prompt textFieldAtIndex:0].delegate=self;
        prompt.delegate=self;
        textField =[prompt textFieldAtIndex:0];
        [prompt show];

    }
    else
    {
    prompt = [[UIAlertView alloc] initWithTitle:@"Please enter a name:"
                                                     message:@"\n\n"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"Save", nil];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(12, 50, 260, 25)];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setPlaceholder:@"Name for message"];
    [prompt addSubview:textField];
    [textField release];
    
    
//    directMessageShowAlert                      =YES;
   
    // show the dialog box
    [prompt show];
    [prompt release];
    
    // set cursor and show keyboard
    [textField becomeFirstResponder];
    }
}

-(void)loadPlaylist:(UIButton *)sender
{
    RecordPlaylistViewController *playlist =[[[RecordPlaylistViewController alloc] init] autorelease];
        
    CATransition *transition        =[CATransition animation];
    transition.duration             =kAnimationDuration;
    transition.timingFunction       =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type                 =@"cube";
    transition.subtype              =kCATransitionFromRight;
    transition.delegate             =self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:playlist animated:YES];
}

#pragma mark
#pragma mark AlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        if([textField.text isEqualToString:@""] || [textField.text isEqualToString:@" "])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"You must enter a name for the recording in order to be saved." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
        }
        else
        {
            
            NSMutableArray *recordingsArray;
            NSArray     *arr2=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString    *doc=[arr2 objectAtIndex:0];
            
            
            int count;
            bool found=false;
            recordingsArray =[[NSMutableArray alloc] init];
            NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:doc error:NULL];
            for (count = 0; count < (int)[directoryContent count]; count++)
            {
                if([[[directoryContent objectAtIndex:count] pathExtension] isEqualToString:@"m4a"])
                {
                    if([[directoryContent objectAtIndex:count] rangeOfString:@"audio"].location==NSNotFound)
                    {
                        
                        if([[directoryContent objectAtIndex:count] rangeOfString:textField.text].location!=NSNotFound && [[directoryContent objectAtIndex:count] length]==[textField.text length])
                        {
                            found=true;
                            break;
                        }

                    }
                }
            }
            

            if(found==true)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"A recording with the same name already exists." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [alert release];
            }
            else
            {
                
                NSArray     *arr        =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString    *docDirect  =[arr objectAtIndex:0];
                NSString    *newFilePath=[docDirect stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a",textField.text]];
                NSString    *oldFilePath=[docDirect stringByAppendingPathComponent:@"audio.m4a"];
                NSString *filename = [NSString stringWithFormat:@"%@.m4a",textField.text];
                
                NSURL *uploadToPHP = [[NSURL alloc] initWithString:newFilePath];
                NSLog(@"Path :%@", uploadToPHP);
                
                NSError         *error      =NULL;
                NSFileManager   *fileManager=[[NSFileManager alloc] init];
                BOOL result =[fileManager moveItemAtPath:oldFilePath toPath:newFilePath error:&error];
                
                /* Upload files from Filemanager here */
                
                NSData *file1Data = [[NSData alloc] initWithContentsOfFile:newFilePath];
                NSString *urlString = @"http://cochraneplus.cochrane.co/iOS_Scripts/uploadAudio.php";
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
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
                
                [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n", filename]] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[NSData dataWithData:file1Data]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [request setHTTPBody:body];
                
                NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                
                NSLog(@"Return String= %@",returnString);
                
                
                /* End file upload to backend */
                
                [stop setEnabled:NO];
                [play setEnabled:NO];
                [save setEnabled:NO];
                [recorder stop];

                if(!result)
                    NSLog(@"Error: %@", error);
                else
                    NSLog(@"succeded");
                
                [fileManager release];

            }
     
            
        }
    }
}

#pragma mark
#pragma mark Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
