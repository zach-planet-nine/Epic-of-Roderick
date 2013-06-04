//
//  IngrethSingleEnemy.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/9/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Image;
@class FadeInOrOut;
@class ParticleEmitter;

@interface IngrethSingleEnemy : AbstractBattleAnimation {
    
    Image *gungnir;
    FadeInOrOut *dimWorld;
    ParticleEmitter *ingrethEmitter;
    int damage;
}

@end
