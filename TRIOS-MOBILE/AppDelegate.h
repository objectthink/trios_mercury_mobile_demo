//
//  AppDelegate.h
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/4/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MercuryInstrument.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MercuryInstrument* instrument;
@end
