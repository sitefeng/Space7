//
//  SelectShipBackgroundLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-19.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "SelectShipBackgroundLayer.h"
#import "AnimatedCloudBackground.h"

#include "ApplicationConstants.c"

@implementation SelectShipBackgroundLayer



- (id) init
{
    if(self = [super init])
    {
        
        AnimatedCloudBackground* animatedBackground = [AnimatedCloudBackground node];
        
        [self addChild: animatedBackground z:1];
        
        
 
    }
    
    return self;
    
}







@end
