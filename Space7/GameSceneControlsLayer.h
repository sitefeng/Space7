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
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"

@interface GameSceneControlsLayer : CCLayer <UIAlertViewDelegate>
{
    
    SneakyJoystick *myJoystick;
    
    CGPoint _lastPosition;
    
}

@property (nonatomic, assign) float scaledVelocityX;

@property (nonatomic, assign) float scaledVelocityY;

@property (nonatomic, assign) BOOL accelerationMode;

@property (nonatomic, assign) BOOL joystickPosition;


@property (nonatomic, assign) BOOL alertViewIsShowing;

+(CCScene*) scene;
-(void) didPressPauseButton;


@end
