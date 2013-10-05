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

@interface BigDog : BatttleShips
@end

@interface MadDog : BatttleShips
@end

@interface Annialator : BatttleShips
@end

@interface Ridiculous : BatttleShips
@end
