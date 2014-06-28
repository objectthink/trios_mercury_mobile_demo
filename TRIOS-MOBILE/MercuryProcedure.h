//
//  MercuryProcedure.h
//  
//
//  Created by stephen eshelman on 6/17/14.
//
//

#import <Foundation/Foundation.h>
#import "MercuryInstrument.h"

@interface MercuryGetProcedureResponse : MercuryResponse
-(instancetype)initWithMessage:(NSData*)message;
-(NSString*)signalToString:(int)signal;
-(int)signalAtIndex:(int)index;
-(int)indexOfSignal:(int)signal;
@end

@interface MercuryGetProcedureCommand : MercuryGet
@end

@interface MercurySetProcedureCommand : MercuryAction
@end

@interface MercurySegment : MercuryInstrumentItem
{
   uint segmentTag;
   int  segmentId;
}
-(NSMutableData*)getBytes;
@end

@interface SegmentIsothermal : MercurySegment
-(instancetype)initWithTime:(float)timeInMinutes;
@end

@interface SegmentEquilibrate : MercurySegment
-(instancetype)initWithTemperature:(float)equilibrateTemperature;
@end

@interface SegmentRamp : MercurySegment
-(instancetype)initWithDegreesPerMinute:(float)degreesPerMinute
                        finalTemerature:(float)finalTemperature;
@end
enum DSCSignalIds
{
   IdInvalid = 0,
   
   IdHeaterADC,
   IdHeaterMV,
   IdHeaterC,
   
   IdFlangeADC,
   IdFlangeMV,
   IdFlangeC,
   
   IdT0UncorrectedADC,
   IdT0UncorrectedMV,
   IdT0C,
   IdT0UncorrectedC,
   
   IdDeltaTADC,
   IdDeltaTMV,
   
   IdDeltaT0ADC,
   IdDeltaT0MV,
   IdDeltaT0UVUnc,
   
   IdRefJunctionADC,
   IdRefJunctionMV,
   IdRefJunctionC,
   
   IdDeltaLidADC,
   IdDeltaLidMV,
   IdDeltaLidUV,
   
   IdDTAmpTempADC,
   IdDTAmpTempMV,
   IdDTAmpTempC,
   
   ///////////////
   IdDeltaT0CUnc,
   IdDeltaT0C,
   IdSampleTC,
   IdDeltaTUV,
   IdDeltaT0UV,
   IdT0CFilt,
   IdSampleTCUnc,
   IdDeltaTUVUnc,
   IdDeltaTCUnc,
   IdDeltaTC,
   IdHeatFlowT4Term1,
   IdHeatFlowT4Term2,
   IdHeatFlowT4Term3,
   IdHeatFlowT4Term4,
   IdHeatFlowT1Unc,
   IdIsCooling,
   IdReferenceTC,
   IdCoefficientRr,
   IdCoefficientRs,
   IdCoefficientCr,
   IdCoefficientCs,
   IdSampleTCRate,
   IdDeltaTCRate,
   IdEinsteinsConstant,
   IdIsHelium,
   IdSamplePanResistance,
   IdReferencePanResistance,
   IdT5TemperatureC,
   IdHeatingRateRatio,
   IdIsRamping,
   IdProgrammedRate,
   IdReferencePanTCRate,
   IdSamplePanTCRate,
   IdHeatFlowT4,
   IdHeatFlowT1,
   IdHeatFlowT4P,
   IdT0CRate,
   IdIsModulating,
   IdHeatFlowT1Filt,
   IdHeatFlowT4Filt,
   IdFilterConstT4PHeatFlow,
   IdHeatFlowT5Unc,
   IdHeatFlowT5,
   IdHeatFlowT4Unc,
   IdSampleHeatFlow,
   IdSampleTCUncalib,
   IdSamplePanTCUncalib,
   IdReferencePanTC,
   IdReferenceHeatFlow,
   IdSamplePanTC,
   IdModulatedTemperatureFilt,
   IdTemperature,
   IdSamplePanTCUnc,
   IdReferenceHeatFlowAverage,
   IdHeatingRateRatioAverage,
   IdHeatFlowT4PUnc,
   IdT5TemperatureRate,
   IdReferenceTCRate,
   IdT5HeatingRateRatio,
   IdSampleTCRateAverage,
   IdDirectHeatCapacityUnc,
   IdDirectHeatCapacity,
   IdHeatFlowT4PFilt,
   IdModulatedTotalHeatFlow,
   IdModulatedT0TotalHeatFlow,
   IdHeatFlow,
   IdWattsPerGram,
   IdModulatedHeatFlowFilt,
   IdModulatedTemperature,
   IdDeltaT0UVFilt,
   IdDeltaT0UncUVFilt,
   IdDeltaT0CUncorrectedFilt,
   IdDeltaT0CFilt,
   IdDeltaTUncUVFilt,
   IdDeltaTUVFilt,
   IdDeltaTCUncFilt,
   IdDeltaTCFilt,
   IdHeatFlowT5Filt,
   IdReferenceHeatFlowRate,
   IdSampleHeatFlowRate,
   IdModulatedPhaseAngle,
   IdModulatedSine,
   IdModulatedCosine,
   IdMDSCNumber,
   IdModulatedAverageSampleHeatFlow,
   IdModulatedAverageReferenceHeatFlow,
   IdModulatedAverageSampleTemperature,
   IdModulatedAverageSamplePanTemperature,
   IdModulatedAverageReferenceTemperature,
   IdModulatedAverageReferencePanTemperature,
   IdModulatedAverageBaselineSubtractedHeatFlowSine,
   IdModulatedBaselineSubtractedHeatFlowSine,
   IdModulatedAverageBaselineSubtractedHeatFlowCosine,
   IdModulatedBaselineSubtractedHeatFlowCosine,
   IdModulatedAverageBaselineSubtractedTemperatureSine,
   IdModulatedBaselineSubtractedTemperatureSine,
   IdModulatedAverageBaselineSubtractedTemperatureCosine,
   IdModulatedBaselineSubtractedTemperatureCosine,
   IdModulatedAverageBaselineSubtractedSampleHeatFlowSine,
   IdModulatedBaselineSubtractedSampleHeatFlowSine,
   IdModulatedAverageBaselineSubtractedSampleHeatFlowCosine,
   IdModulatedBaselineSubtractedSampleHeatFlowCosine,
   IdModulatedAverageBaselineSubtractedReferenceHeatFlowSine,
   IdModulatedBaselineSubtractedReferenceHeatFlowSine,
   IdModulatedAverageBaselineSubtractedReferenceHeatFlowCosine,
   IdModulatedBaselineSubtractedReferenceHeatFlowCosine,
   IdModulatedAverageBaselineSubtractedSampleTemperatureSine,
   IdModulatedAverageBaselineSubtractedSampleTemperatureCosine,
   IdModulatedBaselineSubtractedSampleTemperatureCosine,
   IdModulatedAverageBaselineSubtractedReferenceTemperatureSine,
   IdModulatedBaselineSubtractedReferenceTemperatureSine,
   IdModulatedBaselineSubtractedSampleTemperatureSine,
   IdModulatedAverageBaselineSubtractedReferenceTemperatureCosine,
   IdModulatedBaselineSubtractedReferenceTemperatureCosine,
   IdModulatedAverageBaselineSubtractedSamplePanTemperatureSine,
   IdModulatedBaselineSubtractedSamplePanTemperatureSine,
   IdModulatedAverageBaselineSubtractedSamplePanTemperatureCosine,
   IdModulatedBaselineSubtractedSamplePanTemperatureCosine,
   IdModulatedAverageBaselineSubtractedReferencePanTemperatureSine,
   IdModulatedBaselineSubtractedReferencePanTemperatureSine,
   IdModulatedAverageBaselineSubtractedReferencePanTemperatureCosine,
   IdModulatedBaselineSubtractedReferencePanTemperatureCosine,
   IdModulatedHeatFlowAmplitudeFilt,
   IdModulatedHeatFlowAmplitude,
   IdModulatedHeatFlowPhaseFilt,
   IdModulatedHeatFlowPhase,
   IdModulatedSampleHeatFlowFilt,
   IdModulatedSampleHeatFlowAmplitude,
   IdModulatedSampleHeatFlowPhaseFilt,
   IdModulatedSampleHeatFlowPhase,
   IdModulatedSampleHeatFlowSineAmplitudeFilt,
   IdModulatedSampleHeatFlowSineAmplitude,
   IdModulatedSampleHeatFlowCosineAmplitudeFilt,
   IdModulatedSampleHeatFlowCosineAmplitude,
   IdModulatedReferenceHeatFlowFilt,
   IdModulatedReferenceHeatFlowAmplitudeFilt,
   IdModulatedReferenceHeatFlowAmplitude,
   IdModulatedReferenceHeatFlowPhaseFilt,
   IdModulatedReferenceHeatFlowPhase,
   IdModulatedReferenceHeatFlowSineAmplitudeFilt,
   IdModulatedReferenceHeatFlowSineAmplitude,
   IdModulatedReferenceHeatFlowCosineAmplitudeFilt,
   IdModulatedReferenceHeatFlowCosineAmplitude,
   IdModulatedSamplePanTemperatureFilt,
   IdModulatedSamplePanTemperatureAmplitudeFilt,
   IdModulatedSamplePanTemperatureAmplitude,
   IdModulatedReferencePanTemperatureFilt,
   IdModulatedReferencePanTemperatureAmplitude,
   IdModulatedTemperatureAmplitudeFilt,
   IdModulatedTemperatureAmplitude,
   IdModulatedSampleTemperatureCosineAmplitudeFilt,
   IdModulatedSampleTemperatureCosineAmplitude,
   IdModulatedSampleTemperatureSineAmplitudeFilt,
   IdModulatedSampleTemperatureSineAmplitude,
   IdModulatedReferenceTemperatureCosineAmplitudeFilt,
   IdModulatedReferenceTemperatureCosineAmplitude,
   IdModulatedReferenceTemperatureSineAmplitudeFilt,
   IdModulatedReferenceTemperatureSineAmplitude,
   IdModulatedAverageHeatFlow,
   IdModulatedAverageTemperature,
   IdModulatedSampleHeatFlowAmplitudeFilt,
   IdModulatedReferencePanTemperatureAmplitudeFilt,
   IdModulatedBaselineSubtractedHeatFlow,
   IdModulatedBaselineSubtractedTemperature,
   IdModulatedBaselineSubtractedSampleHeatFlow,
   IdModulatedBaselineSubtractedSampleTemperature,
   IdModulatedBaselineSubtractedReferenceTemperature,
   IdModulatedBaselineSubtractedSamplePanTemperature,
   IdModulatedBaselineSubtractedReferencePanTemperature,
   IdModulatedBaselineSubtractedReferenceHeatFlow,
   IdModulatedTemperaturePhase,
   IdModulatedSamplePanTemperaturePhase,
   IdModulatedReferencePanTemperaturePhase,
   IdModulatedHeatFlowPhaseShift,
   IdModulatedSampleHeatFlowPhaseShift,
   IdModulatedReferenceHeatFlowPhaseShift,
   IdModulatedUnderlyingHeatingRate,
   IdModulatedUnderlyingSampleRate,
   IdModulatedUnderlyingReferenceRate,
   IdModulatedHeatCapacityReversing,
   IdModulatedReversingHeatFlow,
   IdModulatedHeatCapacity,
   IdModulatedHeatCapacityNonReversing,
   IdModulatedHeatFlowNonReversing,
   IdModulatedSampleApparentHeatCapacity,
   IdModulatedReferenceApparentHeatCapacity,
   IdModulatedT0HeatCapacityReversingUnc,
   IdModulatedT0ReversingHeatCapacity,
   IdModulatedT0ReversingHeatFlow,
   IdModulatedT0HeatCapacity,
   IdModulatedT0HeatCapacityNonReversing,
   IdModulatedT0SampleHeatCapacity,
   IdModulatedT0ReferenceHeatCapacity,
   IdModulatedT0HeatFlowNonReversing,
   IdPCASampleIntensity,
   IdPCAReferenceIntensity,
   IdPCAIsShutterOpen,
   
   //////////////////// Gdm Raw Signals
   IdSampleGasFlowRate,
   IdBasePurgeFlowRate,
   
   IdCommonTime,
   IdPowerRequestedByFEP,
   IdSetPointTemperature,
   
   IdPowerDelivered,
   
   IdLastDSCSignal
};

