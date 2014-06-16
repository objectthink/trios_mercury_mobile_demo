//
//  ProcedureViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/14/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "ProcedureViewController.h"
#import "AppDelegate.h"
#import "MercuryFile.h"

@interface ProcedureViewController ()
{
   MercuryInstrument* _instrument;
   int _offset;
}
@end

@implementation ProcedureViewController

-(void)finished:(id<IMercuryFile>)file
{
   NSLog(@"finished:%d",file.data.length);   
}

-(void)updated:(id<IMercuryFile>)file
{
   NSLog(@"updated:%d",file.data.length);
   
   while (_offset < file.data.length)
   {
      id<IMercuryRecord> r = [file getMercuryRecordAtOffset:_offset];
      
      id s = r;

      if (r == nil)
         break;
      
      NSLog(@"%@",r.tag);
      
      _offset += r.length;
      
      if([s isKindOfClass:MercuryDataRecord.class])
      {
         MercuryDataRecord* dr = r;
         
         NSLog(@"%f",[dr valueAtIndex:0]);
      }
   }
}

- (IBAction)startProcedureTapped:(UIButton *)sender
{
   MercuryStartProcedureCommand* command =
   [[MercuryStartProcedureCommand alloc]init];
   
   [_instrument sendCommand:command];
}

- (IBAction)testTapped:(id)sender
{
//   MercuryReadFileCommand* command =
//   [[MercuryReadFileCommand alloc]
//    initWithFilename:@"Procedure.dat" offset:0 moveMethod:0 dataLengthRequested:100];
//   
//   [_instrument sendCommand:command];
   
   _offset = 0;
   
   MercuryFile* file =
   [[MercuryFile alloc]initWithInstrument:_instrument andFilename:@"Procedure.dat"];
   
   MercuryDataFileReader* reader =
   [[MercuryDataFileReader alloc]initWithInstrument:_instrument file:file readSize:2048];
   
   reader.delegate = self;
   
   [reader start];
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
      
      NSLog(@"run:%d end:%d",status.runStatus, status.endStatus);
   }
   if(subcommand == DataFileStatus)
   {
      MercuryDataFileStatus* status =
      [[MercuryDataFileStatus alloc]initWithMessage:message];
      
      NSLog(@"length:%d state:%d",status.length, status.state);
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
         MercuryReadFileResponse* response =
         [[MercuryReadFileResponse alloc]initWithMessage:message];
         
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
   
   //_instrument.instrumentDelegate = self;
   
   [_instrument addDelegate:self];
   
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
