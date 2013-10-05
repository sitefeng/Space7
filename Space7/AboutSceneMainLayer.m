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


@implementation AboutSceneMainLayer


+(CCScene*) scene
{
    
    CCScene *scene = [CCScene node];
    
    AboutSceneMainLayer* aboutMainLayer = [AboutSceneMainLayer node];
    
    CCSprite * background = [CCSprite spriteWithFile:@"gameSceneBackground.png"];
    
    background.anchorPoint= ccp(0,0);
    
    [aboutMainLayer addChild:background z:-1];
   
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
        
        dText= [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 430, 270)];
        
        dText.text = @"Well, hi there, commander!\nWe are now lost in a galaxy far far away from Earth. We have an urgent objective to find our way back to the Milky Way Galaxy. During our adventure, we'll explore gorgeous galaxies while trying to avoid evil alien spaceships.\nI hope you'll enjoy!\n\nSincerely,\niOS game devs\n\n-----\n\nPlease email us at technochimera@gmail.com if you have any questions or suggestions about the game. If you like this game, please spread the word and share this on Facebook. \n\nThank you for your support!\n\n October 5th, 2013\n";
        
        [dText setEditable:NO];
        
        dText.font = [UIFont fontWithName:@"Helvetica" size:18];
        
        dText.backgroundColor = [UIColor clearColor];
        
        dText.textColor = [UIColor whiteColor];
        
        [[[CCDirector sharedDirector] view] addSubview:dText];
        
        
        //Creating the tappable 3 Icons on the right side
        CCMenuItemImage *reportBug = [CCMenuItemImage itemWithNormalImage:@"ReportBugIcon.png" selectedImage:@"closeIcon.png" target:self selector:@selector(reportBugIconPressed)];
        
        [reportBug setScale:2];
        
        CCMenuItemImage *facebookIcon = [CCMenuItemImage itemWithNormalImage:@"facebookIcon.png" selectedImage:@"closeIcon.png" target:self selector:@selector(facebookIconPressed)];
        
        [facebookIcon setScale:2];
        
        CCMenuItemImage *closeIcon = [CCMenuItemImage itemWithNormalImage:@"closeIcon.png" selectedImage:@"facebookIcon.png" target:self selector:@selector(closeIconPressed)];
        [closeIcon setScale:2];
        
        CCMenu *iconsMenu = [CCMenu menuWithItems:reportBug, facebookIcon, closeIcon, nil];
        
        iconsMenu.position = CGPointMake(504, 160);
        
        [iconsMenu alignItemsVerticallyWithPadding:10];
        
        [self addChild:iconsMenu z:1];
        
        //Creating the Title of the scene and display on the top
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"-About-" fontName:@"Marker Felt" fontSize:44];
        title.color = ccc3(255,255,255);
        
        title.anchorPoint = ccp(0,0);
        title.position = ccp(140,270);
        
        [self addChild:title];
        
        
    }
    
    return self;
}

-(void) reportBugIconPressed
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"iOS Augmented Reality - Chapter 6"];
    
    [picker setToRecipients:[NSArray arrayWithObjects:@"technochimera@gmail.com", nil]];
    
    NSString *emailBody = @"Bug Report: \n";
    
    [picker setMessageBody:emailBody isHTML:NO];
    
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController presentViewController:picker animated:YES completion:nil];
}




-(void) facebookIconPressed
{
    
}


-(void) closeIconPressed
{
    
        
    [[CCDirector sharedDirector] replaceScene:[MenuSceneLayer scene]];

    [dText removeFromSuperview];
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
    [app.navController dismissViewControllerAnimated:YES completion:nil];
    
    
}



- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [exTextField resignFirstResponder];
    
    return YES;
    
    
}








@end





