//
//  ViewForMap.m
//  SalesApp
//
//  Created by Diana Mihai on 8/28/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "ViewForMap.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@implementation ViewForMap
@synthesize originalX;
@synthesize originalY;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame label:(NSString*)lbl
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        initialScale = frame.size.width;

        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(-90, -5, 114.75, 19.5)];
        label.textAlignment=NSTextAlignmentCenter;
        self.backgroundColor=[UIColor clearColor];
        label.text=lbl;
        label.numberOfLines=1;
        label.minimumFontSize=8;
        label.adjustsFontSizeToFitWidth=YES;
        label.backgroundColor=[UIColor clearColor];
        
        [label.layer setAnchorPoint:CGPointMake(0.5, 1.0)];
        
       // [dropPinView.layer setAnchorPoint:CGPointMake(1.0, 1.0)];
        
        [self addSubview:label];
//
//
//        
//        originalY=self.frame.origin.y;
//        originalX=self.frame.origin.x;
//        
        UIImageView *pin=[[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-17.5,self.frame.size.height/2-24.5, 35.0, 49.)];
          [pin.layer setAnchorPoint:CGPointMake(0.5, 1.0)];

        [pin setImage:[UIImage imageNamed:@"pin.png"]];
        [self addSubview:pin];

        // Initialization code
    }
    return self;
}

//
//-(void)resize:(CGFloat)scale
//{
//
//}


-(void)redrawWithSize:(float)size
{
if ( size <= initialScale)
{
    if (size * 4.0 > initialScale)
    {
        float scale = size / initialScale;
        self.transform = CGAffineTransformMakeScale(scale, scale);

    }
    else
    {
        size = initialScale /4;
        float scale = size / initialScale;
        self.transform = CGAffineTransformMakeScale(scale, scale);

    }
}
}


@end

