//
//  GameOverLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-05.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "GameOverLayer.h"
#import "GameSceneLayer.h"
#import "MenuSceneLayer.h"


@implementation GameOverLayer

+(CCScene*) sceneWithGameScore:(float)score enemiesKilled:(unsigned int)enemies andTimeScore:(float)time
{
    
    CCScene *scene = [CCScene node];
    
    GameOverLayer* gameOverLayer = [GameOverLayer node];
    
    gameOverLayer.gameScore = score;
    
    gameOverLayer.enemiesKilled = enemies;
    
    gameOverLayer.timeScore = time;

    
    CCSprite * background = [CCSprite spriteWithFile:@"gameSceneBackground.png"];
    
    background.anchorPoint= ccp(0,0);
    
    [gameOverLayer addChild:background z:-1];
    
    [scene addChild: gameOverLayer z:1 tag:22];
    
    
    
    return scene;
    
}


- (id) init
{
    if(self=[super init])
    {
        self.touchEnabled =YES;
        
        if(!self.gameScore)
        {
            self.gameScore = 0;
        }
        if(!self.enemiesKilled)
        {
            self.enemiesKilled = 0;
        }
        if(!self.timeScore)
        {
            self.timeScore = 0;
        }
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        _tryAgainItem = [CCMenuItemImage itemWithNormalImage:@"tryAgainButtonNormal.png" selectedImage:@"tryAgainButtonPressed.png" disabledImage:@"tryAgainButtonDisabled.png" target:self selector:@selector(tryAgain)];

        [_tryAgainItem setIsEnabled:NO];
        
        _mainMenuItem = [CCMenuItemImage itemWithNormalImage:@"mainMenuButtonNormal.png" selectedImage:@"mainMenuButtonPressed.png" disabledImage:@"mainMenuButtonDisabled.png" target:self selector:@selector(mainMenu)];
        
        [_mainMenuItem setIsEnabled:NO];
        
        CCMenu* menuTry = [CCMenu menuWithItems:_tryAgainItem, nil];
        
        
        menuTry.position = ccp(winSize.width - [_tryAgainItem contentSize].width/2.0,[_tryAgainItem contentSize].height/2.0);
        
        CCMenu* menuMenu = [CCMenu menuWithItems:_mainMenuItem, nil];
        
        
        
        menuMenu.position =ccp([_mainMenuItem contentSize].width/2.0,[_mainMenuItem contentSize].height/2.0);
        
        [self addChild: menuMenu];
        [self addChild: menuTry];
        
        [self scheduleOnce:@selector(gameOver) delay:0.5];
        
        
        
    }
    
    return self;
    
}

- (void) tryAgain
{
    
    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
    
}



- (void)mainMenu
{
    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];
    
}


- (void)gameOver
{
    
    
    [self unschedule:@selector(_cmd)];
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    
    CCSprite* title = [CCSprite spriteWithFile:@"gameOverTitle.png"];
    title.position = ccp(winSize.width/2, winSize.height + 50);
    
    
    [self addChild:title];
    
    
    CCMoveTo *titleMove = [CCMoveTo actionWithDuration:1.5 position: ccp(winSize.width/2, winSize.height - 40)];
    
    CCEaseBounceOut *titleDrop = [CCEaseBounceOut actionWithAction:titleMove];
    
    [title runAction:titleDrop];
    
    
    
    
    
    [self scheduleOnce:@selector(setExplosion) delay:2.0];
    
    
    [self scheduleOnce:@selector(displayStats1) delay:4.0];
    
    
    
    
    
}




-(void) setExplosion
{
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    CCParticleExplosion* fire = [[CCParticleExplosion alloc] init];
    
    fire.texture =[[CCSprite spriteWithFile:@"bg-cloudy.png"] texture];
    
    [fire setDuration:0.5];
    
    fire.position =ccp(winSize.width/2, winSize.height - 50);
    
    [self addChild: fire z:6];

    
}



-(void) displayStats1
{
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
//
//    CCSprite *ship = [CCSprite spriteWithFile:@"ship4.png"];
//    
//    [ship setPosition: ccp(-100, winSize.height-40)];
//    
//    [self addChild:ship z:7];
//    
//    CCMoveTo* move = [CCMoveTo actionWithDuration:1 position:ccp(winSize.width+100, winSize.height -40)];
//    
//    [ship runAction:[CCEaseIn actionWithAction:move]];
    
    
    
    CCLabelBMFont* titleLabel = [CCLabelBMFont labelWithString:@"Time Elapsed" fntFile:@"spaceshipNameFont-hd.fnt"];
    [titleLabel setScale:0.9];
    titleLabel.position =ccp(winSize.width/2, winSize.height - 90);
    
    [self addChild:titleLabel];
    
    [self scheduleOnce:@selector(displayStats2) delay:1.0];
    
    
    
}


-(void) displayStats2
{
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF* valueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.0f",self.gameScore] fontName:@"Marker Felt" fontSize:30];

    valueLabel.position =ccp(winSize.width/2, winSize.height - 127.5);
    
    [self addChild:valueLabel];
    
    
    [self scheduleOnce:@selector(displayStats3) delay:1.0];

}

-(void) displayStats3
{
    
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    CCLabelBMFont* titleLabel = [CCLabelBMFont labelWithString:@"Units Destroyed" fntFile:@"spaceshipNameFont-hd.fnt"];
    [titleLabel setScale:0.9];
    titleLabel.position =ccp(winSize.width/2, winSize.height - 165);
    
    [self addChild:titleLabel];
    
    [self scheduleOnce:@selector(displayStats4) delay:1.0];
}

-(void) displayStats4
{
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF* valueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%u",self.enemiesKilled] fontName:@"Marker Felt" fontSize:30];
    
    valueLabel.position =ccp(winSize.width/2, winSize.height - 202.5);
    
    [self addChild:valueLabel];
    
    
    
    [self scheduleOnce:@selector(displayStats5) delay:1.2];

    
}

-(void) displayStats5
{
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    CCLabelBMFont* titleLabel = [CCLabelBMFont labelWithString:@"Total Score" fntFile:@"spaceshipNameFont-hd.fnt"];
    
    titleLabel.position =ccp(winSize.width/2, winSize.height - 240);
    
    [self addChild:titleLabel];
    
    [self scheduleOnce:@selector(displayStats6) delay:0.6];
    
}

-(void) displayStats6
{
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF* valueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.0f",self.timeScore] fontName:@"Marker Felt" fontSize:35];
    
    valueLabel.position =ccp(winSize.width/2, winSize.height - 280);
    
    [self addChild:valueLabel];
    
    [_tryAgainItem setIsEnabled:YES];
    [_mainMenuItem setIsEnabled:YES];
    
    
}



@end
