//
//  BatttleShips.h
//  Space7
//
//  Created by Karim Kawambwa on 10/5/13.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum { //Karim Kawambwa  asteroid types enumeration. Used to tage the asteroids to know the type
    
    _Geronimo = 1000,
    _Hyperion,
    _Annihilator,
    _Prometheus
    
}battleShipType;

@interface BatttleShips : CCSprite {
    
}

@property (nonatomic, assign) int hp;

- (id)initWithFile:(NSString *)file hp:(int)hp;

@end

@interface Geronimo : BatttleShips
@end

@interface Hyperion : BatttleShips
@end

@interface Annihilator : BatttleShips
@end

@interface Prometheus : BatttleShips
@end
