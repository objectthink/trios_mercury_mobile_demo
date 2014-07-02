//
//  EquilibrateSegmentEditorViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 7/2/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "EquilibrateSegmentEditorViewController.h"

@interface EquilibrateSegmentEditorViewController ()

@end

@implementation EquilibrateSegmentEditorViewController

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

   SegmentEquilibrate* e = (SegmentEquilibrate*)self.segment;
   
   NSLog(@"%f", e.equilibrateTemperature);
}

-(void)viewWillDisappear:(BOOL)animated
{
   SegmentEquilibrate* e = (SegmentEquilibrate*)self.segment;
   e.equilibrateTemperature = 77;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
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
