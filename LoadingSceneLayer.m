//
//  LoadingSceneLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-20.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "LoadingSceneLayer.h"
#import "SelectShipLayer.h"
#import "GameSceneLayer.h"

#define kWinSize [[CCDirector sharedDirector] winSize]

#define IS_IPHONE_5 (kWinSize.width == 568)
#define IS_IPHONE_4 (kWinSize.width == 480)

@implementation LoadingSceneLayer
{
    
    
}


+ (CCScene*)sceneWithReplaceSceneName: (NSString*)sceneName
{
    CCScene *scene = [CCScene node];
    
    LoadingSceneLayer* loadinglayer = [LoadingSceneLayer node];
    
    CCSprite* background = [CCSprite spriteWithFile:@"Background-568h@2x.png"];
    
    if(IS_IPHONE_4)
    {
        background = [CCSprite spriteWithFile:@"Background@2x.png"];
    }

    background.anchorPoint = ccp(0,0);
    [loadinglayer addChild:background z:-1];
    
    loadinglayer.replaceSceneName = sceneName;
    
    [scene addChild: loadinglayer];
    
    return scene;
}



-(id) init
{
    
    if(self = [super init])
    {
        
        CCLabelTTF* loadingLabel = [CCLabelTTF labelWithString:@"LOADING..." fontName:@"Helvetica" fontSize:32];
        
        loadingLabel.position = ccp(kWinSize.width/2.0, kWinSize.height/2.0);
        
        [self addChild:loadingLabel z:1];
        
        
        [self scheduleOnce:@selector(replaceScene) delay:0];

    }
    
    
    return self;
    
    
}



- (void)replaceScene
{
    
    if([self.replaceSceneName isEqualToString:@"SelectShipLayer"])
    {
    
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1 scene:[SelectShipLayer scene]]];
    }
    else if([self.replaceSceneName isEqualToString:@"GameSceneLayer"])
    {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1 scene:[GameSceneLayer scene]]];
    }
    
}






@end
