//
//  CreateProcedureViewController.h
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/28/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SNFSegmentedViewController.h>
#import "MercuryProcedure.h"

@interface CreateProcedureViewController : SNFSegmentedViewController
@property (weak, nonatomic) MercuryInstrument* instrument;
@end
