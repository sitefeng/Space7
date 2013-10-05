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



@implementation GameSceneLayer

@synthesize mySpaceship, target;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
    
    GameSceneLayer *gameSceneLayer = [GameSceneLayer node];
    GameSceneControlsLayer *gameSceneControlsLayer = [GameSceneControlsLayer node];
    GameSceneBackgroundLayer *gameSceneBackgroundLayer = [GameSceneBackgroundLayer node];
    
    
    
    CCSprite *background = [CCSprite spriteWithFile:@"bg.png"];
    background.anchorPoint = ccp(0,0);
    
    [gameSceneBackgroundLayer addChild:background];
    
    
    [scene addChild: gameSceneControlsLayer z:2];
    [scene addChild: gameSceneLayer z:1];
    [scene addChild: gameSceneBackgroundLayer z:0];
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"level1.mp3" loop:YES ];
    
    return scene;
    
}


- (id) init
{
    
	if( self=[super init] ) {
        
        self.touchEnabled =NO;
      
        mySpaceship = [CCSprite spriteWithFile:@"ship1.png"];
        target = [CCSprite spriteWithFile:@"target-red.png"];
        target.scale = 0.2;
        
        mySpaceship.position = ccp(100,200);
        
        target.position = ccp(300, mySpaceship.contentSize.height/2);
        
        [self addChild:mySpaceship z:1];
        [mySpaceship addChild:target z:1]; //inorder to allow rotation of target with the ship as an achor point
        
        [self schedule:@selector(gameLogic:) interval:1.0];//By Karim Kawambwa
      
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
        star.scale = 0.5;
    
        // Determine where to spawn the asteroid along the Y axis
        CGSize winSize = [CCDirector sharedDirector].winSize;
        int minY = star.contentSize.height / 2;
        int maxY = winSize.height - star.contentSize.height/2;
        int rangeY = maxY - minY;
        int actualY = (arc4random() % rangeY) + minY;
        
        // Create the asteroid slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        star.position = ccp(winSize.width + star.contentSize.width/2, actualY);
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

- (void) asteroid {//By Karim Kawambwa
    
    NSInteger r = (arc4random() % 5); //Used for asteroid type randomizing
    
    CCSprite *  asteroid;
    
    if (r==0)
    {
        asteroid = [CCSprite spriteWithFile:@"blueroid.png"];
    }
    else if (r ==1)
    {
        asteroid = [CCSprite spriteWithFile:@"greenroid.png"];
    }
    else if (r == 2)
    {
        asteroid = [CCSprite spriteWithFile:@"yellowroid.png"];
    }
    else
    {
        asteroid = [CCSprite spriteWithFile:@"redroid.png"];
    }
    
    // Determine where to spawn the asteroid along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = asteroid.contentSize.height / 2;
    int maxY = winSize.height - asteroid.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the asteroid slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    asteroid.position = ccp(winSize.width + asteroid.contentSize.width/2, actualY);
    [self addChild:asteroid z:0];
    
    // Determine speed of the asteroid
    int minDuration = 3.0;
    int maxDuration = 5.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    //CCMoveTo: You use the CCMoveTo action to direct the object to move off-screen to the left.
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:actualDuration
                                                position:ccp(-asteroid.contentSize.width/2, actualY)];
    
    //CCCallBlockN: The CCCallBlockN function allows us to specify a callback block to run when the action is performed. In this game, you’re going to set up this action to run after the monster goes offscreen to the left – and you’ll remove the monster from the layer when this occurs.
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
    }];
    
    //CCSequence: The CCSequence action allows us to chain together a sequence of actions that are performed in order, one at a time.
    [asteroid runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];

}

-(void) dealloc
{
    
    
    
    [super dealloc];
}

@end






