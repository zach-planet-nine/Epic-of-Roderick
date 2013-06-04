//
//  IngwazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "IngwazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "Image.h"
#import "Projectile.h"

@implementation IngwazAllEnemies

- (void)dealloc {
    
    if (golem) {
        [golem release];
    }
    if (stone) {
        [stone release];
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
                float tempDamage = [wizard calculateIngwazDamageTo:enemy];
                tempDamage *= 0.7;
                damages[enemyIndex] = (int)tempDamage;
                enemyIndex++;
            }
        }
        golem = [[Image alloc] initWithImageNamed:@"Golem.png" filter:GL_LINEAR];
        golem.color = Color4fMake(1, 1, 1, 0);
        golem.renderPoint = CGPointMake(240, 160);
        stone = [[Projectile alloc] initProjectileFrom:Vector2fMake(240, 190) to:Vector2fMake(360, 160) withImage:@"Stone.png" lasting:0.5 withStartAngle:25 withStartSize:Scale2fMake(3, 3) toFinishSize:Scale2fMake(3, 3)];
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
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy flashColor:Color4fMake(1, 0.3, 0, 1)];
                            [enemy youTookDamage:damages[enemyIndex]];
                            enemyIndex++;
                        }
                    }
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
