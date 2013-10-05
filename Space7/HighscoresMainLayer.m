//
//  HighscoresMainLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-26.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "HighscoresMainLayer.h"
#import "MenuSceneLayer.h"


@implementation HighscoresMainLayer

+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    HighscoresMainLayer *highscoresMainLayer = [HighscoresMainLayer node];
    
    [scene addChild: highscoresMainLayer];
    
    return scene;
    
}


- (id) init
{
    if(self=[super init])
    {
        self.touchEnabled=YES;
        
        CCSprite* timerSprite = [CCSprite spriteWithFile:@"circle2.png"];
 
        CCProgressTimer* timer = [CCProgressTimer progressWithSprite:timerSprite];
        timer.type = kCCProgressTimerTypeRadial;
        timer.position = CGPointMake(132, 132);
        timer.percentage = 60;
        [timer setScale: 0.4];
        [self addChild:timer z:1 tag:22];

        [self schedule:@selector(updateProgress)];
        
    }
    
        return self;
}


-(void) updateProgress
{
    
    CCNode* node = [self getChildByTag:22];
	
	CCProgressTimer* timer = (CCProgressTimer*)node;
	timer.percentage += 1;
	if (timer.percentage >= 100)
	{
		timer.percentage = 0;
	}

}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];
    
    
}




@end
