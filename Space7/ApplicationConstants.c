//
//  ApplicationConstants.c
//  Space7
//
//  Created by Si Te Feng on 2013-10-16.
//  Copyright (c) 2013 Si Te Feng. All rights reserved.
//

#define kWinSize [[CCDirector sharedDirector] winSize]

#define IS_IPHONE_5 (kWinSize.width == 568)
#define IS_IPHONE_4 (kWinSize.width == 480)

#define kUserDefaults [NSUserDefaults standardUserDefaults]

#define kGameSceneLayerTag 111
#define kGameSceneControlsLayerTag 222