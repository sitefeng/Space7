//
//  AnimatedCloudBackground.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-13.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "AnimatedCloudBackground.h"

#define kwinSize [[CCDirector sharedDirector] winSize]

#define kNumClouds 8

#define kMaxCloudDuration 15


#define kCloudFrequency 3


@implementation AnimatedCloudBackground



- (id)init
{
    if(self=[super init])
    {
        
        CCSprite* background = [CCSprite spriteWithFile:@"cloudy1.png"];
        
        background.anchorPoint= ccp(0,0);
        
        [self addChild:background z:-1];
        
        
        
        for(int i=1; i<= kNumClouds; i++)
        {
            
            CCSprite* sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"cloud%i.png",i]];
        
            sprite.anchorPoint = ccp(0.5f,0.5f);
            
            
            CGSize contentSize = [sprite contentSize];
            
            sprite.position = ccp(kwinSize.width+contentSize.width*1.5, kwinSize.height/2.0);
            
            
            [self addChild:sprite z:i tag:i];
            
        }
        
        
        
        
        
        
        
        
        [self schedule:@selector(initNewCloud)];
        
        CCSprite* try = [CCSprite spriteWithFile:@"ship4.png"];
        try.position = ccp(0, kwinSize.height/2.0);
        
        [self addChild:try z:9 tag:88];
        
        [self schedule:@selector(moveCloud) interval:0.05 repeat:kCCRepeatForever delay:0];

        
        
        
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
        
        
        if(cloudSprite.position.x >= kwinSize.width + contentSize.width*1.5 || cloudSprite.position.x <= -1 * contentSize.width*1.5  )
        
        {
            
            float cloudVerticalPosition = CCRANDOM_0_1()*kwinSize.height;
            
            cloudSprite.position = ccp(kwinSize.width + contentSize.width*1.5, cloudVerticalPosition);
            
            [cloudSprite setRotation:CCRANDOM_0_1()*360];
            
            
            float scaleValue = 1.0 + CCRANDOM_0_1()*1.5;
            [cloudSprite setScale:scaleValue];
            
            CCMoveTo* moveCloud = [CCMoveTo actionWithDuration:0.3 + CCRANDOM_0_1()*kMaxCloudDuration position:ccp(contentSize.width*1.5 * -1, cloudVerticalPosition)];
            
            [cloudSprite runAction: moveCloud];
            

            
            break;
        }
        
    }
    
    
    
    
    
    
    
    [self schedule:@selector(initNewCloud) interval:1 repeat:kCCRepeatForever delay:CCRANDOM_0_1()* kCloudFrequency];
    
}




- (void) moveCloud
{
    
    CCSprite* try = (CCSprite*)[self getChildByTag:88];
    
    try.position = ccpAdd(try.position, ccp(5,0));
    
    
    
    
}












@end
