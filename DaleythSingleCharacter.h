//
//  DaleythSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"
#import "Global.h"

@class Image;
@class ParticleEmitter;

@interface DaleythSingleCharacter : AbstractBattleAnimation {
    
    Image *food;
    ParticleEmitter *portalEmitter;
    Vector2f velocity;
    int healing;
}

@end
