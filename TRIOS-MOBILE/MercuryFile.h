//
//  MercuryFile.h
//  
//
//  Created by stephen eshelman on 6/13/14.
//
//

#import <Foundation/Foundation.h>
#import "MercuryInstrument.h"

enum MercuryKnownFileType
{
   ProcedureData,
   ProcedurePreamble,
   ProcedureEpilogue
};

@protocol IMercuryRecord
@property (strong, nonatomic) NSString* tag;
@property (nonatomic) int length;
@property (strong, nonatomic) NSData* data;
@end

@protocol IMercuryFile

@property (strong, nonatomic) NSData* data;
@property (copy, nonatomic) NSString* filename;

- (id <IMercuryRecord>) getMercuryRecordAtOffset:(int)index;

@end

@protocol IMercuryFileReader

-(void)finished:(id <IMercuryFile>)file;
-(void)updated:(id <IMercuryFile>)file;

@end

@interface MercuryReadFileCommand : MercuryGet

-(id)initWithFilename:(NSString*)filename
               offset:(int)offset
           moveMethod:(int)moveMethod
  dataLengthRequested:(uint)dataLengthRequested;

@end

@interface MercuryRecord : NSObject <IMercuryRecord>
@property (strong, nonatomic) NSString* tag;
@property (nonatomic) int length;
@property (strong, nonatomic) NSData* data;
@end

@interface MercuryDataRecord : MercuryRecord
@end

@interface MercuryGetRecord : MercuryRecord
@end

@interface MercurySgmtRecord : MercuryRecord
@end

@interface MercuryFile : NSObject <IMercuryFile>

@property (strong, nonatomic) NSData* data;
@property (copy, nonatomic) NSString* filename;

-(id)initWithInstrument:(MercuryInstrument*)instrument andFilename:(NSString*)filename;

@end

@interface MercuryDataFileReader : NSObject <MercuryInstrumentDelegate>

-(id)initWithInstrument:(MercuryInstrument*)instrument file:(id<IMercuryFile>)file readSize:(uint)readSize;
-(void)start;

@end

