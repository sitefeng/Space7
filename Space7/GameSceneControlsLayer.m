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
        
        self.touchEnabled =YES;
        
        //Getting the window size
        //CGSize windowSize = [[CCDirector sharedDirector] winSize];
        
        [self initJoystick];
        
        [self schedule:@selector(joystickUpdate:) interval:1.0/30.0];
        
    }
    
    
    return self;
    
}

- (void) joystickUpdate: (ccTime)deltaTime
{
    CCScene * scene = [[CCDirector sharedDirector] runningScene];
    GameSceneLayer *gameLayer = [scene.children objectAtIndex:1];
    
    CGPoint scaledVelocity = ccpMult(myJoystick.velocity, 2000);
    
    CGPoint newPosition = ccp(gameLayer.mySpaceship.position.x + scaledVelocity.x *deltaTime, gameLayer.mySpaceship.position.y + scaledVelocity.y *deltaTime);
    
    [gameLayer.mySpaceship setPosition: newPosition];
    
}


- (void) initJoystick
{
    SneakyJoystickSkinnedBase *joystickBase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"circle1.png"];
    
    [joystickBase.backgroundSprite setScale: 0.1];
    
    
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"plus.png"];
    
    [joystickBase.thumbSprite setScale: 0.1];
    
    
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0,0, 50, 50)];
    joystickBase.position = ccp(100,100);
    
    [self addChild:joystickBase];
    
    myJoystick = joystickBase.joystick;
    
}




-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];

    
}


-(void) dealloc
{
    
    
    
    [super dealloc];
}


@end
