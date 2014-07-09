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
#import "SegmentsTableViewController.h"

@interface CreateProcedureViewController ()

@end

@implementation CreateProcedureViewController
{
   UIBarButtonItem* _editButton;
   UIBarButtonItem* _doneButton;
   UIBarButtonItem* _startButton;
   BOOL _isEditing;
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
   
   _isEditing = NO;
   
   _startButton =
   [[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
    target:self
    action:@selector(startItemTapped)];
   
   _editButton =
   [[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
    target:self
    action:@selector(editItemTapped)];

   _doneButton =
   [[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
    target:self
    action:@selector(editItemTapped)];

   self.navigationItem.rightBarButtonItems = @[_startButton, _editButton];
}

-(void)editItemTapped
{
   NSLog(@"selectedIndex:%lu", (unsigned long)self.selectedIndex);
   
   _isEditing = !_isEditing;
   
   if(_isEditing)
      self.navigationItem.rightBarButtonItems = @[_startButton, _doneButton];
   else
      self.navigationItem.rightBarButtonItems = @[_startButton, _editButton];

   self.selectedViewController.editing = _isEditing;
}

-(void)startItemTapped
{
   NSLog(@"DONE TAPPED!");
   
   SegmentsTableViewController* c =
   [self.viewControllers objectAtIndex:1];
   
   //SET
   MercurySetProcedureCommand* setCommand =
   [[MercurySetProcedureCommand alloc] init];
   
   for (MercurySegment* segment in c.segments)
   {
      NSLog(@"%@",segment);
      [setCommand addSegment:segment];
   }

   [setCommand addSignal:IdT0C];
   [setCommand addSignal:IdCommonTime];
   [setCommand addSignal:IdHeatFlow];
   
   [_instrument sendCommand:setCommand];
   
   //START
   MercuryStartProcedureCommand* command =
   [[MercuryStartProcedureCommand alloc]init];
   
   [_instrument sendCommand:command];
   
   [self.navigationController popViewControllerAnimated:YES];
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
