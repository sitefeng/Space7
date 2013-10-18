//
//  AboutSceneMainLayer.m
//  Space7
//
//  Created by Si Te Feng on 2013-10-04.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import "AboutSceneMainLayer.h"

#import "AppDelegate.h"
#import "MenuSceneLayer.h"

#import "AnimatedCloudBackground.h"
#import "AnimatedCloudCover.h"

#import <FacebookSDK/FacebookSDK.h>

#include "ApplicationConstants.c"

#define kIconOrder 1

@implementation AboutSceneMainLayer


+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    AboutSceneMainLayer* aboutMainLayer = [AboutSceneMainLayer node];
    AnimatedCloudCover* cloudCover = [AnimatedCloudCover node];
    AnimatedCloudBackground* cloudBackground= [AnimatedCloudBackground node];
    
    [aboutMainLayer addChild:cloudBackground z:-1];
    [aboutMainLayer addChild:cloudCover z:2];
    [scene addChild: aboutMainLayer];
    
    return scene;
    
}


- (id) init
{
    if(self=[super init])
    {
        self.touchEnabled =YES;
        
        //Creating the UIKit Scrollable text
//        AboutSceneViewController* aboutViewController = [[AboutSceneViewController alloc] initWithNibName:@"AboutSceneViewController" bundle:nil];
        
        if(IS_IPHONE_5)
        {
            dText= [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 430, 270)];
        }
        else
        {
            dText = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 380, 270)];
        }
        dText.delegate = self;
        
        dText.text = @"Authors: Si Te Feng and Karim Kawambwa\n\nSpecial Thanks: \"Make Games With Us\"\n\nSound Effects: www.freesfx.co.uk\n\nIcons: www.designbolts.com\n\nProject Start Date: Sep. 22, 2013\n\nFirst Completion Date: Nov. 22, 2013\n\nThank you for supporting and enjoying the game.\n\n\nWell, hi there, commander!\nWe are now lost in a galaxy far far away from Earth. We have an urgent objective to find our way back to the Milky Way Galaxy. During our adventure, we'll explore gorgeous galaxies while trying to avoid evil alien spaceships.\nI hope you'll enjoy!\n\nSincerely,\niOS game devs\n\n*****\n\nPlease email us at technochimera@gmail.com if you have any questions or suggestions about the game. If you like this game, please spread the word and share this on Facebook. \n\nThank you for your support!\n\nOctober 5th, 2013\n\n\n";
        
        [dText setEditable:NO];
        
        dText.font = [UIFont fontWithName:@"Helvetica" size:18];
        
        dText.textColor = [UIColor colorWithRed:50 green:170 blue:255 alpha:1];
        
        dText.backgroundColor = [UIColor clearColor];
        
        dText.textColor = [UIColor whiteColor];
        
        [[[CCDirector sharedDirector] view] addSubview:dText];
        
        
        //Creating the tappable 3 Icons on the right side
        CCMenuItemImage *reportBug = [CCMenuItemImage itemWithNormalImage:@"emailIconNormal.png" selectedImage:@"emailIconPressed.png" target:self selector:@selector(reportBugIconPressed)];
        
        
        CCMenuItemImage *facebookIcon = [CCMenuItemImage itemWithNormalImage:@"facebookIconNormal.png" selectedImage:@"facebookIconPressed.png" target:self selector:@selector(facebookIconPressed)];

        
        CCMenuItemImage *closeIcon = [CCMenuItemImage itemWithNormalImage:@"closeButtonNormal.png" selectedImage:@"closeButtonPressed.png" target:self selector:@selector(closeIconPressed)];
        
        CCMenu *iconsMenu = [CCMenu menuWithItems:reportBug, facebookIcon, closeIcon, nil];
        
        if(IS_IPHONE_5)
        {
            iconsMenu.position = CGPointMake(504, 160);
        }
        else
        {
            iconsMenu.position = CGPointMake(430, 160);
        }
        
        [iconsMenu alignItemsVerticallyWithPadding:35];
        
        [self addChild:iconsMenu z:kIconOrder];
        

        
        //Creating the Title of the scene and display on the top
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"-About-" fontName:@"Helvetica" fontSize:44];
        title.color = ccc3(255,255,255);
        
        title.anchorPoint = ccp(0,0);
        title.position = ccp(30,270);
        
        [self addChild:title];
        
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"about.mp3"];
        
    }
    
    return self;
}

-(void) reportBugIconPressed
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"Space 7 Bug Report"];
    
    [picker setToRecipients:[NSArray arrayWithObjects:@"technochimera@gmail.com", nil]];
    
    NSString *emailBody = @"Please describe the problems that you were experiencing during the game: \n";
    
    [picker setMessageBody:emailBody isHTML:NO];
    
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController presentViewController:picker animated:YES completion:nil];
}




-(void) facebookIconPressed
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    BOOL presentedIntegratedShareDialog = [FBDialogs presentOSIntegratedShareDialogModallyFrom:[[CCDirector sharedDirector] parentViewController] initialText:@"Space 7 is a stunningly color and elegant  game designed only for iOS. Experience it today!" image:nil url:[NSURL URLWithString:@"https://www.facebook.com/spacesevengame"] handler:^(FBOSIntegratedShareDialogResult result, NSError *error) {
        if(error)
        {
            [[[UIAlertView alloc] initWithTitle:@"Unable to share" message:@"Please try again later" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Try Again", nil] show];
            
        }
    }];
    
    if(!presentedIntegratedShareDialog)
    {
        [self alertView:nil didDismissWithButtonIndex:1];
    }
    
    
}


-(void) closeIconPressed
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"click2.mp3"];
    
    [dText removeFromSuperview];
    dText = nil;
    
    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];
    

    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Experience Space 7 for iOS today", @"name",
     @"Game for iOS", @"caption",
     @"Space 7 will suprise you with its stunning colors and elegant gaming experience. Try it on your iOS device today!", @"description",
     @"https://www.facebook.com/spacesevengame", @"link",
     @"http://i.imgur.com/N4dqI0q.png", @"picture",
     nil];
    
    // Invoke the dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil parameters:params
                                              handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error)
     {
         if(error)
         {
             [[[UIAlertView alloc] initWithTitle:@"Unable to share" message:@"Please try again later" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Try Again", nil] show];
             
         }
     }];
    }
    
}





- (void) dealloc
{
    
    
    
    [super dealloc];
}


@end






