//
//  DaleythAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/29/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "DaleythAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "ParticleEmitter.h"
#import "Image.h"

@implementation DaleythAllEnemies

- (void)dealloc {
    
    if (portalEmitter) {
        [portalEmitter release];
    }
    if (sirLamorak) {
        [sirLamorak release];
    }
    if (axe) {
        [axe release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                damages[enemyIndex] = [wizard calculateDaleythDamageTo:enemy];
                enemyIndex++;
            }
        }
        
        portalEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"PortalEmitter.pex"];
        portalEmitter.sourcePosition = Vector2fMake(240, 160);
        sirLamorak = [[Image alloc] initWithImageNamed:@"SirLamorak.png" filter:GL_LINEAR];
        axe = [[Image alloc] initWithImageNamed:@"LamorakAxe.png" filter:GL_LINEAR];
        sirLamorak.renderPoint = CGPointMake(240, 160);
        sirLamorak.color = Color4fMake(1, 1, 1, 0);
        axe.renderPoint = CGPointMake(240, 180);
        velocity = Vector2fMake((160 + (RANDOM_0_TO_1() * 120 * 2)), -480);
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
                    duration = 2;
                    break;
                case 2:
                    stage++;
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damages[enemyIndex]];
                            [enemy flashColor:Color4fMake(0, 1, 0, 1)];
                        }
                    }
                    duration = 1;
                    break;
                case 3:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        if (stage == 0) {
            [portalEmitter updateWithDelta:aDelta];
        }
        if (stage == 1) {
            [portalEmitter updateWithDelta:aDelta];
            sirLamorak.color = Color4fMake(1, 1, 1, sirLamorak.color.alpha + aDelta * 2);
        }
        if (stage == 2) {
            [portalEmitter updateWithDelta:aDelta];
            axe.rotation += (720 * aDelta);
            if (axe.rotation > 360) {
                axe.rotation -= 360;
            }
            axe.renderPoint = CGPointMake(axe.renderPoint.x + (velocity.x * aDelta), axe.renderPoint.y + (velocity.y * aDelta));
            if (axe.renderPoint.y < 0 || axe.renderPoint.y > 320) {
                velocity = Vector2fMake(velocity.x, velocity.y * -1);
            }
            if (axe.renderPoint.x > 480 || axe.renderPoint.x < 0) {
                velocity = Vector2fMake(velocity.x * -1, velocity.y);
            }
        }
    }
}

- (void)render {
    
    if (active) {
        [portalEmitter renderParticles];
        [sirLamorak renderCenteredAtPoint:sirLamorak.renderPoint];
        if (stage == 2) {
            [axe renderCenteredAtPoint:axe.renderPoint scale:Scale2fMake(1, 1) rotation:axe.rotation];
        }
    }
}

@end
