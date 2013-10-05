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

@implementation BigDog

- (id)init {
    if ((self = [super initWithFile:@"ship1.png" hp:100 ])) {
    }
    return self;
}

@end

@implementation MadDog

- (id)init {
    if ((self = [super initWithFile:@"ship4.png" hp:100 ])) {
    }
    return self;
}

@end

@implementation Ridiculous

- (id)init {
    if ((self = [super initWithFile:@"ship4.png" hp:100 ])) {
    }
    return self;
}

@end

@implementation Annialator

- (id)init {
    if ((self = [super initWithFile:@"ship4.png" hp:100 ])) {
    }
    return self;
}

@end
