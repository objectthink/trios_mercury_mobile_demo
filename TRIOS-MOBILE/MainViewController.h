//
//  MainViewController.h
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/4/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MercuryInstrument.h"

@interface MainViewController : UIViewController
<
MercuryInstrumentDelegate,
UIPickerViewDataSource
>
@property (weak, nonatomic) IBOutlet UITextField *ipAddressText;
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIPickerView *accessPicker;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
@end
