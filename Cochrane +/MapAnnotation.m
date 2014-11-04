//
//  MapAnnotation.m
//  SalesApp
//
//  Created by Diana Mihai on 7/5/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize coordinate,title;

-(void)dealloc{
    [title release];
    [super dealloc];
}

@end
