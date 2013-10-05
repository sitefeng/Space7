//
//  Asteroid.m
//  Space7
//
//  Created by Karim Kawambwa on 10/5/13.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "Asteroid.h"


@implementation Asteroid

- (id)initWithFile:(NSString *)file hp:(int)hp minMoveDuration:(int)minMoveDuration maxMoveDuration:(int)maxMoveDuration {
    if ((self = [super initWithFile:file])) {
        self.hp = hp;
        self.minMoveDuration = minMoveDuration;
        self.maxMoveDuration = maxMoveDuration;
    }
    return self;
}

@end

@implementation WeakAndFastAsteroid

- (id)init {
    if ((self = [super initWithFile:@"blueroid.png" hp:1 minMoveDuration:3 maxMoveDuration:5])) {
    }
    return self;
}

@end

@implementation StrongAndSlowAsteroid

- (id)init {
    if ((self = [super initWithFile:@"redroid.png" hp:3 minMoveDuration:6 maxMoveDuration:12])) {
    }
    return self;
}

@end
