//
//  HelazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HelazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "Image.h"
#import "ParticleEmitter.h"

@implementation HelazSingleEnemy

- (void)dealloc {
    
    if (garm) {
        [garm release];
    }
    if (helazEmitter) {
        [helazEmitter release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        target1 = aEnemy;
        damage = [poet calculateHelazDamageTo:aEnemy];
        garm = [[Image alloc] initWithImageNamed:@"Garm.png" filter:GL_NEAREST];
        garm.color = Color4fMake(0, 0, 0, 1);
        garm.renderPoint = CGPointMake(aEnemy.renderPoint.x - 50, aEnemy.renderPoint.y - 30);
        helazEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"HelazEmitter.pex"];
        helazEmitter.sourcePosition = Vector2fMake(garm.renderPoint.x + 20, garm.renderPoint.y + 20);
        stage = 0;
        duration = 1;
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
                    [target1 youTookDamage:damage];
                    [target1 flashColor:Color4fMake(1, 0, 0, 1)];
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
                garm.color = Color4fMake(garm.color.red + aDelta, garm.color.green + aDelta, garm.color.blue + aDelta, 1);
                break;
            case 1:
                [helazEmitter updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [garm renderCenteredAtPoint:garm.renderPoint];
        if (stage == 1) {
            [helazEmitter renderParticlesWithImage:garm];
        }
    }
}

@end
