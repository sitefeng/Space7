//
//  GameOverLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-05.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>

#import "AppDelegate.h"
#import "GameOverLayer.h"
#import "GameSceneLayer.h"
#import "MenuSceneLayer.h"

#import "AnimatedCloudBackground.h"

#import "ApplicationConstants.c"



#define kTitleBorderOrder 6
#define kMenuButtonOrder 5
#define kIconOrder 7

#define kMenuButtonTag 10
#define kTryAgainButtonTag 11


@implementation GameOverLayer

+(CCScene*) sceneWithGameScore:(float)score enemiesKilled:(unsigned int)enemies andTimeScore:(float)time
{
    
    CCScene *scene = [CCScene node];
    
    GameOverLayer* gameOverLayer = [GameOverLayer node];
    gameOverLayer.gameScore = score;
    gameOverLayer.enemiesKilled = enemies;
    gameOverLayer.timeScore = time;

    AnimatedCloudBackground* background = [AnimatedCloudBackground node];
    [gameOverLayer addChild:background z:-1];
    
    [scene addChild: gameOverLayer z:1 tag:22];
    
    return scene;
    
}


- (id) init
{
    if(self=[super init])
    {
        self.touchEnabled =YES;
        
        if(!self.gameScore)
        {
            self.gameScore = 0;
        }
        if(!self.enemiesKilled)
        {
            self.enemiesKilled = 0;
        }
        if(!self.timeScore)
        {
            self.timeScore = 0;
        }
        
        
        _tryAgainItem = [CCMenuItemImage itemWithNormalImage:@"tryAgainButtonNormal.png" selectedImage:@"tryAgainButtonPressed.png" disabledImage:@"tryAgainButtonDisabled.png" target:self selector:@selector(tryAgain)];

        [_tryAgainItem setIsEnabled:NO];
        
        _mainMenuItem = [CCMenuItemImage itemWithNormalImage:@"mainMenuButtonNormal.png" selectedImage:@"mainMenuButtonPressed.png" disabledImage:@"mainMenuButtonDisabled.png" target:self selector:@selector(mainMenu)];
        
        [_mainMenuItem setIsEnabled:NO];
        
        CCMenu* menuTry = [CCMenu menuWithItems:_tryAgainItem, nil];
        
        
        menuTry.position = ccp(kWinSize.width + [_tryAgainItem contentSize].width/2.0,[_tryAgainItem contentSize].height/2.0);
        
        CCMenu* menuMenu = [CCMenu menuWithItems:_mainMenuItem, nil];
        
        menuMenu.position =ccp(-1 * [_mainMenuItem contentSize].width/2.0,[_mainMenuItem contentSize].height/2.0);
        
        [self addChild: menuMenu z:kMenuButtonOrder tag:kMenuButtonTag];
        [self addChild: menuTry z:kMenuButtonOrder tag:kTryAgainButtonTag];
        
        [self scheduleOnce:@selector(gameOver) delay:0.5];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gameOver.mp3"];
        
    }
    
    return self;
}

- (void) tryAgain
{
    
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    //Restoring the health to 100 percent
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"gameScore"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"enemiesKilled"];
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"timeScore"];
    [[NSUserDefaults standardUserDefaults] setFloat:100 forKey:@"healthLevel"];
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"energyScore"];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1 scene:[GameSceneLayer scene]]];

}



- (void)mainMenu
{
    
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    ////////FINAL CLEAN UP OF THE NSUSERDEFAULTS
    
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"gameScore"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"enemiesKilled"];
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"timeScore"];
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"healthLevel"];
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"energyScore"];
    [[NSUserDefaults standardUserDefaults] setFloat:0 forKey:@"selectedShip"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@" " forKey:@"playerName"];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeBL transitionWithDuration:1 scene:[MenuSceneLayer scene]]];

}


- (void)gameOver
{
    
    [self unschedule:@selector(_cmd)];
    
    CCSprite* title = [CCSprite spriteWithFile:@"gameOverTitle.png"];
    title.position = ccp(kWinSize.width/2, kWinSize.height + 50);
    
    [self addChild:title];
    
    CCMoveTo *titleMove = [CCMoveTo actionWithDuration:1.5 position: ccp(kWinSize.width/2, kWinSize.height - 40)];
    
    CCEaseBounceOut *titleDrop = [CCEaseBounceOut actionWithAction:titleMove];
    
    [title runAction:titleDrop];
    
    [self scheduleOnce:@selector(setExplosion) delay:2.0];
    
    [self scheduleOnce:@selector(displayStats1) delay:4.0];
    
}




-(void) setExplosion
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"gameOverSceneExplode.mp3"];
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    CCParticleExplosion* circles = [[CCParticleExplosion alloc] init];
    
    circles.texture =[[CCSprite spriteWithFile:@"circle2.png"] texture];
    
    [circles setDuration:0.5];
    
    circles.position =ccp(winSize.width/2, winSize.height - 50);
    
    [self addChild: circles z: kTitleBorderOrder];

}



-(void) displayStats1
{
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    CCLabelBMFont* titleLabel = [CCLabelBMFont labelWithString:@"Time Elapsed" fntFile:@"spaceshipNameFont.fnt"];
    [titleLabel setScale:0.9];
    titleLabel.position =ccp(winSize.width/2, winSize.height - 90);
    
    [self addChild:titleLabel];
    
    [self scheduleOnce:@selector(displayStats2) delay:1.0];
    
}


-(void) displayStats2
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF* valueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.0f s",self.timeScore] fontName:@"Marker Felt" fontSize:30];

    valueLabel.position =ccp(winSize.width/2, winSize.height - 127.5);
    
    [self addChild:valueLabel];
    
    [self scheduleOnce:@selector(displayStats3) delay:1.0];

}

-(void) displayStats3
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    CCLabelBMFont* titleLabel = [CCLabelBMFont labelWithString:@"Units Destroyed" fntFile:@"spaceshipNameFont.fnt"];
    [titleLabel setScale:0.9];
    titleLabel.position =ccp(winSize.width/2, winSize.height - 165);
    
    [self addChild:titleLabel];
    
    [self scheduleOnce:@selector(displayStats4) delay:1.0];
}

-(void) displayStats4
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF* valueLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%u",self.enemiesKilled] fontName:@"Marker Felt" fontSize:30];
    
    valueLabel.position =ccp(winSize.width/2, winSize.height - 202.5);
    
    [self addChild:valueLabel];
    
    [self scheduleOnce:@selector(displayStats5) delay:1.0];
    
}

-(void) displayStats5
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click1.mp3"];
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    CCLabelBMFont* titleLabel = [CCLabelBMFont labelWithString:@"Total Score" fntFile:@"spaceshipNameFont.fnt"];
    
    titleLabel.position =ccp(winSize.width/2, winSize.height - 240);
    
    [self addChild:titleLabel];
    
    [self scheduleOnce:@selector(displayStats6) delay:1.0];
    
}

-(void) displayStats6
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    CGSize winSize= [[CCDirector sharedDirector] winSize];
    
    NSMutableString* valueString = [NSMutableString stringWithFormat:@"%.0f",self.gameScore];
    
    if(self.gameScore>=1000)
        [valueString appendString:@" !"];
        
    CCLabelTTF* valueLabel = [CCLabelTTF labelWithString: valueString fontName:@"Marker Felt" fontSize:35];;
    
    valueLabel.position =ccp(winSize.width/2, winSize.height - 280);
    
    [self addChild:valueLabel];
    
    [self scheduleOnce:@selector(showMenuButtons) delay:0.5];
    
}



-(void) showMenuButtons
{
    
    CCMenu* menu = (CCMenu*)[self getChildByTag:kMenuButtonTag];
    CCMenu* tryAgain = (CCMenu*)[self getChildByTag: kTryAgainButtonTag];
    
    CCMoveTo* menuMove = [CCMoveTo actionWithDuration:1.0 position:ccp([_mainMenuItem contentSize].width/2.0,[_mainMenuItem contentSize].height/2.0)];
    CCMoveTo* tryAgainMove = [CCMoveTo actionWithDuration:1.0 position:ccp(kWinSize.width - [_tryAgainItem contentSize].width/2.0,[_tryAgainItem contentSize].height/2.0)];
    
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"button.mp3"];
    
    [menu runAction:menuMove];
    [tryAgain runAction: tryAgainMove];
    
    
    [_tryAgainItem setIsEnabled:YES];
    [_mainMenuItem setIsEnabled:YES];
    
    
    //Creating the tappable 3 Icons on the right side
    CCMenuItemImage *emailIcon = [CCMenuItemImage itemWithNormalImage:@"emailIconNormal.png" selectedImage:@"emailIconPressed.png" target:self selector:@selector(emailIconPressed)];
    
    [emailIcon setScale:0.7];
    
    CCMenuItemImage *facebookIcon = [CCMenuItemImage itemWithNormalImage:@"facebookIconNormal.png" selectedImage:@"facebookIconPressed.png" target:self selector:@selector(facebookIconPressed)];
    
    [facebookIcon setScale:0.7];
    
    CCMenu *iconsMenu = [CCMenu menuWithItems:emailIcon, facebookIcon, nil];
    
    iconsMenu.position = CGPointMake(kWinSize.width/2.0,[facebookIcon contentSize].height * -1);
    
    [iconsMenu alignItemsHorizontallyWithPadding:100];
    
    [self addChild:iconsMenu z:kIconOrder];

    CCMoveTo* shareIconsMove = [CCMoveTo actionWithDuration:0.4 position:CGPointMake(kWinSize.width/2.0, kWinSize.height - 280)];
    
    [iconsMenu runAction:shareIconsMove];
    
}




-(void) facebookIconPressed
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    [FBDialogs presentOSIntegratedShareDialogModallyFrom:[[CCDirector sharedDirector] parentViewController] initialText:[NSString stringWithFormat:@"Space 7 is a stunningly colorful and elegant game designed for iOS. I just played the game and got %.0f points! Download the gmae on an iOS device today!", self.gameScore] image:nil url:[NSURL URLWithString:@"https://www.facebook.com/spacesevengame"] handler:^(FBOSIntegratedShareDialogResult result, NSError *error) {
        if(error)
        {
            [self alertView:nil didDismissWithButtonIndex:1];
            
        }
    }];
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        NSMutableDictionary *params =
        [NSMutableDictionary dictionaryWithObjectsAndKeys:
         [NSString stringWithFormat:@"I just got %.0f points on Space 7!", self.gameScore], @"name",
         @"Game for iOS", @"caption",
         @"Space 7 will suprise you with its stunning colors and elegant gaming experience. Game elements like the responsive star dust and dynamically generated environment create an amazing sense of depth within the game. Experience the game on your iOS device today!", @"description",
         @"https://www.facebook.com/spacesevengame", @"link",
         @"http://i.imgur.com/N4dqI0q.png", @"picture",
         nil];
        
        // Invoke the dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
         {
             if(error)
             {
                 [[[UIAlertView alloc] initWithTitle:@"Unable to share" message:@"Please ensure that you are connected to the internet" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Try Again", nil] show];
                 
             }
         }];
    }
    
}


- (void) emailIconPressed
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    if( [MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
    
        [picker setSubject:@"Let's play Space 7!"];
    
        NSString *emailBody = [NSString stringWithFormat: @"Hey, \n I just played a round of the new Space 7 iOS game for iPhone and iPod touch and got %.0f points. You should try this game too, it's pretty good! \n\nI'm pretty sure you'll enjoy it!", self.gameScore];
    
        [picker setMessageBody:emailBody isHTML:NO];
    
        AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
        [app.navController presentViewController:picker animated:YES completion:nil];
    }
    
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Cannot send email" message:@"Please ensure that you have logged into your mail account" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
    }
    
}



- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController dismissViewControllerAnimated:YES completion:nil];
    
}



@end
