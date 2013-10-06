//
//  GameSceneLayer.h
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "BatttleShips.h"


@interface GameSceneLayer : CCLayer {
    
    float global_x;
    float global_y;
    
}


@property (nonatomic, retain) BatttleShips *mySpaceship;
@property (nonatomic, retain) CCSprite *target;
@property (nonatomic, retain) NSMutableArray *_asteroids;
@property (nonatomic, retain) NSMutableArray *_projectiles;
@property (nonatomic, retain) NSMutableArray *_stars;

@property (nonatomic, strong) CCSprite *boom;
@property (nonatomic, strong) CCAction *blowupAction;



- (void)fire;
- (void)starParallax: (ccTime)deltaTime velocity: (CGPoint)velocity;
- (void)asteroidParallax: (ccTime)deltaTime velocity: (CGPoint)velocity;

+(CCScene*) scene;




@end
