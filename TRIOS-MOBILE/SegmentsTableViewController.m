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
   
   __weak IBOutlet UIButton *_addButton;
   
   UIPopoverController* _popoverController;
   
   NSArray* _choices;
}

@end

@implementation SegmentsTableViewController

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
   [_segmentSelectedList reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   CGRect frame =
   [tableView rectForRowAtIndexPath:indexPath];
   
   MercurySegmentEditorViewController* e;
   
   MercurySegment* segment = [_segments objectAtIndex:indexPath.row];
   
   switch (segment.segmentId)
   {
      case Isothermal:
         e =
         [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil]
          instantiateViewControllerWithIdentifier:@"IsothermalEditor"];
         break;
      case Equilibrate:
         e =
         [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil]
          instantiateViewControllerWithIdentifier:@"EquilibrateEditor"];
         break;
      case Ramp:
         e =
         [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil]
          instantiateViewControllerWithIdentifier:@"RampEditor"];
         break;
   }
   
   //do we have an editor for the taped segment?
   if (e != nil)
   {
      e.segment = segment;
      
      _popoverController =
      [[UIPopoverController alloc] initWithContentViewController:e];
      
      _popoverController.delegate = self;
      
      [_popoverController
       presentPopoverFromRect:[tableView convertRect:frame toView:self.view]
       inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
   }
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
   _segmentSelectedList.editing = editing;
   _addButton.enabled = !editing;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
   return YES;
}

-  (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath
{
   MercurySegment* segment = [_segments objectAtIndex:sourceIndexPath.row];
   [_segments removeObjectAtIndex:sourceIndexPath.row];
   [_segments insertObject:segment atIndex:destinationIndexPath.row];

}

- (void) tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (editingStyle == UITableViewCellEditingStyleDelete)
   {
      [_segments removeObjectAtIndex:indexPath.row];
      
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                       withRowAnimation:UITableViewRowAnimationFade];
   }
}

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
   
   _choices =
  @[
    [[SegmentEquilibrate alloc] initWithTemperature:40.0],
    [[SegmentIsothermal alloc]initWithTime:1.00],
    [[SegmentRamp alloc]initWithDegreesPerMinute:20 finalTemerature:50],
    [[SegmentDataOn alloc]initWithBool:YES]
    ];
   
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
   
   MercurySegment* segment =
   [_choices objectAtIndex:selected];
   
   [_segments addObject:[segment copy]];
   
   [_segmentSelectedList reloadData];
}

#pragma mark - picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
   return [_choices count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component
{
   MercurySegment* segment =
   [_choices objectAtIndex:row];
   
   return [segment name];
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
   
   cell.selectionStyle = UITableViewCellSelectionStyleDefault;
   
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
