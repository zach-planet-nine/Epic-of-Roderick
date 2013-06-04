//
//  IngwazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IngwazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "Image.h"
#import "Projectile.h"

@implementation IngwazSingleEnemy

- (void)dealloc {
    
    if (golem) {
        [golem release];
    }
    if (stone) {
        [stone release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        target1 = aEnemy;
        damage = [wizard calculateIngwazDamageTo:aEnemy];
        golem = [[Image alloc] initWithImageNamed:@"Golem.png" filter:GL_NEAREST];
        golem.renderPoint = CGPointMake(240, 160);
        golem.color = Color4fMake(1, 1, 1, 0);
        stone = [[Projectile alloc] initProjectileFrom:Vector2fMake(240, 190) to:Vector2fMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y) withImage:@"Stone.png" lasting:0.5 withStartAngle:25 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
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
                    [target1 flashColor:Color4fMake(0.6, 0.4, 0, 1)];
                    [target1 youTookDamage:damage];
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
                golem.color = Color4fMake(1, 1, 1, golem.color.alpha + aDelta);
                break;
            case 1:
                [stone updateWithDelta:aDelta];
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [golem renderCenteredAtPoint:golem.renderPoint];
        if (stage == 1) {
            [stone renderProjectiles];
        }
    }
}

@end
