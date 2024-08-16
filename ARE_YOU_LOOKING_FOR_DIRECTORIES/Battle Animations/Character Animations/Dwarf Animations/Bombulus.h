//
//  Bombulus.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/14/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class Projectile;
@class BattleDwarf;
@class ParticleEmitter;

@interface Bombulus : AbstractBattleAnimation {
    Projectile *bomb;
    BattleDwarf *dwarf;
    ParticleEmitter *explosion;
}

@end
