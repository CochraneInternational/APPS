//
//  ComposeNewMessageViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 7/29/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "ComposeNewMessageViewController.h"
#import "DropDownList.h"
#import "Configuration.h"
#import "BaseDataObject.h"

@interface ComposeNewMessageViewController ()

@end

@implementation ComposeNewMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
              // Custom initialization
    }
    return self;
}

-(id)init
{
    if(self=[super init])
    {

        self.view.backgroundColor=[UIColor whiteColor];
        
        backButton =[UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
        [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        backButton.showsTouchWhenHighlighted=YES;
        [self.view addSubview:backButton];
        
        
        toLabel =[[UILabel alloc] init];
        toLabel.frame=CGRectMake(0, 90, 40, 50);
        toLabel.font=[UIFont fontWithName:@"Avenir-Black" size:16.0];
        toLabel.textColor=[UIColor blackColor];
        toLabel.backgroundColor=[UIColor clearColor];
        toLabel.textAlignment=NSTextAlignmentCenter;
        toLabel.text=@"TO:";
        [self.view addSubview:toLabel];
        
        txtView =[[UITextView alloc] init];
        txtView.frame=CGRectMake(10, toLabel.frame.origin.y+toLabel.frame.size.height+20, self.view.frame.size.width-20, 200);
        txtView.layer.cornerRadius=10;
        txtView.layer.masksToBounds=YES;
        txtView.layer.borderWidth=2;
        txtView.font=[UIFont fontWithName:@"AmericanTypewriter" size:16.0];
        txtView.layer.borderColor=[UIColor blackColor].CGColor;
        [self.view addSubview:txtView];
        
        
        sendButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        sendButton.frame=CGRectMake(self.view.frame.size.width/2-40, 0, 80, 50);
        [sendButton setTitle:@"Send" forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sendButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    }
    return  self;
}



#pragma mark
#pragma mark Move View Up
- (void)keyboardDidShow:(NSNotification *)notification
{
    //Assign new frame to your view
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    [UIView setAnimationDelay:0.0];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    
//    [self.view setFrame:CGRectMake(0,-100,320,460)];
//    
//    [UIView commitAnimations];
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    
}
#pragma mark
#pragma mark Dismiss Keyboard

-(void)tapOutsideTextfield:(UITapGestureRecognizer *)recognizer
{
    CGPoint location =[recognizer locationInView:[recognizer.view superview]];
    
    if(CGRectContainsPoint(self.view.frame, location) && ( !CGRectContainsPoint(txtView.frame, location)))
    {
        if([txtView isFirstResponder])
        {
            
            [txtView resignFirstResponder];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationDelay:0.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            
            [self.view setFrame:CGRectMake(0,0,320,460)];
            
            [UIView commitAnimations];
            
        }
    }
    
}

-(void)sendPressed:(UIButton *)sender
{
    
    [DejalBezelActivityView activityViewForView:self.view];

    NSString *string=[usersArrayDropdown objectAtIndex:selectedID];
    NSArray  *arr =[string componentsSeparatedByString:@"&&"];
    
    ASIFormDataRequest *requestDevice =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sendPushesFromiOS.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/sendPushesFromiOS.php"]];
    
    [requestDevice setPostValue:txtView.text forKey:@"text"];
    [requestDevice setPostValue:[arr objectAtIndex:1] forKey:@"userID"];
    [requestDevice setPostValue:loginID forKey:@"sender"];
    
    
    
    [requestDevice setCompletionBlock:^{
        
        
        [DejalBezelActivityView removeViewAnimated:YES];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"messageSent" object:nil];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success!" message:@"Message was sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }];
    
    
    [requestDevice setFailedBlock:^{
    
        [DejalBezelActivityView removeViewAnimated:YES];

    }];
    [requestDevice startAsynchronous];
  

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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // init DropDownList
	[self _initDropDownList];
	
	// Set delegate
	myDropDownList.delegate = self;
	
	// Add to MainViewController
	[self.view addSubview:myDropDownList];
	
    [self _initDropDownListContent];

    
	// Paste data to myDropdownList
	myDropDownList.objects = dropDownListItems;
	
	// Make active (because it's inactive by default)
	[myDropDownList setUserInteractionEnabled:YES];
	// Do any additional setup after loading the view.
}

#pragma mark - Table view data source

//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
      
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark DropDownList delegate

- (void) dropDownListItemDidSelected:(DropDownList*) theDropDownList WithNumber:(int) k
{
    
    selectedID=k;

}

- (void) dropDownListDidShown:(DropDownList*) theDropDownList
{
	NSLog(@"dropdownlist is shown");
}

@end


@implementation ComposeNewMessageViewController (Private)


// myDropDownList button possition in MainViewController
#define MY_DROPDOWNLIST_ORIGIN									CGPointMake(45.0,90.0)

// myDropDownList name to use in delegate methods
#define MY_DROPDOWNLIST_NAME									@"CLICK TO SELECT USER"

// myDropDownList type to use in
// + (void) _pasteData:(DOBaseDropDownCellObject*)_data To:(id)_destination WithType:(NSString*) type
// methos
#define MY_DROPDOWNLIST_TYPE									@"DEFAULT_TYPE"

// Number of items to display in myDropDownList
#define	ITEMS_NUMBER											9

// Instruction label frame in button
#define BUTTON_INSTRUCTION_LABEL_FRAME							CGRectMake(14.0,20.0,200.0,12.0)

// myDropdownList table view parameters
static const CGFloat X_TABLE_MARGIN								= 4.0;
static const CGFloat Y_TABLE_MARGIN								= 45.0;

// myDropDownList backgroud parameters
static const CGFloat X_BAKCGROUND_MARGIN						= -13.0;
static const CGFloat Y_BACKGROUND_MARGIN						= 0.0;
static const CGFloat BG_UNDER_TABLE_HEIGHT						= 20.0;

- (void) _initDropDownList
{
	// Create configuration object
	Configuration *config = [[[Configuration alloc] init] autorelease];
	
	myDropDownList=[[DropDownList alloc] initWithOrigin:MY_DROPDOWNLIST_ORIGIN
                                            ActiveImage:config.buttonActiveBG
                                      WithInactiveImage:config.buttonNoActiveBG];
	
	myDropDownList.name = MY_DROPDOWNLIST_NAME;
	myDropDownList.type = MY_DROPDOWNLIST_TYPE;
	myDropDownList.buttonInstructionLabelFrame = BUTTON_INSTRUCTION_LABEL_FRAME;
	
	[myDropDownList setTopMainBG:config.openBGTop setMiddleBG:config.openBGMiddle setBottom:config.openBGBottom];
	
	[myDropDownList setCellBGImage:config.itemBG setCellBGHoverImage:config.itemBGHoved];
	
	[myDropDownList setBGXMargin:X_BAKCGROUND_MARGIN
                       BGYMargin:Y_BACKGROUND_MARGIN
              BGUnderTableHeight:BG_UNDER_TABLE_HEIGHT];
	
	[myDropDownList setTableXMargin:X_TABLE_MARGIN TableYMargin:Y_TABLE_MARGIN];
	
	myDropDownList.cellDispAmount = ITEMS_NUMBER;
	
	// Make myDropDownList inactive by default
	[myDropDownList setUserInteractionEnabled:NO];
	
	// Set parent view controller
	myDropDownList.parentViewController = self;
//    self.usersArray =[[NSMutableArray alloc] init];

}

- (void) _initDropDownListContent
{


    int itemsNumber = [usersArrayDropdown count];
	dropDownListItems = [[NSMutableArray alloc] init];
	for (int i = 0; i < itemsNumber; i++)
	{
        NSString *string=[usersArrayDropdown objectAtIndex:i];
        NSArray  *arr =[string componentsSeparatedByString:@"&&"];
        if([[arr objectAtIndex:1] isEqualToString:loginID])
        {
            NSLog(@"isEqual");
        }
        else
        {
            BaseItemObject *tempBaseItemObject = [[[BaseItemObject alloc] init] autorelease];
            BaseDataObject *tempBaseDataObject = [[[BaseDataObject alloc] init] autorelease];
            tempBaseDataObject.name =[arr objectAtIndex:0];// [NSString stringWithFormat:@"LEMBERG SOLUTIONS"];
//            tempBaseDataObject.description = [NSString stringWithFormat:@"DESCRIPTION %i",i];
            tempBaseDataObject.image = [UIImage imageNamed:@"icon.png"];
            tempBaseItemObject.dataObject = tempBaseDataObject;
            [dropDownListItems addObject:tempBaseItemObject];
        }
	}

}



- (void) _initLembergsLogo
{
	CGPoint logoOrigin = CGPointMake(10.0, 10.0);
	UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
	CGRect logoFrame = CGRectMake(logoOrigin.x, logoOrigin.y, logoImage.size.width/2, logoImage.size.height/2);
	UIImageView *logoView = [[[UIImageView alloc] initWithFrame:logoFrame] autorelease];
	[logoView setImage:logoImage];
	[self.view addSubview:logoView];
}
@end


