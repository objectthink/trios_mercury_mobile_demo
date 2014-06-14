//
//  MercuryInstrument.h
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/4/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
typedef enum MercuryAccessType
{
   Viewer = 1,
   Master = 2
} MercuryAccess;

@interface MercuryInstrumentItem : NSObject
{
}
-(float)floatAtOffset:(NSUInteger)offset inData:(NSData*)data;
-(uint)uintAtOffset:(NSUInteger)offset inData:(NSData*)data;
@end

@interface MercuryCommand : MercuryInstrumentItem
{
   uint subCommandId;
}

@property (strong, nonatomic) NSMutableData* bytes;

-(id)init;
-(NSMutableData*)getBytes;
@end

@interface MercuryStatus : MercuryInstrumentItem
{
   uint subCommandId;
}

@property (strong, nonatomic) NSMutableData* bytes;

-(id)initWithMessage:(NSMutableData*)message;
-(NSMutableData*)getBytes;
@end


@interface MercuryAction : MercuryCommand
@end

@interface MercuryGet : MercuryCommand
@end

@interface MercuryResponse : NSObject
{
}

@property (strong, nonatomic) NSMutableData* bytes;
@end

@interface MercurySetRealTimeSignalsCommand : MercuryAction
-(id)init;
-(void)addSignal:(int)signal;
@end

@interface MercuryGetRealTimeSignalsCommand : MercuryGet
-(id)init;
@end

@interface MercuryGetRealTimeSignalsResponse : MercuryResponse
-(id)init;
@end


@protocol MercuryInstrumentDelegate <NSObject>
-(void)connected;
-(void)accept:(MercuryAccess)access;
-(void)stat:(NSData*)message withSubcommand:(uint)subcommand;

-(void)response:(NSData*)message withSequenceNumber:(uint)sequenceNumber subcommand:(uint)subcommand status:(uint)status;

-(void)ackWithSequenceNumber:(uint)sequencenumber;
-(void)nakWithSequenceNumber:(uint)sequencenumber andError:(uint)errorcode;

@optional
-(void)error:(NSError*)error;
@end

@interface MercuryInstrument : NSObject <GCDAsyncSocketDelegate>
{
   GCDAsyncSocket* socket;
}

@property (weak, nonatomic) NSObject<MercuryInstrumentDelegate> *instrumentDelegate;
@property (nonatomic) MercuryAccess access;
@property (strong, nonatomic)NSString* host;

-(BOOL)connectToHost:(NSString*)host andPort:(uint16_t)port;
-(void)disconnect;

-(uint)sendCommand:(MercuryCommand*)command;

-(BOOL)
   loginWithUsername:(NSString*)username
   machineName:(NSString*)machineName
   ipAddress:(NSString*)ipAddress
   access:(uint)access;

-(float)floatAtOffset:(NSUInteger)offset inData:(NSData*)data;
-(uint)uintAtOffset:(NSUInteger)offset inData:(NSData*)data;

-(void)addDelegate:(id<MercuryInstrumentDelegate>) delegate;

@end
