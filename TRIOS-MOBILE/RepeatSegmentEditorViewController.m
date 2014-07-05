//
//  RepeatSegmentEditorViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 7/5/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "RepeatSegmentEditorViewController.h"

@interface RepeatSegmentEditorViewController ()

@end

@implementation RepeatSegmentEditorViewController
{
   IBOutlet UITextField *_repeatIndexText;
   IBOutlet UITextField *_countText;
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
   
   SegmentRepeat* segment = (SegmentRepeat*)self.segment;
   
   _repeatIndexText.text =
   [NSString stringWithFormat:@"%d", segment.repeatIndex];
   
   _countText.text =
   [NSString stringWithFormat:@"%d", segment.count];
}

-(void)viewWillDisappear:(BOOL)animated
{
   SegmentRepeat* s = (SegmentRepeat*)self.segment;
   
   s.repeatIndex = [_repeatIndexText.text intValue];
   s.count = [_countText.text intValue];
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
