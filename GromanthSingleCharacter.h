//
//  GromanthSingleCharacter.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractBattleAnimation.h"

@class ParticleEmitter;

@interface GromanthSingleCharacter : AbstractBattleAnimation {
    
    ParticleEmitter *gromanthEmitter;
}

@end
