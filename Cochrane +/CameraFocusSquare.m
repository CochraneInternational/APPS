//
//  CameraFocusSquare.m
//  SalesApp
//
//  Created by Diana Mihai on 6/13/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "CameraFocusSquare.h"


const float squareLength=80.f;

@implementation CameraFocusSquare

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self setBackgroundColor:[UIColor redColor]];
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.layer setBorderWidth:2.0];
        [self.layer setCornerRadius:4.0];
        
        CABasicAnimation *selectionAnimation =[CABasicAnimation animationWithKeyPath:@"borderColor"];
        selectionAnimation.toValue=(id)[UIColor blueColor].CGColor;
        selectionAnimation.repeatCount=8;
        [self.layer addAnimation:selectionAnimation forKey:@"selectionAnimation"];
        
    }
    return self;
}





@end
