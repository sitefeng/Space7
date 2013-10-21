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

        self.gameLevel = self.gameScore / 10.0 + 1;
        
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
        float currentLevelReq = 10000;
        int i = 1;
        
        while(eScore >= 500 * i)
        {
            eScore = eScore - 500* i;
            ++i;
        }
        
        currentLevelReq = i * 500;
        
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
        self.levelLabel.position = ccp(kWinSize.width/2.0, kWinSize.height - 5);
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
        
        while(eScore >= 500 * level)
        {
            eScore = eScore - 500* level;
            ++level;
        }
        
        currentLevelReq = level * 500;
        
        float percentageToSet = eScore / currentLevelReq * 100;
        self.energyBar.percentage =  percentageToSet;
        
        //Setting the level label
        self.gameLevel = level;
        
        //Setting the GUI elements
        [self.gameScoreValueLabel setString:[NSString stringWithFormat:@"%.0f",self.gameScore]];
        [self.enemiesKilledValueLabel setString:[NSString stringWithFormat:@"%u",self.enemiesKilled]];
        [self.levelLabel setString:[NSString stringWithFormat:@"Level %u", self.gameLevel]];
        
        updateTime =0;
    }
    
    updateTime+=delta;
    
    self.timeScore = self.timeScore + delta *3;
    
    
    
    
    
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

-(void) dealloc
{
    [super dealloc];
}


@end
