//
//  NauthizAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NauthizAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Projectile.h"
#import "FadeInOrOut.h"

@implementation NauthizAllEnemies

- (void)dealloc {
    
    if (nauthizGhost) {
        [nauthizGhost release];
    }
    if (dimWorld) {
        [dimWorld release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                int tempDamage = [valk calculateNauthizDamageTo:enemy];
                tempDamage = (int)((float)(tempDamage) * 0.7);
                damages[enemyIndex] = tempDamage;
                enemyIndex++;
            }
        }
        dimWorld = [[FadeInOrOut alloc] initFadeOutToAlpha:0.28 withDuration:1.05];
        duration = 1;
        stage = 0;
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
                    nauthizGhost = [[Projectile alloc] initProjectileFrom:Vector2fMake(140, -30) to:Vector2fMake(460, 60) withImage:@"Ghost.png" lasting:0.4 withStartAngle:30 withStartSize:Scale2fMake(0.2, 0.2) toFinishSize:Scale2fMake(1, 1)];
                    duration = 0.4;
                    break;
                case 1:
                    stage++;
                    [nauthizGhost release];
                    nauthizGhost = [[Projectile alloc] initProjectileFrom:Vector2fMake(460, 60) to:Vector2fMake(280, 120) withImage:@"Ghost.png" lasting:0.4 withStartAngle:90 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                    duration = 0.4; 
                    break;
                case 2:
                    stage++;
                    [nauthizGhost release];
                    nauthizGhost = [[Projectile alloc] initProjectileFrom:Vector2fMake(280, 120) to:Vector2fMake(460, 180) withImage:@"Ghost.png" lasting:0.4 withStartAngle:90 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                    duration = 0.4;
                    break;
                case 3:
                    stage++;
                    [nauthizGhost release];
                    nauthizGhost = [[Projectile alloc] initProjectileFrom:Vector2fMake(460, 180) to:Vector2fMake(280, 240) withImage:@"Ghost.png" lasting:0.4 withStartAngle:90 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                    duration = 0.4;
                    break;
                case 4:
                    stage++;
                    [nauthizGhost release];
                    nauthizGhost = [[Projectile alloc] initProjectileFrom:Vector2fMake(280, 240) to:Vector2fMake(520, 400) withImage:@"Ghost.png" lasting:0.4 withStartAngle:90 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookEssenceDamage:damages[enemyIndex]];
                            enemyIndex++;
                        }
                    }
                    duration = 0.4;
                    break;
                case 5:
                    stage++;
                    active = NO;
                    break;
                default:
                    break;
            }
        }
        if (stage == 0) {
            [dimWorld updateWithDelta:aDelta];
        } else if (stage < 6) {
            
            [nauthizGhost updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active) {
        if (stage == 0) {
            [dimWorld render];
        } else if (stage < 6) {
            
            [dimWorld render];
            [nauthizGhost renderProjectiles];
        }
    }
}

@end
