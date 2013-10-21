//
//  EntryLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-20.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "EntryLayer.h"
#import "MenuSceneLayer.h"
#include "ApplicationConstants.c"

@implementation EntryLayer

+(CCScene *) scene
{
    
	EntryLayer *layer = [EntryLayer node];
	
    CCScene *scene = [CCScene node];
    
    CCSprite *background;
    
    if(IS_IPHONE_5)
    {
        background = [CCSprite spriteWithFile:@"LaunchImage-568h@2x.png"];
    }
    else if(IS_IPHONE_4)
    {
        background = [CCSprite spriteWithFile:@"LaunchImage@2x.png"];
    }
    
    [background setRotation:90];
    background.anchorPoint = ccp(0.5,0.5);
    [background setPosition:ccp(kWinSize.width/2.0, kWinSize.height/2.0)];
    
    [layer addChild:background z:-1];
    
    [scene addChild: layer];
    
    //Play the background music
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"homePage.mp3" loop:YES];

    
	// return the scene
	return scene;
}



-(id) init
{
    
    if(self=[super init])
    {
        [self scheduleOnce:@selector(replaceScene) delay:2.7];
   
    }
    
    return self;
}

- (void) replaceScene
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.6 scene:[MenuSceneLayer scene] ]];
    
}












@end
