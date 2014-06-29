//
//  CreateProcedureViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/28/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "CreateProcedureViewController.h"
#import "FlowManager.h"
#import "AppDelegate.h"
#import "MercuryProcedure.h"
#import "SegmentsTableViewController.h"

@interface CreateProcedureViewController ()

@end

@implementation CreateProcedureViewController

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
   
   UIBarButtonItem *doneItem =
   [[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
    target:self
    action:@selector(doneItemTapped)];
   
   NSArray *actionButtonItems = @[doneItem];
   
   self.navigationItem.rightBarButtonItems = actionButtonItems;
}

-(void)doneItemTapped
{
   NSLog(@"DONE TAPPED!");
   
   SegmentsTableViewController* c =
   [self.viewControllers objectAtIndex:1];
   
   for (MercurySegment* segment in c.segments)
   {
      NSLog(@"%@", segment);
   }
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
