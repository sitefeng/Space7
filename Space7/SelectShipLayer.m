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

#import "SelectShipBackgroundLayer.h"

#import "ApplicationConstants.c"


#define kTitleTag 33
#define kShipChoiceMenuTag 34

#define kShipIconTag 35
#define kShipCheckMarkTag 36

#define kSelectCrystalTag 37

#define kGlideMenuTag 38
#define kJoystickMenuTag 39
#define kNextButtonTag 40

#define kReturnMenuButtonTag 41
#define kBackMenuTag 42
#define kPlayMenuTag 43


#define kNicknameArraySize 27


enum {
    kShipIcon1Tag = 137,
    kShipIcon2Tag,
    kShipIcon3Tag,
    kShipIcon4Tag,
    };


@implementation SelectShipLayer
{
    CCLabelBMFont* _nickNameLabel;
    
    BOOL _glideMode;
    
    NSArray* _namesArray;
    NSInteger _shipSelected;
    BOOL _joystickPosition;
    
    int _selectedShipMenuItem;
    
}



+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    SelectShipLayer* selectShipLayer = [SelectShipLayer node];
    
    SelectShipBackgroundLayer* backgroundLayer = [SelectShipBackgroundLayer node];
    
    [scene addChild: selectShipLayer z:1 tag:1];
    [scene addChild: backgroundLayer z:0 tag:0];
    
    return scene;
}


- (id) init
{
    if(self=[super init])
    {
        self.touchEnabled =YES;
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"shipSelection.mp3" loop:YES];
        
        _glideMode = [[NSUserDefaults standardUserDefaults] boolForKey:@"glideMode"];
        _joystickPosition = [[NSUserDefaults standardUserDefaults] boolForKey:@"joystickPosition"];
        _selectedShipMenuItem =0;
        
        //Set up the _namesArray
        _namesArray = [[NSArray alloc] initWithObjects: @"Andy", @"Sam", @"Max", @"Sherry", @"Dennis", @"Eric", @"Jack", @"Wesley", @"Ben", @"Steven", @"Chris", @"Calvin", @"Colin", @"Aditya", @"Alex", @"David", @"Edison", @"Abs", @"Cary", @"Mike", @"Lisa", @"Alicia", @"Kathryn", @"Jessie", @"Taylor", @"Christina", @"Fiona", nil];
        
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
        
        
        CCMenuItemImage *imageA = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(getPrometheus)];
        CCMenuItemImage *imageB = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(getAnnihilator)];
        CCMenuItemImage *imageC = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(getHyperion)];
        CCMenuItemImage *imageD = [CCMenuItemImage itemWithNormalImage:@"shipPreviewNormal.png" selectedImage:@"shipPreviewPressed.png" target:self selector: @selector(getGeronimo)];
        
        
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
        
        
        //////////////////////////////////////////////
        //Start the Animations
        ///////////////////////////////////////////////////
        CCMoveTo* moveTitle = [CCMoveTo actionWithDuration:1.5 position:ccp(kWinSize.width/2.0, kWinSize.height/2.0 +133)];
        CCEaseBounceOut * bounceMove = [CCEaseBounceOut actionWithAction:moveTitle];
        
        [[self getChildByTag:kTitleTag] runAction:bounceMove];
        
        [self scheduleOnce:@selector(presentShipSelection) delay:0];
        [self scheduleOnce:@selector(revealExtensions) delay:1];
        [self scheduleOnce:@selector(showNextButton) delay:2];
        
        //Make sure the ship selection menu item keeps highlighting
        [self schedule:@selector(shipSelectionMenuKeepHighlight) interval:0.5];
        
        //////////////////////////////////////////////////////////////////
        //////////////////////////////////////
        //Init Second Display
        //////////////////////////////////////
        
        CCLabelBMFont* title2 = [CCLabelBMFont labelWithString:@"SETTINGS" fntFile:@"spaceshipNameFont.fnt"];
        [title2 setPosition:ccp(kWinSize.width/2.0, kWinSize.height/2.0 +133 - kWinSize.height)];
        
        [self addChild:title2];
        
        
        CCMenuItemImage* nicknameItem = [CCMenuItemImage itemWithNormalImage:@"selectionNicknameNormal.png" selectedImage:@"selectionNicknamePressed.png" target:self selector:@selector(shuffleNickname)];
        CCMenu* nicknameMenu = [CCMenu menuWithItems:nicknameItem, nil];
        [nicknameMenu setPosition:ccp(kWinSize.width/2.0, kWinSize.height/2.0 +70 - kWinSize.height)];
        
        CCSprite* nameFieldSprite = [CCSprite spriteWithFile:@"nameField.png"];
        [nameFieldSprite setPosition:ccp(kWinSize.width/2.0, kWinSize.height/2.0 + 28 - kWinSize.height)];
         
        [self addChild:nicknameMenu z:8];
        [self addChild:nameFieldSprite z:9];
        
        
        //Setting up the user nickname
        
        NSUInteger nameInteger = arc4random() % kNicknameArraySize;
        
        _nickNameLabel = [CCLabelBMFont labelWithString:[_namesArray objectAtIndex: nameInteger] fntFile:@"spaceshipNameFont.fnt"];
        [_nickNameLabel setPosition:ccp(kWinSize.width/2.0, kWinSize.height/2.0 + 29 - kWinSize.height)];
        
        [self addChild: _nickNameLabel z:10];
        
        
        CCSpriteBatchNode* indicatorBatch = [CCSpriteBatchNode batchNodeWithFile:@"indicator.png"];
        
        [self addChild:indicatorBatch];
        
        for(int i=0; i<5; i++)
        {
            CCSprite* indicator = [CCSprite spriteWithFile:@"indicator.png"];
            
            [indicator setPosition:ccp(kWinSize.width/2.0 + 60 - 30*i, kWinSize.height/2.0 - 15 - kWinSize.height)];
            
            [indicatorBatch addChild:indicator];
        }
        
        
        ////////////////////////////////
        //Toggles
        ////////////////////////////
        
        CCLabelBMFont* glideLabel = [CCLabelBMFont labelWithString:@"Glide\nMode" fntFile:@"spaceshipNameFont.fnt"];
        
        [glideLabel setPosition:ccp(kWinSize.width/2.0 - 75, kWinSize.height/2.0 - 57 - kWinSize.height)];
        
        [self addChild: glideLabel];
        
        CCLabelBMFont* joystickLabel = [CCLabelBMFont labelWithString:@"Joystick\nPosition" fntFile:@"spaceshipNameFont.fnt"];
        [joystickLabel setPosition:ccp(kWinSize.width/2.0 + 75, kWinSize.height/2.0 - 57 - kWinSize.height)];
        
        [self addChild: joystickLabel];
        
        
        CCMenuItemImage* onItem = [CCMenuItemImage itemWithNormalImage:@"selectionOnNormal.png" selectedImage:@"selectionOnPressed.png" target:self selector:@selector(onSwitch)];
        CCMenuItemImage* offItem = [CCMenuItemImage itemWithNormalImage:@"selectionOffNormal.png" selectedImage:@"selectionOffPressed.png" target:self selector:@selector(offSwitch)];
        
        [offItem selected];
        
        CCMenu* glideMenu = [CCMenu menuWithItems:onItem, offItem, nil];
        [glideMenu setPosition:ccp(kWinSize.width/2.0 - 75, kWinSize.height/2.0 - 120 - kWinSize.height)];
        
        [glideMenu alignItemsHorizontallyWithPadding:0];
        
        [self addChild:glideMenu z:12 tag:kGlideMenuTag];
        
        CCMenuItemImage* leftItem = [CCMenuItemImage itemWithNormalImage:@"selectionLeftNormal.png" selectedImage:@"selectionLeftPressed.png" target:self selector:@selector(leftSwitch)];
        CCMenuItemImage* rightItem = [CCMenuItemImage itemWithNormalImage:@"selectionRightNormal.png" selectedImage:@"selectionRightPressed.png" target:self selector:@selector(rightSwitch)];
        
        [leftItem selected];
        
        CCMenu* joystickMenu = [CCMenu menuWithItems:leftItem, rightItem, nil];
        [joystickMenu setPosition:ccp(kWinSize.width/2.0 + 75, kWinSize.height/2.0 - 120 - kWinSize.height)];
        
        [joystickMenu alignItemsHorizontallyWithPadding:0];
        
        [self addChild:joystickMenu z:11 tag: kJoystickMenuTag];
        
        
        //periodically check whether CCMenu highlight are deselected
        [self schedule:@selector(rehighlightMenu) interval:1 repeat:kCCRepeatForever delay:0];
        
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



- (void)presentShipSelection
{
    
    CCMoveTo *moveMenuItems = [CCMoveTo actionWithDuration:1 position:ccp(kWinSize.width/2.0, kWinSize.height/2.0-30)];
    
    [[self getChildByTag:kShipChoiceMenuTag] runAction:moveMenuItems];
    
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
    
}



- (void)showNextButton
{
    // Now Enable the tappable Menus
    [(CCMenu*)[self getChildByTag:kShipChoiceMenuTag] setEnabled: YES];
    [(CCMenu*)[self getChildByTag:kShipIconTag] setEnabled: YES];
    [(CCMenu*)[self getChildByTag:kShipCheckMarkTag] setEnabled: YES];
    
    
    //Initiating the ship icons that rotate
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

    
    //Displaying the ship icons that rotate
    CCScaleTo* scaleShip1 = [CCScaleTo actionWithDuration:0.5 scale:0.5];
    [ship1 setPosition:ccp(kWinSize.width/2.0 - 155, kWinSize.height/2.0 +69)];
    [ship1 runAction:scaleShip1];
    
    CCScaleTo* scaleShip2 = [CCScaleTo actionWithDuration:0.5 scale:0.5];
    [ship2 setPosition:ccp(kWinSize.width/2.0 - 155, kWinSize.height/2.0 +2)];
    [ship2 runAction:scaleShip2];
    
    CCScaleTo* scaleShip3 = [CCScaleTo actionWithDuration:0.5 scale:0.5];
    [ship3 setPosition:ccp(kWinSize.width/2.0 - 155, kWinSize.height/2.0 -62)];
    [ship3 runAction:scaleShip3];
    
    CCScaleTo* scaleShip4 = [CCScaleTo actionWithDuration:0.5 scale:0.5];
    [ship4 setPosition:ccp(kWinSize.width/2.0 - 155, kWinSize.height/2.0 -128)];
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
        [returnMenu setPosition:ccp(-0.5 * menuItem.contentSize.width, kWinSize.height/2)];
        
        positionToSet = ccp(menuItem.contentSize.width/2, kWinSize.height/2);
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
        [returnMenu setPosition:ccp(-0.5 * menuItem.contentSize.width, kWinSize.height/2)];
        
        positionToSet = ccp(menuItem.contentSize.width/2, kWinSize.height/2);
    }

    [self addChild:returnMenu z:15 tag: kReturnMenuButtonTag];
    
    CCMoveTo* moveReturnMenu = [CCMoveTo actionWithDuration:1 position:positionToSet];

    [returnMenu runAction:moveReturnMenu];
    
    //Setting the Next button now
    CCMenuItemImage* nextItem;
    CGPoint positionToSet2;
    CCMenu* nextButton;
    
    if(IS_IPHONE_5)
    {
        nextItem = [CCMenuItemImage itemWithNormalImage:@"selectionNextButtonNormal.png" selectedImage:@"selectionNextButtonPressed.png" disabledImage:@"selectionNextButtonDisabled.png" target:self selector:@selector(moveToNext)];
        nextButton = [CCMenu menuWithItems:nextItem, nil];
        [nextButton setPosition:ccp(kWinSize.width + nextItem.contentSize.width / 2 ,  kWinSize.height/2)];
        
        positionToSet2 = ccp(kWinSize.width - nextItem.contentSize.width/2,  kWinSize.height/2);
    }
    else if(IS_IPHONE_4)
    {
        nextItem = [CCMenuItemImage itemWithNormalImage:@"selectionNextButtonNormaliPhone4.png" selectedImage:@"selectionNextButtonPressediPhone4.png" disabledImage:@"selectionNextButtonDisablediPhone4.png" target:self selector:@selector(moveToNext)];
        nextButton = [CCMenu menuWithItems:nextItem, nil];
        [nextButton setPosition:ccp(kWinSize.width + nextItem.contentSize.width / 2 , kWinSize.height - nextItem.contentSize.height/2)];
        
        positionToSet2 = ccp(kWinSize.width - nextItem.contentSize.width/2, kWinSize.height - nextItem.contentSize.height/2);

    }
    else
    {
        nextItem = [CCMenuItemImage itemWithNormalImage:@"selectionNextButtonNormal.png" selectedImage:@"selectionNextButtonPressed.png" target:self selector:@selector(moveToNext)];
        nextButton = [CCMenu menuWithItems:nextItem, nil];
        
    [nextButton setPosition:ccp(kWinSize.width + nextItem.contentSize.width / 2 , kWinSize.height/2)];
    
    positionToSet2 = ccp(kWinSize.width - nextItem.contentSize.width/2, kWinSize.height/2);
        
    }
    
    [nextItem setIsEnabled: NO];

    [self addChild:nextButton z:12 tag:kNextButtonTag];
    CCMoveTo* moveInNextButton = [CCMoveTo actionWithDuration:1 position:positionToSet2];
    
    [nextButton runAction:moveInNextButton];

    
    
}



- (void)returnToMenu
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1 scene:[MenuSceneLayer scene]]];
    
}



- (void)moveToNext
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    //Let the two menu buttons move to sides
    [self moveFirstMenusAside];
    
    //Moving the layer up
    CCMoveBy* moveEntireLayer = [CCMoveBy actionWithDuration:2 position:ccp(0, kWinSize.height)];
    CCEaseElasticInOut* easeForLayerMove = [CCEaseElasticInOut actionWithAction:moveEntireLayer];
    [self runAction:easeForLayerMove];
    
    //Ensure the button does't get tapped twice!
    [(CCMenu*)[self getChildByTag: kNextButtonTag] setEnabled:NO];
    [(CCMenu*)[self getChildByTag:kReturnMenuButtonTag] setEnabled: NO];
    
    [self scheduleOnce:@selector(initSecondMenus) delay:2];
    
}

- (void) initSecondMenus
{
    //Creating the next two menu items
    CCMenuItemImage* backItem = [CCMenuItemImage itemWithNormalImage:@"selectionBackButtonNormal.png" selectedImage:@"selectionBackButtonPressed.png" target:self selector:@selector(backButtonPressed)];
    
    CCMenu* backMenu = [CCMenu menuWithItems:backItem, nil];
    
//    backMenu.anchorPoint = ccp(0.5,0.5);
    
    [backMenu setPosition:ccp( -1 * backItem.contentSize.width/2.0,  -1 * kWinSize.height/2)];
    
    [self addChild:backMenu z:15 tag: kBackMenuTag];
    
    
    CCMenuItemImage* playItem = [CCMenuItemImage itemWithNormalImage:@"selectionPlayButtonNormal.png" selectedImage:@"selectionPlayButtonPressed.png" target:self selector:@selector(playButtonPressed)];
    
    CCMenu* playMenu = [CCMenu menuWithItems:playItem, nil];
    
//    playMenu.anchorPoint = ccp(0.5,0.5);
    
    
    [playMenu setPosition:ccp( kWinSize.width + playItem.contentSize.width/2.0 ,  -1 * kWinSize.height/2.0)];
    
    [self addChild:playMenu z:15 tag: kPlayMenuTag];
    
    
    [self scheduleOnce:@selector(moveSecondMenusBackIn) delay:0];
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



-(void) getGeronimo
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"selectSpaceship.mp3"];
    
    //Setting the next button to be enabled
    [(CCMenuItem*)[[[self getChildByTag:kNextButtonTag] children] objectAtIndex: 0] setIsEnabled: YES];
    
    //Making the highlight to stay
    CCMenuItemImage* itemImage = (CCMenuItemImage*)[[[self getChildByTag:kShipChoiceMenuTag] children] objectAtIndex:0];
    [itemImage selected];
    
    _selectedShipMenuItem = 1;
    
    //Deselect the rest of the menu items
    [(CCMenuItemImage*)[[[self getChildByTag:kShipChoiceMenuTag] children] objectAtIndex:1] unselected];
    [(CCMenuItemImage*)[[[self getChildByTag:kShipChoiceMenuTag] children] objectAtIndex:2] unselected];
    
    CCSprite* crystalSprite =(CCSprite*)[self getChildByTag:kSelectCrystalTag];
    [crystalSprite setScale:0.01];
    CCScaleTo* scaleCrystal = [CCScaleTo actionWithDuration:3 scale:1];
    
    CCEaseExponentialOut* easeScale = [CCEaseExponentialOut actionWithAction:scaleCrystal];

    [crystalSprite runAction:easeScale];
    
    [crystalSprite setPosition:ccp(kWinSize.width/2 + 155, kWinSize.height/2 +69)];
    
    _shipSelected = _Geronimo;
    
}


-(void) getHyperion
{
    
    CCSprite* crystalSprite =(CCSprite*)[self getChildByTag:kSelectCrystalTag];
    [crystalSprite setScale:0.01];
    
    [self getGeronimo];
    
    [crystalSprite setPosition:ccp(kWinSize.width/2 + 155, kWinSize.height/2 +2)];
    
    _shipSelected = _Hyperion;
    
    //Making the highlight to stay
    CCMenuItemImage* itemImage = (CCMenuItemImage*)[[[self getChildByTag:kShipChoiceMenuTag] children] objectAtIndex:1];
    [itemImage selected];
    
    _selectedShipMenuItem = 2;
    
    //Deselect the rest of the menu items
    [(CCMenuItemImage*)[[[self getChildByTag:kShipChoiceMenuTag] children] objectAtIndex:0] unselected];
    [(CCMenuItemImage*)[[[self getChildByTag:kShipChoiceMenuTag] children] objectAtIndex:2] unselected];
    
}


-(void) getAnnihilator
{

    
    CCSprite* crystalSprite =(CCSprite*)[self getChildByTag:kSelectCrystalTag];
    [crystalSprite setScale:0.01];
    
    [self getGeronimo];
    
    [crystalSprite setPosition:ccp(kWinSize.width/2 + 155, kWinSize.height/2 -62)];
    
    _shipSelected = _Annihilator;
    
    //Making the highlight to stay
    CCMenuItemImage* itemImage = (CCMenuItemImage*)[[[self getChildByTag:kShipChoiceMenuTag] children] objectAtIndex:2];
    [itemImage selected];
    
    _selectedShipMenuItem = 3;
    
    //Deselect the rest of the menu items
    [(CCMenuItemImage*)[[[self getChildByTag:kShipChoiceMenuTag] children] objectAtIndex:1] unselected];
    [(CCMenuItemImage*)[[[self getChildByTag:kShipChoiceMenuTag] children] objectAtIndex:0] unselected];
    
}


-(void) getPrometheus
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"comingSoon.mp3"];
    
//    CCSprite* crystalSprite =(CCSprite*)[self getChildByTag:kSelectCrystalTag];
//    [crystalSprite setScale:0.01];
//    
//    [self getGeronimo];
//    
//    [crystalSprite setPosition:ccp(kWinSize.width/2 + 155, kWinSize.height/2 -128)];
    
    [[[UIAlertView alloc] initWithTitle:@"Coming Soon" message:@"Each app update will bring in a new exotic spaceship. Stay tuned!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
    
//    _shipSelected = _Annihilator;
}




- (AppController *) controller
{
    AppController *app = [UIApplication sharedApplication].delegate;
    return app;
}



- (void)shuffleNickname
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    NSUInteger tryInt = arc4random() % kNicknameArraySize;
    
    NSString* nameToSet = [_namesArray objectAtIndex:tryInt];
    
    if([nameToSet isEqualToString:_nickNameLabel.string])
    {
        [self shuffleNickname];
    }
    else
    {
        [_nickNameLabel setString:nameToSet];
    }

}



- (void)onSwitch
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    _glideMode = YES;
    
    [[[self getChildByTag:kGlideMenuTag].children objectAtIndex:0] selected];
    [[[self getChildByTag:kGlideMenuTag].children objectAtIndex:1] unselected];
    
    
}

- (void)offSwitch
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    _glideMode = NO;
    
    [[[self getChildByTag:kGlideMenuTag].children objectAtIndex:0] unselected];
    [[[self getChildByTag:kGlideMenuTag].children objectAtIndex:1] selected];
    
    
}

- (void)leftSwitch
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    _joystickPosition = NO;
    
    [[[self getChildByTag:kJoystickMenuTag].children objectAtIndex:0] selected];
    [[[self getChildByTag:kJoystickMenuTag].children objectAtIndex:1] unselected];

    
    
}

- (void)rightSwitch
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    _joystickPosition = YES;
    
    [[[self getChildByTag:kJoystickMenuTag].children objectAtIndex:0] unselected];
    [[[self getChildByTag:kJoystickMenuTag].children objectAtIndex:1] selected];
    
    
}



- (void)rehighlightMenu
{
    if(_glideMode)
    {
        [[[self getChildByTag:kGlideMenuTag].children objectAtIndex:0] selected];
        [[[self getChildByTag:kGlideMenuTag].children objectAtIndex:1] unselected];
    }
    else
    {
        [[[self getChildByTag:kGlideMenuTag].children objectAtIndex:0] unselected];
        [[[self getChildByTag:kGlideMenuTag].children objectAtIndex:1] selected];
    }
    if(_joystickPosition)
    {
        [[[self getChildByTag:kJoystickMenuTag].children objectAtIndex:0] unselected];
        [[[self getChildByTag:kJoystickMenuTag].children objectAtIndex:1] selected];
    }
    else
    {
        [[[self getChildByTag:kJoystickMenuTag].children objectAtIndex:0] selected];
        [[[self getChildByTag:kJoystickMenuTag].children objectAtIndex:1] unselected];
    }
    
    
}


- (void)backButtonPressed
{
    CCMoveBy* moveLayer = [CCMoveBy actionWithDuration:2 position:ccp(0, -1* kWinSize.height)];
    
    CCEaseElasticInOut* moveEase = [CCEaseElasticInOut actionWithAction:moveLayer];
    
    [self runAction:moveEase];
    
    [self moveSecondMenusAside];
    
    [self scheduleOnce:@selector(moveFirstMenusBackIn) delay:2];
    
}


- (void)playButtonPressed
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    [[self controller] setShipToStart:_shipSelected];
    
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"gameScore"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"enemiesKilled"];
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"timeScore"];
    [[NSUserDefaults standardUserDefaults] setFloat:100 forKey:@"healthLevel"];
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"energyScore"];
    
    [[NSUserDefaults standardUserDefaults] setBool:_glideMode forKey:@"glideMode"];
    [[NSUserDefaults standardUserDefaults] setBool:_joystickPosition forKey:@"joystickPosition"];
    [[NSUserDefaults standardUserDefaults] setObject:[_nickNameLabel string] forKey:@"playerName"];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1 scene:[GameSceneLayer scene]]];
    
    
}


- (void)moveFirstMenusAside
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    
    CCMenuItem* menuItem = (CCMenuItemImage*)[[[self getChildByTag:kReturnMenuButtonTag] children] objectAtIndex:0];
    
    CCMoveBy* moveReturnMenu = [CCMoveBy actionWithDuration:0.8 position:ccp(-1 * menuItem.contentSize.width, 0)];
    [[self getChildByTag:kReturnMenuButtonTag] runAction:moveReturnMenu];
    CCMoveBy* moveNext = [CCMoveBy actionWithDuration:0.8 position:ccp(menuItem.contentSize.width, 0 )];
    [[self getChildByTag:kNextButtonTag] runAction:moveNext];

    [(CCMenu*)[self getChildByTag:kNextButtonTag] setEnabled: NO];
    [(CCMenu*)[self getChildByTag:kReturnMenuButtonTag] setEnabled: NO];
}


- (void)moveFirstMenusBackIn
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    CCMenuItem* menuItem = (CCMenuItemImage*)[[[self getChildByTag:kReturnMenuButtonTag] children] objectAtIndex:0];
    
    CCMoveBy* moveReturnMenu = [CCMoveBy actionWithDuration:0.8 position:ccp(menuItem.contentSize.width, 0)];
    [[self getChildByTag:kReturnMenuButtonTag] runAction:moveReturnMenu];
    CCMoveBy* moveNext = [CCMoveBy actionWithDuration:0.8 position:ccp(-1 * menuItem.contentSize.width, 0 )];
    [[self getChildByTag:kNextButtonTag] runAction:moveNext];
    
    [(CCMenu*)[self getChildByTag:kNextButtonTag] setEnabled: YES];
    [(CCMenu*)[self getChildByTag:kReturnMenuButtonTag] setEnabled: YES];

    
}


- (void)moveSecondMenusAside
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    CCMenuItem* menuItem = (CCMenuItemImage*)[[[self getChildByTag:kBackMenuTag] children] objectAtIndex:0];
    
    CCMoveBy* moveReturnMenu = [CCMoveBy actionWithDuration:0.8 position:ccp(-1 * menuItem.contentSize.width, 0)];
    [[self getChildByTag:kBackMenuTag] runAction:moveReturnMenu];
    CCMoveBy* moveNext = [CCMoveBy actionWithDuration:0.8 position:ccp(menuItem.contentSize.width, 0 )];
    [[self getChildByTag:kPlayMenuTag] runAction:moveNext];
    

    [(CCMenu*)[self getChildByTag:kBackMenuTag] setEnabled:NO];
    [(CCMenu*)[self getChildByTag:kPlayMenuTag] setEnabled:NO];
    
    
}

- (void)moveSecondMenusBackIn
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    CCMenuItem* menuItem = (CCMenuItemImage*)[[[self getChildByTag:kBackMenuTag] children] objectAtIndex:0];

    CCMoveBy* moveReturnMenu = [CCMoveBy actionWithDuration:0.8 position:ccp(menuItem.contentSize.width, 0)];
    [[self getChildByTag:kBackMenuTag] runAction:moveReturnMenu];
    CCMoveBy* moveNext = [CCMoveBy actionWithDuration:0.8 position:ccp(-1 * menuItem.contentSize.width, 0 )];
    [[self getChildByTag:kPlayMenuTag] runAction:moveNext];
    

    [(CCMenu*)[self getChildByTag:kBackMenuTag] setEnabled:YES];
    [(CCMenu*)[self getChildByTag:kPlayMenuTag] setEnabled:YES];


}



- (void)shipSelectionMenuKeepHighlight
{

            [(CCMenuItemImage*)[[[self getChildByTag:kShipChoiceMenuTag] children] objectAtIndex:(_selectedShipMenuItem -1)] selected];

    
}






@end
