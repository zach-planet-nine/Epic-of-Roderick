//
//  HagalazAllCharacters.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/24/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;
@class FadeInOrOut;

@interface HagalazAllCharacters : AbstractBattleAnimation {
    
    ParticleEmitter *starEmitter;
    FadeInOrOut *dimWorld;
}

@end
