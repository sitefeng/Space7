//
//  GameSceneDisplayLayer.h
//  Space7
//
//  Created by Si Te Feng on 2013-10-05.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameSceneDisplayLayer : CCLayer {
    
    unsigned int gameScore;
    unsigned int enemiesKilled;
    
}

@property (nonatomic, assign) unsigned int gameScore;
@property (nonatomic, assign) unsigned int enemiesKilled;

@property (nonatomic, retain) CCProgressTimer* energyBar;
@property (nonatomic, retain) CCProgressTimer* healthBar;

@property (nonatomic, retain) CCLabelTTF* gameScoreValueLabel;
@property (nonatomic, retain) CCLabelTTF* enemiesKilledValueLabel;




- (void)updateHealth: (float)newhealth;




@end
