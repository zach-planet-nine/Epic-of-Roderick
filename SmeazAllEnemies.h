//
//  SmeazAllEnemies.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface SmeazAllEnemies : AbstractBattleAnimation {
    
    NSMutableArray *smeazEmitters;    
    int damage;
    int numberOfEnemies;
    int numberOfCharacters;
}

@end
