//
//  GameSceneBackgroundLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "GameSceneBackgroundLayer.h"
#import "AnimatedCloudBackground.h"
#import "AnimatedCloudCover.h"

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
        
        //AnimatedCloudCover* cloudCover = [AnimatedCloudCover node];
        AnimatedCloudBackground* animatedBackground = [AnimatedCloudBackground node];
        
        
        //[self addChild:cloudCover z:2];
        [self addChild: animatedBackground z:-1];
        
        
        CCSprite *background = [CCSprite spriteWithFile:@"cloudy1.png"];
        background.anchorPoint = ccp(0,0);
        
        [self addChild:background z:-2];
        
    }
    
    
    return self;
    
}







-(void) dealloc
{
    
    
    
    [super dealloc];
}

@end
