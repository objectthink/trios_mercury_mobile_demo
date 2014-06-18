//
//  ProcedureViewController.h
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/14/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "MercuryInstrument.h"
#import "MercuryStatus.h"
#import "MercuryFile.h"
#import "MercuryProcedure.h"

@interface ProcedureViewController : UIViewController <
MercuryInstrumentDelegate,
IMercuryFileReader,
UITableViewDataSource,
UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *doneLabel;
@property (strong, nonatomic) IBOutlet UILabel *ProcedureStatusData;
@property (strong, nonatomic) IBOutlet UILabel *DataFileStatusData;
@property (strong, nonatomic) IBOutlet UITableView *SignalTableView;
@end
