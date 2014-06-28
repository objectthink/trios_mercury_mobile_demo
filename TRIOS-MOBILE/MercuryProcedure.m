//
//  MercuryProcedure.m
//  
//
//  Created by stephen eshelman on 6/17/14.
//
//

#import "MercuryInstrument.h"
#import "MercuryProcedure.h"

static int uniqueTagStatic = 0;
@implementation MercurySegment
{
}

-(instancetype)init
{
   if(self = [super init])
   {
      segmentTag  = 0x544D4753;  //SGMT
   }
   return self;
}

-(NSMutableData*)getBytes
{
   uniqueTagStatic++;
   
   [self.bytes setLength:0];
   
   [self.bytes appendBytes:&segmentTag length:4];
   [self.bytes appendBytes:&segmentId length:4];
   [self.bytes appendBytes:&uniqueTagStatic length:4];
   
   return self.bytes;
}
@end

@implementation SegmentIsothermal
{
   float _timeInMinutes;
}

-(instancetype)initWithTime:(float)timeInMinutes
{
   if(self = [super init])
   {
      segmentId  = 0x01030000;
      _timeInMinutes = timeInMinutes;
   }
   
   return self;
}

-(NSMutableData*)getBytes
{
   [super getBytes];
   
   [self.bytes appendBytes:&_timeInMinutes length:4];
   
   return self.bytes;
}
@end

@implementation SegmentEquilibrate
{
   float _equilibrateTemperature;
}

-(instancetype)initWithTemperature:(float)equilibrateTemperature
{
   if(self = [super init])
   {
      segmentId  = 0x01030001;
      _equilibrateTemperature = equilibrateTemperature;
   }
   
   return self;
}

-(NSMutableData*)getBytes
{
   [super getBytes];
   
   [self.bytes appendBytes:&_equilibrateTemperature length:4];
   
   return self.bytes;
}
@end

@implementation SegmentRamp
{
   float _degreesPerMinute;
   float _finalTemperature;
}

-(instancetype)initWithDegreesPerMinute:(float)degreesPerMinute
                        finalTemerature:(float)finalTemperature
{
   if(self = [super init])
   {
      segmentId  = 0x01030002;
      _degreesPerMinute = degreesPerMinute;
      _finalTemperature = finalTemperature;
   }
   
   return self;
}

-(NSMutableData*)getBytes
{
   [super getBytes];
   
   [self.bytes appendBytes:&_degreesPerMinute length:4];
   [self.bytes appendBytes:&_finalTemperature length:4];
   
   return self.bytes;
}
@end

@implementation MercuryGetProcedureResponse
{
   NSDictionary* _signalToString;
}

-(NSString*)signalToString:(int)signal
{
   NSString* value = [_signalToString objectForKey:[NSNumber numberWithInt:signal]];
   
   if(value != nil)
   {
      return value;
   }
   else
   {
      return @"UNKNOWN";
   }
}

-(int)signalAtIndex:(int)index
{
   int signal;
   [self.bytes getBytes:&signal range:NSMakeRange(index * 4, 4)];
   
   return signal;
}

-(int)indexOfSignal:(int)signal
{
   int index = -1;
   int signalCount = (int)self.bytes.length  / 4;
   
   for (int i=0; i < signalCount; i++)
   {
      if (signal == [self signalAtIndex:i])
      {
         index = i;
         break;
      }
   }
   
   return index;
}

-(instancetype)initWithMessage:(NSData *)message
{
   if(self = [super initWithMessage:message])
   {
      uint subcommand = [self uintAtOffset:0 inData:message];
      uint lengthOfSetupSection = [self uintAtOffset:4 inData:message];
      uint lengthOfSignalSection= [self uintAtOffset:lengthOfSetupSection + 8 inData:message];
      
      int signalSectionIndex = lengthOfSetupSection+8+4;
      
      self.bytes =
      [NSMutableData dataWithBytes:message.bytes+signalSectionIndex length:lengthOfSignalSection];
      
      int signal;
      [self.bytes getBytes:&signal range:NSMakeRange(0, 4)];

      NSLog(@"%d %d %d %d",
            subcommand,
            lengthOfSetupSection,
            lengthOfSignalSection,
            signal);
      
      _signalToString =
      @{
        [NSNumber numberWithInt:IdHeaterADC] : @"IdHeaterADC",
        [NSNumber numberWithInt:IdHeaterMV] : @"IdHeaterMV",
        [NSNumber numberWithInt:IdHeaterC] : @"IdHeaterC",
        [NSNumber numberWithInt:IdFlangeADC] : @"IdFlangeADC",
        [NSNumber numberWithInt:IdFlangeMV] : @"IdFlangeMV",
        [NSNumber numberWithInt:IdFlangeC] : @"IdFlangeC",
        [NSNumber numberWithInt:IdT0UncorrectedADC] : @"IdT0UncorrectedADC",
        [NSNumber numberWithInt:IdT0UncorrectedMV] : @"IdT0UncorrectedMV",
        [NSNumber numberWithInt:IdT0C] : @"IdT0C",
        [NSNumber numberWithInt:IdT0UncorrectedC] : @"IdT0UncorrectedC",
        [NSNumber numberWithInt:IdRefJunctionADC] : @"IdRefJunctionADC",
        [NSNumber numberWithInt:IdDeltaT0ADC] : @"IdDeltaT0ADC",
        [NSNumber numberWithInt:IdDeltaT0MV] : @"IdDeltaT0MV",
        [NSNumber numberWithInt:IdDeltaT0UVUnc] : @"IdDeltaT0UVUnc",
        [NSNumber numberWithInt:IdRefJunctionMV] : @"IdRefJunctionMV",
        [NSNumber numberWithInt:IdRefJunctionC] : @"IdRefJunctionC",
        [NSNumber numberWithInt:IdDeltaLidADC] : @"IdDeltaLidADC",
        [NSNumber numberWithInt:IdDeltaLidMV] : @"IdDeltaLidMV",
        [NSNumber numberWithInt:IdDeltaLidUV] : @"IdDeltaLidUV",
        [NSNumber numberWithInt:IdDTAmpTempADC] : @"IdDTAmpTempADC",
        [NSNumber numberWithInt:IdDTAmpTempMV] : @"IdDTAmpTempMV",
        [NSNumber numberWithInt:IdDTAmpTempC] : @"IdDTAmpTempC",
        [NSNumber numberWithInt:IdDeltaT0CUnc] : @"IdDeltaT0CUnc",
        [NSNumber numberWithInt:IdDeltaT0C] : @"IdDeltaT0C",
        [NSNumber numberWithInt:IdSampleTC] : @"IdSampleTC",
        
        [NSNumber numberWithInt:IdCommonTime] : @"IdCommonTime",
        [NSNumber numberWithInt:IdHeatFlow]:@"IdHeatFlow"
        };
   }
   return self;
}
@end

@implementation MercuryGetProcedureCommand
@end

@implementation MercurySetProcedureCommand
-(id)init
{
   if(self = [super init])
   {
      subCommandId = MercurySetProcedureCommandId;
   }
   return self;
}

-(NSMutableData*)getBytes
{
   [super getBytes];
   
   char zero = 0;
   
   uint setupSectionLength = 68;
   [self.bytes appendBytes:&setupSectionLength length:4];

   CFUUIDRef guid = CFUUIDCreate(NULL);
   CFUUIDBytes guidBytes = CFUUIDGetUUIDBytes(guid);
   
   [self.bytes appendBytes:&guidBytes length:16];
   
   for (int i = 0; i < 68 - 16; i++)
      [self.bytes appendBytes:&zero length:1];
   
   uint signalSectionLength = 8;
   [self.bytes appendBytes:&signalSectionLength length:4];
   
   uint aSignal = 9;
   [self.bytes appendBytes:&aSignal length:4];
   
   aSignal = IdCommonTime;
   [self.bytes appendBytes:&aSignal length:4];

   uint segmentSectionLength = 52;
   [self.bytes appendBytes:&segmentSectionLength length:4];

   MercurySegment* segment =
   [[SegmentEquilibrate alloc] initWithTemperature:40.0];

   [self.bytes appendData:[segment getBytes]];

   segment =
   [[SegmentIsothermal alloc] initWithTime:2.0];
   
   [self.bytes appendData:[segment getBytes]];

   segment =
   [[SegmentRamp alloc] initWithDegreesPerMinute:20 finalTemerature:50];
   
   [self.bytes appendData:[segment getBytes]];

   return self.bytes;
}
@end

