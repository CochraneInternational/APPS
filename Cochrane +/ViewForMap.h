//
//  ViewForMap.h
//  SalesApp
//
//  Created by Diana Mihai on 8/28/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewForMap : UIView
{
    float		 initialScale;

}
@property (nonatomic) float originalX;
@property (nonatomic) float originalY;


-(id)initWithFrame:(CGRect)frame label:(NSString*)lbl;
-(void)resize:(CGFloat)scale;
-(void)redrawWithSize:(float)size;

@end
