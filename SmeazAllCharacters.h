//
//  SmeazAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Image;

@interface SmeazAllCharacters : AbstractBattleAnimation {
    
    Image *bloodDrop;
    float smeazDuration;
    float rotationVelocity;
}

@end
