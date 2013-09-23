//
//  MenuSceneLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-22.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "MenuSceneLayer.h"
#import "GameSceneLayer.h"

@implementation MenuSceneLayer

+(CCScene *) scene
{
    
    
	MenuSceneLayer *layer = [MenuSceneLayer node];
	
    CCScene *scene = [CCScene node];
    
    CCSprite *background = [CCSprite spriteWithFile:@"SpaceSevenBackgroundLowResolution.png"];
    
    background.anchorPoint = ccp(0,0);
    
    [background setScale:2];
    [layer addChild:background z:-1];
    
    [scene addChild: layer];
    
    //Play the background music
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"homePage.mp3" loop:YES];
    
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"click1.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"click2.mp3"];
	
	// return the scene
	return scene;
}


-(id) init
{
	
	if( (self=[super init]) ) {
        
        self.touchEnabled = YES;
        

        
        
        //Getting the window size
        CGSize windowSize = [[CCDirector sharedDirector] winSize];
        
		
        //Creating the Main Menu:
        
        CCMenuItemImage* newGame = [CCMenuItemImage itemWithNormalImage:@"NewGameNormal.png" selectedImage:@"NewGameTouched.png" target:self selector:@selector(newGameTouched) ];
        
        CCMenuItemImage* loadGame = [CCMenuItemImage itemWithNormalImage:@"LoadGameNormal.png"  selectedImage:@"LoadGameTouched.png"  target:self selector:@selector(loadGameTouched) ];
        
        CCMenuItemImage* highscores = [CCMenuItemImage itemWithNormalImage:@"HighScoresNormal.png"  selectedImage:@"HighScoresTouched.png"  target:self selector:@selector(highscoresTouched) ];
		
        CCMenu* mainMenu = [CCMenu menuWithItems:newGame, loadGame, highscores, nil];
        
        mainMenu.position = ccp(windowSize.width/2, windowSize.height/2.5);
        
        [mainMenu alignItemsVerticallyWithPadding: 15];
        
        //Creating the About button
        
        CCMenuItemImage* aboutButton = [CCMenuItemImage itemWithNormalImage:@"AboutButtonNormal.png"  selectedImage:@"AboutButtonTouched.png"  target:self selector:@selector(aboutButtonTouched) ];
        
        CGSize aboutButtonSize = aboutButton.contentSize;
        
        CCMenu* about = [CCMenu menuWithItems:aboutButton, nil];
  
        about.position = ccp(windowSize.width - aboutButtonSize.width, aboutButtonSize.height);
        
        
        //Adding Main Menu and the About button to the Menu Scene        
        [self addChild:about z:2];
        [self addChild:mainMenu z:2];
        
	}
	return self;
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    
    
    
    
}


-(void) newGameTouched
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
    
}

-(void) loadGameTouched
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    
}

-(void) highscoresTouched
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    
}

-(void) aboutButtonTouched
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    
}



- (void) dealloc
{
  
	
	[super dealloc];
}


@end
