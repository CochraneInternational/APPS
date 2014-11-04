//
//  UAModalExampleView.m
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "UAExampleModalPanel.h"

#define BLACK_BAR_COMPONENTS				{ 0.22, 0.22, 0.22, 1.0, 0.07, 0.07, 0.07, 1.0 }

@implementation UAExampleModalPanel

@synthesize viewLoadedFromXib;
@synthesize array;
@synthesize position;
@synthesize parent;

- (id)initWithFrame:(CGRect)frame title:(int )index {
	if ((self = [super initWithFrame:frame])) {
		
		CGFloat colors[8] = BLACK_BAR_COMPONENTS;
		[self.titleBar setColorComponents:colors];
//		self.headerLabel.text = title;
		
		
		////////////////////////////////////
		// RANDOMLY CUSTOMIZE IT
		////////////////////////////////////
		// Show the defaults mostly, but once in awhile show a completely random funky one
		if (arc4random() % 4 == 0) {
            
			// Funky time.
			UADebugLog(@"Showing a randomized panel for modalPanel: %@", self);
			
			// Margin between edge of container frame and panel. Default = {20.0, 20.0, 20.0, 20.0}
			self.margin = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0);
			
			// Margin between edge of panel and the content area. Default = {20.0, 20.0, 20.0, 20.0}
			self.padding = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0);
			
			// Border color of the panel. Default = [UIColor whiteColor]
			self.borderColor = [UIColor whiteColor];
			
			// Border width of the panel. Default = 1.5f;
			self.borderWidth = 1.5f;
			
			// Corner radius of the panel. Default = 4.0f
			self.cornerRadius = 4.0f;
			
			// Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
			self.contentColor = [UIColor colorWithWhite:0.0 alpha:0.8];
			
			// Shows the bounce animation. Default = YES
			self.shouldBounce =YES;
			
			// Shows the actionButton. Default title is nil, thus the button is hidden by default
//			[self.actionButton setTitle:@"Foobar" forState:UIControlStateNormal];

			// Height of the title view. Default = 40.0f
//			[self setTitleBarHeight:40.0f];
			
			// The background color gradient of the title
//			CGFloat colors[8] = {
//				(arc4random() % 2), (arc4random() % 2), (arc4random() % 2), 1,
//				(arc4random() % 2), (arc4random() % 2), (arc4random() % 2), 1
//			};
//
//			[[self titleBar] setColorComponents:colors];
			
//			// The gradient style (Linear, linear reversed, radial, radial reversed, center highlight). Default = UAGradientBackgroundStyleLinear
//			[[self titleBar] setGradientStyle:UAGradientBackgroundStyleLinear];//(arc4random() % 5)];
//		
//			// The line mode of the gradient view (top, bottom, both, none). Top is a white line, bottom is a black line.
//			[[self titleBar] setLineMode: pow(2, (arc4random() % 3))];
//			
//			// The noise layer opacity. Default = 0.4
//			[[self titleBar] setNoiseOpacity:0.4];
			
			// The header label, a UILabel with the same frame as the titleBar
			[self headerLabel].font = [UIFont boldSystemFontOfSize:floor(self.titleBarHeight / 2.0)];
		}

	
		//////////////////////////////////////
		// SETUP RANDOM CONTENT
		//////////////////////////////////////
//		UIWebView *wv = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
//		[wv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://urbanapps.com/product_list"]]];
		
		UITableView *tv = [[[UITableView alloc] initWithFrame:CGRectZero] autorelease];
        tv.delegate=self;
		[tv setDataSource:self];
		
//		UIImageView *iv = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
//		[iv setImage:[UIImage imageNamed:@"UrbanApps.png"]];
//		[iv setContentMode:UIViewContentModeScaleAspectFit];
//		
//		[[NSBundle mainBundle] loadNibNamed:@"UAExampleView" owner:self options:nil];
		
		NSArray *contentArray = [NSArray arrayWithObjects: tv, nil];
		
//		int i = arc4random() % [contentArray count];
		v = [[contentArray objectAtIndex:0] retain];
		[self.contentView addSubview:v];
		
	}	
	return self;
}

- (void)dealloc {
    [v release];
//	[viewLoadedFromXib release];
    [super dealloc];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[v setFrame:self.contentView.bounds];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[[array objectAtIndex:position] objectAtIndex:2] count];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString *cellIdentifier = @"UAModalPanelCell";
	CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
	}
	
    NSArray *arr =[[[[[array objectAtIndex:position] objectAtIndex:2] objectAtIndex:indexPath.row] substringToIndex:[[[[array objectAtIndex:position] objectAtIndex:2] objectAtIndex:indexPath.row]rangeOfString:@"&&"].location] componentsSeparatedByString:@"~~~"];
//	[cell.textLabel setText:[NSString stringWithFormat:@"%i. - %@",indexPath.row, [[[[array objectAtIndex:position] objectAtIndex:2] objectAtIndex:indexPath.row] substringToIndex:[[[[array objectAtIndex:position] objectAtIndex:2] objectAtIndex:indexPath.row]rangeOfString:@"&&"].location] ]]   ;
    [cell.textLabel setText:[NSString stringWithFormat:@"%i. - %@",indexPath.row,[arr objectAtIndex:0]]];
    cell.tagCell=[arr objectAtIndex:1];
	[cell.textLabel setBackgroundColor:[UIColor clearColor]];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    OverviewSalesmanViewController *overview=[[[OverviewSalesmanViewController alloc] init] autorelease];
    overview.name= cell.textLabel.text;
    overview.salesmanTag=cell.tagCell;
    
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromRight;
    transition.delegate=self;

    [parent.navigationController.view.layer addAnimation:transition forKey:nil];
    [parent.navigationController pushViewController:overview animated:YES];
    

}

#pragma mark - Actions
- (IBAction)buttonPressed:(id)sender {
	// The button was pressed. Lets do something with it.
	
	// Maybe the delegate wants something to do with it...
	if ([delegate respondsToSelector:@selector(superAwesomeButtonPressed:)]) {
		[delegate performSelector:@selector(superAwesomeButtonPressed:) withObject:sender];
	
	// Or perhaps someone is listening for notifications 
	} else {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"SuperAwesomeButtonPressed" object:sender];
	}
		
}

@end
