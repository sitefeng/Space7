//
//  GameSceneControlsLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "GameSceneControlsLayer.h"
#import "MenuSceneLayer.h"
#import "GameSceneLayer.h"
#import "GameSceneDisplayLayer.h"
#import "GameOverLayer.h"
#import "GameSceneDisplayLayer.h"

#include "ApplicationConstants.c"

@implementation GameSceneControlsLayer

+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    CCLayer *gameSceneLayer = [CCLayer node];
    
    
    [scene addChild: gameSceneLayer];
    
    return scene;
    
}

- (id) init
{
    
	if( self=[super init] ) {
        
        _alertViewIsShowing = NO;
        self.touchEnabled =YES;
        self.joystickPosition = NO;
        self.accelerationMode = NO;
        
        self.joystickPosition = [[NSUserDefaults standardUserDefaults] boolForKey:@"joystickPosition"];
        
        self.accelerationMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"glideMode"];
        
        [self initJoystick];
        
        
        [self initPauseButton];
        
        
        [self initShootButton];
        
        [self schedule:@selector(joystickUpdate:) interval:1.0/30.0];
        [self schedule:@selector(gameLogic:) interval:1.0];//By Karim Kawambwa
        
        //Save the game every 10 seconds
        [self schedule:@selector(saveGame) interval:10];
        
        ////////////////////////
        /////////////////////////
        //VERY IMPORTANT SWITCH
//        self.accelerationMode = YES;
        /////////////////////////
        //////////////////////////
        
        
        self.scaledVelocityX = 0;
        self.scaledVelocityY = 0;
        _lastPosition = ccp(568,320);
        
    }
    
    
    return self;
    
}

-(void)gameLogic:(ccTime)dt {//By Karim Kawambwa
    [self checkHealth];
}


- (void) joystickUpdate: (ccTime)deltaTime
{
    CCScene * scene = [[CCDirector sharedDirector] runningScene];
    GameSceneLayer *gameLayer = [scene.children objectAtIndex:1];
    
    if(!self.accelerationMode)
    {
        
        self.scaledVelocityX = myJoystick.velocity.x * 200;
        self.scaledVelocityY = myJoystick.velocity.y * 200;

    }
    else
    {
        CGPoint scaledAcceleration = ccpMult(myJoystick.velocity,16);
    
        self.scaledVelocityX = self.scaledVelocityX + scaledAcceleration.x;
        self.scaledVelocityY = self.scaledVelocityY + scaledAcceleration.y;
    
        //Apply friction
    
        if(self.scaledVelocityX > 0)
        {
            self.scaledVelocityX = self.scaledVelocityX - 3 ;
        }
        if(self.scaledVelocityY > 0)
        {
            self.scaledVelocityY = self.scaledVelocityY -3 ;
        }
        
        if(self.scaledVelocityX < 0)
        {
            self.scaledVelocityX += 3;
            
        }
        if(self.scaledVelocityY < 0)
        {
            self.scaledVelocityY += 3;
            
        }
        
        if(gameLayer.mySpaceship.position.x >= kWinSize.width - 12)
        {
            self.scaledVelocityX = -0.5 * self.scaledVelocityX - 30;
        }
        else if(gameLayer.mySpaceship.position.x <= 12)
        {
            self.scaledVelocityX = -0.5 * self.scaledVelocityX +30 ;
        }
        
        if(gameLayer.mySpaceship.position.y >= kWinSize.height - 12)
        {
            self.scaledVelocityY = -0.5 * self.scaledVelocityY - 30;
        }
        else if(gameLayer.mySpaceship.position.y <= 12)
        {
            self.scaledVelocityY = -0.5 * self.scaledVelocityY + 30;
        }
        
    }
    
    CGPoint newPosition = ccp(gameLayer.mySpaceship.position.x + self.scaledVelocityX *deltaTime, gameLayer.mySpaceship.position.y + self.scaledVelocityY *deltaTime);
    
    if ( newPosition.y >= kWinSize.height || newPosition.y <= 0)
    {
        
        if( newPosition.x >= kWinSize.width || newPosition.x <= 0)
        {
                newPosition = ccp(gameLayer.mySpaceship.position.x, gameLayer.mySpaceship.position.y);
        }
        else
        {
            newPosition = ccp(gameLayer.mySpaceship.position.x + self.scaledVelocityX *deltaTime, gameLayer.mySpaceship.position.y);
            
        }
    
    }
    else
    {
        if( newPosition.x >= kWinSize.width || newPosition.x <= 0)
        {
            newPosition = ccp(gameLayer.mySpaceship.position.x, gameLayer.mySpaceship.position.y + self.scaledVelocityY *deltaTime);
        }
        else
        {
            newPosition = ccp(gameLayer.mySpaceship.position.x + self.scaledVelocityX *deltaTime, gameLayer.mySpaceship.position.y + self.scaledVelocityY *deltaTime);
        }
        
    }
    
    
//    if ((gameLayer.mySpaceship.position.y + self.scaledVelocityY *deltaTime) < kWinSize.height && newPosition.y > 0 && newPosition.x < kWinSize.width && newPosition.x > 0)
    
    [gameLayer.mySpaceship setPosition: newPosition];

    
    [gameLayer starParallax:deltaTime velocity:ccp(self.scaledVelocityX, self.scaledVelocityY)];
  //  [gameLayer asteroidParallax:deltaTime velocity:scaledVelocity];

    
    //Rotating the spaceship to the joystick orientation
    float x= myJoystick.velocity.x;
    float y = myJoystick.velocity.y;
    float rotation= gameLayer.mySpaceship.rotation;
    
    if(x==0 && y == 0)
    {
        //Do nothing
    }
    else
    {
        rotation = (-atan2(y , x))*180.0/M_PI;
    }
    
    
    gameLayer.mySpaceship.rotation = rotation;
    
    
}


- (void) initJoystick
{
    SneakyJoystickSkinnedBase *joystickBase = [[SneakyJoystickSkinnedBase alloc] init];
    
    CCSprite* backSprite = [CCSprite spriteWithFile:@"gameButtonNormal.png"];
    
    CGSize joystickBaseSize = [backSprite contentSize];
    
    joystickBase.backgroundSprite = backSprite;
    
    
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"brushedMetalJoystick.png"];
    
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0,0, 2, 2)];
    
    joystickBase.joystick.joystickRadius = 33;
    
    
    if(!self.joystickPosition)
    {
        joystickBase.position = ccp(joystickBaseSize.width, joystickBaseSize.height);
        
    }
    else
    {
        joystickBase.position = ccp(kWinSize.width - joystickBaseSize.width, joystickBaseSize.height);
    }
    
    
    [self addChild:joystickBase];
    
    myJoystick = joystickBase.joystick;
    
}


-(void) initShootButton
{
    
    CCMenuItemImage *ShootButtonImg= [CCMenuItemImage itemWithNormalImage:@"gameButtonNormal.png" selectedImage:@"gameButtonPressed.png" target:self selector:@selector(didPressShootButton)];
    
    CGSize buttonSize = ShootButtonImg.contentSize;
    
    CCMenu *shootButton = [CCMenu menuWithItems:ShootButtonImg, nil];
    
    if(!self.joystickPosition)
    {
        shootButton.position = ccp(kWinSize.width - buttonSize.width, buttonSize.height);
    }
    else
    {
        shootButton.position = ccp(buttonSize.width, buttonSize.height);
    }
    
    [self addChild: shootButton z:75];
    
    
    CCSprite* shootCrystal = [CCSprite spriteWithFile:@"shootCrystal.png"];
    
    if(!self.joystickPosition)
    {
        shootCrystal.position = ccp(kWinSize.width - buttonSize.width, buttonSize.height);
    }
    else
    {
        shootCrystal.position = ccp(buttonSize.width, buttonSize.height);
    }
    
    [self addChild:shootCrystal z:74 tag: 74];
    
    [self schedule:@selector(rotateShootCrystal) interval:1 repeat:kCCRepeatForever delay:0];
    
}

- (void)initPauseButton
{
    CCMenuItemImage *pauseButtonImg = [CCMenuItemImage itemWithNormalImage:@"pauseButtonNormal.png" selectedImage:@"pauseButtonPressed.png" target:self selector:@selector(didPressPauseButton)];
    
    
    CCMenu *pauseButton = [CCMenu menuWithItems:pauseButtonImg, nil];
    
    pauseButton.position = ccp(kWinSize.width - 43, 250);
    
    [self addChild: pauseButton];
    
}

- (void)checkHealth
{
    if ([self gameLayer].mySpaceship.hp <= 0) {
        [[CCDirector sharedDirector] startAnimation];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
        GameSceneDisplayLayer* layer = (GameSceneDisplayLayer*)[[self parent]getChildByTag:66];
        
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFadeBL transitionWithDuration:1 scene:[GameOverLayer sceneWithGameScore:layer.gameScore enemiesKilled:layer.enemiesKilled andTimeScore:layer.timeScore]]];
    }
    
}

-(void) didPressPauseButton
{
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    [[CCDirector sharedDirector] stopAnimation];
    
    UIAlertView* pauseAlert = [[UIAlertView alloc] initWithTitle:@"Game Paused" message:@"Current progress will be automatically saved when you return to main menu" delegate:self cancelButtonTitle:@"Main Menu" otherButtonTitles:@"Resume", nil];
    
    [pauseAlert show];
    
    self.alertViewIsShowing = YES;
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.alertViewIsShowing = NO;
    
    if(buttonIndex==0)
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
        
        GameSceneDisplayLayer* displayLayer = (GameSceneDisplayLayer*)[[self parent] getChildByTag:66];
        
        [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.gameScore forKey:@"gameScore"];
        [[NSUserDefaults standardUserDefaults] setInteger: displayLayer.enemiesKilled forKey:@"enemiesKilled"];
        [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.timeScore forKey:@"timeScore"];
        [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.energyScore forKey:@"energyScore"];
        [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.healthBar.percentage forKey:@"healthLevel"];
        
        [[CCDirector sharedDirector] startAnimation];
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFadeBL transitionWithDuration:1 scene:[MenuSceneLayer scene]]];
    }
    else
    {
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
        [[CCDirector sharedDirector] startAnimation];
    }

}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //commented out by Karim
    
//    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
//    
//    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];

    
}




-(void) didPressShootButton
{
    
    
    [[self gameLayer] fire]; //Karim Kawambwa
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"shoot2.mp3"];
    
    GameSceneDisplayLayer* layer = (GameSceneDisplayLayer*)[[self parent] getChildByTag:66];
    
    layer.gameScore++;
    
    
    
    
}

- (GameSceneLayer *) gameLayer
{
//    CCScene * scene = [[CCDirector sharedDirector] runningScene];
//    GameSceneLayer *gameLayer = [scene.children objectAtIndex:1];
//    return gameLayer;

    GameSceneLayer* layer = (GameSceneLayer*)[[self parent] getChildByTag:kGameSceneLayerTag];

    return layer;




}



- (void)rotateShootCrystal
{
    
    CCSprite* crystal = (CCSprite*)[self getChildByTag:74];
    
    CCRotateBy* rotateCrystal = [CCRotateBy actionWithDuration:1 angle:120];
    
    [crystal runAction:rotateCrystal];
    
    
}





-(void) saveGame
{
    GameSceneDisplayLayer* displayLayer = (GameSceneDisplayLayer*)[[self parent] getChildByTag:66];
    
    [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.gameScore forKey:@"gameScore"];
    [[NSUserDefaults standardUserDefaults] setInteger: displayLayer.enemiesKilled forKey:@"enemiesKilled"];
    [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.timeScore forKey:@"timeScore"];
    [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.energyScore forKey:@"energyScore"];
    [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.healthBar.percentage forKey:@"healthLevel"];
}




-(void) dealloc
{
    
    
    [super dealloc];
}


@end
