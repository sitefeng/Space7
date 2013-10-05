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
        
        [self initJoystick];
        
        [self initBombButton];
        
        
        
        [self schedule:@selector(joystickUpdate:) interval:1.0/30.0];
        
    }
    
    
    return self;
    
}

- (void) joystickUpdate: (ccTime)deltaTime
{
    CCScene * scene = [[CCDirector sharedDirector] runningScene];
    GameSceneLayer *gameLayer = [scene.children objectAtIndex:1];
    
    CGPoint scaledVelocity = ccpMult(myJoystick.velocity, 200);
    global_x = scaledVelocity.x;
    global_y = scaledVelocity.y;
    CGPoint newPosition = ccp(gameLayer.mySpaceship.position.x + scaledVelocity.x *deltaTime, gameLayer.mySpaceship.position.y + scaledVelocity.y *deltaTime); //new position for ship
    
    [gameLayer.mySpaceship setPosition: newPosition];
    
//    newPosition = ccp(gameLayer.target.position.x + scaledVelocity.x *deltaTime, gameLayer.target.position.y + scaledVelocity.y *deltaTime); // new position for target
//    
//    [gameLayer.target setPosition:newPosition];
    
    
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
    
//    float npx = gameLayer.target.position.x * cos(rotation) - gameLayer.target.position.y *sin(rotation);
//    float npy = gameLayer.target.position.x * sin(rotation) + gameLayer.target.position.y *cos(rotation);
//    
//    [gameLayer.target setPosition:CGPointMake(npx, npy)];
    
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


-(void) initBombButton
{
    
    //Getting the window size
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemImage *bombButtonImg= [CCMenuItemImage itemWithNormalImage:@"gameButtonNormal.png" selectedImage:@"gameButtonPressed.png" disabledImage:@"gameButtonDisabled.png" target:self selector:@selector(didPressBombButton)];
    
    CGSize buttonSize = bombButtonImg.contentSize;
    
    CCMenu *bombButton = [CCMenu menuWithItems:bombButtonImg, nil];
    
    bombButton.position = ccp(windowSize.width - buttonSize.width, buttonSize.height);
    
    [self addChild: bombButton];
    
    
}




-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //commented out by Karim
    
//    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
//    
//    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];

    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
}

- (void)fire
{
//    // Choose one of the touches to work with
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    // Set up initial location of projectile
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCScene * scene = [[CCDirector sharedDirector] runningScene];
    GameSceneLayer *gameLayer = [scene.children objectAtIndex:1];
    CCSprite *projectile = [CCSprite spriteWithFile:@"star.png"];
    projectile.position = gameLayer.mySpaceship.position;
    
    // Determine offset of location to projectile
    CCLOG(@"rotation %f", gameLayer.mySpaceship.rotation);
    
    float x ; //= 200 - (sin(gameLayer.mySpaceship.rotation) * 200);
    float y ; //= 200 - (cos(gameLayer.mySpaceship.rotation) * 200);
    
    if (gameLayer.mySpaceship.rotation <= 0.0f) {
        CCLOG(@"rotation %f", -gameLayer.mySpaceship.rotation);
        x = ((cos(-gameLayer.mySpaceship.rotation*M_PI/180.0f)) * 50.0f);
        y = ((sin(-gameLayer.mySpaceship.rotation*M_PI/180.0f)) * 50.0f);
        
    }else{
        CCLOG(@"rotation %f", 360.0f - gameLayer.mySpaceship.rotation);
        x = ((cos((360.0f - gameLayer.mySpaceship.rotation)*M_PI/180.0f)) * 50.0f);
        y = ((sin((360.0f - gameLayer.mySpaceship.rotation)*M_PI/180.0f)) * 50.0f);
    }
    
    CCLOG(@"x %f", x);
    CCLOG(@"y %f", y);
    CGPoint target = CGPointMake(gameLayer.mySpaceship.position.x + x,
                                 gameLayer.mySpaceship.position.y + y );
    
    CCLOG(@"target, postion x %f %f", target.x, projectile.position.x);
    CCLOG(@"target, postion y %f %f", target.y, projectile.position.y);
    CGPoint offset = ccpSub(target , projectile.position);
    CCLOG(@"offset %f %f", offset.x, offset.y);
    // Bail out if you are shooting down or backwards
    if (offset.x <= 0) return;
    
    // Ok to add now - we've double checked position
    [self addChild:projectile];
    
    int realX = winSize.width + (projectile.contentSize.width/2);
    float ratio = (float) offset.y / (float) offset.x;
    int realY = (realX * ratio) + projectile.position.y;
    CGPoint realDest = ccp(realX, realY);
    
    // Determine the length of how far you're shooting
    int offRealX = realX - projectile.position.x;
    int offRealY = realY - projectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    // Move projectile to actual endpoint
    [projectile runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [node removeFromParentAndCleanup:YES];
     }],
      nil]];
}


-(void) didPressBombButton
{
    
    
    CCLOG(@"Button was pressed");
    
    [self fire]; //Karim Kawambwa
    
}




-(void) dealloc
{
    
    
    
    [super dealloc];
}


@end
