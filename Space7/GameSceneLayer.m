//
//  GameSceneLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "GameSceneLayer.h"
#import "GameSceneControlsLayer.h"
#import "GameSceneBackgroundLayer.h"
#import "GameSceneDisplayLayer.h"
#import "Asteroid.h"
#import "BatttleShips.h"
#import "GameSceneDisplayLayer.h"
#import "AppDelegate.h"
#import "AnimatedCloudCover.h"

#include "ApplicationConstants.c"


#define kHealthBar 56
#define kEnergyBar 57
#define kProfilePicture 58
#define kGameScoreLabel 59



@implementation GameSceneLayer
{
    
    NSMutableArray* _explodeFrames;
}

@synthesize mySpaceship, target, _asteroids, _projectiles, _stars;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    GameSceneLayer *gameSceneLayer = [GameSceneLayer node];
    GameSceneControlsLayer *gameSceneControlsLayer = [GameSceneControlsLayer node];
    GameSceneBackgroundLayer *gameSceneBackgroundLayer = [GameSceneBackgroundLayer node];
    GameSceneDisplayLayer *gameSceneDisplayLayer = [GameSceneDisplayLayer node];
    
    [scene addChild: gameSceneDisplayLayer z:3 tag:66];
    [scene addChild: gameSceneControlsLayer z:2 tag:kGameSceneControlsLayerTag];
    [scene addChild: gameSceneLayer z:1 tag:kGameSceneLayerTag];
    [scene addChild: gameSceneBackgroundLayer z:0];
    
   

    
    return scene;
    
}


- (id) init
{
    
	if( self=[super init] ) {
        
        _asteroids = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
        _stars = [[NSMutableArray alloc] init];

        //Preload the explosion effect
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"explosion.plist"];
        _explodeFrames = [[NSMutableArray alloc] init];
        for (int i=1; i<=32; i++) {
            NSString *string;
            if (i/10 == 0){
                string = [NSString stringWithFormat:@"slice0%d_0%d.png",i,i];
            }else{
                string = [NSString stringWithFormat:@"slice%d_%d.png",i,i];
            }
            
            [_explodeFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              string]];
        }
        
        
        
        
        
        
        //Set touch not enabled
        self.touchEnabled =NO;
        AppController *appC = [UIApplication sharedApplication].delegate;
        [self initializeShip:appC.shipToStart];
        
        
        //INITIALIZE THE SPACESHIP
        
        
        //        CCParticleExplosion* explosion = [CCParticleExplosion node];
//        explosion.autoRemoveOnFinish = YES;
//        //explosion.texture = [tempElement texture];
//        explosion.startSize = 5.0f;
//        explosion.endSize = 1.0f;
//        explosion.duration = 0.1f;
//        explosion.speed = 30.0f;
//        explosion.anchorPoint = ccp(0.5f,0.5f);
//       // explosion.position = tempElement.position;
//        [self addChild: explosion z: self.zOrder+1];
        
        
        [self schedule:@selector(gameLogic:) interval:1.0];//By Karim Kawambwa
        [self schedule:@selector(update:) interval:1.0/30.0];
        [self schedule:@selector(updateShip:) interval:1.0/30.0];
        
      
        
        
        AnimatedCloudCover* cloudCover = [AnimatedCloudCover node];

        [self addChild:cloudCover z:2];
        
    }
    
    return self;
    
}

- (void)initializeShip: (NSInteger) type
{
    //INITIALIZE THE SPACESHIP
    if(type!=-1)
    {
        switch (type) {
            case _Geronimo:
                mySpaceship = [[Geronimo alloc] init];
                break;
            
            case _Hyperion:
                mySpaceship = [[Hyperion alloc] init];
                break;
            
            case _Annihilator:
                mySpaceship = [[Annihilator alloc] init];
                break;
        
            case _Prometheus:
                mySpaceship = [[Prometheus alloc] init];
                break;
                
            default:
                NSLog(@"Ship type was not specified correctly!!");
                break;
        }
        
    }
    else
    {
         NSLog(@"No ship type was specified!!");
    
    }
    
   // target = [CCSprite spriteWithFile:@"target-red.png"];
    //target.scale = 0.1;
    mySpaceship.position = ccp(100,200);

    mySpaceship.position = ccp(kWinSize.width/2,kWinSize.height/2);
    
    //target.position = ccp(300, mySpaceship.contentSize.height/2);
    
        [self addChild:mySpaceship z:1];
    //[mySpaceship addChild:target z:1]; //inorder to allow rotation of target with the ship as an achor point
    

}

- (void)blowUpAtPosition: (CGPoint)position
{
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"explosion.png"];
    [self addChild:spriteSheet];
    
    
    
    
    
    
    CCAnimation* explosion = [CCAnimation animationWithSpriteFrames:_explodeFrames delay:0.025f];
    
    
    self.boom = [CCSprite spriteWithSpriteFrameName:@"slice01_01.png"];
    self.boom.position = position;
   
    [self.boom runAction: [CCSequence actions:[CCAnimate actionWithAnimation:explosion], [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
    }],nil] ];
    self.boom.scale = 2.5;
    [spriteSheet addChild:self.boom];

}

- (void)hitExplosionAt: (CGPoint)position
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"hit.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"hit.png"];
    [self addChild:spriteSheet z:2];
    
    NSMutableArray *exlodeFrames = [NSMutableArray array];
    for (int i=1; i<=52; i++) {
        NSString *string;
        string = [NSString stringWithFormat:@"hit_%d.png",i];
        
        [exlodeFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          string]];
    }
    
    CCAnimation *explode = [CCAnimation
                            animationWithSpriteFrames:exlodeFrames delay:0.025f];
    

    
    self.boom = [CCSprite spriteWithSpriteFrameName:@"hit_1.png"];
    self.boom.position = position;
    
    [self.boom runAction: [CCSequence actions:[CCAnimate actionWithAnimation:explode], [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
    }],nil] ];
    self.boom.scale = 1;
    [spriteSheet addChild:self.boom];
    
}




-(void)gameLogic:(ccTime)dt {//By Karim Kawambwa
    [self star];
    [self asteroid];
}

- (void) star {//By Karim Kawambwa
    
    for (int i = 0; i < 8 ; ++i){ //create many stars
        
        CCSprite * star = [CCSprite spriteWithFile:@"star.png"];
        star.scale = 0.3;
    
        // Determine where to spawn the asteroid along the Y axis
        int minY = star.contentSize.height / 2;
        int maxY = kWinSize.height - star.contentSize.height/2;
        int rangeY = maxY - minY;
        int actualY = (arc4random() % rangeY) + minY;
        
        // Create the asteroid slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        star.position = ccp(kWinSize.width + star.contentSize.width/2, actualY);
        star.tag = 3;
        [_stars addObject:star];
        [self addChild:star z:0];
        
        // Determine speed of the asteroid
        int minDuration = 4.0;
        int maxDuration = 10.0;
        int rangeDuration = maxDuration - minDuration;
        int actualDuration = (arc4random() % rangeDuration) + minDuration;
        
        // Create the actions
        //CCMoveTo: You use the CCMoveTo action to direct the object to move off-screen to the left.
        CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                    position:ccp(-star.contentSize.width/2, actualY)];
        
        //CCCallBlockN: The CCCallBlockN function allows us to specify a callback block to run when the action is performed. In this game, you’re going to set up this action to run after the monster goes offscreen to the left – and you’ll remove the monster from the layer when this occurs.
        CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
            [node removeFromParentAndCleanup:YES];
        }];
        
        //CCSequence: The CCSequence action allows us to chain together a sequence of actions that are performed in order, one at a time.
        [star runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
        
    }
}



- (void) starParallax: (ccTime)deltaTime velocity: (CGPoint)velocity
{
    //NSMutableArray *starsToMove = [[NSMutableArray alloc] init];
    for (CCSprite *star in _stars) {
        
        CGPoint newPosition = ccp(star.position.x - (velocity.x * 0.25) *deltaTime, star.position.y - (velocity.y * 0.25) *deltaTime); //new position for ship
        
        [star setPosition: newPosition];
        

//        starsToMove addObject:star
//        for (CCSprite *star in starsToMove) {
//            
//        }
    }

}

//- (void) asteroidParallax: (ccTime)deltaTime velocity: (CGPoint)velocity //KK not used
//{
//    
//    for (Asteroid *asteroid in _asteroids) {
//        
//        CGPoint newPosition = ccp(asteroid.position.x - (velocity.x * 0.8) *deltaTime, asteroid.position.y - (velocity.y * 0.8) *deltaTime); //new position for ship
//        
//        [asteroid setPosition: newPosition];
//        
//        
//    }
//    
//}


- (void) asteroid {//By Karim Kawambwa
    
   // NSInteger r = (arc4random() % 5);
    
    Asteroid *  asteroid;
    if (arc4random() % 2 == 0) { //Used for asteroid type randomizing
        asteroid = [[WeakAsteroid alloc] init];
    }else {
        
        if (arc4random() % 2 == 0) { //Used for asteroid type randomizing
            asteroid = [[MedWeakAsteroid alloc] init];
        }else {
            if (arc4random() % 2 == 0) { //Used for asteroid type randomizing
                asteroid = [[MedStrongAsteroid alloc] init];
            }else {
                asteroid = [[StrongAsteroid alloc] init];
            }
        }
    }
    
    
    NSInteger spawn = (arc4random() % 4);

    int actualX;
    int actualY;
    if (spawn == 1 || spawn == 2 ) {
        // Determine where to spawn the asteroid along the X axis
        int minX = kWinSize.width /2;
        int maxX = kWinSize.width - asteroid.contentSize.width/2;
        int rangeX = maxX - minX;
        actualX = (arc4random() % rangeX) + minX;
        
        // Create the asteroid slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        asteroid.position = ccp(actualX, kWinSize.height + asteroid.contentSize.height/2);
        [_asteroids addObject:asteroid];
        [self addChild:asteroid z:1];
    }
    else
    {
        // Determine where to spawn the asteroid along the Y axis
        int minY = asteroid.contentSize.height / 2;
        int maxY = kWinSize.height - asteroid.contentSize.height/2;
        int rangeY = maxY - minY;
        actualY = (arc4random() % rangeY) + minY;
        
        // Create the asteroid slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        asteroid.position = ccp(kWinSize.width + asteroid.contentSize.width/2, actualY);
        [_asteroids addObject:asteroid];
        [self addChild:asteroid z:1];
    }
    
    
    // Determine speed of the asteroid
    int minDuration = asteroid.minMoveDuration; //3.0f
    int maxDuration = asteroid.maxMoveDuration; //5.0f
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    CCMoveTo * actionMove;
    if (spawn == 1 || spawn == 2) {
        // Create the actions
        //CCMoveTo: You use the CCMoveTo action to direct the object to move off-screen to the left.
        actionMove = [CCMoveTo actionWithDuration:actualDuration
                                         position:ccp(-asteroid.contentSize.width/2 - (arc4random() % (int)kWinSize.width) ,
                                                      -asteroid.contentSize.height/2 - (arc4random() % (int)kWinSize.height))];
    }
    else
    {
        // Create the actions
        //CCMoveTo: You use the CCMoveTo action to direct the object to move off-screen to the left.
        actionMove = [CCMoveTo actionWithDuration:actualDuration
                                         position:ccp(-asteroid.contentSize.width/2, actualY)];
    }
    
    //CCCallBlockN: The CCCallBlockN function allows us to specify a callback block to run when the action is performed. In this game, you’re going to set up this action to run after the monster goes offscreen to the left – and you’ll remove the monster from the layer when this occurs.
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
        [_asteroids removeObject:node];
    }];
    
    //CCSequence: The CCSequence action allows us to chain together a sequence of actions that are performed in order, one at a time.
    [asteroid runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];

}


- (void)update:(ccTime)dt {
    
    
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    
    for (CCSprite *projectile in _projectiles) {
        
        BOOL asteroidHit = FALSE;
        NSMutableArray *asteroidToAnnialate = [[NSMutableArray alloc] init];
        
        for (Asteroid *asteroid in _asteroids) {
            
            if (CGRectIntersectsRect(projectile.boundingBox, asteroid.boundingBox)) {
                
                asteroidHit = TRUE;
                asteroid.hp --;
                
                if (asteroid.hp <= 0) {
                    [self blowUpAtPosition:asteroid.position];
                    [asteroidToAnnialate addObject:asteroid];
                    
                    //By SiTe to update Score on the Display layer
                
                    GameSceneDisplayLayer *updateLayer = (GameSceneDisplayLayer*)[[self parent] getChildByTag:66];
                    [updateLayer updatekill];
                    
                    switch (asteroid.type) { //Bonus point on each Kill
                        case WeakAstroid:
                            [updateLayer updatescore:5];
                            break;
                        case MedWeakAstroid:
                            [updateLayer updatescore:11];
                            break;
                        case MedStrongAstroid:
                            [updateLayer updatescore:17];
                            break;
                        case StrongAstroid:
                            [updateLayer updatescore:23];
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    [self hitExplosionAt:asteroid.position];
                }
                
                
                if (asteroidHit) {
                    [projectilesToDelete addObject:projectile];
                    [[SimpleAudioEngine sharedEngine] playEffect:@"Distant Boom.mp3"];
                }
                
                asteroidHit = FALSE;

                break;

            }
        }
        
        for (Asteroid *asteroid in asteroidToAnnialate) {
            [_asteroids removeObject:asteroid];
            [self removeChild:asteroid cleanup:YES];
        }
        
        
        [asteroidToAnnialate release];
    }
    
    for (CCSprite *projectile in projectilesToDelete) {
        [_projectiles removeObject:projectile];
        [self removeChild:projectile cleanup:YES];
    }
    [projectilesToDelete release];
}


- (void)updateShip:(ccTime)dt {
    
    
    BOOL shipHit = FALSE;
    NSMutableArray *asteroidToAnnialate = [[NSMutableArray alloc] init];
        
    for (Asteroid *asteroid in _asteroids) {
        
        if (CGRectIntersectsRect(mySpaceship.boundingBox, asteroid.boundingBox)) {
            
            shipHit = TRUE;
            [asteroidToAnnialate addObject:asteroid];
            
            if (shipHit) {
                if (asteroid.type == StrongAstroid){
                    mySpaceship.hp -= 9;
                }
                else if (asteroid.type == MedStrongAstroid)
                {
                    mySpaceship.hp -= 7;
                }
                else if (asteroid.type == MedWeakAstroid)
                {
                    mySpaceship.hp -= 5;
                }
                else if (asteroid.type == WeakAstroid)
                {
                    mySpaceship.hp -= 3;
                }
                else{
                    //nothing
                }
                [self blowUpAtPosition:asteroid.position];
              //  [self hitExplosionAt:mySpaceship.position];
                
                CCScene * scene = [[CCDirector sharedDirector] runningScene];
                GameSceneDisplayLayer *displayLayer = [scene.children objectAtIndex:3];
                
                //CCLOG(@"%d",mySpaceship.hp);
                [displayLayer updateHealth:mySpaceship.hp];
                
                //[mySpaceship runAction:[CCBlink actionWithDuration:.5 blinks:3]];
                [[SimpleAudioEngine sharedEngine] playEffect:@"Explosion 2.mp3"];
            }
            
            shipHit = FALSE;
            break;
            
        }
        
    }
    
    for (Asteroid *asteroid in asteroidToAnnialate) {
        [_asteroids removeObject:asteroid];
        [self removeChild:asteroid cleanup:YES];
    }
    
    
    [asteroidToAnnialate release];

}

- (void)fire
{
    //    // Choose one of the touches to work with
    //    UITouch *touch = [touches anyObject];
    //    CGPoint location = [self convertTouchToNodeSpace:touch];
    
    // Set up initial location of projectile
    [[SimpleAudioEngine sharedEngine] playEffect:@"Laser Shot 4.mp3"];

    
    CCSprite *projectile = [CCSprite spriteWithFile:@"bullet.png"];
    projectile.position = mySpaceship.position;
    
    // Determine offset of location to projectile
    //CCLOG(@"rotation %f",mySpaceship.rotation);
    
    float x ; //= 200 - (sin(gameLayer.mySpaceship.rotation) * 200);
    float y ; //= 200 - (cos(gameLayer.mySpaceship.rotation) * 200);
    
    if (mySpaceship.rotation <= 0.0f) {
        //CCLOG(@"rotation %f", -mySpaceship.rotation);
        
        x = (cos(CC_DEGREES_TO_RADIANS(-mySpaceship.rotation)) * 50.0f);
        y = (sin(CC_DEGREES_TO_RADIANS(-mySpaceship.rotation)) * 50.0f);
        
    }else{
        //CCLOG(@"rotation %f", 360.0f - mySpaceship.rotation);
        
        x = (cos(CC_DEGREES_TO_RADIANS(360.0f - mySpaceship.rotation)) * 50.0f);
        y = (sin(CC_DEGREES_TO_RADIANS(360.0f - mySpaceship.rotation)) * 50.0f);
    }
    
    //CCLOG(@"x %f", x);
    //CCLOG(@"y %f", y);
    
    CGPoint targetPoint = CGPointMake(mySpaceship.position.x + x,
                                 mySpaceship.position.y + y );
    
    //CCLOG(@"target, postion x %f %f", targetPoint.x, projectile.position.x);
    //CCLOG(@"target, postion y %f %f", targetPoint.y, projectile.position.y);
    
    CGPoint offset = ccpSub(targetPoint , projectile.position);
    //CCLOG(@"offset %f %f", offset.x, offset.y);
    
    // Bail out if you are shooting down or backwards
    //if (offset.x <= 0) return; //doesn't allow back shooting
    
    // Ok to add now - we've double checked position
    projectile.tag = 2;
    [_projectiles addObject:projectile];
    [self addChild:projectile];
    
    int realX ;
    float ratio;
    int realY;
    if (targetPoint.x > projectile.position.x) {
       realX = kWinSize.width + (projectile.contentSize.width/2);
       ratio = (float) offset.y / (float) offset.x;
       realY = (realX * ratio) + projectile.position.y;
    }
    else
    {
        realX = -kWinSize.width - (projectile.contentSize.width/2);
        ratio = (float) offset.y / (float) - offset.x;
        realY =  projectile.position.y + ((-realX) * ratio);
    }

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
         [_projectiles removeObject:node];
     }],
      nil]];

}

-(void) dealloc
{
    
    
    [_asteroids release];
    [_projectiles release];
    [_stars release];
    
    _projectiles = nil;
    _asteroids = nil;
    _stars = nil;
    
    [super dealloc];
}

@end






