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

#define kHealthBar 56
#define kEnergyBar 57
#define kProfilePicture 58
#define kGameScoreLabel 59


@implementation GameSceneLayer

@synthesize mySpaceship, target, _asteroids, _projectiles, _stars;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    GameSceneLayer *gameSceneLayer = [GameSceneLayer node];
    GameSceneControlsLayer *gameSceneControlsLayer = [GameSceneControlsLayer node];
    GameSceneBackgroundLayer *gameSceneBackgroundLayer = [GameSceneBackgroundLayer node];
    GameSceneDisplayLayer *gameSceneDisplayLayer = [GameSceneDisplayLayer node];
    
    CCSprite *background = [CCSprite spriteWithFile:@"bg.png"];
    background.anchorPoint = ccp(0,0);
    
    [gameSceneBackgroundLayer addChild:background];
    
    [scene addChild: gameSceneDisplayLayer z:3 tag:66];
    [scene addChild: gameSceneControlsLayer z:2];
    [scene addChild: gameSceneLayer z:1];
    [scene addChild: gameSceneBackgroundLayer z:0];
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"level1.mp3" loop:YES ];
    
    return scene;
    
}


- (id) init
{
    
	if( self=[super init] ) {
        
        _asteroids = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
        _stars = [[NSMutableArray alloc] init];

        
        self.touchEnabled =NO;
      
        //INITIALIZE THE SPACESHIP
        mySpaceship = [[BigDog alloc] init];
        target = [CCSprite spriteWithFile:@"target-red.png"];
        target.scale = 0.1;
        
        mySpaceship.position = ccp(100,200);
        
        target.position = ccp(300, mySpaceship.contentSize.height/2);
        
        [self addChild:mySpaceship z:1];
        [mySpaceship addChild:target z:1]; //inorder to allow rotation of target with the ship as an achor point
        
        
        
        [self schedule:@selector(gameLogic:) interval:1.0];//By Karim Kawambwa
        [self schedule:@selector(update:) interval:1.0/30.0];
      
    }
    
    return self;
    
}



-(void)gameLogic:(ccTime)dt {//By Karim Kawambwa
    [self star];
    [self asteroid];
}

- (void) star {//By Karim Kawambwa
    
    for (int i = 0; i < 8 ; ++i){ //create many stars
        
        CCSprite * star = [CCSprite spriteWithFile:@"star.png"];
        star.scale = 0.25;
    
        // Determine where to spawn the asteroid along the Y axis
        CGSize winSize = [CCDirector sharedDirector].winSize;
        int minY = star.contentSize.height / 2;
        int maxY = winSize.height - star.contentSize.height/2;
        int rangeY = maxY - minY;
        int actualY = (arc4random() % rangeY) + minY;
        
        // Create the asteroid slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        star.position = ccp(winSize.width + star.contentSize.width/2, actualY);
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

- (void) asteroidParallax: (ccTime)deltaTime velocity: (CGPoint)velocity
{
    
    for (Asteroid *asteroid in _asteroids) {
        
        CGPoint newPosition = ccp(asteroid.position.x - (velocity.x * 0.5) *deltaTime, asteroid.position.y - (velocity.y * 0.5) *deltaTime); //new position for ship
        
        [asteroid setPosition: newPosition];
        
        
    }
    
}


- (void) asteroid {//By Karim Kawambwa
    
   // NSInteger r = (arc4random() % 5);
    
    Asteroid *  asteroid;
    if (arc4random() % 2 == 0) { //Used for asteroid type randomizing
        asteroid = [[[WeakAndFastAsteroid alloc] init] autorelease];
    } else {
        asteroid = [[[StrongAndSlowAsteroid alloc] init] autorelease];
    }
    
//Outdated
//    if (r==0)
//    {
//        asteroid = [CCSprite spriteWithFile:@"blueroid.png"];
//        asteroid.tag = blueroid;
//    }
//    else if (r ==1)
//    {
//        asteroid = [CCSprite spriteWithFile:@"greenroid.png"];
//        asteroid.tag = greenroid;
//    }
//    else if (r == 2)
//    {
//        asteroid = [CCSprite spriteWithFile:@"yellowroid.png"];
//        asteroid.tag = yellowroid;
//    }
//    else
//    {
//        asteroid = [CCSprite spriteWithFile:@"redroid.png"];
//        asteroid.tag = redroid;
//    }
    
    NSInteger spawn = (arc4random() % 4);

    CGSize winSize = [CCDirector sharedDirector].winSize;
    int actualX;
    int actualY;
    if (spawn == 1 || spawn == 2 ) {
        // Determine where to spawn the asteroid along the X axis
        int minX = asteroid.contentSize.width / 2;
        int maxX = winSize.width - asteroid.contentSize.width/2;
        int rangeX = maxX - minX;
        actualX = (arc4random() % rangeX) + minX;
        
        // Create the asteroid slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        asteroid.position = ccp(actualX, winSize.height + asteroid.contentSize.height/2);
        [_asteroids addObject:asteroid];
        [self addChild:asteroid z:1];
    }
    else
    {
        // Determine where to spawn the asteroid along the Y axis
        int minY = asteroid.contentSize.height / 2;
        int maxY = winSize.height - asteroid.contentSize.height/2;
        int rangeY = maxY - minY;
        actualY = (arc4random() % rangeY) + minY;
        
        // Create the asteroid slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        asteroid.position = ccp(winSize.width + asteroid.contentSize.width/2, actualY);
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
                                         position:ccp(-asteroid.contentSize.width/2 - (arc4random() % (int)winSize.width) ,
                                                      -asteroid.contentSize.height/2 - (arc4random() % (int)winSize.height))];
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
                    [asteroidToAnnialate addObject:asteroid];
                }
                
                
                if (asteroidHit) {
                    [projectilesToDelete addObject:projectile];
                    [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.caf"];
                }

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
    
    
    BOOL asteroidHit = FALSE;
    NSMutableArray *asteroidToAnnialate = [[NSMutableArray alloc] init];
        
    for (Asteroid *asteroid in _asteroids) {
        
        if (CGRectIntersectsRect(mySpaceship.boundingBox, asteroid.boundingBox)) {
            
            asteroidHit = TRUE;
            asteroid.hp --;
            if (asteroid.hp <= 0) {
                [asteroidToAnnialate addObject:asteroid];
            }
            
            if (asteroidHit) {
                if (asteroid.type == StrongAndFastroid){
                    mySpaceship.hp -= 15;
                }
                else if (asteroid.type == StrongAndSlowroid)
                {
                    mySpaceship.hp -= 10;
                }
                else if (asteroid.type == WeakAndSlowroid)
                {
                    mySpaceship.hp -= 2;
                }
                else if (asteroid.type == WeakAndFastroid)
                {
                    mySpaceship.hp -= 5;
                }
                else{
                    //nothing
                }
                
                //[[SimpleAudioEngine sharedEngine] playEffect:@"explosion.caf"];
            }
            
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
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *projectile = [CCSprite spriteWithFile:@"star.png"];
    projectile.position = mySpaceship.position;
    
    // Determine offset of location to projectile
    CCLOG(@"rotation %f",mySpaceship.rotation);
    
    float x ; //= 200 - (sin(gameLayer.mySpaceship.rotation) * 200);
    float y ; //= 200 - (cos(gameLayer.mySpaceship.rotation) * 200);
    
    if (mySpaceship.rotation <= 0.0f) {
        CCLOG(@"rotation %f", -mySpaceship.rotation);
        
        x = (cos(CC_DEGREES_TO_RADIANS(-mySpaceship.rotation)) * 50.0f);
        y = (sin(CC_DEGREES_TO_RADIANS(-mySpaceship.rotation)) * 50.0f);
        
    }else{
        CCLOG(@"rotation %f", 360.0f - mySpaceship.rotation);
        
        x = (cos(CC_DEGREES_TO_RADIANS(360.0f - mySpaceship.rotation)) * 50.0f);
        y = (sin(CC_DEGREES_TO_RADIANS(360.0f - mySpaceship.rotation)) * 50.0f);
    }
    
    CCLOG(@"x %f", x);
    CCLOG(@"y %f", y);
    
    CGPoint target = CGPointMake(mySpaceship.position.x + x,
                                 mySpaceship.position.y + y );
    
    CCLOG(@"target, postion x %f %f", target.x, projectile.position.x);
    CCLOG(@"target, postion y %f %f", target.y, projectile.position.y);
    
    CGPoint offset = ccpSub(target , projectile.position);
    CCLOG(@"offset %f %f", offset.x, offset.y);
    // Bail out if you are shooting down or backwards
    if (offset.x <= 0) return;
    
    // Ok to add now - we've double checked position
    projectile.tag = 2;
    [_projectiles addObject:projectile];
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






