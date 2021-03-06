//
//  IsothermalSegmentEditorViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 7/2/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "IsothermalSegmentEditorViewController.h"

@interface IsothermalSegmentEditorViewController ()
@end

@implementation IsothermalSegmentEditorViewController
{
   IBOutlet UITextField *_timeInMinutesText;
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
   
   SegmentIsothermal* i = (SegmentIsothermal*)self.segment;
   
   _timeInMinutesText.text =
   [NSString stringWithFormat:@"%.02f", i.timeInMinutes];
}

-(void)viewWillDisappear:(BOOL)animated
{
   SegmentIsothermal* i = (SegmentIsothermal*)self.segment;
   i.timeInMinutes = [_timeInMinutesText.text floatValue];
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
