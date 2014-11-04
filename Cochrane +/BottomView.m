//
//  BottomView.m
//  SalesApp
//
//  Created by Diana Mihai on 6/12/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

@synthesize delegate;
@synthesize noOfMessUnread;
@synthesize messUnreadImgView;

#pragma mark
#pragma mark Init


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initElements];
        // Initialization code
    }
    return self;
}


-(id)init
{
    self=[super init];
    if(self)
    {
    }
    return self;
}

-(void)initElements
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateView) name:@"updateBottomViewInbox" object:nil];

    
    slideUpAndDown      =[UIButton buttonWithType:UIButtonTypeCustom];
    [slideUpAndDown setImage:[UIImage imageNamed:@"buttonUp.png"] forState:UIControlStateNormal];
    slideUpAndDown.frame=CGRectMake(self.frame.size.width/2-self.frame.size.width*0.08, 0, 45, [UIScreen mainScreen].bounds.size.height*0.07);
    slideUpAndDown.showsTouchWhenHighlighted=YES;
    slideUpAndDown.userInteractionEnabled   =YES;
    [slideUpAndDown addTarget:self action:@selector(slideUpAndDownPressed:) forControlEvents:UIControlEventTouchUpInside];
    
//#ifdef DEBUG
//    slideUpAndDown.layer.borderColor=[UIColor blackColor].CGColor;
//    slideUpAndDown.layer.borderWidth=2;
//#endif
    
    [self addSubview:slideUpAndDown];
    
    bottomImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.035, self.frame.size.width, 0.09*[UIScreen mainScreen].bounds.size.height)]; //y=20
    [bottomImageView setImage:[UIImage imageNamed:@"newBottom.png"]];

    [self addSubview:bottomImageView];
    

//    //priorities button
//    prioritiesButton        =[UIButton buttonWithType:UIButtonTypeCustom];
//    prioritiesButton.frame  =CGRectMake(5,0.19*self.frame.size.height, 52, 0.09*[UIScreen mainScreen].bounds.size.height);
//#ifdef DEBUG
//    prioritiesButton.layer.borderColor  =[UIColor blackColor].CGColor;
//    prioritiesButton.layer.borderWidth  =2;
//#endif
//    prioritiesButton.showsTouchWhenHighlighted=YES;
//    [prioritiesButton addTarget:self action:@selector(prioritiesPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:prioritiesButton];
    
    
    
    //inbox button
    inboxButton         =[UIButton buttonWithType:UIButtonTypeCustom];
    inboxButton.frame   =CGRectMake(10, 0.19*self.frame.size.height, 70, 0.09*[UIScreen mainScreen].bounds.size.height);
//#ifdef DEBUG
//    inboxButton.layer.borderColor   =[UIColor blackColor].CGColor;
//    inboxButton.layer.borderWidth   =2;
//#endif
    inboxButton.showsTouchWhenHighlighted=YES;
    [inboxButton addTarget:self action:@selector(inboxPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:inboxButton];
    
    
    
    //recordButton
    recordButton            =[UIButton buttonWithType:UIButtonTypeCustom];
    recordButton.frame      =CGRectMake(inboxButton.frame.origin.x+inboxButton.frame.size.width+5, 0.19*self.frame.size.height, 60, 0.09*[UIScreen mainScreen].bounds.size.height);
//#ifdef DEBUG
//    recordButton.layer.borderColor  =[UIColor blackColor].CGColor;
//    recordButton.layer.borderWidth  =2;
//#endif
    recordButton.showsTouchWhenHighlighted=YES;
    [recordButton addTarget:self action:@selector(recordPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:recordButton];
    

    //brochureButton
    brochuresButton         =[UIButton buttonWithType:UIButtonTypeCustom];
    brochuresButton.frame   =CGRectMake(recordButton.frame.origin.x+recordButton.frame.size.width+10, 0.19*self.frame.size.height, 60, 0.09*[UIScreen mainScreen].bounds.size.height);
//#ifdef DEBUG
//    brochuresButton.layer.borderColor   =[UIColor blackColor].CGColor;
//    brochuresButton.layer.borderWidth   =2;
//#endif
    brochuresButton.showsTouchWhenHighlighted=YES;
    [brochuresButton addTarget:self action:@selector(brochurePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:brochuresButton];
    
    
    //scanBussinessCard
    scanBusinnessCard       =[UIButton buttonWithType:UIButtonTypeCustom];
    scanBusinnessCard.frame =CGRectMake(brochuresButton.frame.origin.x+brochuresButton.frame.size.width+10, 0.19*self.frame.size.height, 60, 0.09*[UIScreen mainScreen].bounds.size.height);
//#ifdef DEBUG
//    scanBusinnessCard.layer.borderColor =[UIColor blackColor].CGColor;
//    scanBusinnessCard.layer.borderWidth =2;
//#endif
    scanBusinnessCard.showsTouchWhenHighlighted=YES;
    [scanBusinnessCard addTarget:self action:@selector(scanBussinessPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scanBusinnessCard];
    
    
    messUnreadImgView =[[UIImageView alloc] initWithFrame:CGRectMake(inboxButton.frame.origin.x+inboxButton.frame.size.width/2 -8, inboxButton.frame.origin.y+3, 16, 16)];
    messUnreadImgView.image=[UIImage imageNamed:@"newMessageBackground.png"];
    [self addSubview:messUnreadImgView];
    messUnreadImgView.hidden=YES;
    
    noOfMessUnread =[[UILabel alloc] initWithFrame:CGRectMake(inboxButton.frame.origin.x+inboxButton.frame.size.width/2 -7, inboxButton.frame.origin.y+3, 14, 15)];
    noOfMessUnread.backgroundColor=[UIColor clearColor];
    noOfMessUnread.textColor=[UIColor whiteColor];
    noOfMessUnread.font=[UIFont fontWithName:@"Arial-BoldMT" size:10.0];
//    noOfMessUnread.text=@"10";
    messUnreadImgView.hidden=YES;
    noOfMessUnread.textAlignment=NSTextAlignmentCenter;
    [self addSubview:noOfMessUnread];


}


-(void)updateView
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"])
    {
        int count=0;
        
        NSMutableArray *  inboxMess=[[NSMutableArray alloc] init];
        
        for(int i=0;i<[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] count];i++)
        {
            [inboxMess addObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"inboxMessages"] objectAtIndex:i]];
        }
        
        
        for(int i=0;i<[inboxMess count];i++)
        {
            if([[[inboxMess objectAtIndex:i] objectAtIndex:0]  isEqualToString:@"unread"])
                count++;
        }
        
        [inboxMess release];
        
        if(count>0)
        {
            noOfMessUnread.text     =[NSString stringWithFormat:@"%i",count];
            noOfMessUnread.hidden   =NO;
            messUnreadImgView.hidden=NO;
        }
        else
        {
            messUnreadImgView.hidden=YES;
            noOfMessUnread.hidden   =YES;
        }
    }
    else
    {
        messUnreadImgView.hidden=YES;
        noOfMessUnread.hidden   =YES;


    }

}



-(void)slideUpAndDownPressed:(UIButton *)sender
{
    [delegate actionOnSlideUpButton];
}



#pragma mark
#pragma mark UIButton's Actions


-(void)prioritiesPressed:(UIButton *)sender
{
    [delegate prioritiesView];
}


-(void)inboxPressed:(UIButton *)sender
{
    NSLog(@"inbox pressed:");
    [delegate inboxView];
//    [delegate recordView];
}


-(void)recordPressed:(UIButton *)sender
{
    [delegate recordView];
}


-(void)brochurePressed:(UIButton *)sender
{
    [delegate brochureView];
}


-(void)scanBussinessPressed:(UIButton *)sender
{
    [delegate scanBussiness];
}


#pragma mark
#pragma mark Color From Hex

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end