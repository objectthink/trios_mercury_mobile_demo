//
//  ProcedureDetailViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/21/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "ProcedureDetailViewController.h"
#import "MercuryFile.h"
#import <ShinobiCharts/ShinobiChart.h>

@interface ProcedureDetailViewController () <SChartDatasource, MercuryDataFileVisualizer>
@end

@implementation ProcedureDetailViewController
{
   ShinobiChart* _chart;
   float _data;
   float _time;
}

-(void)pointData:(float)data time:(float)time
{
   _data = data;
   _time = time;
   
   [_chart appendNumberOfDataPoints:1 toEndOfSeriesAtIndex:0];
   [_chart redrawChart];
}

- (int)numberOfSeriesInSChart:(ShinobiChart *)chart
{
   return 1;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index {
   
   SChartLineSeries *lineSeries = [[SChartLineSeries alloc] init];
   
   lineSeries.title = [NSString stringWithFormat:@"<SIGNAL DATA>"];
   
   return lineSeries;
}

- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex
{
   return 0;
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex {
   
   SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
   
   datapoint.xValue = [NSNumber numberWithDouble:_time];
   datapoint.yValue = [NSNumber numberWithDouble:_data];

   return datapoint;
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
   
   //////////CHART STUFF
   self.view.backgroundColor = [UIColor whiteColor];
   
   CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 10.0 : 50.0;
   
   _chart = [[ShinobiChart alloc] initWithFrame:CGRectInset(self.view.bounds, margin, margin + 35)];
   _chart.title = @"Live Test Data";
   
   _chart.licenseKey = @"rS3mkUUne/mi95GMjAxNDA3MjFzdGVwaGVuLm4uZXNoZWxtYW5Ab2JqZWN0dGhpbmsuY29tdr8nNk8qpbHgex6AE6+LVRAaE9fuGbXpuupSWpWHaqsO6pDxG9OpRdLD7JN7N7pDaWGQOAxg+e2R1NldUy2vIIApMrMR+lyeAnENN8Erk7lKYmd0UmcKDw1nDxZ7AogcifWcwLUyGuik5ffgkV17wFqTsGHo=BQxSUisl3BaWf/7myRmmlIjRnMU2cA7q+/03ZX9wdj30RzapYANf51ee3Pi8m2rVW6aD7t6Hi4Qy5vv9xpaQYXF5T7XzsafhzS3hbBokp36BoJZg8IrceBj742nQajYyV7trx5GIw9jy/V6r0bvctKYwTim7Kzq+YPWGMtqtQoU=PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+"; // TODO: add your trial licence key here!
   
   _chart.autoresizingMask = ~UIViewAutoresizingNone;
   
   // add a pair of axes
   SChartNumberAxis *xAxis = [[SChartNumberAxis alloc] init];
   xAxis.title = @"Time";
   _chart.xAxis = xAxis;
   
   SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] init];
   yAxis.title = @"<SIGNAL NAME>";
   _chart.yAxis = yAxis;
   
   // enable gestures
   yAxis.enableGesturePanning = YES;
   yAxis.enableGestureZooming = YES;
   xAxis.enableGesturePanning = YES;
   xAxis.enableGestureZooming = YES;
   
   //_chart.legend.hidden = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
   
   // Add the chart to the view controller
   [self.view addSubview:_chart];
   
   _chart.datasource = self;

   /////////////////////
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
