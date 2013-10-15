//
//  GameOverLayer.h
//  Space7
//
//  Created by Si Te Feng on 2013-10-05.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>


@interface GameOverLayer : CCLayer <MFMailComposeViewControllerDelegate>
{
    
    CCMenuItemImage* _tryAgainItem;
    CCMenuItemImage* _mainMenuItem;
    
}


@property (nonatomic, assign) float gameScore;
@property (nonatomic, assign) unsigned int enemiesKilled;
@property (nonatomic, assign) float timeScore;







+(CCScene*) sceneWithGameScore: (float)score enemiesKilled: (unsigned int) enemies andTimeScore:(float)time;

@end
