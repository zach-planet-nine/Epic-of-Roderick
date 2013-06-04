//
//  FyrazAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface FyrazAllCharacters : AbstractBattleAnimation {
    
    ParticleEmitter *character1Emitter;
    ParticleEmitter *character2Emitter;
    float essenceGiven;
}

@end
