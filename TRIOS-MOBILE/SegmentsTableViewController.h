//
//  SegmentsTableViewController.h
//  Pods
//
//  Created by stephen eshelman on 6/29/14.
//
//

#import <UIKit/UIKit.h>

@interface SegmentsTableViewController : UIViewController <
UITableViewDataSource,
UITableViewDelegate,
UIPickerViewDataSource,
UIPickerViewDelegate,
UIPopoverControllerDelegate
>

@property (strong, nonatomic) NSMutableArray* segments;
@property (strong, nonatomic) NSMutableArray* signals;

@end
