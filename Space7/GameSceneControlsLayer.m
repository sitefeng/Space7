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
        
        [self initJoystick];
        
        
        
        [self initPauseButton];
        
        
        [self initShootButton];
        
        [self schedule:@selector(joystickUpdate:) interval:1.0/30.0];
        [self schedule:@selector(gameLogic:) interval:1.0];//By Karim Kawambwa
        
        
        ////////////////////////
        /////////////////////////
        //VERY IMPORTANT SWITCH
        self.accelerationMode = NO;
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
    
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    
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
            self.scaledVelocityX = self.scaledVelocityX -3 ;
        }
        if(self.scaledVelocityY > 0)
        {
            self.scaledVelocityY = self.scaledVelocityY -3 ;
        }
        
        if(self.scaledVelocityX<0)
        {
            self.scaledVelocityX += 3;
            
        }
        if(self.scaledVelocityY<0)
        {
            self.scaledVelocityX += 3;
            
        }
        
        if((self.scaledVelocityX!=0 || self.scaledVelocityY != 0) && (gameLayer.mySpaceship.position.x == _lastPosition.x && gameLayer.mySpaceship.position.y == _lastPosition.y))
        {
            self.scaledVelocityX = 0;
            self.scaledVelocityY = 0;
        }
        
        
    }
    
    CGPoint newPosition = ccp(gameLayer.mySpaceship.position.x + self.scaledVelocityX *deltaTime, gameLayer.mySpaceship.position.y + self.scaledVelocityY *deltaTime); //new position for ship
    
    
    if (newPosition.y < windowSize.height && newPosition.y > 0 && newPosition.x < windowSize.width && newPosition.x > 0)
    { //bounds
        [gameLayer.mySpaceship setPosition: newPosition];
    }
    
    
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
    
    joystickBase.position = ccp(joystickBaseSize.width, joystickBaseSize.height);
    
    
    [self addChild:joystickBase];
    
    myJoystick = joystickBase.joystick;
    
}


-(void) initShootButton
{
    
    CCMenuItemImage *ShootButtonImg= [CCMenuItemImage itemWithNormalImage:@"gameButtonNormal.png" selectedImage:@"gameButtonPressed.png" target:self selector:@selector(didPressShootButton)];
    
    CGSize buttonSize = ShootButtonImg.contentSize;
    
    CCMenu *ShootButton = [CCMenu menuWithItems:ShootButtonImg, nil];
    
    ShootButton.position = ccp(kWinSize.width - buttonSize.width, buttonSize.height);
    
    [self addChild: ShootButton z:75];
    
    
    CCSprite* shootCrystal = [CCSprite spriteWithFile:@"shootCrystal.png"];
    
    shootCrystal.position = ccp(kWinSize.width - buttonSize.width, buttonSize.height);

    [self addChild:shootCrystal z:74 tag: 74];
    
    [self schedule:@selector(rotateShootCrystal) interval:1 repeat:kCCRepeatForever delay:0];
    
}

- (void)initPauseButton
{
    CCMenuItemImage *pauseButtonImg = [CCMenuItemImage itemWithNormalImage:@"pauseButtonNormal.png" selectedImage:@"pauseButtonPressed.png" disabledImage:@"pauseButtonDisabled.png" target:self selector:@selector(didPressPauseButton)];
    
    
    CCMenu *pauseButton = [CCMenu menuWithItems:pauseButtonImg, nil];
    
    pauseButton.position = ccp(kWinSize.width - 43, 250);
    
    [self addChild: pauseButton];
    
}

- (void)checkHealth
{
    if ([self gameLayer].mySpaceship.hp <= 0) {
        [[CCDirector sharedDirector] startAnimation];
        
        GameSceneDisplayLayer* layer = (GameSceneDisplayLayer*)[[self parent]getChildByTag:66];
        
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
        [[CCDirector sharedDirector] replaceScene: [GameOverLayer sceneWithGameScore:layer.gameScore enemiesKilled:layer.enemiesKilled andTimeScore:layer.timeScore]];
    }
    
}

-(void) didPressPauseButton
{
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    [[CCDirector sharedDirector] stopAnimation];
    
    UIAlertView* pauseAlert = [[UIAlertView alloc] initWithTitle:@"Game Paused" message:@"Current level scores will be automatically saved when you return to main menu" delegate:self cancelButtonTitle:@"Resume" otherButtonTitles:@"Main Menu", nil];
    
    [pauseAlert show];
    
    self.alertViewIsShowing = YES;
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.alertViewIsShowing = NO;
    
    if(buttonIndex==1)
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
        [[CCDirector sharedDirector] startAnimation];
        
        GameSceneDisplayLayer* displayLayer = (GameSceneDisplayLayer*)[[self parent] getChildByTag:66];
        
        [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.gameScore forKey:@"gameScore"];
        [[NSUserDefaults standardUserDefaults] setInteger: displayLayer.enemiesKilled forKey:@"enemiesKilled"];
        [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.timeScore forKey:@"timeScore"];
        [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.energyBar.percentage forKey:@"energyLevel"];
        [[NSUserDefaults standardUserDefaults] setFloat:displayLayer.healthBar.percentage forKey:@"healthLevel"];
        
        
        
        [[CCDirector sharedDirector] replaceScene: [MenuSceneLayer scene]];
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
    
    CCLOG(@"Button was pressed");
    
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










-(void) dealloc
{
    
    
    [super dealloc];
}


@end
