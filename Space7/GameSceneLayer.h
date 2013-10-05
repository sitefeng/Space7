//
//  GameSceneLayer.h
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//


@interface GameSceneLayer : CCLayer {
    
    UIView *starsView;
    float global_x;
    float global_y;
}


@property (nonatomic, retain) CCSprite *mySpaceship;
@property (nonatomic, retain) CCSprite *target;
@property (nonatomic, retain) NSMutableArray *_asteroids;
@property (nonatomic, retain) NSMutableArray *_projectiles;

- (void)fire;

+(CCScene*) scene;




@end
