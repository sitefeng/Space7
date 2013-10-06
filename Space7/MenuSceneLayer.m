//
//  MenuSceneLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-22.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "MenuSceneLayer.h"
#import "GameSceneLayer.h"
#import "HighscoresMainLayer.h"
#import "AboutSceneMainLayer.h"
#import "SelectShipLayer.h"

//delete after
#import "GameOverLayer.h"

@implementation MenuSceneLayer

+(CCScene *) scene
{
    
    
	MenuSceneLayer *layer = [MenuSceneLayer node];
	
    CCScene *scene = [CCScene node];
    
    CCSprite *background = [CCSprite spriteWithFile:@"SpaceSevenBackground.png"];
    
    background.anchorPoint = ccp(0,0);
    
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
        newGame.scale = 0.7;
        
        CCMenuItemImage* loadGame = [CCMenuItemImage itemWithNormalImage:@"LoadGameNormal.png"  selectedImage:@"LoadGameTouched.png" disabledImage:@"LoadGameDisabled.png" target:self selector:@selector(loadGameTouched) ];
        loadGame.scale = 0.7;
        
        if(true)
        {
            
            [loadGame setIsEnabled:NO];
            
        }
        
        CCMenuItemImage* highscores = [CCMenuItemImage itemWithNormalImage:@"HighScoresNormal.png"  selectedImage:@"HighScoresTouched.png" target:self selector:@selector(highscoresTouched) ];
		highscores.scale = 0.7;
        
        
        CCMenu* mainMenu = [CCMenu menuWithItems:newGame, loadGame, highscores, nil];
        
        mainMenu.position = ccp(windowSize.width/2, (windowSize.height/2) - 60);
        
        [mainMenu alignItemsVerticallyWithPadding: 12];
        
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
    
    [[CCDirector sharedDirector] replaceScene:[SelectShipLayer scene]];
    
}

-(void) loadGameTouched
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    
}

-(void) highscoresTouched
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    [[CCDirector sharedDirector] replaceScene:[HighscoresMainLayer scene]];
    
    
}

-(void) aboutButtonTouched
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    
    [[CCDirector sharedDirector] replaceScene:[AboutSceneMainLayer scene]];

    
}



- (void) dealloc
{
  
	
	[super dealloc];
}


@end
