//
//  FlowManager.h
//  MultiFlowDemo
//
//  Created by Thomas Kelly on 20/02/2013.
//  Copyright (c) 2013 Scott Logic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShinobiEssentials/SEssentialsFlowLayout.h>

@interface FlowManager : UIView <SEssentialsFlowLayoutDelegate>
-(void)addSubview:(UIView*)subview toFlowAtIndex:(int)index;
@end
