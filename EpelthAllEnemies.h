//
//  EpelthAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface EpelthAllEnemies : AbstractBattleAnimation {
    
    ParticleEmitter *epelthEmitter;
    int damages[4];
    int xDirection;
    int yDirection;
}

@end
