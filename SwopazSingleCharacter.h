//
//  SwopazSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Image;

@interface SwopazSingleCharacter : AbstractBattleAnimation {
    
    Image *bloodDrop;
    float swopazDuration;
    float bloodDropAlpha;
}

@end
