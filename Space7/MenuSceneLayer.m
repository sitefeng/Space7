//
//  MenuSceneLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-22.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "MenuSceneLayer.h"


@implementation MenuSceneLayer

+(CCScene *) scene
{

    
	MenuSceneLayer *layer = [MenuSceneLayer node];
	
    CCScene *scene = [[CCScene alloc] init];
    
    CCSprite *background = [CCSprite spriteWithFile:@"SpaceSevenBackground.png"];
    
    background.anchorPoint = ccp(0,0);
    
    [layer addChild:background z:-1];
    
    [scene addChild: layer];
	
	// return the scene
	return scene;
}


-(id) init
{
	
	if( (self=[super init]) ) {
        
        CGSize windowSize = [[CCDirector sharedDirector] winSize];
        
		
        //Creating the Main Menu:
        
        CCMenuItemImage* newGame = [CCMenuItemImage itemWithNormalImage:@"NewGameNormal.png" selectedImage:@"NewGameTouched.png"];
        
        CCMenuItemImage* loadGame = [CCMenuItemImage itemWithNormalImage:@"LoadGameNormal.png" selectedImage:@"LoadGameTouched.png"];
        
        CCMenuItemImage* highscores = [CCMenuItemImage itemWithNormalImage:@"HighScoresNormal.png" selectedImage:@"HighScoresTouched.png"];
		
        CCMenu* mainMenu = [CCMenu menuWithItems:newGame, loadGame, highscores, nil];
        
        mainMenu.position = ccp(windowSize.width/2, windowSize.height/2.5);
        
        [mainMenu alignItemsVerticallyWithPadding: 15];
        
        
        //Creating the About button
        
        CCMenuItemImage* aboutButton = [CCMenuItemImage itemWithNormalImage:@"AboutButtonNormal.png" selectedImage:@"AboutButtonTouched.png"];
        
        CGSize aboutButtonSize = aboutButton.contentSize;
        
        CCMenu* about = [CCMenu menuWithItems:aboutButton, nil];
        
        about.position = ccp(windowSize.width - aboutButtonSize.width, aboutButtonSize.height);
        
        
        //Adding Main Menu and the About button to the Menu Scene
        
        [self addChild:about z:2];
        [self addChild:mainMenu z:2];
        
	}
	return self;
}


- (void) dealloc
{
	
	[super dealloc];
}


@end
