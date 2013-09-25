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
        CGSize windowSize = [[CCDirector sharedDirector] winSize];
        
        [self initJoystick];
        
        CCMenuItemImage *bombButtonImg= [CCMenuItemImage itemWithNormalImage:@"gameButtonNormal.png" selectedImage:@"gameButtonPressed.png" disabledImage:@"gameButtonDisabled.png" target:self selector:@selector(didPressBombButton)];
        
        CGSize buttonSize = bombButtonImg.contentSize;
        
        CCMenu *bombButton = [CCMenu menuWithItems:bombButtonImg, nil];
        
        bombButton.position = ccp(windowSize.width - buttonSize.width, buttonSize.height);
        
        [self addChild: bombButton];
        
        [self schedule:@selector(joystickUpdate:) interval:1.0/30.0];
        
    }
    
    
    return self;
    
}

- (void) joystickUpdate: (ccTime)deltaTime
{
    CCScene * scene = [[CCDirector sharedDirector] runningScene];
    GameSceneLayer *gameLayer = [scene.children objectAtIndex:1];
    
    CGPoint scaledVelocity = ccpMult(myJoystick.velocity, 200);
    
    CGPoint newPosition = ccp(gameLayer.mySpaceship.position.x + scaledVelocity.x *deltaTime, gameLayer.mySpaceship.position.y + scaledVelocity.y *deltaTime);
    
    [gameLayer.mySpaceship setPosition: newPosition];
    
    
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
    
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"circle1.png"];
    
    [joystickBase.backgroundSprite setScale: 0.17];
    
    
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"plus.png"];
    
    [joystickBase.thumbSprite setScale: 0.17];
    
    
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect: CGRectMake(0,0, 2, 2)];
    
    joystickBase.joystick.joystickRadius = 33;
    
    joystickBase.position = ccp(76,76);
    
    [self addChild:joystickBase];
    
    myJoystick = joystickBase.joystick;
    
}




-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];

    
}


-(void) didPressBombButton
{
    
    
    CCLOG(@"Button was pressed");
    
    
    
}




-(void) dealloc
{
    
    
    
    [super dealloc];
}


@end
