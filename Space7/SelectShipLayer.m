//
//  SelectShipLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-05.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "SelectShipLayer.h"
#import "GameSceneLayer.h"
#import "BatttleShips.h"
#import "AppDelegate.h"
#import "AnimatedCloudBackground.h"

@implementation SelectShipLayer
+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    SelectShipLayer* selectShipLayer = [SelectShipLayer node];
    
    AnimatedCloudBackground* animatedBackground = [AnimatedCloudBackground node];
    
    [selectShipLayer addChild: animatedBackground z:-1];
    
    [scene addChild: selectShipLayer];
    
    return scene;

    
}


- (id) init
{
    if(self=[super init])
    {
        self.touchEnabled =YES;
        
        CCLabelTTF* title = [CCLabelTTF labelWithString:@"Please choose your spaceship" fontName:@"Marker Felt" fontSize:45];
        
        CGSize winsize = [[CCDirector sharedDirector] winSize];
        
        title.position = ccp(winsize.width/2.0, winsize.height/2.0 +120);
        
        [self addChild:title];
        
        CCMenuItemLabel *geronimoLabel = [CCMenuItemLabel itemWithLabel:[CCLabelBMFont labelWithString:@"Geronimo" fntFile:@"spaceshipNameFont.fnt"] target:self selector:@selector(getGeronimo)];
        CCMenuItemLabel *hyperionLabel = [CCMenuItemLabel itemWithLabel:[CCLabelBMFont labelWithString:@"Hyperion" fntFile:@"spaceshipNameFont.fnt"]target:self selector:@selector(getHyperion)];
        CCMenuItemLabel *annihilatorLabel = [CCMenuItemLabel itemWithLabel:[CCLabelBMFont labelWithString:@"Annihilator" fntFile:@"spaceshipNameFont.fnt"]target:self selector:@selector(getAnnihilator)];
        //CCMenuItemLabel *prometheusLabel = [CCMenuItemLabel itemWithLabel:[CCLabelBMFont labelWithString:@"Prometheus" fntFile:@"spaceshipNameFont.fnt"]target:self selector:@selector(getPrometheus)];
        
        CCMenu *shipChoiceMenu = [CCMenu menuWithItems:geronimoLabel,hyperionLabel,annihilatorLabel, nil];
        
        shipChoiceMenu.position = ccp(winsize.width/2.0, winsize.height/2.0-30);
        
        [shipChoiceMenu alignItemsVerticallyWithPadding:20];
        
        
        [self addChild:shipChoiceMenu];
        
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"selectScene.mp3"];
        
        
    }
    
    return self;
    
}


- (void)getGeronimo{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    [[self controller] setShipToStart:_Geronimo];
    [[CCDirector sharedDirector] replaceScene: [GameSceneLayer scene]];
    
}



- (void)getHyperion{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    [[self controller] setShipToStart:_Hyperion];
    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
}

- (void)getAnnihilator{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    [[self controller] setShipToStart:_Annihilator];
    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
}

- (void)getPrometheus{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    [[self controller] setShipToStart:_Prometheus];
    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
}

- (AppController *) controller
{
    AppController *app = [UIApplication sharedApplication].delegate;
    return app;
}


@end
