//
//  ProcedureViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/14/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "ProcedureViewController.h"
#import "ProcedureViewTableViewCell.h"

@interface ProcedureViewController ()
{
   MercuryInstrument* _instrument;
   MercuryGetProcedureResponse* _procedure;
   MercuryDataRecord* _dataRecord;
   int _offset;
   int _selectedSignalIndex;
   
   NSObject<MercuryDataFileVisualizer>* _dataFileVisualizer;
   NSObject<MercuryDataFileVisualizerEx>* _dataFileVisualizerEx;
   
   MercuryFile* _file;
   MercuryDataFileReader* _reader;
}
@end

@implementation ProcedureViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   _dataFileVisualizer = [segue destinationViewController];
   _dataFileVisualizerEx = [segue destinationViewController];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   _selectedSignalIndex = (int)indexPath.row;
   [self performSegueWithIdentifier:@"SignalDetail" sender:self];
}

//TODO:add signals property to get procedure response
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if(_procedure != nil)
   {
      return (int) _procedure.bytes.length  / 4;  //bytes is signal list for now
   }
   else
      return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
   
   if (cell == nil)
   {
      cell = [[ProcedureViewTableViewCell alloc]
              initWithStyle:UITableViewCellStyleSubtitle
              reuseIdentifier:@"MyIdentifier"];
   }
   
   cell.textLabel.text = [_procedure signalToString:[_procedure signalAtIndex:(int)indexPath.row]];
   
   cell.detailTextLabel.text =
   [NSString stringWithFormat:@"%f",[_dataRecord valueAtIndex:(int)indexPath.row]];
   
   return cell;
}

-(void)finished:(id<IMercuryFile>)file
{
   NSLog(@"finished:%lu",(unsigned long)file.data.length);
   
   self.doneLabel.text =
   [NSString stringWithFormat:@"finished:%lu",(unsigned long)file.data.length];
   
   _reader.delegate = nil;
   
   _file = nil;
   _reader = nil;
}

-(void)updated:(id<IMercuryFile>)file
{
   NSLog(@"updated:%lu",(unsigned long)file.data.length);
   while (_offset < file.data.length)
   {
      MercuryRecord* r = (MercuryRecord*)[file getMercuryRecordAtOffset:_offset];
      
      id s = r;

      if (r == nil)
         break;
      
      NSLog(@"%@",r.tag);
      
      _offset += r.length;
      
      if([s isKindOfClass:MercuryDataRecord.class])
      {
         _dataRecord = (MercuryDataRecord*)r;
         
         if (_dataFileVisualizer != nil)
         {
//            [_dataFileVisualizer
//             pointData:[_dataRecord valueAtIndex:[_procedure indexOfSignal:_selectedSignalIndex+1]]
//             time:[_dataRecord valueAtIndex:[_procedure indexOfSignal:IdCommonTime]]
//             ];
            
            [_dataFileVisualizerEx procedure:_procedure
                                      record:_dataRecord
                                     xSignal:IdCommonTime
                                     ySignal:[_procedure signalAtIndex:_selectedSignalIndex]
                                 seriesIndex:0];
         }
         
         [self.SignalTableView reloadData];
      }
      
      if([s isKindOfClass:MercuryGetRecord.class])
      {
         MercuryGetRecord* gr = (MercuryGetRecord*)r;
         
         _procedure =
         [[MercuryGetProcedureResponse alloc]initWithMessage:gr.data];
         
      }
   }
}

- (IBAction)startProcedureTapped:(UIButton *)sender
{
   //create and send procedure
   MercurySetProcedureCommand* setCommand =
   [[MercurySetProcedureCommand alloc] init];
   
   [setCommand addSegment:[[SegmentEquilibrate alloc] initWithTemperature:40.0]];
   [setCommand addSegment:[[SegmentIsothermal alloc]initWithTime:0.3]];
   [setCommand addSegment:[[SegmentRamp alloc] initWithDegreesPerMinute:20 finalTemerature:60]];
   
   [setCommand addSignal:IdT0C];
   [setCommand addSignal:IdCommonTime];
   [setCommand addSignal:IdHeatFlow];
   
   [_instrument sendCommand:setCommand];
   
   MercuryStartProcedureCommand* command =
   [[MercuryStartProcedureCommand alloc]init];
   
   [_instrument sendCommand:command];
}

- (IBAction)testTapped:(id)sender
{
   self.doneLabel.text = @"";

   _offset = 0;
   
   //MercuryFile* file =
   _file =
   [[MercuryFile alloc]initWithInstrument:_instrument andFilename:@"Procedure.dat"];
   
   //MercuryDataFileReader* reader =
   _reader =
   [[MercuryDataFileReader alloc]initWithInstrument:_instrument file:_file readSize:8192];
   
   _reader.delegate = self;
   
   [_reader start];
}

-(void)connected
{
}

-(void)accept:(MercuryAccess)access
{
}

-(void)stat:(NSData*)message withSubcommand:(uint)subcommand
{
   if(subcommand == ProcedureStatus)
   {
      MercuryProcedureStatus* status =
      [[MercuryProcedureStatus alloc] initWithMessage:message];
      
      //NSLog(@"run:%d end:%d",status.runStatus, status.endStatus);
      
      NSString* runStatus;
      switch (status.runStatus)
      {
         case Idle:
            runStatus = @"Idle";
            break;
         case PostTest:
            runStatus = @"PostTest";
            break;
         case PreTest:
            runStatus = @"PreTest";
            break;
         case Test:
            runStatus = @"Test";
            break;
         default:
            runStatus = @"Unknown";
            break;
      }
      
      NSString* endStatus;
      switch (status.endStatus) {
         case Complete:
            endStatus = @"Complete";
            break;
         case Error:
            endStatus = @"Error";
            break;
         case NotRun:
            endStatus = @"NotRun";
            break;
         case Running:
            endStatus = @"Running";
            break;
         case UserStopped:
            endStatus = @"UserStopped";
            break;
         default:
            endStatus = @"Unknown";
            break;
      }
      
      self.ProcedureStatusData.text =
      [NSString stringWithFormat:@"runstatus: %@ endstatus: %@ segment: %d",
       runStatus , endStatus, status.currentSegmentId];
   }
   
   if(subcommand == DataFileStatus)
   {
      MercuryDataFileStatus* status =
      [[MercuryDataFileStatus alloc]initWithMessage:message];
      
      NSString* state;
      switch (status.state) {
         case Open:
            state = @"Open";
            break;
         case Closed:
            state = @"Closed";
            break;
         case DoesNotExist:
            state = @"DoesNotExist";
         default:
            state = @"Unkown";
            break;
      }
      
      self.DataFileStatusData.text =
      [NSString stringWithFormat:@"length: %d  state: %@", status.length, state];
   }
}

-(void)     response:(NSData *)message
  withSequenceNumber:(uint)sequenceNumber
          subcommand:(uint)subcommand
              status:(uint)status
{
   if(subcommand == 0x00000007)
   {
      if(status==0)
      {
         //MercuryReadFileResponse* response =
         //[[MercuryReadFileResponse alloc]initWithMessage:message];
         
      }
   }

}

-(void)ackWithSequenceNumber:(uint)sequencenumber
{
}

-(void)nakWithSequenceNumber:(uint)sequencenumber andError:(uint)errorcode
{
}

-(void)error:(NSError *)error
{
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      // Custom initialization
   }
   return self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   
   AppDelegate* app = [[UIApplication sharedApplication] delegate];
   
   _instrument = [app instrument];
   
   [_instrument addDelegate:self];
   
   [_instrument sendCommand:[[MercuryGetProcedureStatusCommand alloc]init]];
   [_instrument sendCommand:[[MercuryGetDataFileStatusCommand alloc]init]];
   
   self.title = @"Procedure";
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

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
