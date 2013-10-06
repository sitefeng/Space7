//
//  HighscoresMainLayer.h
//  Space7
//
//  Created by Si Te Feng on 2013-09-26.
//  Copyright 2013 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HighscoresMainLayer : CCLayer <UITextFieldDelegate>
    
{
        UITextView *dText;
        UITextField* exTextField;
        
        
        
    
}


+(CCScene *) scene;


@end
