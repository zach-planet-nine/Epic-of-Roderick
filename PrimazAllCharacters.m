//
//  PrimazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "PrimazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"

@implementation PrimazAllCharacters

- (void)dealloc {
    
    if (essenceEmitters) {
        [essenceEmitters release];
    }
    if (primazBall) {
        [primazBall release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        essenceEmitters = [[NSMutableArray alloc] init];
        colorIndex = 0;
		maxColors = 1;
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive && character != valk) {
                rageAdder += [valk calculatePrimazRageAdderFrom:character];
                ParticleEmitter *essenceEmitter = [[ParticleEmitter alloc] initProjectileEmitterWithFile:@"EssenceEmitter.pex" fromPoint:character.renderPoint toPoint:CGPointMake(valk.renderPoint.x + 120, valk.renderPoint.y)];
				essenceEmitter.startColor = essenceEmitter.finishColor = character.essenceColor;
                colors[colorIndex] = character.essenceColor;
                [essenceEmitters addObject:essenceEmitter];
                [essenceEmitter release];
                colorIndex++;
            }
        }
        primazBall = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"AnsuzBall.pex"];
        primazBall.sourcePosition = Vector2fMake(valk.renderPoint.x + 120, valk.renderPoint.y);
        velocity = Vector2fMake(-120 / 0.4, 0);
        stage = 0;
        duration = 0.7;
        active = YES;
        
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
                    duration = 0.4;
                    for (ParticleEmitter *pe in essenceEmitters) {
                        pe.active = NO;
                    }
                    break;
                case 1:
                    stage++;
                    BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
                    valk.rageMeter += rageAdder;
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                primazBall.speed += aDelta * 100;
				if (colorIndex > maxColors) {
					colorIndex = 0;
				}
				primazBall.startColor = primazBall.finishColor = colors[colorIndex];
				colorIndex++;
				[primazBall updateWithDelta:aDelta];
                for (ParticleEmitter *pe in essenceEmitters) {
                    [pe updateWithDelta:aDelta];
                }
                break;
            case 1:
                primazBall.speed -= aDelta * 200;
                primazBall.startParticleSize -= aDelta;
				Vector2f deltaPosition = Vector2fMultiply(velocity, aDelta);
				primazBall.sourcePosition = Vector2fAdd(primazBall.sourcePosition, deltaPosition);
				primazBall.destination = CGPointMake(primazBall.sourcePosition.x, primazBall.sourcePosition.y);
				if (colorIndex > maxColors) {
					colorIndex = 0;
				}
				////NSLog(@"Color index is: %d", colorIndex);
				primazBall.startColor = primazBall.finishColor = colors[colorIndex];
				colorIndex++;
				[primazBall updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        switch (stage) {
            case 0:
                for (ParticleEmitter *pe in essenceEmitters) {
                    [pe renderParticles];
                }
                [primazBall renderParticles];
                break;
            case 1:
                [primazBall renderParticles];
            default:
                break;
        }
    }
}

@end
