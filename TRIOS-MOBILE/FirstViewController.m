//
//  FirstViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/4/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//
#import "AppDelegate.h"
#import "FirstViewController.h"

@implementation MercuryFEPCriticalStatus
{
}

-(id)initWithMessage:(NSMutableData*)message
{
   if(self = [super initWithMessage:message])
   {
      self.names = @[
                @"Heater A/D Counts",
                @"Heater A/D millivolts",
                @"Heater Temperature",
                @"Heater A/D Data Valid",
                @"Flange A/D Counts",
                @"Flange A/D millivolts",
                @"Flange Temperature",
                @"Flange A/D Data Valid",
                @"Tzero A/D Counts",
                @"Tzero A/D millivolts",
                @"Tzero Temperature",
                @"Tzero A/D Data Valid",
                @"DeltaT A/D Counts",
                @"DeltaT A/D millivolts",
                @"DeltaT microVolts",
                @"DeltaT A/D Data Valid",
                @"Delta Tzero A/D Counts",
                @"Delta Tzero A/D millivolts",
                @"Delta Tzero microVolts",
                @"Delta Tzero A/D Data Valid",
                @"Reference Junction A/D Counts",
                @"Reference Junction A/D millivolts",
                @"Reference Junction Temperature",
                @"Reference Junction A/D Data Valid",
                @"Delta Lid A/D Counts",
                @"Delta Lid A/D millivolts",
                @"Delta Lid Temperature",
                @"Delta Lid A/D Data Valid",
                @"DT Amp Temp A/D Counts",
                @"DT Amp Temp A/D millivolts",
                @"DT Amp Temp Temperature",
                @"DT Amp Temp A/D Data Valid",
                @"T Zero Temp Corrected",
                @"MDSC Sine Angle",
                @"Ramp Rate",
                @"Programmed Ramp Rate",
                @"Operating State",
                @"Fep Flags",
                @"Power Requested",
                @"Set Point Temperature",
                
                ];
      
      self.values = [NSMutableArray arrayWithCapacity:[self.names count]];
      
      for (int i=0; i< [self.names count]; i++)
         [self.values addObject:[NSNumber numberWithInt:0]];
      
//      float temperature = [self floatAtOffset:12 inData:message];
//      [self.values setObject:[NSNumber numberWithFloat:temperature] atIndexedSubscript:2];
//      
//      float tzeroTemperature = [self floatAtOffset:44 inData:message];
//      [self.values setObject:[NSNumber numberWithFloat:tzeroTemperature] atIndexedSubscript:10];
      
      
      /*Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:4 inData:message]] atIndexedSubscript:0];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:8 inData:message]] atIndexedSubscript:1];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:12 inData:message]] atIndexedSubscript:2];
      /*Unsigned Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:16 inData:message]] atIndexedSubscript:3];
      /*Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:20 inData:message]] atIndexedSubscript:4];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:24 inData:message]] atIndexedSubscript:5];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:28 inData:message]] atIndexedSubscript:6];
      /*Unsigned Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:32 inData:message]] atIndexedSubscript:7];
      /*Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:36 inData:message]] atIndexedSubscript:8];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:40 inData:message]] atIndexedSubscript:9];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:44 inData:message]] atIndexedSubscript:10];
      /*Unsigned Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:48 inData:message]] atIndexedSubscript:11];
      /*Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:52 inData:message]] atIndexedSubscript:12];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:56 inData:message]] atIndexedSubscript:13];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:60 inData:message]] atIndexedSubscript:14];
      /*Unsigned Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:64 inData:message]] atIndexedSubscript:15];
      /*Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:68 inData:message]] atIndexedSubscript:16];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:72 inData:message]] atIndexedSubscript:17];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:76 inData:message]] atIndexedSubscript:18];
      /*Unsigned Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:80 inData:message]] atIndexedSubscript:19];
      /*Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:84 inData:message]] atIndexedSubscript:21];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:88 inData:message]] atIndexedSubscript:22];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:92 inData:message]] atIndexedSubscript:23];
      /*Unsigned Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:96 inData:message]] atIndexedSubscript:24];
      /*Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:100 inData:message]] atIndexedSubscript:25];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:104 inData:message]] atIndexedSubscript:26];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:108 inData:message]] atIndexedSubscript:27];
      /*Unsigned Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:112 inData:message]] atIndexedSubscript:28];
      /*Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:116 inData:message]] atIndexedSubscript:29];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:120 inData:message]] atIndexedSubscript:30];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:124 inData:message]] atIndexedSubscript:31];
      /*Unsigned Integer*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:128 inData:message]] atIndexedSubscript:32];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:132 inData:message]] atIndexedSubscript:33];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:136 inData:message]] atIndexedSubscript:34];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:140 inData:message]] atIndexedSubscript:35];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:144 inData:message]] atIndexedSubscript:36];
      /*Enum*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:148 inData:message]] atIndexedSubscript:37];
      /*Bits*/
      [self.values setObject:[NSNumber numberWithFloat:[self uintAtOffset:152 inData:message]] atIndexedSubscript:38];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:156 inData:message]] atIndexedSubscript:39];
      /*Float*/
      [self.values setObject:[NSNumber numberWithFloat:[self floatAtOffset:160 inData:message]] atIndexedSubscript:40];
   }
   return self;
}
@end

@interface FirstViewController ()
{
   AppDelegate* _app;
   MercuryInstrument* _instrument;
   MercuryFEPCriticalStatus* status;
}
@end

@implementation FirstViewController

-(void)response:(NSData *)message withSequenceNumber:(uint)sequenceNumber subcommand:(uint)subcommand status:(uint)status
{
}

-(int)tableView:tableView numberOfRowsInSection:(NSInteger)section
{
   return [status.names count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView
       cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
   
   if (cell == nil)
   {
      cell = [[UITableViewCell alloc]
              initWithStyle:UITableViewCellStyleSubtitle
              reuseIdentifier:@"MyIdentifier"];
      
   }
   
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   cell.textLabel.text =
   [NSString stringWithFormat:@"%@",
    [status.names objectAtIndex:indexPath.row]
    ];
   
   cell.detailTextLabel.text =
   [NSString stringWithFormat:@"%@",
    [status.values objectAtIndex:indexPath.row]
    ];
   
   return cell;
}

- (IBAction)testTapped:(UIButton *)sender
{
   [_instrument sendCommand:[[MercurySetRealTimeSignalsCommand alloc]init]];
}

-(void)ackWithSequenceNumber:(uint)sequencenumber
{
   NSLog(@"FirstViewController ack:%d",sequencenumber);
}

-(void)nakWithSequenceNumber:(uint)sequencenumber andError:(uint)errorcode
{
   NSLog(@"firstViewController nak:%d [%d]",sequencenumber,errorcode);
}

-(void)connected
{
   NSLog(@"FirstViewController:connected");
}

-(void)accept:(MercuryAccess)access
{
   NSLog(@"FirstViewController:accept:%d",access);
}

-(void)stat:(NSData*)message withSubcommand:(uint)subcommand
{
   if(subcommand == 0x01026000)
   {
      status =
      [[MercuryFEPCriticalStatus alloc]initWithMessage:[message copy]];
            
      [self.FETStatusTableView reloadData];
   }
   
}

-(void)response:(NSData*)message withSubcommand:(uint)subcommand
{
   NSLog(@"FirstViewController:response:%d",subcommand);
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   
   _app = [[UIApplication sharedApplication] delegate];
   _instrument = [_app instrument];
   
   NSString* accessString;
   NSString* title;
   
   switch (_instrument.access)
   {
      case Viewer:
         accessString = @"Viewer";
         break;
      case Master:
         accessString = @"Master";
      default:
         break;
   }
   
   title = [NSString stringWithFormat:@"%@ %@ ",_instrument.host,accessString];
   
   [[self tabBarController] setTitle:title];
   
   /////////////////////////////////////////
}

-(void)viewWillAppear:(BOOL)animated
{
   _instrument.instrumentDelegate = self;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
}

@end
