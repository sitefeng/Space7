//
//  LoadingSceneLayer.h
//  Space7
//
//  Created by Si Te Feng on 2013-10-20.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoadingSceneLayer : CCLayer {
    
}

@property (nonatomic, retain) NSString* replaceSceneName;

+ (CCScene*) sceneWithReplaceSceneName: (NSString*)sceneName;

@end
