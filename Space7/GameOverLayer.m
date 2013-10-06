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

+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    GameOverLayer* gameOverLayer = [GameOverLayer node];
    
    CCSprite * background = [CCSprite spriteWithFile:@"gameSceneBackground.png"];
    
    background.anchorPoint= ccp(0,0);
    
    [gameOverLayer addChild:background z:-1];
    
    [scene addChild: gameOverLayer];
    
    return scene;
    
}


- (id) init
{
    if(self=[super init])
    {
        self.touchEnabled =YES;
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCMenuItemImage *tryAgainItem = [CCMenuItemImage itemWithNormalImage:@"tryAgainButtonNormal.png" selectedImage:@"tryAgainButtonPressed.png" target:self selector:@selector(tryAgain)];

        
        CCMenuItemImage *mainMenuItem = [CCMenuItemImage itemWithNormalImage:@"mainMenuButtonNormal.png" selectedImage:@"mainMenuButtonPressed.png" target:self selector:@selector(mainMenu)];
        
        CCMenu* menuTry = [CCMenu menuWithItems:tryAgainItem, nil];
        
        
        menuTry.position = ccp(winSize.width - [tryAgainItem contentSize].width/2.0,[tryAgainItem contentSize].height/2.0);
        
        CCMenu* menuMenu = [CCMenu menuWithItems:mainMenuItem, nil];
        
        
        
        menuMenu.position =ccp([mainMenuItem contentSize].width/2.0,[mainMenuItem contentSize].height/2.0);
        
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
    
}



@end
