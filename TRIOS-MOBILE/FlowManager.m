//
//  FlowManager.m
//  MultiFlowDemo
//
//  Created by Thomas Kelly on 20/02/2013.
//  Copyright (c) 2013 Scott Logic. All rights reserved.
//

#import "FlowManager.h"

@interface FlowManager () {
   NSMutableArray *flowLayouts;
   UIView *viewInProgress;
}
@end

@implementation FlowManager

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self)
   {
      flowLayouts = [NSMutableArray new];
      for (int i = 0; i < 3; i++)
      {
         CGSize flowSize = CGSizeMake(frame.size.width/3, frame.size.height);
         CGRect flowFrame = CGRectMake(i*flowSize.width, 100, flowSize.width, flowSize.height);
         [self createFlowWithFrame:flowFrame];
      }
   }
   return self;
}

-(void)createFlowWithFrame:(CGRect)frame
{
   SEssentialsFlowLayout *flow = [[SEssentialsFlowLayout alloc] initWithFrame:frame];
   flow.flowDelegate = self;
   flow.dragsOutsideBounds = YES;
   flow.clipsToBounds = NO;
   [flowLayouts addObject:flow];
   [self addSubview:flow];
}

-(void)addSubview:(UIView*)subview toFlowAtIndex:(int)index
{
   SEssentialsFlowLayout *flow = [flowLayouts objectAtIndex:index];
   [flow addManagedSubview:subview];
}

#pragma mark - Flow Delegate Methods

- (void)didBeginEditInFlowLayout:(SEssentialsFlowLayout *)flow
{
   for (SEssentialsFlowLayout *otherFlow in flowLayouts)
   {
      if (flow != otherFlow)
      {
         [otherFlow beginEditMode];
      }
   }
   
   [self bringSubviewToFront:flow];
}

- (void)didEndEditInFlowLayout:(SEssentialsFlowLayout *)flow
{
   for (SEssentialsFlowLayout *otherFlow in flowLayouts)
   {
      if (flow != otherFlow)
      {
         [otherFlow endEditMode];
      }
   }
}

-(void)flowLayout:(SEssentialsFlowLayout *)sourceFlow didDragView:(UIView *)view
{
   CGPoint dragPosition = [sourceFlow convertPoint:view.center toView:self];
   for (SEssentialsFlowLayout *destinationFlow in flowLayouts)
   {
      if (destinationFlow != sourceFlow)
      {
         if(CGRectContainsPoint(destinationFlow.frame, dragPosition))
         {
            //Convert the center to the new frame of reference
            view.center = [self convertPoint:dragPosition toView:destinationFlow];
            
            //Swap owners
            [destinationFlow addManagedSubview:view];
            [sourceFlow unmanageSubview:view];
         }
      }
   }
}


-(BOOL)flowLayout:(SEssentialsFlowLayout *)flow shouldMoveView:(UIView *)view
{
   if (!viewInProgress)
      viewInProgress = view;
   
   return view == viewInProgress;
}

-(void)flowLayout:(SEssentialsFlowLayout *)flow didMoveView:(UIView *)view
{
   viewInProgress = nil;
}

-(void)flowLayout:(SEssentialsFlowLayout *)flow didNotMoveView:(UIView *)view
{
   viewInProgress = nil;
}
@end