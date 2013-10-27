//
//  Asteroid.m
//  Space7
//
//  Created by Karim Kawambwa on 10/5/13.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "Asteroid.h"


@implementation Asteroid

- (id)initWithFile:(NSString *)file hp:(int)hp minMoveDuration:(int)minMoveDuration maxMoveDuration:(int)maxMoveDuration type:(int)astoType {
    if ((self = [super initWithFile:file])) {
        self.hp = hp;
        self.minMoveDuration = minMoveDuration;
        self.maxMoveDuration = maxMoveDuration;
        self.type = astoType;
    }
    return self;
}

@end

@implementation MedWeakAsteroid

- (id)init {
    if ((self = [super initWithFile:@"blueroid.png" hp:2 minMoveDuration:4 maxMoveDuration:7 type: MedWeakAstroid])) {
    }
    return self;
}

@end

@implementation MedStrongAsteroid

- (id)init {
    if ((self = [super initWithFile:@"yellowroid.png" hp:3 minMoveDuration:5 maxMoveDuration:9 type: MedStrongAstroid])) {
    }
    return self;
}

@end

@implementation WeakAsteroid

- (id)init {
    if ((self = [super initWithFile:@"greenroid.png" hp:1 minMoveDuration:2 maxMoveDuration:5 type: WeakAstroid])) {
    }
    return self;
}

@end

@implementation StrongAsteroid

- (id)init {
    if ((self = [super initWithFile:@"redroid.png" hp:4 minMoveDuration:5 maxMoveDuration:12 type: StrongAstroid])) {
    }
    return self;
}

@end
