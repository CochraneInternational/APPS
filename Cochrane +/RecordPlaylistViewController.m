//
//  RecordPlaylistViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/24/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "RecordPlaylistViewController.h"

@interface RecordPlaylistViewController ()
@property BOOL panningProgress;

@end

@implementation RecordPlaylistViewController


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
        background.image=[UIImage imageNamed:@"recordListBackground_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"recordListBackground_iPhone4.png"];
    }    [self.view addSubview:background];

//    
//    upView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
//    upView.image=[UIImage imageNamed:@"emptyUpLarge.png"];
//    [self.view addSubview:upView];
    
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    
//    navTitle                        =[[UILabel alloc] init];
//    navTitle.frame                  =CGRectMake(self.view.frame.size.width/2-100, 0, 200, 40);
//    navTitle.backgroundColor        =[UIColor clearColor];
//    navTitle.textAlignment          = NSTextAlignmentCenter;
//    navTitle.text                   =@"Records Playlist";
//    navTitle.font                   =[UIFont fontWithName:@"Arial-BoldMT" size:20];
//    navTitle.textColor              =[UIColor whiteColor];
//    [self.view addSubview:navTitle];
    
    recordingsArray =[[NSMutableArray alloc] init];
    
    NSArray     *arr=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString    *doc=[arr objectAtIndex:0];
    
    
    int count;
    
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:doc error:NULL];
    for (count = 0; count < (int)[directoryContent count]; count++)
    {
        if([[[directoryContent objectAtIndex:count] pathExtension] isEqualToString:@"m4a"])
        {
            if([[directoryContent objectAtIndex:count] rangeOfString:@"audio"].location==NSNotFound)
            {
                NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
                [dict setObject:[doc stringByAppendingPathComponent:[directoryContent objectAtIndex:count]] forKey:@"path"];
                [dict setObject:[[directoryContent objectAtIndex:count]stringByDeletingPathExtension] forKey:@"name"];
                [recordingsArray addObject:dict];
                [dict release];
            }
        }
    }
    
    
    playlistTableView   =[[UITableView alloc] initWithFrame:CGRectMake(0, backButton.frame.origin.y+backButton.frame.size.height+10, self.view.frame.size.width, self.view.frame.size.height-playlistTableView.frame.origin.y) style:UITableViewStylePlain];
    playlistTableView.dataSource=self;
    playlistTableView.delegate  =self;
//    [playlistTableView setBackgroundColor:[UIColor clearColor]];
    [playlistTableView setTableFooterView:[[[UIView alloc] initWithFrame:CGRectZero] autorelease]];//analyze
    [playlistTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:playlistTableView];
                          
}


#pragma mark
#pragma mark UIButton's Actions


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

#pragma mark
#pragma mark Table View Delegate

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recordingsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    RecordPlaylistCell *cell        =[[RecordPlaylistCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"prioritiesCell"];
    cell.delegate=self;
    cell.playButton.tag=indexPath.row;
    cell.textLabel.text=[[recordingsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.textColor        =[UIColor darkGrayColor];
    cell.textLabel.font             =[UIFont fontWithName:@"AmericanTypewriter" size:20];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return  cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update the recording volume to play at max
    // Set AudioSession
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setDelegate:self];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    // Changing the default output audio route
    UInt32 doChangeDefaultRoute = 1;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
    
    RecordPlaylistCell *cell = (RecordPlaylistCell *)[playlistTableView cellForRowAtIndexPath:indexPath];
    
    if([cell.imgSet isEqualToString:@"play"])
    {
        cell.background.image=[UIImage imageNamed:@"recordCellList_stop.png"];
        cell.imgSet=@"stop";
        
        slider=[[UISlider alloc] initWithFrame:CGRectMake(0, cell.frame.size.height/2-15, cell.frame.size.width-30, 30)];
        [slider addTarget:self action:@selector(progressChanged:) forControlEvents:UIControlEventValueChanged];
        slider.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        [slider setThumbImage:[UIImage imageNamed:@"sliderPrgKnob.png"] forState:UIControlStateNormal];
//        UIImage *sliderLeftTrackImage2=[UIImage imageNamed:@"sliderPrgBgOn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12) resizingMode:uiimageresi
        [slider setUserInteractionEnabled:NO];
        [cell addSubview:slider];
        [cell bringSubviewToFront:slider];
        
        NSURL *url  =[NSURL fileURLWithPath:[[recordingsArray objectAtIndex:indexPath.row] objectForKey:@"path"]];
        player      = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [player setDelegate:self];
        [player stop];
        slider.maximumValue = [player duration];
        slider.value        = 0.0;
        [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        [player setVolume:1.0];
        [player play];
        
     

    }
    else
    {
        
//        cell.background.image=[UIImage imageNamed:@"recordCellList_stop.png"];
//        cell.imgSet=@"stop";
    }
        
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    [tableView endUpdates];
}


#pragma mark
#pragma mark Child Methods
-(void)playEntry :(int)tag
{
    
    viewForPlaying =[[UIView alloc] initWithFrame:CGRectMake(15, 50, self.view.frame.size.width-30, self.view.frame.size.height-100)];
    [viewForPlaying setBackgroundColor:[UIColor blackColor]];
    [viewForPlaying setAlpha:0.5];
    [self.view addSubview:viewForPlaying];
    
    
      
    name =[[UILabel alloc] initWithFrame:CGRectMake(viewForPlaying.frame.origin.x+10, viewForPlaying.frame.origin.y+10, viewForPlaying.frame.size.width-20, 100)];
//#ifdef DEBUG
//    name.layer.borderColor=[UIColor blackColor].CGColor;
//    name.layer.borderWidth=2;
//#endif
    [name setBackgroundColor:[UIColor clearColor]];
    name.numberOfLines  =0;
    name.text           =[NSString stringWithFormat:@"Record : %@",[[recordingsArray objectAtIndex:tag] objectForKey:@"name"]];
    name.textColor      =[UIColor redColor];
    name.textAlignment  =NSTextAlignmentCenter;
    name.font           =[UIFont fontWithName:@"AmericanTypewriter-Bold" size:18.0];
    name.text           =[name.text stringByAppendingString:[NSString stringWithFormat:@"\n Length : %f",player.duration] ];
    [self.view addSubview:name];
    

}

-(void)updateTime:(UISlider *)sender
{
    slider.value = player.currentTime;

}


- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    // Loop though all the cells and reset the play/pause button
    //NSMutableArray *cells = [[NSMutableArray alloc] init];
    for (NSInteger j = 0; j < [playlistTableView numberOfSections]; ++j)
    {
        for (NSInteger i = 0; i < [playlistTableView numberOfRowsInSection:j]; ++i)
        {
//            [cells addObject:[playlistTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]]];
            RecordPlaylistCell *cell = (RecordPlaylistCell *)[playlistTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
            cell.background.image=[UIImage imageNamed:@"recordListCell_play.png"];
            cell.imgSet=@"play";
        }
    }
    
    [player stop];
    slider.value=0.0;
    [viewForPlaying removeFromSuperview];
    [slider         removeFromSuperview];
    [name           removeFromSuperview];
}

#pragma mark
#pragma mark Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
