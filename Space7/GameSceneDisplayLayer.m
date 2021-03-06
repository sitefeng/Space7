//
//  GameSceneDisplayLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-05.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "GameSceneDisplayLayer.h"
#import "AppDelegate.h"
#import "BatttleShips.h"

#include "ApplicationConstants.c"

#define kHealthBar 56
#define kEnergyBar 57
#define kProfilePicture 58
#define kGameScoreLabel 59

#define kNumGameLevelMusic 4

#define kBasicLevelReq 50


#define kLevelLabelPosition ccp(kWinSize.width/2.0, kWinSize.height - 5)


@implementation GameSceneDisplayLayer
{
    float updateTime;
}

- (id) init
{
    
	if( self=[super init] ) {
        
        
        self.gameScore = [[NSUserDefaults standardUserDefaults] floatForKey:@"gameScore"];
        self.enemiesKilled =  [[NSUserDefaults standardUserDefaults] integerForKey:@"enemiesKilled"];
        
        self.timeScore = [[NSUserDefaults standardUserDefaults] floatForKey:@"timeScore"];
        self.energyScore = [[NSUserDefaults standardUserDefaults] floatForKey:@"energyScore"];
        
        
        updateTime = 0;
        self.touchEnabled = NO;
        
        
        //INITIALIZING THE GAME STATUS DISPLAYS
        
        //Making the top-left corner items
        CCSprite* healthBarSprite = [CCSprite spriteWithFile:@"healthBar.png"];
        
        self.healthBar = [CCProgressTimer progressWithSprite:healthBarSprite];
        
        self.healthBar.type = kCCProgressTimerTypeBar;
        self.healthBar.barChangeRate=ccp(1,0);
        self.healthBar.midpoint=ccp(0.0,0.0f);

        self.healthBar.percentage = [[NSUserDefaults standardUserDefaults] floatForKey:@"healthLevel"];
        
        if(self.healthBar.percentage == 0)
        {
            self.healthBar.percentage = 100;
        }
        
        self.healthBar.anchorPoint = ccp(0,0);
        self.healthBar.position = ccp(56,300);
        
        CCSprite* energyBarSprite = [CCSprite spriteWithFile:@"energyBar.png"];
        
        self.energyBar = [CCProgressTimer progressWithSprite:energyBarSprite];
        
        self.energyBar.type = kCCProgressTimerTypeBar;
        self.energyBar.barChangeRate=ccp(1,0);
        self.energyBar.midpoint=ccp(0.0,0.0f);
    
        

        float eScore = self.energyScore;
        float currentLevelReq = 0;
        int i = 1;
        
        while(eScore >= kBasicLevelReq * i)
        {
            eScore = eScore - kBasicLevelReq* i;
            ++i;
        }
        
        self.gameLevel = i;
        currentLevelReq = i * kBasicLevelReq;
        
        float percentageToSet = eScore / currentLevelReq * 100;
        
        self.energyBar.percentage =  percentageToSet;
        self.energyBar.anchorPoint = ccp(0,0);
        self.energyBar.position = ccp(56, 285);
        
        [self addChild:self.healthBar z:5 tag:kHealthBar];
        [self addChild:self.energyBar z:5 tag:kEnergyBar];
        
        
        //Setting up the profile ship icon picture
        AppController *appC = [UIApplication sharedApplication].delegate;
        CCSprite* profileSprite;
        
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"selectedShip"]==0)
        {
            NSLog(@"In NSUserDefaults, the selected Ship wasn't set up");
        }
        
        switch (appC.shipToStart) {
            case _Geronimo:
                profileSprite = [CCSprite spriteWithFile:@"ship1.png"];
                
                [[NSUserDefaults standardUserDefaults] setInteger:_Geronimo forKey:@"selectedShip"];
                break;
                
            case _Hyperion:
                profileSprite = [CCSprite spriteWithFile:@"ship2.png"];
                [[NSUserDefaults standardUserDefaults] setInteger:_Hyperion forKey:@"selectedShip"];
                break;
                
            case _Annihilator:
                profileSprite = [CCSprite spriteWithFile:@"ship3.png"];
                [[NSUserDefaults standardUserDefaults] setInteger:_Annihilator forKey:@"selectedShip"];
                break;
                
            case _Prometheus:
                
                [[NSUserDefaults standardUserDefaults] setInteger:_Prometheus forKey:@"selectedShip"];
                break;
                
            default:
                break;
        }
    
        [profileSprite setRotation:270];
        [profileSprite setScale:0.5];
        profileSprite.anchorPoint = ccp(0.5,0.5);
        profileSprite.position = ccp(30, kWinSize.height-24);
        
        [self addChild: profileSprite z:5 tag:kProfilePicture];
        
        
        //Displaying the player's name
        CCLabelBMFont* playerNameLabel = [CCLabelBMFont labelWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"playerName"] fntFile:@"gameScoreFont.fnt"];
        
        playerNameLabel.anchorPoint = ccp(0,1);
        playerNameLabel.position = ccp(11, kWinSize.height - 43);
        
        [self addChild:playerNameLabel z:5];
        
        
        //Displaying the Level Label
        
        NSString* level = [NSString stringWithFormat:@"Level %u", self.gameLevel];
        
        self.levelLabel = [CCLabelBMFont labelWithString:level fntFile:@"gameScoreFont.fnt"];
        
        self.levelLabel.anchorPoint = ccp(0.5,1);
        self.levelLabel.position = kLevelLabelPosition;
        [self addChild:self.levelLabel z:5];
        
        //Making the top right elements
        
        gameScoreSLabel = [CCLabelBMFont labelWithString:@"S:" fntFile:@"gameScoreFont.fnt"];
        gameScoreSLabel.position = ccp(kWinSize.width - 78,310);
        enemiesKilledKLabel = [CCLabelBMFont labelWithString:@"K:" fntFile:@"gameScoreFont.fnt"];
        enemiesKilledKLabel.position = ccp(kWinSize.width - 78,290);
        
        self.gameScoreValueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.0f",self.gameScore] fontName:@"Helvetica" fontSize:20];
        
        self.gameScoreValueLabel.position = ccp(kWinSize.width - 38,310);
        
        self.enemiesKilledValueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%u",self.enemiesKilled] fontName:@"Helvetica" fontSize:20];
        
        self.enemiesKilledValueLabel.position = ccp(kWinSize.width - 38,290);
        
        
        [self addChild:gameScoreSLabel z:5 tag:kGameScoreLabel];
        [self addChild:self.gameScoreValueLabel z:5 tag:kGameScoreLabel];
        [self addChild:enemiesKilledKLabel z:5 tag:kGameScoreLabel];
        [self addChild:self.enemiesKilledValueLabel z:5 tag:kGameScoreLabel];
        
        [self scheduleUpdate];
        
        NSString* musicName = [NSString stringWithFormat:@"level%i.mp3", (self.gameLevel-1)% kNumGameLevelMusic + 1];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:musicName loop:YES];
        
    }
    
    return self;
    
}




- (void)update: (ccTime)delta
{
    
    if (updateTime>0.5) {

        //Setting the Energy Bar level
        float eScore = self.energyScore;
        float currentLevelReq = 0;
        int level = 1;
        
        while(eScore >= kBasicLevelReq * level)
        {
            eScore = eScore - kBasicLevelReq* level;
            ++level;
        }
        
        currentLevelReq = level * kBasicLevelReq;
        
        float percentageToSet = eScore / currentLevelReq * 100;
        self.energyBar.percentage =  percentageToSet;
        
        //Setting the level label
        if(self.gameLevel < level)
        {
            self.gameLevel = level;

            //Adding an animation and new music for leveling up
            [self scheduleOnce:@selector(levelUpTransition) delay:0];
            
        }
        
        //Setting the GUI elements
        [self.gameScoreValueLabel setString:[NSString stringWithFormat:@"%.0f",self.gameScore]];
        [self.enemiesKilledValueLabel setString:[NSString stringWithFormat:@"%u",self.enemiesKilled]];
        
        
        updateTime =0;
    }
    
    updateTime+=delta;
    
    
    float bonusPoints = self.gameScore - self.timeScore;
    
    self.timeScore = self.timeScore + delta *3;
    
    self.gameScore = bonusPoints + self.timeScore;
    
}


- (void)updateHealth: (float)newhealth
{
     self.healthBar.percentage = newhealth;
}

- (void)updatescore: (float)score
{
    self.gameScore += score;
    //[self.gameScoreValueLabel runAction:[CCBlink actionWithDuration:.5 blinks:1]];
    
    //scale the scores label up and down
    id scaleUpAction =  [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:.5 scaleX:1.2 scaleY:1.2] rate:2.0];
    id scaleDownAction = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.5 scaleX:0.8 scaleY:0.8] rate:2.0];
    CCSequence *scaleSeq = [CCSequence actions:scaleUpAction, scaleDownAction, nil];
    [self.gameScoreValueLabel runAction:scaleSeq];
    
    
    //Updating the energyScore
    self.energyScore += score;
    
    
}

- (void)updatekill
{
    self.enemiesKilled++;
   // [self.enemiesKilledValueLabel runAction:[CCBlink actionWithDuration:.5 blinks:1]];
    id scaleUpAction =  [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:.5 scaleX:1.2 scaleY:1.2] rate:2.0];
    id scaleDownAction = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.5 scaleX:0.8 scaleY:0.8] rate:2.0];
    CCSequence *scaleSeq = [CCSequence actions:scaleUpAction, scaleDownAction, nil];
    [self.enemiesKilledValueLabel runAction:scaleSeq];
}


- (void)levelUpTransition
{
    
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];

    CCMoveBy* moveLevelUpwards = [CCMoveBy actionWithDuration:0.5 position:ccp(0,self.levelLabel.contentSize.height)];
    [self.levelLabel runAction:moveLevelUpwards];
    
    [self scheduleOnce:@selector(initLevelUpAnimation) delay:0.5];
    [self scheduleOnce:@selector(levelUpLabelGoUpScreen) delay:3];

}

#pragma mark - Level up private helper methods


- (void)initLevelUpAnimation
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"levelUp.mp3"];
    
    //Putting the label on the left side of the screen and preparing for screen entrance
    [self.levelLabel setPosition:ccp(-kWinSize.width - self.levelLabel.contentSize.width/2.0, kWinSize.height/2.0 + 45)];

    [self.levelLabel setScale:1.7];
    [self.levelLabel setScaleX:2.2];
    
    //Updating the level string itself
    [self.levelLabel setString:[NSString stringWithFormat:@"Level %u", self.gameLevel]];
    
    
    //Run the rest of the animations
    CCMoveTo* presentLevelLabel = [CCMoveTo actionWithDuration:1 position:ccp(kWinSize.width/2.0, kWinSize.height/2.0 + 45)];
    
    CCScaleTo* scaleX = [CCScaleTo actionWithDuration:0.4 scale:1.7];
    
    CCSequence* levelUpAnimation = [CCSequence actions:presentLevelLabel, scaleX, nil];
    
    [self.levelLabel runAction:levelUpAnimation];

}


- (void)levelUpLabelGoUpScreen
{
    //Change the background music to the next one
    NSString* musicName = [NSString stringWithFormat:@"level%i.mp3", (self.gameLevel-1)% kNumGameLevelMusic + 1];
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:musicName loop:YES];
    
    
    CCMoveTo* moveToOriginalPosition = [CCMoveTo actionWithDuration:0.6 position:kLevelLabelPosition];
    
    CCScaleTo* scaleBackToNorm = [CCScaleTo actionWithDuration:0.6 scale:1];
    
    [self.levelLabel runAction:moveToOriginalPosition];
    [self.levelLabel runAction:scaleBackToNorm];
    
    
}





-(void) dealloc
{
    [super dealloc];
}


@end
