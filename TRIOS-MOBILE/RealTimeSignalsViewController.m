//
//  RealTimeSignalsViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/7/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "RealTimeSignalsViewController.h"

@interface RealTimeSignalsViewController ()
{
   AppDelegate* _app;
   MercuryInstrument* _instrument;
   MercurySetRealTimeSignalsCommand* command;
   NSMutableArray* signalsList;
   NSMutableArray* signals;
}

@end

@implementation RealTimeSignalsViewController
-(long)tableView:tableView numberOfRowsInSection:(NSInteger)section
{
   return [signalsList count];
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
   cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",
                          [signalsList objectAtIndex:indexPath.row],
                          [signals objectAtIndex:indexPath.row]
                          ];
   return cell;
}

- (IBAction)clearTapped:(id)sender
{
   command = [[MercurySetRealTimeSignalsCommand alloc] init];
}

- (IBAction)addSignalTapped:(id)sender
{
   [command addSignal:[self.signalText.text intValue]];
}

- (IBAction)setSignalListTapped:(id)sender
{
   [_instrument sendCommand:command];
}

- (IBAction)getSignalListTapped:(id)sender
{
   [_instrument sendCommand:[[MercuryGetRealTimeSignalsCommand alloc]init]];
}

-(void)ackWithSequenceNumber:(uint)sequencenumber
{
   NSLog(@"ack:%d",sequencenumber);
}

-(void)nakWithSequenceNumber:(uint)sequencenumber andError:(uint)errorcode
{
   NSLog(@"nak:%d %d",sequencenumber, errorcode);
}

-(void)connected
{
}

-(void)accept:(MercuryAccess)access
{
}

-(void)stat:(NSData*)message withSubcommand:(uint)subcommand
{
   if(subcommand == 0x00020002)
   {
      [signals removeAllObjects];
      
      long signalCount = [message length]/4;
      for (int i = 1; i < signalCount -1; i++)
      {
         float signal = [_instrument floatAtOffset:i*4 inData:message];
         [signals addObject:[NSNumber numberWithFloat:signal]];
      }
      
      [self.signalTableView reloadData];
   }
}

-(void)response:(NSData *)message withSequenceNumber:(uint)sequenceNumber subcommand:(uint)subcommand status:(uint)status
{
   NSLog(@"response:%d %d %d", sequenceNumber, subcommand, status);
 
   //get response
   if(subcommand == 0x00000008)
   {
      [signalsList removeAllObjects];
      
      long signalCount = [message length]/4;
      for (int i =0; i < signalCount; i++)
      {
         uint signal = [_instrument uintAtOffset:i*4 inData:message];
         [signalsList addObject:[NSNumber numberWithInt:signal]];
      }
   }
   
   //set response, do get
   if(subcommand == 0x0001000A)
   {
      [_instrument sendCommand:[[MercuryGetRealTimeSignalsCommand alloc]init]];      
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

   _app = [[UIApplication sharedApplication] delegate];
   _instrument = [_app instrument];
   
   signalsList = [[NSMutableArray alloc] init];
   signals = [[NSMutableArray alloc] init];
   
   //get the current list of signals
   [_instrument sendCommand:[[MercuryGetRealTimeSignalsCommand alloc]init]];
   
   if(_instrument.access == Viewer)
   {
      self.setSignalButton.enabled = NO;
      self.addSignalButton.enabled = NO;
   }
   else
   {
      self.setSignalButton.enabled = YES;
      self.addSignalButton.enabled = YES;
   }
   
   command = [[MercurySetRealTimeSignalsCommand alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
   _instrument.instrumentDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
