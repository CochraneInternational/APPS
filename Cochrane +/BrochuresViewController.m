//
//  BrochuresViewController.m
//  SalesApp
//
//  Created by Diana Mihai on 6/15/13.
//  Copyright (c) 2013 Diana Mihai. All rights reserved.
//

#import "BrochuresViewController.h"
#import "ZipArchive.h"

#define kAnimationDuration 1.0


@interface BrochuresViewController ()

@end

@implementation BrochuresViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    background =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if(IS_IPHONE_5)
    {
        background.image=[UIImage imageNamed:@"brochuresBackround_iPhone5.png"];
    }
    else
    {
        background.image=[UIImage imageNamed:@"brochuresBackground_iPhone4.png"];
    }
    
    [self.view addSubview:background];

    
    
    backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame=CGRectMake(0, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [backButton setImage:[UIImage imageNamed:@"backButtonBrochures.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    backButton.showsTouchWhenHighlighted=YES;
    [self.view addSubview:backButton];
    
    sendButton =[UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame=CGRectMake(self.view.frame.size.width-self.view.frame.size.width/5, self.view.frame.size.height*0.1, self.view.frame.size.width/5, self.view.frame.size.height*0.05);
    [sendButton setImage:[UIImage imageNamed:@"sendButtonBrochures.png"] forState:UIControlStateNormal];
    sendButton.showsTouchWhenHighlighted=YES;
    [sendButton addTarget:self action:@selector(sendBrochures:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sendButton];
    
    
    totalFile=0;

    
   	// Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    brochures=[[NSMutableArray alloc] init];
    selectedMarks = [NSMutableArray new];

    [DejalBezelActivityView activityViewForView:self.view];
    
    
    NSArray     *docs=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString    *docPath=[docs objectAtIndex:0];

    NSString *filePathAndDirectory = [docPath stringByAppendingPathComponent:@"Brochures"];
    NSError *error;
    
    if (![[NSFileManager defaultManager] createDirectoryAtPath:filePathAndDirectory
                                   withIntermediateDirectories:NO
                                                    attributes:nil
                                                         error:&error])
    {
        NSLog(@"Create directory error: %@", error);
    }
    
    
    ASIFormDataRequest *request =[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@brochuresList.php",SERVER]]];//@"http://www.x-2.info/SalesApp_php/brochuresList.php"]];
    [request setCompletionBlock:^{

        NSArray *files =[request.responseString componentsSeparatedByString:@"@"];
        for(int i=0;i<[files count];i++)
        {
            NSString *file=[files objectAtIndex:i];
            NSArray *subfiles =[file componentsSeparatedByString:@"$"];
            [brochures addObject:subfiles];
        }
        [brochures removeLastObject];
        [self showTable];

    }];
    
    [request setFailedBlock:^{
        
        [DejalBezelActivityView removeViewAnimated:YES];

    }];
    [request startAsynchronous];
    
    
}

-(void)showTable
{
    [DejalBezelActivityView removeViewAnimated:YES];


    if(IS_IPHONE_5)
    {
           brochuresTableView =[[UITableView alloc] initWithFrame:CGRectMake(0.05*[UIScreen mainScreen].bounds.size.width, self.view.frame.size.height/4.5+0.03*[UIScreen mainScreen].bounds.size.height, self.view.frame.size.width-0.10*[UIScreen mainScreen].bounds.size.width, self.view.frame.size.height*4/6) style:UITableViewStylePlain] ;
    }
    else
    {
           brochuresTableView =[[UITableView alloc] initWithFrame:CGRectMake(0.05*[UIScreen mainScreen].bounds.size.width, self.view.frame.size.height/4.5+0.05*[UIScreen mainScreen].bounds.size.height, self.view.frame.size.width-0.10*[UIScreen mainScreen].bounds.size.width, self.view.frame.size.height*4/6) style:UITableViewStylePlain] ;
    }
 

    brochuresTableView.dataSource=self;
    brochuresTableView.backgroundColor=[UIColor clearColor];
    brochuresTableView.delegate=self;
    [brochuresTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.view addSubview:brochuresTableView];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [brochures count];
    
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.11*[UIScreen mainScreen].bounds.size.height;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrochuresCell *cell =[[[BrochuresCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identif" cellAtIndex:indexPath.row] autorelease];//analyze
    cell.name.text=[[[brochures objectAtIndex:indexPath.row] objectAtIndex:0] stringByDeletingPathExtension];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    [cell setIsSelected: [selectedMarks containsObject:cell.name.text] ? YES : NO cellAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BrochuresCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    
    NSString *text = cell.name.text;

    if ([selectedMarks containsObject:text])// Is selected?
    {
        [selectedMarks removeObject:text];
        totalFile=totalFile-[[[brochures objectAtIndex:indexPath.row] objectAtIndex:2] integerValue];
    }
    else
    {
        [selectedMarks addObject:text];
        totalFile=totalFile+[[[brochures objectAtIndex:indexPath.row] objectAtIndex:2] integerValue];

    }
    
    if(totalFile<5*1024)
    {
        
        NSArray     *docs=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString    *docPath=[docs objectAtIndex:0];

        NSString *filePathAndDirectory = [docPath stringByAppendingPathComponent:@"Brochures"];

        NSString    *filePath=[[filePathAndDirectory stringByAppendingPathComponent:cell.name.text  ] stringByAppendingPathExtension:@"pdf"];
        
        
              
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        

        NSLog(@"Brochure Name: %@", cell.name.text);
        
//        ASIFormDataRequest *request =[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@brochuresList.php",SERVER]]];//@"http://www.x-2.info/SalesApp_php/brochuresList.php"]];
//        [request setCompletionBlock:^{
//            
//            NSArray *files =[request.responseString componentsSeparatedByString:@"@"];
//            for(int i=0;i<[files count];i++)
//            {
//                NSString *file=[files objectAtIndex:i];
//                NSArray *subfiles =[file componentsSeparatedByString:@"$"];
//                [brochures addObject:subfiles];
//            }
//            [brochures removeLastObject];
//            [self showTable];
//            
//        }];
        
        ASIFormDataRequest *req=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@testdownloadBrochure.php",SERVER]]]; //@"http://www.x-2.info/SalesApp_php/test/downloadBrochure.php"]];
        [req setPostValue:cell.name.text forKey:@"name"];
//        [req setDownloadDestinationPath:filePath];
        [req setCompletionBlock:^{
            NSLog(@"Download Brochure: %@",req.responseString);
            
            NSString *stringURL = req.responseString;
            NSURL  *url = [NSURL URLWithString:stringURL];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            if ( urlData )
            {
                NSString *emailSubject = [@"Brochure - " stringByAppendingString:cell.name.text];
                NSString *pdfFilename = [cell.name.text stringByAppendingString:@".pdf"];
                
                NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString  *documentsDirectory = [paths objectAtIndex:0];
                
                NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,pdfFilename];
                [urlData writeToFile:filePath atomically:YES];
                
                MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
                picker.mailComposeDelegate = self;
                
                // Set the subject of email
                [picker setSubject:emailSubject];
                
                NSData *pdfData = [NSData dataWithContentsOfFile:filePath];
                [picker addAttachmentData:pdfData mimeType:@"application/PDF" fileName: pdfFilename];
                
                
                [self presentModalViewController:picker animated:YES];
                
                // Release picker
                [picker release];
            }
            
            // Do any additional setup after loading the view.
        }];
        [req setFailedBlock:^{
        }];
        
        [req startAsynchronous];

    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"The limit for attachement was reached!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
   
}


-(void)sendBrochures:(UIButton *)sender
{
    BOOL isDir=NO;
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *subpaths;
    
    NSString *toCompress = @"Brochures_Archive1";
//    NSString *pathToCompress = [documentsDirectory stringByAppendingPathComponent:toCompress];
    
    NSArray     *docs=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString    *docPath=[docs objectAtIndex:0];
    //    NSString    *filePath=[docPath stringByAppendingPathComponent:@"Brochures"];
    
    //    filePathAndDirectory=@"";
    NSString *filePathAndDirectory = [docPath stringByAppendingPathComponent:@"Brochures"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePathAndDirectory isDirectory:&isDir] && isDir){
        subpaths = [fileManager subpathsAtPath:filePathAndDirectory];
    } else if ([fileManager fileExistsAtPath:filePathAndDirectory]) {
        subpaths = [NSArray arrayWithObject:filePathAndDirectory];
    }
    
    NSString *zipFilePath = [documentsDirectory stringByAppendingPathComponent:@"Brochures_Archive.zip"];
    
    ZipArchive *za = [[ZipArchive alloc] init];
    [za CreateZipFile2:zipFilePath];
    if (isDir) {
        for(NSString *path in subpaths){
            NSString *fullPath = [filePathAndDirectory stringByAppendingPathComponent:path];
            if([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && !isDir){
                [za addFileToZip:fullPath newname:path];
            }
        }
    } else {
        [za addFileToZip:filePathAndDirectory newname:toCompress];
    }
    
    BOOL successCompressing = [za CloseZipFile2];
    if(successCompressing)
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        // Set the subject of email
        [picker setSubject:@"Brochure"];

        NSData *pdfData = [NSData dataWithContentsOfFile:zipFilePath];
        [picker addAttachmentData:pdfData mimeType:@"application/zip" fileName:@"Brochures_Archive.zip"];
        
        
        [self presentModalViewController:picker animated:YES];
        
        // Release picker
        [picker release];
        // Do any additional setup after loading the view.

    }
    else
    {
        NSLog(@"compressing not succede!");
    }

}


-(void)show:(NSString *)nm pfilepth:(NSString*)file
{
    
    [DejalBezelActivityView removeViewAnimated:YES];

    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Set the subject of email
    [picker setSubject:@"Brochure"];
    

    
    NSData *pdfData = [NSData dataWithContentsOfFile:file];
    [picker addAttachmentData:pdfData mimeType:@"application/pdf" fileName:name];
    
    
    [self presentModalViewController:picker animated:YES];
    
    // Release picker
    [picker release];
	// Do any additional setup after loading the view.
    

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Called once the email is sent
    // Remove the email view controller
    [self dismissModalViewControllerAnimated:YES];
}



-(void)backButtonPressed:(UIButton *)sender
{
    CATransition *transition =[CATransition animation];
    transition.duration =kAnimationDuration;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"cube";
    transition.subtype=kCATransitionFromLeft;
    transition.delegate=self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
