//
//  GameSceneLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "GameSceneLayer.h"
#import "GameSceneControlsLayer.h"
#import "GameSceneBackgroundLayer.h"



@implementation GameSceneLayer


+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    GameSceneLayer *gameSceneLayer = [GameSceneLayer node];
    GameSceneControlsLayer *gameSceneControlsLayer = [GameSceneControlsLayer node];
    GameSceneBackgroundLayer *gameSceneBackgroundLayer = [GameSceneBackgroundLayer node];
    
    
    [scene addChild: gameSceneControlsLayer z:2];
    [scene addChild: gameSceneLayer z:1];
    [scene addChild: gameSceneBackgroundLayer z:0];
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"level1.mp3" loop:YES ];
    
    
    return scene;
    
}


- (id) init
{
    
	if( self=[super init] ) {
        
        self.touchEnabled =NO;
        
        
        CCSprite *sprite = [CCSprite spriteWithFile:@"ship4.png"];
        sprite.position = ccp(200,200);
        
        
        
        
        [self addChild:sprite];

        
        
        
    }
    
    
    return self;
    
}


-(void) dealloc
{
    
    
    
    [super dealloc];
}

@end
