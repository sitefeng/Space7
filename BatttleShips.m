//
//  BatttleShips.m
//  Space7
//
//  Created by Karim Kawambwa on 10/5/13.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "BatttleShips.h"


@implementation BatttleShips

- (id)initWithFile:(NSString *)file hp:(int)hp  {
    if ((self = [super initWithFile:file])) {
        self.hp = hp;
    }
    return self;
}

@end

@implementation Geronimo

- (id)init {
    if ((self = [super initWithFile:@"ship1.png" hp:100 ])) {
    }
    return self;
}

@end

@implementation Hyperion

- (id)init {
    if ((self = [super initWithFile:@"ship2.png" hp:100 ])) {
    }
    return self;
}

@end

@implementation Annihilator

- (id)init {
    if ((self = [super initWithFile:@"ship4.png" hp:100 ])) {
    }
    return self;
}

@end

@implementation Prometheus

- (id)init {
    if ((self = [super initWithFile:@"ship4.png" hp:100 ])) {
    }
    return self;
}

@end
