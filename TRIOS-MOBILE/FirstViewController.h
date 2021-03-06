//
//  FirstViewController.h
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/4/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MercuryInstrument.h"

@interface MercuryFEPCriticalStatus : MercuryStatus
@property (strong, nonatomic) NSArray* names;
@property (strong, nonatomic) NSMutableArray* values;
@end

@interface FirstViewController : UIViewController <
MercuryInstrumentDelegate,
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) IBOutlet UITableView *FETStatusTableView;

@end
