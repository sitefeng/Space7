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
    
    CCLayer *gameSceneLayer = [CCLayer node];
    //CCLayer *gameSceneControlsLayer = [CCLayer node];
    //CCLayer *gameSceneBackgroundLayer = [CCLayer node];

    CCSprite *background = [CCSprite spriteWithFile:@"ship4.png"];
    background.position = ccp(500,500);
    [background setScale:5];
    
    [gameSceneLayer addChild:background z:3];
    
    
    
    
    //[scene addChild: gameSceneControlsLayer z:2];
    [scene addChild: gameSceneLayer z:1];
    //[scene addChild: gameSceneBackgroundLayer z:0];
    
    
    
    
    return scene;
    
}


- (id) init
{
    
	if( self=[super init] ) {
        
        self.touchEnabled =NO;
        
        
        CCSprite *sprite = [CCSprite spriteWithFile:@"ship4.png"];
        sprite.position = ccp(300,300);
        sprite.anchorPoint = ccp(0.5f, 0.5f);
        [sprite setScale: 4];
        
        
        [self addChild:sprite];

        
        
        
    }
    
    
    return self;
    
}


-(void) dealloc
{
    
    
    
    [super dealloc];
}

@end
