//
//  AnimatedCloudBackground.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-13.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "AnimatedCloudBackground.h"

#define kWinSize [[CCDirector sharedDirector] winSize]

#define kNumClouds 8

#define kMaxCloudDuration 15

//Higher the number the lower the frequency is
#define kCloudFrequency 0.8


@implementation AnimatedCloudBackground



- (id)init
{
    if(self=[super init])
    {
        
        //Adding a static background
        CCSprite* background = [CCSprite spriteWithFile:@"cloudy1.png"];
        background.anchorPoint= ccp(0,0);
        [self addChild:background z:-1];
        
        for(int i=1; i<= kNumClouds; i++)
        {
            
            CCSprite* sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"cloud%i.png",i]];
        
            sprite.anchorPoint = ccp(0.5f,0.5f);
            
            
            CGSize contentSize = [sprite contentSize];
            
            sprite.position = ccp(kWinSize.width+contentSize.width*1.5, kWinSize.height/2.0);
            
            
            [self addChild:sprite z:i tag:i];
            
        }
        
  
        [self schedule:@selector(initNewCloud)];

        
        
        
        for(int i=1; i<= 5; i++)
        {
            
            CCSprite* sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"circ%i.png",i]];
            
            sprite.anchorPoint = ccp(0.5f,0.5f);
            
            [sprite setScale: 1+ CCRANDOM_0_1()*3];
            
            sprite.position = ccp(kWinSize.width * CCRANDOM_0_1(), kWinSize.height * CCRANDOM_0_1());
            
            [self addChild:sprite z:14.0+CCRANDOM_0_1()*16.0 tag:100 + i];
            
        }
        

        
    }
    
    return self;
    
}


- (void)initNewCloud
{
    
    [self unschedule:@selector(initNewCloud)];
    
    
    for(int i = 1; i<= kNumClouds ; i++)
    {
        
        CCSprite* cloudSprite = (CCSprite*)[self getChildByTag:i];
        CGSize contentSize = [cloudSprite contentSize];
        
        
        if(cloudSprite.position.x >= kWinSize.width + contentSize.width*1.5 || cloudSprite.position.x <= -1 * contentSize.width*1.5  )
        
        {
            
            float cloudVerticalPosition = CCRANDOM_0_1()*kWinSize.height;
            
            cloudSprite.position = ccp(kWinSize.width + contentSize.width*1.5, cloudVerticalPosition);
            
            [cloudSprite setRotation:CCRANDOM_0_1()*360];
            
            float scaleValue = 1.0 + CCRANDOM_0_1()*1.5;
            [cloudSprite setScale:scaleValue];
            
            
            float cloudDuration = 5.5 + CCRANDOM_0_1()*kMaxCloudDuration;
            cloudSprite.zOrder = (int)(30 - cloudDuration); //Current range 14-30
            
            CCMoveTo* moveCloud = [CCMoveTo actionWithDuration:cloudDuration position:ccp(contentSize.width*1.5 * -1, cloudVerticalPosition)];
            
            [cloudSprite runAction: moveCloud];
        
            break;
        }
        
    }
    

    [self schedule:@selector(initNewCloud) interval:1 repeat:kCCRepeatForever delay:CCRANDOM_0_1()* kCloudFrequency];
    
}












@end
