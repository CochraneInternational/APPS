//
//  CustomTableCell.h
//  SalesApp
//
//  Created by Diana Mihai on 6/15/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell
{
    UILabel         *name;
    UIImageView     *background;

}

@property (nonatomic,strong) NSString *tagCell;
@end
