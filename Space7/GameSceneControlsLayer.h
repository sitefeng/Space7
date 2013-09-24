//
//  GameSceneControlsLayer.h
//  Space7
//
//  Created by Si Te Feng on 2013-09-23.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

@interface GameSceneControlsLayer : CCLayer {
    
    SneakyJoystick *myJoystick;
    
}



+(CCScene*) scene;





@end
