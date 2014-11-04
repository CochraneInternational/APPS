//
//  UAModalExampleView.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "UATitledModalPanel.h"
#import "CustomTableCell.h"
#import "OverviewSalesmanViewController.h"

@interface UAExampleModalPanel : UATitledModalPanel <UITableViewDataSource,UITableViewDelegate> {
	UIView			*v;
	IBOutlet UIView	*viewLoadedFromXib;
}

@property (nonatomic, retain) IBOutlet UIView *viewLoadedFromXib;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic) int position;
@property (nonatomic,strong) UIViewController *parent;

- (id)initWithFrame:(CGRect)frame title:(int )index;
- (IBAction)buttonPressed:(id)sender;

@end
