//
//  MercuryInstrument.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/4/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "MercuryInstrument.h"

union intToFloat
{
   uint32_t i;
   float fp;
};

@implementation MercuryInstrumentItem : NSObject
{
}

-(id)initWithMessage:(NSData*)message
{
   if(self = [super init])
   {
      self.bytes = [message copy];
   }
   return self;
}

-(NSMutableData*)getBytes
{
   return self.bytes;
}

-(float)floatAtOffset:(NSUInteger)offset inData:(NSData*)data;\
{
   assert([data length] >= offset + sizeof(float));
   union intToFloat convert;
   
   const uint32_t* bytes = [data bytes] + offset;
   
   //convert.i = CFSwapInt32BigToHost(*bytes);
   
   convert.i = (*bytes);
   
   const float value = convert.fp;
   
   return value;   
}

-(uint)uintAtOffset:(NSUInteger)offset inData:(NSData*)data
{
   assert([data length] >= offset + sizeof(float));
   union intToFloat convert;
   
   const uint32_t* bytes = [data bytes] + offset;
   
   convert.i = (*bytes);
   
   const uint value = convert.i;
   
   return value;   
}
@end

@implementation MercuryStatus
@end

@implementation MercuryCommand
-(id)init
{
   if(self = [super init])
   {
      self.bytes = [[NSMutableData alloc] init];
   }
   return self;
}

-(NSMutableData*)getBytes
{
   [self.bytes setLength:0];

   [self.bytes appendBytes:&subCommandId length:4];

   return self.bytes;
}

@end

@implementation MercuryAction
@end

@implementation MercuryGet
@end

@implementation MercuryResponse
@end

@implementation MercuryStartProcedureCommand

-(id)init
{
   if(self = [super init])
   {
      subCommandId = MercuryStartProcedureCommandId;
   }
   return self;
}

@end

@implementation MercurySetRealTimeSignalsCommand
{
   NSMutableArray* signals;
}

-(id)init
{
   if(self = [super init])
   {
      subCommandId = 0x0001000A;
      
      signals = [[NSMutableArray alloc] init];
   }
   return self;
}

//TODO:add signal for testing
-(NSMutableData*)getBytes
{
   [self.bytes setLength:0];
   
   [self.bytes appendBytes:&subCommandId length:4];
   
   for(NSNumber* signal in signals)
   {
      int i = [signal intValue];
      [self.bytes appendBytes:&i length:4];
   }

   return [super getBytes];
}

-(void)addSignal:(int)signal
{
   [signals addObject:[NSNumber numberWithInt:signal]];
}
@end

@implementation MercuryGetRealTimeSignalsCommand
-(id)init
{
   if(self = [super init])
   {
      subCommandId = 0x00000008;
   }
   return self;
}

-(NSMutableData*)getBytes
{
   [self.bytes setLength:0];
   
   [self.bytes appendBytes:&subCommandId length:4];
   
   return [super getBytes];
}
@end

@implementation MercuryInstrument
{
   NSMutableArray* delegates;
   uint _sequenceNumber;
}

-(void)addDelegate:(id<MercuryInstrumentDelegate>)delegate
{
   [delegates addObject:delegate];
}

-(float)floatAtOffset:(NSUInteger)offset
               inData:(NSData*)data
{
   assert([data length] >= offset + sizeof(float));
   union intToFloat convert;
   
   const uint32_t* bytes = [data bytes] + offset;
   
   //convert.i = CFSwapInt32BigToHost(*bytes);
   
   convert.i = (*bytes);
   
   const float value = convert.fp;
   
   return value;
}

-(uint)uintAtOffset:(NSUInteger)offset
             inData:(NSData*)data
{
   assert([data length] >= offset + sizeof(float));
   union intToFloat convert;
   
   const uint32_t* bytes = [data bytes] + offset;
   
   convert.i = (*bytes);
   
   const uint value = convert.i;
   
   return value;
}

-(void)disconnect
{
   [socket disconnect];
}

-(BOOL)connectToHost:(NSString*)host andPort:(uint16_t)port
{
   delegates = [[NSMutableArray alloc]init];
   
   self.host = [NSString stringWithFormat:@"%@",host];

   _sequenceNumber = 0;
   
   dispatch_queue_t mainQueue = dispatch_get_main_queue();
	
	socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue];
	
	NSError *error = nil;
	if (![socket
         connectToHost:host
         onPort:port
         withTimeout:30
         error:&error])
   {
		NSLog(@"Error connecting: %@", error);
      
      if(self.instrumentDelegate != nil)
      {
         if([self.instrumentDelegate respondsToSelector:@selector(error:)])
            [self.instrumentDelegate error:error];
         
         for (id<MercuryInstrumentDelegate> delegate in delegates)
         {
            [delegate error:error];
         }
      }

      return NO;
   }
   else
   {
      NSLog(@"Connecting!");
      return YES;
   }
}

-(BOOL)loginWithUsername:(NSString*)username
             machineName:(NSString*)machineName
               ipAddress:(NSString*)ipAddress
                  access:(uint)access
{
   BOOL r = YES;
   
   struct LoginCommand
   {
      unsigned char Sync[4];
      unsigned int Length;
      unsigned char Type[4];
      unsigned int RequestedAccess;
      unsigned char ClientIP[4];
      char UserName[64];
      char MachineName[64];
      unsigned char Footer[4];
   } LoginMessage =
   {
      {'S', 'Y', 'N', 'C'},
      140,
      {'L', 'O', 'G', 'N'},
      access,
      {127, 0, 0, 1},
      "",
      "",
      {'E', 'N', 'D', ' '}
   };
   
   memcpy(LoginMessage.UserName, [username UTF8String], 64);
   memcpy(LoginMessage.MachineName, [machineName UTF8String], 64);
   
   NSData*   e = [NSData dataWithBytes:&LoginMessage length:152];
   
   [socket writeData:e withTimeout:(NSTimeInterval)30 tag:0];
   [socket readDataToData:[NSData dataWithBytes:"END " length:4] withTimeout:-1 tag:0];
   
   return r;
}

-(uint)sendCommand:(MercuryCommand*)command
{
   _sequenceNumber++;
   
   NSMutableData* message = [[NSMutableData alloc]init];
   
   uint length = [[command getBytes] length];   //(uint)[command.bytes length];
   
   uint action = 0x4E544341;
   uint get = 0x20544547;
   uint type = get;
   
   if([command isKindOfClass:[MercuryAction class]])
      type = action;
   
   length += 8;
   
   [message appendBytes:"SYNC" length:4];
   [message appendBytes:&length length:4];
   [message appendBytes:&type length:4];
   [message appendBytes:&_sequenceNumber length:4];
   [message appendData:[command getBytes]];
   [message appendBytes:"END " length:4];
   
   [socket writeData:message withTimeout:-1 tag:0];
   [socket readDataToData:[NSData dataWithBytes:"END " length:4] withTimeout:-1 tag:0];

   return _sequenceNumber;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
#if !TARGET_IPHONE_SIMULATOR
   {
      [sock performBlock:^{
         if ([sock enableBackgroundingOnSocket])
            NSLog(@"Enabled backgrounding on socket");
         else
            NSLog(@"Enabling backgrounding failed!");
      }];
   }
#endif
   
   if(self.instrumentDelegate != nil)
      [self.instrumentDelegate connected];
   
   for (id<MercuryInstrumentDelegate> delegate in delegates)
   {
      [delegate connected];
   }
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock
{
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	NSLog(@"socket:%p didWriteDataWithTag:%ld", sock, tag);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
   //////////////////////////////
   NSInputStream* inputStream = [NSInputStream inputStreamWithData:data];
   
   [inputStream open];
   
   Byte sync[4];
   Byte type[4];
   Byte length[4];
   Byte length2[4];
   Byte temp[4];
   
   [inputStream read:sync maxLength:4];     //SYNC
   [inputStream read:length maxLength:4];   //LENGTH
   
   [inputStream read:type maxLength:4];     //STAT or
   
   [inputStream read:length2 maxLength:4];  //SUBCOMMAND ID
   [inputStream read:temp maxLength:4];
   [inputStream read:temp maxLength:4];
   
   uint subcommand = [self uintAtOffset:12 inData:data];
   
   NSString* typeAsString =
   [[NSString alloc] initWithBytes:type length:4 encoding:NSUTF8StringEncoding];
   
   uint datalength = [self uintAtOffset:4 inData:data];
   
   //////////////////////////////
   NSData* message = [NSData dataWithBytes:[data bytes]+12 length:[self uintAtOffset:4 inData:data]];
   if(self.instrumentDelegate != nil)
   {
      if ([typeAsString isEqualToString:@"ACPT"])
      {
         self.access = (MercuryAccess)[self uintAtOffset:12 inData:data];
         [self.instrumentDelegate accept:self.access];
         
         for (id<MercuryInstrumentDelegate> delegate in delegates)
         {
            [delegate accept:self.access];
         }
      }
      
      if ([typeAsString isEqualToString:@"STAT"])
      {
         [self.instrumentDelegate stat:message withSubcommand:subcommand];
         
         for (id<MercuryInstrumentDelegate> d in delegates)
         {
            [d stat:message withSubcommand:subcommand];
         }
      }
      
      if([typeAsString isEqualToString:@"ACK "])
      {
         [self.instrumentDelegate ackWithSequenceNumber:[self uintAtOffset:12 inData:data]];
         
         for (id<MercuryInstrumentDelegate> delegate in delegates)
         {
            [delegate ackWithSequenceNumber:[self uintAtOffset:12 inData:data]];
         }
      }
      
      if ([typeAsString isEqualToString:@"NAK "])
      {
         uint sequenceNumer = [self uintAtOffset:12 inData:data];
         uint errorCode = [self uintAtOffset:16 inData:data];
         
         [self.instrumentDelegate nakWithSequenceNumber:sequenceNumer andError:errorCode];

         for (id<MercuryInstrumentDelegate> delegate in delegates)
         {
            [delegate nakWithSequenceNumber:sequenceNumer andError:errorCode];
         }
      }
      
      if([typeAsString isEqualToString:@"RSP "])
      {
         //             |          4            8            12            16
         //     4     8            12           16           20            24
         //SYNC/LENGTH  //RESPONSE | Sequence # | Subcommand | Status Code |<Data>

         uint sequenceNumber  = [self uintAtOffset:12 inData:data];
         uint subcommand      = [self uintAtOffset:16 inData:data];
         uint status          = [self uintAtOffset:20 inData:data];
         
         if( (datalength - 16) > 0)
            message = [NSData dataWithBytes:[data bytes]+24 length:datalength - 16];
         
         [self.instrumentDelegate
          response:message
          withSequenceNumber:sequenceNumber
          subcommand:subcommand
          status:status];
         
         for (id<MercuryInstrumentDelegate> delegate in delegates)
         {
            [delegate           response:message
                      withSequenceNumber:sequenceNumber
                              subcommand:subcommand
                                  status:status];
         }

      }
   }
   //////////////////////////////
   
   [sock readDataToData:[NSData dataWithBytes:"END " length:4] withTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)error
{
	NSLog(@"socketDidDisconnect:%p withError: %@", sock, error);
   
   if(self.instrumentDelegate != nil)
      [self.instrumentDelegate error:error];
}



@end
