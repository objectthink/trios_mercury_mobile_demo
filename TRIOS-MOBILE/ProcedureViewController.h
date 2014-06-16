//
//  ProcedureViewController.h
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/14/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MercuryInstrument.h"
#import "MercuryStatus.h"
#import "MercuryFile.h"

@interface ProcedureViewController : UIViewController <
MercuryInstrumentDelegate,
IMercuryFileReader
>
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *doneLabel;
@end
