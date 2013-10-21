//
//  Asteroid.h
//  Space7
//
//  Created by Karim Kawambwa on 10/5/13.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum { //Karim Kawambwa  asteroid types enumeration. Used to tage the asteroids to know the type
    
    WeakAstroid = 1000,
    MedWeakAstroid,
    MedStrongAstroid,
    StrongAstroid
    
}asteroidTypes;

@interface Asteroid : CCSprite {
    
}

@property (nonatomic, assign) int hp;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int minMoveDuration;
@property (nonatomic, assign) int maxMoveDuration;

- (id)initWithFile:(NSString *)file hp:(int)hp minMoveDuration:(int)minMoveDuration maxMoveDuration:(int)maxMoveDuration type:(int) astoType;

@end

@interface MedWeakAsteroid : Asteroid
@end

@interface MedStrongAsteroid : Asteroid
@end

@interface WeakAsteroid : Asteroid
@end

@interface StrongAsteroid : Asteroid
@end