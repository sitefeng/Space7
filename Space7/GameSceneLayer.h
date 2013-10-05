//
//  GameSceneLayer.h
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

enum { //Karim Kawambwa  asteroid types enumeration. Used to tage the asteroids to know the type
    
    blueroid = 1000,
    greenroid,
    redroid,
    yellowroid
    
}asteroidTypes;

@interface GameSceneLayer : CCLayer {
    
    float global_x;
    float global_y;
    
}


@property (nonatomic, retain) CCSprite *mySpaceship;
@property (nonatomic, retain) CCSprite *target;
@property (nonatomic, retain) NSMutableArray *_asteroids;
@property (nonatomic, retain) NSMutableArray *_projectiles;
@property (nonatomic, retain) NSMutableArray *_stars;




- (void)fire;
- (void)starParallax: (ccTime)deltaTime velocity: (CGPoint)velocity;

+(CCScene*) scene;




@end
