//
//  SelectSalesmanCell.h
//  SalesApp
//
//  Created by Diana Mihai on 6/20/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectSalesmanCell : UITableViewCell
{
    UILabel         *name;
   
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellAtIndex:(int)index;

@property(nonatomic,strong)  UIImageView     *background;

@end
