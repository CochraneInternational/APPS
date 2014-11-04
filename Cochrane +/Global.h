//
//  Global.h
//  SalesApp
//
//  Created by Diana Mihai on 6/20/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

/*
 admin      is 0
 manager    is 1
 salesman   is 2
 */

//@"%@get_path.php",SERVER]
//#define SERVER @"http://ec2-54-214-232-95.us-west-2.compute.amazonaws.com/ConstructionPHP/"


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define kAnimationDuration 1.0

#define SERVER @"http://cochraneplus.cochrane.co/iOS_Scripts/"   //Link to iOS Scripts folder

#import <CoreLocation/CoreLocation.h>

#ifndef SalesApp_Global_h
#define SalesApp_Global_h

int             priorities_row_selected;
int             salesman_row_selected;
NSString        *loginID;
NSArray         *parsedString ;
NSString        *name;
NSString        *isAdmin;
CLLocation      *currentLocation;
NSString        *uploadStepsFilePath;
NSMutableArray  *pctsArray;
NSString        *deviceTok;
NSMutableArray  *inboxMess;
NSMutableArray  *usersArrayDropdown;
NSString        *crm_link;

//array with coordinates
NSMutableArray *coordinatesArray;

//internet reachability
BOOL internetActive;
BOOL hostActive;


BOOL messageKeyboardIsUp;

#endif
