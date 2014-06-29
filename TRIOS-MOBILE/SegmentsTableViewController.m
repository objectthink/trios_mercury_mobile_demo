//
//  SegmentsTableViewController.m
//  Pods
//
//  Created by stephen eshelman on 6/29/14.
//
//

#import "SegmentsTableViewController.h"
#import "MercuryProcedure.h"

@interface SegmentsTableViewController ()
{   
   IBOutlet UIPickerView *_segmentChoiceList;
   IBOutlet UITableView *_segmentSelectedList;
}

@end

@implementation SegmentsTableViewController

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
   
   self.segments = [[NSMutableArray alloc]init];
   self.signals  = [[NSMutableArray alloc] init];
   
   // Uncomment the following line to preserve selection between presentations.
   // self.clearsSelectionOnViewWillAppear = NO;
   
   // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
   // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
}

- (IBAction)addSegmentTapped:(UIButton *)sender
{
   int selected =
   [_segmentChoiceList selectedRowInComponent:0];
   
   switch (selected)
   {
      case 0:
         [_segments addObject:[[SegmentEquilibrate alloc]initWithTemperature:40.0]];
         break;
      case 1:
         [_segments addObject:[[SegmentIsothermal alloc] initWithTime:1.0]];
         break;
      case 2:
         [_segments addObject:[[SegmentRamp alloc] initWithDegreesPerMinute:20 finalTemerature:50.0]];
          break;
   }
   
   [_segmentSelectedList reloadData];
}

#pragma mark - picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
   return 3;
}

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component
{
   switch (row)
   {
      case 0:
         return @"Equilibrate";
         break;
      case 1:
         return @"Isothermal";
         break;
      case 2:
         return @"Ramp";
         break;
   }
   
   return @"Viewer";
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
   switch (row)
   {
      case 0:
         break;
      case 1:
         break;
      case 2:
         break;
   }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [self.segments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
   
   if (cell == nil)
   {
      cell = [[UITableViewCell alloc]
              initWithStyle:UITableViewCellStyleSubtitle
              reuseIdentifier:@"MyIdentifier"];
      
   }
   
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
   cell.textLabel.text        =
   [[self.segments objectAtIndex:indexPath.row] name];
   
   cell.detailTextLabel.text  =
   [[self.segments objectAtIndex:indexPath.row] description];
   
   return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
