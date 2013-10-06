//
//  GameSceneDisplayLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-05.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "GameSceneDisplayLayer.h"


#define kHealthBar 56
#define kEnergyBar 57
#define kProfilePicture 58
#define kGameScoreLabel 59

@implementation GameSceneDisplayLayer
{
    float updateTime;
}


- (id) init
{
    
	if( self=[super init] ) {
        
        self.gameScore = 0;
        self.enemiesKilled = 0;
        updateTime = 0;
        self.timeScore = 0;
        
        self.touchEnabled = NO;
        
        
        //INITIALIZING THE GAME STATUS DISPLAYS
        
        //Making the top-left corner items
        CCSprite* healthBarSprite = [CCSprite spriteWithFile:@"healthBar.png"];
        
        self.healthBar = [CCProgressTimer progressWithSprite:healthBarSprite];
        
        self.healthBar.type = kCCProgressTimerTypeBar;
        self.healthBar.barChangeRate=ccp(1,0);
        self.healthBar.midpoint=ccp(0.0,0.0f);
        self.healthBar.percentage = 100;
        self.healthBar.anchorPoint = ccp(0,0);
        self.healthBar.position = ccp(60,300);
        
        CCSprite* energyBarSprite = [CCSprite spriteWithFile:@"energyBar.png"];
        
        self.energyBar = [CCProgressTimer progressWithSprite:energyBarSprite];
        
        self.energyBar.type = kCCProgressTimerTypeBar;
        self.energyBar.barChangeRate=ccp(1,0);
        self.energyBar.midpoint=ccp(0.0,0.0f);
        self.energyBar.percentage = 100;
        self.energyBar.anchorPoint = ccp(0,0);
        self.energyBar.position = ccp(60,285);
        
        [self addChild:self.healthBar z:5 tag:kHealthBar];
        [self addChild:self.energyBar z:5 tag:kEnergyBar];
        
        CCSprite* profileSprite = [CCSprite spriteWithFile:@"ship1.png"];
        
        [profileSprite setRotation:270];
        [profileSprite setScale:0.5];
        profileSprite.anchorPoint = ccp(0,0);
        profileSprite.position = ccp(50, 280);
        
        [self addChild: profileSprite z:5 tag:kProfilePicture];
        
        
        //Making the top right elements
        
        CCLabelBMFont* gameScoreSLabel = [CCLabelBMFont labelWithString:@"S:" fntFile:@"gameScoreFont-hd.fnt"];
        
        gameScoreSLabel.position = ccp(490,310);
        
        CCLabelBMFont* enemiesKilledKLabel = [CCLabelBMFont labelWithString:@"K:" fntFile:@"gameScoreFont-hd.fnt"];
        
        enemiesKilledKLabel.position = ccp(490,290);
        
        
        self.gameScoreValueLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Helvetica" fontSize:20];
        
        self.gameScoreValueLabel.position = ccp(530,310);
        
        self.enemiesKilledValueLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Helvetica" fontSize:20];
        
        self.enemiesKilledValueLabel.position = ccp(530,290);
        
        
        [self addChild:gameScoreSLabel z:5 tag:kGameScoreLabel];
        [self addChild:self.gameScoreValueLabel z:5 tag:kGameScoreLabel];
        [self addChild:enemiesKilledKLabel z:5 tag:kGameScoreLabel];
        [self addChild:self.enemiesKilledValueLabel z:5 tag:kGameScoreLabel];
        
        [self scheduleUpdate];
        
    }
    
    return self;
    
}




- (void)update: (ccTime)delta
{
    
    if (updateTime>0.5) {
        [self.gameScoreValueLabel setString:[NSString stringWithFormat:@"%.0f",self.gameScore]];
        
        [self.enemiesKilledValueLabel setString:[NSString stringWithFormat:@"%u",self.enemiesKilled]];
        
        updateTime =0;
    }
    
    updateTime+=delta;
    
    self.timeScore = self.timeScore+ delta *3;
    
    self.gameScore = self.timeScore + self.enemiesKilled*20;
    
    
    
}

- (void)updateHealth: (float)newhealth
{
    self.healthBar.percentage = newhealth;
}



-(void) dealloc
{
    

    [super dealloc];
}


@end
