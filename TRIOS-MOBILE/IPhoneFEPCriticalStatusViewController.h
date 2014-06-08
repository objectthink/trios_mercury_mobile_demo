//
//  IPhoneFEPCriticalStatusViewController.h
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/8/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MercuryInstrument.h"

@interface IPhoneFEPCriticalStatusViewController : UIViewController <
MercuryInstrumentDelegate,
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) IBOutlet UITableView *FETStatusTableView;

@end

