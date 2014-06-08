//
//  RealTimeSignalsViewController.h
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/7/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MercuryInstrument.h"

@interface RealTimeSignalsViewController : UIViewController <MercuryInstrumentDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *signalTableView;
@property (strong, nonatomic) IBOutlet UIButton *setSignalButton;
@property (strong, nonatomic) IBOutlet UIButton *addSignalButton;
@property (strong, nonatomic) IBOutlet UITextField *signalText;

@end
