//
//  GromanthSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "GromanthSingleCharacter.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "ParticleEmitter.h"
#import "BattleStringAnimation.h"

@implementation GromanthSingleCharacter

- (void)dealloc {
    
    if (gromanthEmitter) {
        [gromanthEmitter release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter  

{
    self = [super init];
    if (self) {
        
        if (!aCharacter.isDrauraed) {
            BattleStringAnimation *ineffective = [[BattleStringAnimation alloc] initIneffectiveStringFrom:aCharacter.renderPoint];
            [sharedGameController.currentScene addObjectToActiveObjects:ineffective];
            [ineffective release];
            stage = 3;
            active = NO;
            duration = 3;
            
        } else {
            gromanthEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"EssenceEmitter.pex"];
            gromanthEmitter.gravity = Vector2fMake(0, 200);
            gromanthEmitter.sourcePosition = Vector2fMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 20);
            gromanthEmitter.startColor = aCharacter.essenceColor;
            aCharacter.isDrauraed = NO;
            target1 = aCharacter;
            stage = 0;
            duration = 1.5;
            active = YES;
        }
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0) {
            switch (stage) {
                case 0:
                    stage++;
                    BattleStringAnimation *deDrauraed = [[BattleStringAnimation alloc] initStatusString:@"deDrauraed!" from:target1.renderPoint];
                    [sharedGameController.currentScene addObjectToActiveObjects:deDrauraed];
                    [deDrauraed release];
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [gromanthEmitter updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [gromanthEmitter renderParticles];
    }
}

@end
