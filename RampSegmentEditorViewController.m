//
//  RampSegmentEditorViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 7/4/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "RampSegmentEditorViewController.h"

@interface RampSegmentEditorViewController ()

@end

@implementation RampSegmentEditorViewController
{
   IBOutlet UITextField *_degreesPerMinuteText;
   IBOutlet UITextField *_finalTemperatureText;
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
   
   SegmentRamp* r = (SegmentRamp*)self.segment;
   
   _degreesPerMinuteText.text =
   [NSString stringWithFormat:@"%.02f", r.degreesPerMinute];
   
   _finalTemperatureText.text =
   [NSString stringWithFormat:@"%.02f", r.finalTemperature];
}

-(void)viewWillDisappear:(BOOL)animated
{
   SegmentRamp* r = (SegmentRamp*)self.segment;
   
   r.degreesPerMinute = [_degreesPerMinuteText.text floatValue];
   r.finalTemperature = [_finalTemperatureText.text floatValue];
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
