//
//  BatttleShips.h
//  Space7
//
//  Created by Karim Kawambwa on 10/5/13.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

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
