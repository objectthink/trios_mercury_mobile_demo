//
//  DataOnSegmentEditorViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 7/5/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "DataOnSegmentEditorViewController.h"

@interface DataOnSegmentEditorViewController ()

@end

@implementation DataOnSegmentEditorViewController
{
   __weak IBOutlet UISwitch *_dataOnSwitch;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self)
   {
   }
   return self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   
   SegmentDataOn* segment = (SegmentDataOn*)self.segment;
   
   _dataOnSwitch.on = segment.on;
}

-(void)viewWillDisappear:(BOOL)animated
{
   SegmentDataOn* segment = (SegmentDataOn*)self.segment;
   
   segment.on = _dataOnSwitch.on;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
