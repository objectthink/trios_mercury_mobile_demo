//
//  MercuryProcedure.m
//  
//
//  Created by stephen eshelman on 6/17/14.
//
//

#import "MercuryProcedure.h"


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
   int signalCount = self.bytes.length  / 4;
   
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
@end
