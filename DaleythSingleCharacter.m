//
//  DaleythSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DaleythSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"
#import "Image.h"

@implementation DaleythSingleCharacter

- (void)dealloc {
    
    if (portalEmitter) {
        [portalEmitter release];
    }
    if (food) {
        [food release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
    
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        healing = [wizard calculateDaleythHealingTo:aCharacter];
        target1 = aCharacter;
        portalEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PortalEmitter.pex"];
        portalEmitter.sourcePosition = Vector2fMake(240, 160);
        food = [[Image alloc] initWithImageNamed:@"Food.png" filter:GL_NEAREST];
        food.renderPoint = CGPointMake(240, 160);
        velocity = Vector2fMake((aCharacter.renderPoint.x - 240) * 2, (aCharacter.renderPoint.y - 160) * 2);
        stage = 0;
        duration = 0.75;
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
                    duration = 0.5;
                    break;
                case 1:
                    stage++;
                    [target1 youWereHealed:healing];
                    duration = 1;
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
                [portalEmitter updateWithDelta:aDelta];
                break;
            case 1:
                [portalEmitter updateWithDelta:aDelta];
                food.renderPoint = CGPointMake(food.renderPoint.x + (velocity.x * aDelta), food.renderPoint.y + (velocity.y * aDelta));
                food.color = Color4fMake(1, 1, 1, food.color.alpha - (aDelta * 2));
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage < 2) {
        [portalEmitter renderParticles];
        if (stage == 1) {
            [food renderCenteredAtPoint:food.renderPoint];
        }
    }
}

@end
