//
//  LaguzSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "LaguzSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRanger.h"
#import "Image.h"
#import "ParticleEmitter.h"

@implementation LaguzSingleCharacter

- (void)dealloc {
    
    if (rainCloud) {
        [rainCloud release];
    }
    if (rainEmitter) {
        [rainEmitter release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
    
        BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
        target1 = aCharacter;
        laguzDuration = [ranger calculateLaguzDuration];
        rainCloud = [[Image alloc] initWithImageNamed:@"DarkCloud.png" filter:GL_NEAREST];
        rainCloud.color = Color4fMake(1, 1, 1, 0);
        rainCloud.renderPoint = CGPointMake(aCharacter.renderPoint.x - 15, aCharacter.renderPoint.y + 60);
        rainEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"LaguzRainEmitter.pex"];
        rainEmitter.sourcePosition = Vector2fMake(rainCloud.renderPoint.x, rainCloud.renderPoint.y);
        rainEmitter.stoppingPlane = Vector2fMake(120, aCharacter.renderPoint.y - 30);
        stage = 0;
        duration = 0.4;
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
                    [target1 youWereHealed:(int)((target1.level + target1.levelModifier) * 2 + (RANDOM_0_TO_1() * 20))];
                    duration = laguzDuration;
                    break;
                case 1:
                    stage++;
                    duration = 0.4;
                    break;
                case 2:
                    stage++;
                    active = NO;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                rainCloud.color = Color4fMake(1, 1, 1, rainCloud.color.alpha + aDelta);
                break;
            case 1:
                [rainEmitter updateWithDelta:aDelta];
                target1.hp += MIN((target1.level + target1.levelModifier) * aDelta, target1.maxHP - target1.hp);
                break;
            case 2:
                rainCloud.color = Color4fMake(1, 1, 1, rainCloud.color.alpha - aDelta);
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [rainCloud renderCenteredAtPoint:rainCloud.renderPoint];
        if (stage == 1) {
            [rainEmitter renderParticlesWithImage:rainCloud];
        }
    }
}

@end
