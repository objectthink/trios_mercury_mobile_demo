//
//  CreateProcedureViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/28/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "CreateProcedureViewController.h"
#import "FlowManager.h"

@interface CreateProcedureViewController ()

@end

@implementation CreateProcedureViewController

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
   // Do any additional setup after loading the view.
   
   FlowManager* flowManager =
   [[FlowManager alloc] initWithFrame:self.view.frame];
   
   [self.view addSubview:flowManager];
   
   for (int i=0; i<3; i++)
   {
      UIView* view =
      [[UIView alloc] initWithFrame:CGRectMake(0,0, 200, 50)];
      
      [view setBackgroundColor:[UIColor blueColor]];
      [flowManager addSubview:view toFlowAtIndex:0];
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
