//
//  IngrethAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Projectile;
@class FadeInOrOut;
@class ParticleEmitter;

@interface IngrethAllEnemies : AbstractBattleAnimation {
    
    Projectile *mjollnir;
    FadeInOrOut *dimWorld;
    ParticleEmitter *ingrethEmitter;
    int damages[4];
}

@end
