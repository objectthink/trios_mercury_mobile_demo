//
//  MercuryFile.m
//  
//
//  Created by stephen eshelman on 6/13/14.
//
//

#import "MercuryFile.h"

@implementation MercuryReadFileCommand
{
   NSString*   _filename;
   int         _offset;
   uint        _moveMethod;
   uint        _dataLengthRequested;
}

-(id)initWithFilename:(NSString *)filename
               offset:(int)offset
           moveMethod:(int)moveMethod
  dataLengthRequested:(uint)dataLengthRequested
{
   if(self = [super init])
   {
      subCommandId = 0x00000007;
      
      _filename = [NSString stringWithString:filename];
      _offset = offset;
      _moveMethod = moveMethod;
      _dataLengthRequested = dataLengthRequested;
   }
   return self;
}

-(NSMutableData*)getBytes
{
   //wchar_t wzero = L'\0';
   char zero = '\0';
   
   [self.bytes setLength:0];
   
   NSData* uFilename = [_filename dataUsingEncoding:NSUnicodeStringEncoding];
   NSMutableData* muFilename = [uFilename mutableCopy];
   [muFilename appendBytes:&zero length:sizeof(wchar_t)];
   
   //uint filenameLength = [muFilename length];
   uint length = 28;
   
   [self.bytes appendBytes:&subCommandId length:4];
   
   //[self.bytes appendBytes:&filenameLength length:4];
   //[self.bytes appendData:muFilename];
   
   NSMutableData* tempFilename =
   [[NSMutableData alloc]init];
   
   char p = 'P';
   char r = 'r';
   char o = 'o';
   char c = 'c';
   char e = 'e';
   char d = 'd';
   char u = 'u';
   char dot = '.';
   char a = 'a';
   char t = 't';

   [self.bytes appendBytes:&length length:4];

   [tempFilename appendBytes:&p length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&r length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&o length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&c length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&e length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&d length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&u length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&r length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&e length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&dot length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&d length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&a length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&t length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&zero length:1];
   [tempFilename appendBytes:&zero length:1];
   
   [self.bytes appendData:tempFilename];

   [self.bytes appendBytes:&_offset length:4];
   [self.bytes appendBytes:&_moveMethod length:4];
   [self.bytes appendBytes:&_dataLengthRequested length:4];
   
   return self.bytes;
}

@end

@implementation MercuryReadFileResponse
-(instancetype)initWithMessage:(NSData *)message
{
   if(self = [super initWithMessage:message])
   {
      self.length = [self uintAtOffset:0 inData:message];
      self.data = [NSData dataWithBytes:[message bytes]+4 length:[message length]-4];
   }
   return self;
}
@end

@implementation MercuryFile
{
   MercuryInstrument* _mercuryInstrument;
}

-(id)initWithInstrument:(MercuryInstrument *)instrument andFilename:(NSString *)filename
{
   self = [super init];
   
   if(!self) return nil;
   
   _mercuryInstrument = instrument;
   
   self.filename = filename;
   self.data = [[NSMutableData alloc] init];
   
   return self;
}

-(id<IMercuryRecord>)getMercuryRecordAtOffset:(int)index
{
   //int dataLength = 0;
   //int recordLength = 0;
   //NSString* tag = @"";
   
   return nil;
}
@end

@implementation MercuryDataFileReader
{
   MercuryInstrument* _instrument;
   id <IMercuryFile> _file;
   uint _readSize;
   int _offset;
   uint _sequenceNumber;
   
   MercuryDataFileStatus* _fileStatus;
}

#pragma mark -
-(id)initWithInstrument:(MercuryInstrument *)instrument file:(id)file readSize:(uint)readSize
{
   if(self = [super init])
   {
      _instrument = instrument;
      _file = file;
      _readSize = readSize;
      _offset = 0;
   }
   return self;
}

-(void)start
{
   [_instrument addDelegate:self];
}

#pragma mark MercuryInstrumentDelegate
-(void)connected
{
}

-(void)accept:(MercuryAccess)access
{
}

-(void)stat:(NSData*)message withSubcommand:(uint)subcommand
{
   if(subcommand==ProcedureStatus)
   {
   }

   if(subcommand==DataFileStatus)
   {
      MercuryReadFileCommand* command =
      [[MercuryReadFileCommand alloc]
       initWithFilename:_file.filename
       offset:_offset
       moveMethod:0
       dataLengthRequested:_readSize];
      
      _fileStatus =
      [[MercuryDataFileStatus alloc]initWithMessage:message];
      
      switch (_fileStatus.state) {
         case Open:
            _sequenceNumber = [_instrument sendCommand:command];
            break;
         case Closed:
            _sequenceNumber = [_instrument sendCommand:command];
            break;
         default:
            break;
      }
      
   }
}

-(void)     response:(NSData *)message
  withSequenceNumber:(uint)sequenceNumber
          subcommand:(uint)subcommand
              status:(uint)status
{
   if(subcommand == MercuryReadFileCommandId && _sequenceNumber == sequenceNumber)
   {
      MercuryReadFileResponse* response =
      [[MercuryReadFileResponse alloc]initWithMessage:message];
      
      [_file.data appendData:response.data];
      
      _offset += response.length;
      
      [self.delegate updated:_file];
      
      if(_fileStatus.state == Open) return;
      
      if(_fileStatus.state == Closed && [_file.data length] < _fileStatus.length)
      {
         MercuryReadFileCommand* command =
         [[MercuryReadFileCommand alloc]
          initWithFilename:_file.filename
          offset:_offset
          moveMethod:0
          dataLengthRequested:_readSize];

         _sequenceNumber = [_instrument sendCommand:command];
      }
      else
      {
         [self.delegate finished:_file];
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

@end
