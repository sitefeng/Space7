//
//  HighscoresMainLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-26.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "HighscoresMainLayer.h"
#import "MenuSceneLayer.h"

#import "AnimatedCloudBackground.h"
#import "AnimatedCloudCover.h"

#include "ApplicationConstants.c"

@implementation HighscoresMainLayer

+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    HighscoresMainLayer* highscoresMainLayer = [HighscoresMainLayer node];
    AnimatedCloudCover* cloudCover = [AnimatedCloudCover node];
    AnimatedCloudBackground* animatedBackground = [AnimatedCloudBackground node];
    
    [highscoresMainLayer addChild: animatedBackground z:-1];
    [highscoresMainLayer addChild: cloudCover z:2];
    [scene addChild: highscoresMainLayer];
    
    return scene;
    
}


- (id) init
{
    if(self=[super init])
    {
        self.touchEnabled =YES;
        
        if(IS_IPHONE_5)
        {
            dText= [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 430, 270)];
        }
        else
        {
            dText= [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 380, 270)];
        }
        
        
        dText.text = @"1)Si Te Feng -- 5000\n2)Si Te Feng -- 2400\n";
        
        [dText setEditable:NO];
        
        dText.font = [UIFont fontWithName:@"Helvetica" size:18];
        
        dText.backgroundColor = [UIColor clearColor];
        
        dText.textColor = [UIColor whiteColor];
        
        [[[CCDirector sharedDirector] view] addSubview:dText];
        
        
        //Creating the tappable 3 Icons on the right side
        CCMenuItemImage *facebookIcon = [CCMenuItemImage itemWithNormalImage:@"facebookIconNormal.png" selectedImage:@"facebookIconPressed.png" target:self selector:@selector(facebookIconPressed)];
        
        
        CCMenuItemImage *closeIcon = [CCMenuItemImage itemWithNormalImage:@"closeButtonNormal.png" selectedImage:@"closeButtonPressed.png" target:self selector:@selector(closeIconPressed)];
        
        CCMenu *iconsMenu = [CCMenu menuWithItems: facebookIcon, closeIcon, nil];
        
        if(IS_IPHONE_5)
        {
        iconsMenu.position = CGPointMake(504, 160);
        }
        else
        {
        iconsMenu.position = CGPointMake(430, 160);
        }
        
        
        [iconsMenu alignItemsVerticallyWithPadding:45];
        
        [self addChild:iconsMenu z:1];
        
        //Creating the Title of the scene and display on the top
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"-Highscores-" fontName:@"Marker Felt" fontSize:44];
        title.color = ccc3(255,255,255);
        
        title.anchorPoint = ccp(0,0);
        title.position = ccp(30,270);
        
        [self addChild:title];
        
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"about.mp3"];
        
    }
    
    return self;
}




-(void) closeIconPressed
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];
    
    [dText removeFromSuperview];
    
}

-(void) facebookIconPressed
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [exTextField resignFirstResponder];
    
    return YES;
    
    
}








@end
