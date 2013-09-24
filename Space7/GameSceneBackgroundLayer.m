//
//  GameSceneBackgroundLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "GameSceneBackgroundLayer.h"


@implementation GameSceneBackgroundLayer



+(CCScene*) scene
{
    
    CCScene *scene = [[CCScene alloc] init];
    
    GameSceneBackgroundLayer *layer = [GameSceneBackgroundLayer node];
    
    [scene addChild: layer];
    
    return scene;
    
}


- (id) init
{
    
	if( self=[super init] ) {
        
        self.touchEnabled = NO;
        
        
        
        
        
        
        
    }
    
    
    return self;
    
}







-(void) dealloc
{
    
    
    
    [super dealloc];
}

@end
