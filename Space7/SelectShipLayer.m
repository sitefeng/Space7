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

#import "ApplicationConstants.c"


#define kTitleTag 33
#define kShipChoiceMenuTag 34

#define kShipIconTag 35
#define kShipCheckMarkTag 36

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
        
        CCLabelBMFont* title = [CCLabelBMFont labelWithString:@"SELECT YOUR SPACESHIP" fntFile:@"spaceshipNameFont.fnt"];
        
        title.position = ccp(kWinSize.width/2.0, -10);
        
        [self addChild:title z:3 tag:kTitleTag];
        
        
        CCMenuItemImage *geronimoImage = [CCMenuItemImage itemWithNormalImage:@"geronimoNormal.png" selectedImage:@"geronimoPressed.png" target:self selector:@selector(getGeronimo)];
        
        CCMenuItemImage *hyperionImage = [CCMenuItemImage itemWithNormalImage:@"hyperionNormal.png" selectedImage:@"hyperionPressed.png" target:self selector:@selector(getHyperion)];
        
        CCMenuItemImage *annihilatorImage = [CCMenuItemImage itemWithNormalImage:@"annihilatorNormal.png" selectedImage:@"annihilatorPressed.png" target:self selector:@selector(getAnnihilator)];
        
        CCMenuItemImage *prometheusImage = [CCMenuItemImage itemWithNormalImage:@"prometheusNormal.png" selectedImage:@"prometheusPressed.png" target:self selector:@selector(getPrometheus)];
        
        CCMenu *shipChoiceMenu = [CCMenu menuWithItems:geronimoImage, hyperionImage,annihilatorImage, prometheusImage, nil];
        
        shipChoiceMenu.position = ccp(kWinSize.width/2.0, kWinSize.height/2.0-20);//-110
        
        [shipChoiceMenu alignItemsVerticallyWithPadding:20];
        
        [self addChild:shipChoiceMenu z:2 tag:kShipChoiceMenuTag];
        
        
        CCMenuItemImage *image1 = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector:@selector(ship1IconToggle)];
        
        CCMenuItemImage *image2 = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector:@selector(ship2IconToggle)];
        
        CCMenuItemImage *image3 = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector:@selector(ship3IconToggle)];
        
        CCMenuItemImage *image4 = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector:@selector(ship4IconToggle)];
        
        CCMenu *shipIconToggleMenu = [CCMenu menuWithItems:image1, image2, image3, image4, nil];
        
        shipIconToggleMenu.anchorPoint= ccp(1.0f, 0.5f);
        
        shipIconToggleMenu.position = ccp(kWinSize.width/2.0 - 140, kWinSize.height/2.0-20);
        
        [shipIconToggleMenu alignItemsVerticallyWithPadding:15];
        
        [self addChild:shipIconToggleMenu z:3 tag:kShipIconTag];
        
//        
//        CCSprite* shipCheckMarkSpriteNormal1;
//        CCSprite* shipCheckMarkSpriteNormal2;
//        CCSprite* shipCheckMarkSpriteNormal3;
//        CCSprite* shipCheckMarkSpriteNormal4;
//        CCSprite* shipCheckMarkSpritePressed1;
//        CCSprite* shipCheckMarkSpritePressed2;
//        CCSprite* shipCheckMarkSpritePressed3;
//        CCSprite* shipCheckMarkSpritePressed4;
//        
//        
//        shipCheckMarkSpriteNormal1 = shipCheckMarkSpriteNormal1 = shipCheckMarkSpriteNormal2= shipCheckMarkSpriteNormal3=shipCheckMarkSpriteNormal4 = [CCSprite spriteWithFile:@"shipPreviewNormal.png"];
//        [shipCheckMarkSpriteNormal1 setFlipX:YES];
//        [shipCheckMarkSpriteNormal2 setFlipX:YES];
//        [shipCheckMarkSpriteNormal4 setFlipX:YES];
//        [shipCheckMarkSpriteNormal3 setFlipX:YES];
//        
//        shipCheckMarkSpritePressed1 = shipCheckMarkSpritePressed1 = shipCheckMarkSpritePressed2 = shipCheckMarkSpritePressed3 = shipCheckMarkSpritePressed4 = [CCSprite spriteWithFile:@"shipPreviewPressed.png"];
//        [shipCheckMarkSpritePressed1 setFlipX:YES];
//        [shipCheckMarkSpritePressed2 setFlipX:YES];
//        [shipCheckMarkSpritePressed3 setFlipX:YES];
//        [shipCheckMarkSpritePressed4 setFlipX:YES];
        
        
        CCMenuItemImage *imageA = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(shipACheckMark)];
        CCMenuItemImage *imageB = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(shipBCheckMark)];
        CCMenuItemImage *imageC = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(shipCCheckMark)];
        CCMenuItemImage *imageD = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(shipDCheckMark)];
        
        
        CCMenu *shipCheckMarkMenu = [CCMenu menuWithItems:imageA, imageB, imageC, imageD, nil];
        
        shipCheckMarkMenu.contentSize = CGSizeZero;
        
        [shipCheckMarkMenu setRotation:180];
        
        shipCheckMarkMenu.anchorPoint = ccp(0, 0.5f);
        
        shipCheckMarkMenu.position = ccp(kWinSize.width/2.0 +140, kWinSize.height/2.0 -20);//+140 -20
        
        [shipCheckMarkMenu alignItemsVerticallyWithPadding:15];
        
        [self addChild:shipCheckMarkMenu z:4 tag:kShipCheckMarkTag];
        
        
        
        
        
        
        
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"selectScene.mp3"];

    }
    
    return self;
    
}

- (void) rightPlacesForItems
{
    
    //title.position = ccp(kWinSize.width/2.0, kWinSize.height/2.0 +120);
    //shipChoiceMenu.position = ccp(kWinSize.width/2.0, kWinSize.height/2.0-30);
    
    
    
}










- (void)getGeronimo{
    
    //[[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    [[self controller] setShipToStart:_Geronimo];
    [[CCDirector sharedDirector] replaceScene: [GameSceneLayer scene]];
    
}



- (void)getHyperion{
    //[[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    [[self controller] setShipToStart:_Hyperion];
    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
}

- (void)getAnnihilator{
    //[[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    [[self controller] setShipToStart:_Annihilator];
    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
}

- (void)getPrometheus{
    
    //[[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    [[[UIAlertView alloc] initWithTitle:@"Coming Soon" message:@"Each app update will being in a new exotic spaceship. Stay tuned!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    
    
    
//    [[self controller] setShipToStart:_Prometheus];
//    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
}


- (void)ship1IconToggle
{
    
    
    
}



- (void)ship2IconToggle
{
    
    
    
}




- (void)ship3IconToggle
{
    
    
    
}



- (void)ship4IconToggle
{
    
    
    
}



-(void) shipACheckMark
{
    
    
    
}


-(void) shipBCheckMark
{
    
    
    
}


-(void) shipCCheckMark
{
    
    
    
}


-(void) shipDCheckMark
{
    
    
    
}


- (AppController *) controller
{
    AppController *app = [UIApplication sharedApplication].delegate;
    return app;
}



@end
