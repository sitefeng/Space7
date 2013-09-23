//
//  GameSceneControlsLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "GameSceneControlsLayer.h"
#import "MenuSceneLayer.h"

@implementation GameSceneControlsLayer



+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    CCLayer *gameSceneLayer = [CCLayer node];
    
    
    [scene addChild: gameSceneLayer];
    
    return scene;
    
}


- (id) init
{
    
	if( self=[super init] ) {
        
        self.touchEnabled =YES;
        
        //Getting the window size
        CGSize windowSize = [[CCDirector sharedDirector] winSize];
        

        
        
        
        
        
    }
    
    
    return self;
    
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];

    
}


-(void) dealloc
{
    
    
    
    [super dealloc];
}


@end
