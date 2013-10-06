//
//  HighscoresMainLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-09-26.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "HighscoresMainLayer.h"
#import "MenuSceneLayer.h"


@implementation HighscoresMainLayer

+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    HighscoresMainLayer* highscoresMainLayer = [HighscoresMainLayer node];
    
    CCSprite * background = [CCSprite spriteWithFile:@"gameSceneBackground.png"];
    
    background.anchorPoint= ccp(0,0);
    
    [highscoresMainLayer addChild:background z:-1];
    
    [scene addChild: highscoresMainLayer];
    
    return scene;
    
}


- (id) init
{
    if(self=[super init])
    {
        self.touchEnabled =YES;
        
        dText= [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 430, 270)];
        
        dText.text = @"1)Si Te Feng -- 5000\n2)Si Te Feng -- 2400\n";
        
        [dText setEditable:NO];
        
        dText.font = [UIFont fontWithName:@"Helvetica" size:18];
        
        dText.backgroundColor = [UIColor clearColor];
        
        dText.textColor = [UIColor whiteColor];
        
        [[[CCDirector sharedDirector] view] addSubview:dText];
        
        
        //Creating the tappable 3 Icons on the right side
        CCMenuItemImage *facebookIcon = [CCMenuItemImage itemWithNormalImage:@"FacebookIconNormal.png" selectedImage:@"FacebookIconPressed.png" target:self selector:@selector(facebookIconPressed)];
        
        [facebookIcon setScale:0.8];
        
        CCMenuItemImage *closeIcon = [CCMenuItemImage itemWithNormalImage:@"closeIcon.png" selectedImage:@"facebookIcon.png" target:self selector:@selector(closeIconPressed)];
        [closeIcon setScale:2];
        
        CCMenu *iconsMenu = [CCMenu menuWithItems: facebookIcon, closeIcon, nil];
        
        iconsMenu.position = CGPointMake(504, 160);
        
        [iconsMenu alignItemsVerticallyWithPadding:40];
        
        [self addChild:iconsMenu z:1];
        
        //Creating the Title of the scene and display on the top
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"-Highscores-" fontName:@"Marker Felt" fontSize:44];
        title.color = ccc3(255,255,255);
        
        title.anchorPoint = ccp(0,0);
        title.position = ccp(140,270);
        
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
