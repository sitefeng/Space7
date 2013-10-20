//
//  SelectShipLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-05.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "MenuSceneLayer.h"

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

#define kSelectCrystalTag 37


enum {
    kShipIcon1Tag = 137,
    kShipIcon2Tag,
    kShipIcon3Tag,
    kShipIcon4Tag,
    };

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
        
        title.position = ccp(kWinSize.width/2.0, kWinSize.height + 10);
        
        [self addChild:title z:6 tag:kTitleTag];
        
        
        CCMenuItemImage *geronimoImage = [CCMenuItemImage itemWithNormalImage:@"geronimoNormal.png" selectedImage:@"geronimoPressed.png" target:self selector:@selector(getGeronimo)];
        
        CCMenuItemImage *hyperionImage = [CCMenuItemImage itemWithNormalImage:@"hyperionNormal.png" selectedImage:@"hyperionPressed.png" target:self selector:@selector(getHyperion)];
        
        CCMenuItemImage *annihilatorImage = [CCMenuItemImage itemWithNormalImage:@"annihilatorNormal.png" selectedImage:@"annihilatorPressed.png" target:self selector:@selector(getAnnihilator)];
        
        CCMenuItemImage *prometheusImage = [CCMenuItemImage itemWithNormalImage:@"prometheusNormal.png" selectedImage:@"prometheusPressed.png" target:self selector:@selector(getPrometheus)];
        
        CCMenu *shipChoiceMenu = [CCMenu menuWithItems:geronimoImage, hyperionImage,annihilatorImage, prometheusImage, nil];
        
        shipChoiceMenu.position = ccp(kWinSize.width/2.0, kWinSize.height/2.0-400);//-200
        
        [shipChoiceMenu alignItemsVerticallyWithPadding:20];//20
        
        [shipChoiceMenu setEnabled:NO];
        
        [self addChild:shipChoiceMenu z:5 tag:kShipChoiceMenuTag];
        
        
        
        CCMenuItemImage *image1 = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector:@selector(ship1IconToggle)];
        CCMenuItemImage *image2 = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector:@selector(ship2IconToggle)];
        CCMenuItemImage *image3 = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector:@selector(ship3IconToggle)];
        CCMenuItemImage *image4 = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector:@selector(ship4IconToggle)];
        
        CCMenu *shipIconToggleMenu = [CCMenu menuWithItems:image1, image2, image3, image4, nil];
        
        shipIconToggleMenu.anchorPoint= ccp(1.0f, 0.5f);
        
        shipIconToggleMenu.position = ccp(kWinSize.width/2.0 +15, kWinSize.height/2.0-400);
        
        [shipIconToggleMenu alignItemsVerticallyWithPadding:15];//15
        
        [shipIconToggleMenu setEnabled:NO];
        
        [self addChild:shipIconToggleMenu z:3 tag:kShipIconTag];
        
        
        CCMenuItemImage *imageA = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(shipDCheckMark)];
        CCMenuItemImage *imageB = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(shipCCheckMark)];
        CCMenuItemImage *imageC = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(shipBCheckMark)];
        CCMenuItemImage *imageD = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(shipACheckMark)];
        
        
        CCMenu *shipCheckMarkMenu = [CCMenu menuWithItems:imageA, imageB, imageC, imageD, nil];
        
        shipCheckMarkMenu.contentSize = CGSizeZero;
        
        [shipCheckMarkMenu setRotation:180];
        
        shipCheckMarkMenu.anchorPoint = ccp(0, 0.5f);
        
        shipCheckMarkMenu.position = ccp(kWinSize.width/2.0 -15, kWinSize.height/2.0 -400);//+140 -20
        
        [shipCheckMarkMenu alignItemsVerticallyWithPadding:15];//15
        
        [shipCheckMarkMenu setEnabled:NO];
        
        [self addChild:shipCheckMarkMenu z:4 tag:kShipCheckMarkTag];
        
        
        
        
        
        
        
        
        
        
        
        CCSprite* selectCrystal = [CCSprite spriteWithFile:@"selectCrystal.png"];
        
        selectCrystal.position = ccp(kWinSize.width/2.0, -20);
        
        [selectCrystal setScale:0.01];
        
        CCRotateBy* rotateCrystal = [CCRotateBy actionWithDuration:1 angle:120];
        
        CCRepeat* repeatRotation = [CCRepeat actionWithAction:rotateCrystal times:kCCRepeatForever];
        
        [selectCrystal runAction:repeatRotation];
        
        [self addChild:selectCrystal z:1 tag:kSelectCrystalTag];
        
        
        
        //Start the Animations
        CCMoveTo* moveTitle = [CCMoveTo actionWithDuration:1 position:ccp(kWinSize.width/2.0, kWinSize.height/2.0 +120)];
        CCEaseBounceOut * bounceMove = [CCEaseBounceOut actionWithAction:moveTitle];
        
        [[self getChildByTag:kTitleTag] runAction:bounceMove];
        
        
        
        
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"selectScene.mp3"];
        
        [self scheduleOnce:@selector(presentShipSelection) delay:0];
        
        

    }
    
    return self;
    
}

- (void)rotateShipIcon
{
    CCRotateBy* rotateBy1= [CCRotateBy actionWithDuration:0.1 angle:12];
    CCRotateBy* rotateBy2= [CCRotateBy actionWithDuration:0.1 angle:12];
    CCRotateBy* rotateBy3= [CCRotateBy actionWithDuration:0.1 angle:12];
    CCRotateBy* rotateBy4= [CCRotateBy actionWithDuration:0.1 angle:12];
    
    
    [[self getChildByTag: kShipIcon1Tag] runAction:rotateBy1];
    [[self getChildByTag: kShipIcon2Tag] runAction:rotateBy2];
    [[self getChildByTag: kShipIcon3Tag] runAction:rotateBy3];
    [[self getChildByTag: kShipIcon4Tag] runAction:rotateBy4];
    
}



- (void)getGeronimo{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    [[self controller] setShipToStart:_Geronimo];
    [[CCDirector sharedDirector] replaceScene: [GameSceneLayer scene]];
    
}


- (void)getHyperion{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    [[self controller] setShipToStart:_Hyperion];
    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
}

- (void)getAnnihilator{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    [[self controller] setShipToStart:_Annihilator];
    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
}

- (void)getPrometheus{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    [[[UIAlertView alloc] initWithTitle:@"Coming Soon" message:@"Each app update will bring in a new exotic spaceship. Stay tuned!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    
    
    
//    [[self controller] setShipToStart:_Prometheus];
//    [[CCDirector sharedDirector] replaceScene:[GameSceneLayer scene]];
}



- (void)presentShipSelection
{
    
    CCMoveTo *moveMenuItems = [CCMoveTo actionWithDuration:1 position:ccp(kWinSize.width/2.0, kWinSize.height/2.0-30)];
    
//    CCEaseExponentialOut* elasticizeMenu = [CCEaseExponentialOut actionWithAction:moveMenuItems];
    
    [[self getChildByTag:kShipChoiceMenuTag] runAction:moveMenuItems];

    
//    CCMoveTo* moveShipIconMenu = [CCMoveTo actionWithDuration:1 position:ccp(kWinSize.width/2.0 +15 , kWinSize.height/2.0 - 40)];
//    
////    CCEaseExponentialOut* elasticizeMoveShipIcon = [CCEaseExponentialOut actionWithAction:moveShipIconMenu];
//    
//    [[self getChildByTag:kShipIconTag] runAction: moveShipIconMenu];
//    
//
//    CCMoveTo* moveShipCheckMarkMenu = [CCMoveTo actionWithDuration:1 position:ccp(kWinSize.width/2.0 -15 , kWinSize.height/2.0- 40) ];
//    
////    CCEaseExponentialOut* elasticizeShipChoice = [CCEaseExponentialOut actionWithAction:moveShipChoiceMenu];
//    
//    [[self getChildByTag:kShipCheckMarkTag] runAction:moveShipCheckMarkMenu];
    
    
    [self scheduleOnce:@selector(revealExtensions) delay:1];
    
    
}


- (void)revealExtensions
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"extend.mp3"];
    
    CCMoveTo* moveShipIconMenu = [CCMoveTo actionWithDuration:1 position:ccp(kWinSize.width/2.0 - 140, kWinSize.height/2.0 - 30)];
    
    CCEaseExponentialOut* elasticizeMoveShipIcon = [CCEaseExponentialOut actionWithAction:moveShipIconMenu];
    
    [[self getChildByTag:kShipIconTag] runAction: elasticizeMoveShipIcon];
    

    CCMoveTo* moveShipChoiceMenu = [CCMoveTo actionWithDuration:1 position:ccp(kWinSize.width/2.0+140, kWinSize.height/2.0-30) ];
    CCEaseExponentialOut* elasticizeShipChoice = [CCEaseExponentialOut actionWithAction:moveShipChoiceMenu];
    
    [[self getChildByTag:kShipCheckMarkTag] runAction:elasticizeShipChoice];
    
    

    
    
    
    
    [self scheduleOnce:@selector(showNextButton) delay:1];
    
}



- (void)showNextButton
{
    // Now Enable the tappable Menus
    [(CCMenu*)[self getChildByTag:kShipChoiceMenuTag] setEnabled: YES];
    [(CCMenu*)[self getChildByTag:kShipIconTag] setEnabled: YES];
    [(CCMenu*)[self getChildByTag:kShipCheckMarkTag] setEnabled: YES];
    
    
    //Initiating the ship icons
    CCSprite* ship1 = [CCSprite spriteWithFile:@"ship1.png"];
    CCSprite* ship2 = [CCSprite spriteWithFile:@"ship2.png"];
    CCSprite* ship3 = [CCSprite spriteWithFile:@"ship3.png"];
    CCSprite* ship4 = [CCSprite spriteWithFile:@"ship4.png"];
    
    [ship4 setRotation:90];
    [ship1 setScale:0.01];
    [ship2 setScale:0.01];
    [ship3 setScale:0.01];
    [ship4 setScale:0.01];
    
    [self schedule:@selector(rotateShipIcon) interval:0.1 repeat:kCCRepeatForever delay:0];

    
    //Displaying the ship icons
    CCScaleTo* scaleShip1 = [CCScaleTo actionWithDuration:0.5 scale:0.5];
    [ship1 setPosition:ccp(kWinSize.width/2 - 155, kWinSize.height/2 +69)];
    [ship1 runAction:scaleShip1];
    
    CCScaleTo* scaleShip2 = [CCScaleTo actionWithDuration:0.5 scale:0.5];
    [ship2 setPosition:ccp(kWinSize.width/2 - 155, kWinSize.height/2 +2)];
    [ship2 runAction:scaleShip2];
    
    CCScaleTo* scaleShip3 = [CCScaleTo actionWithDuration:0.5 scale:0.5];
    [ship3 setPosition:ccp(kWinSize.width/2 - 155, kWinSize.height/2 -62)];
    [ship3 runAction:scaleShip3];
    
    CCScaleTo* scaleShip4 = [CCScaleTo actionWithDuration:0.5 scale:0.5];
    [ship4 setPosition:ccp(kWinSize.width/2 - 155, kWinSize.height/2 -128)];
    [ship4 runAction:scaleShip4];
    

    
    [self addChild:ship1 z:1 tag: kShipIcon1Tag];
    [self addChild:ship2 z:1 tag: kShipIcon2Tag];
    [self addChild:ship3 z:1 tag: kShipIcon3Tag];
    [self addChild:ship4 z:1 tag: kShipIcon4Tag];
    
    
    ///////Show Next button and the Menu Button
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    
    CCMenuItemImage* menuItem;
    CGPoint positionToSet;
    CCMenu* returnMenu;
    
    
    if(IS_IPHONE_5)
    {
        menuItem = [CCMenuItemImage itemWithNormalImage:@"selectionMenuButtonNormal.png" selectedImage:@"selectionMenuButtonPressed.png" target:self selector:@selector(returnToMenu)];
        returnMenu = [CCMenu menuWithItems:menuItem, nil];
        [returnMenu setPosition:ccp(-0.5 * menuItem.contentSize.width, menuItem.contentSize.height/2)];
        
        positionToSet = ccp(menuItem.contentSize.width/2, menuItem.contentSize.height/2);
    }
    else if(IS_IPHONE_4)
    {
        menuItem = [CCMenuItemImage itemWithNormalImage:@"selectionMenuButtonNormaliPhone4.png" selectedImage:@"selectionMenuButtonPressediPhone4.png" target:self selector:@selector(returnToMenu)];
        returnMenu = [CCMenu menuWithItems:menuItem, nil];
        [returnMenu setPosition:ccp(-0.5 * menuItem.contentSize.width, kWinSize.height - menuItem.contentSize.height/2)];
        
        positionToSet = ccp(menuItem.contentSize.width/2, kWinSize.height - menuItem.contentSize.height/2);
    }
    else
    {
        menuItem = [CCMenuItemImage itemWithNormalImage:@"selectionMenuButtonNormal.png" selectedImage:@"selectionMenuButtonPressed.png" target:self selector:@selector(returnToMenu)];
        returnMenu = [CCMenu menuWithItems:menuItem, nil];
        [returnMenu setPosition:ccp(-0.5 * menuItem.contentSize.width, menuItem.contentSize.height/2)];
        
        positionToSet = ccp(menuItem.contentSize.width/2, menuItem.contentSize.height/2);
    }

    [self addChild:returnMenu];
    
    CCMoveTo* moveReturnMenu = [CCMoveTo actionWithDuration:1 position:positionToSet];

    [returnMenu runAction:moveReturnMenu];
    
    //Setting the Nexts button now
    CCMenuItemImage* nextItem;
    CGPoint positionToSet2;
    CCMenu* nextButton;
    
    if(IS_IPHONE_5)
    {
        nextItem = [CCMenuItemImage itemWithNormalImage:@"selectionNextButtonNormal.png" selectedImage:@"selectionNextButtonPressed.png" target:self selector:@selector(moveToNext)];
        nextButton = [CCMenu menuWithItems:nextItem, nil];
        [nextButton setPosition:ccp(kWinSize.width + nextItem.contentSize.width / 2 , nextItem.contentSize.height/2)];
        
        positionToSet2 = ccp(kWinSize.width - nextItem.contentSize.width/2, nextItem.contentSize.height/2);
    }
    else if(IS_IPHONE_4)
    {
        nextItem = [CCMenuItemImage itemWithNormalImage:@"selectionNextButtonNormaliPhone4.png" selectedImage:@"selectionNextButtonPressediPhone4.png" target:self selector:@selector(moveToNext)];
        nextButton = [CCMenu menuWithItems:nextItem, nil];
        [nextButton setPosition:ccp(kWinSize.width + nextItem.contentSize.width / 2 , kWinSize.height - nextItem.contentSize.height/2)];
        
        positionToSet2 = ccp(kWinSize.width - nextItem.contentSize.width/2, kWinSize.height - nextItem.contentSize.height/2);

    }
    else
    {
        nextItem = [CCMenuItemImage itemWithNormalImage:@"selectionNextButtonNormal.png" selectedImage:@"selectionNextButtonPressed.png" target:self selector:@selector(moveToNext)];
        nextButton = [CCMenu menuWithItems:nextItem, nil];
    [nextButton setPosition:ccp(kWinSize.width + nextItem.contentSize.width / 2 , nextItem.contentSize.height/2)];
    
    positionToSet2 = ccp(kWinSize.width - nextItem.contentSize.width/2, nextItem.contentSize.height/2);
        
    }

    [self addChild:nextButton];
    CCMoveTo* moveNextButton = [CCMoveTo actionWithDuration:1 position:positionToSet2];
    
    [nextButton runAction:moveNextButton];
    
    
}



- (void)returnToMenu
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    
    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];
    
}


- (void)moveToNext
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    
    
}





- (void)ship1IconToggle
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"previewSpaceship.mp3"];
    
}



- (void)ship2IconToggle
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"previewSpaceship.mp3"];
    
    
}




- (void)ship3IconToggle
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"previewSpaceship.mp3"];
    
    
}



- (void)ship4IconToggle
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"previewSpaceship.mp3"];
    
    
}



-(void) shipACheckMark
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"selectSpaceship.mp3"];
    
    CCSprite* crystalSprite =(CCSprite*)[self getChildByTag:kSelectCrystalTag];
    [crystalSprite setScale:0.01];
    CCScaleTo* scaleCrystal = [CCScaleTo actionWithDuration:3 scale:1];
    
    CCEaseExponentialOut* easeScale = [CCEaseExponentialOut actionWithAction:scaleCrystal];

    [crystalSprite runAction:easeScale];
    
    [crystalSprite setPosition:ccp(kWinSize.width/2 + 155, kWinSize.height/2 +69)];
    
}


-(void) shipBCheckMark
{
    CCSprite* crystalSprite =(CCSprite*)[self getChildByTag:kSelectCrystalTag];
    [crystalSprite setScale:0.01];
    
    [self shipACheckMark];
    
    
    [crystalSprite setPosition:ccp(kWinSize.width/2 + 155, kWinSize.height/2 +2)];
    
}


-(void) shipCCheckMark
{
    CCSprite* crystalSprite =(CCSprite*)[self getChildByTag:kSelectCrystalTag];
    [crystalSprite setScale:0.01];
    
    [self shipACheckMark];
    
    [crystalSprite setPosition:ccp(kWinSize.width/2 + 155, kWinSize.height/2 -62)];
    
}


-(void) shipDCheckMark
{
    CCSprite* crystalSprite =(CCSprite*)[self getChildByTag:kSelectCrystalTag];
    [crystalSprite setScale:0.01];
    
    [self shipACheckMark];
    
    [crystalSprite setPosition:ccp(kWinSize.width/2 + 155, kWinSize.height/2 -128)];
    
}












- (AppController *) controller
{
    AppController *app = [UIApplication sharedApplication].delegate;
    return app;
}



@end
