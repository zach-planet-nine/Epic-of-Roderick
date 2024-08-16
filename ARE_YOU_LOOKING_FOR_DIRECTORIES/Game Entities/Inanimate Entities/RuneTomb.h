//
//  RuneTomb.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/2/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractEntity.h"

@class AbstractRuneDrawingAnimation;
@class Character;
@class ParticleEmitter;

@interface RuneTomb : AbstractEntity {
    
    Image *runeTomb;
    ParticleEmitter *runeTombEmitter;
    AbstractRuneDrawingAnimation *rune;
    NSString *key;
    Character *character;
    BOOL hasGivenRune;
}

- (id)initAtLocation:(CGPoint)aLocation withRune:(AbstractRuneDrawingAnimation *)aRune withRuneKey:(NSString *)aKey forCharacter:(Character *)aCharacter withTriggerNextStage:(BOOL)aTrigger;

- (id)initAtTile:(CGPoint)aTile withRune:(AbstractRuneDrawingAnimation *)aRune withRuneKey:(NSString *)aKey forCharacter:(Character *)aCharacter withTriggerNextStage:(BOOL)aTrigger;


@end
