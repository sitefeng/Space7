//
//  AboutSceneMainLayer.h
//  Space7
//
//  Created by Si Te Feng on 2013-10-04.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>


@interface AboutSceneMainLayer : CCLayer <UITextViewDelegate, MFMailComposeViewControllerDelegate, UIScrollViewDelegate>
{
    UITextView *dText;
    
    NSTimer* _mainLoopTimer;
    
    
}

+(CCScene *) scene;

@end
