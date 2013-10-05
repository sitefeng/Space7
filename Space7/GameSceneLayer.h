//
//  GameSceneLayer.h
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//


@interface GameSceneLayer : CCLayer {
    
    UIView *starsView;
}


@property (nonatomic, retain) CCSprite *mySpaceship;
@property (nonatomic, retain) CCSprite *target;


+(CCScene*) scene;




@end
