//
//  HolgethSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HolgethSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Projectile.h"

@implementation HolgethSingleEnemy

- (void)dealloc {
    
    if (birdProjectiles) {
        [birdProjectiles release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        int birds = [valk calculateHolgethBirds];
        birdProjectiles = [[NSMutableArray alloc] init];
        //NSLog(@"Birds: %d", birds);
        target1 = aEnemy;
        birdIndex = 0;
        for (int i = 0; i < birds; i++) {
            CGPoint fromPoint = CGPointMake(200 + (RANDOM_0_TO_1() * 400), 400);
            Vector2f vector = Vector2fMake(aEnemy.renderPoint.x - fromPoint.x, aEnemy.renderPoint.y - fromPoint.y);
            if (vector.x == 0) {
                vector.x = 1;
            }
            if (vector.y == 0) {
                vector.y = 1;
            }
            float angle = atanf((vector.y / vector.x)) * 57.2957795;
            if (angle < 0 && vector.x < 0) {
                angle += 180;
            } else if (angle < 0 && vector.y < 0) {
                angle += 360;
            } else if (vector.x < 0 && vector.y < 0) {
                angle += 180;
            }
            if (fromPoint.x > aEnemy.renderPoint.x) {
                Projectile *bird = [[Projectile alloc] initProjectileFrom:Vector2fMake(fromPoint.x, fromPoint.y) to:Vector2fMake((aEnemy.renderPoint.x - (fromPoint.x - aEnemy.renderPoint.x)), (fromPoint.y - (fromPoint.y - aEnemy.renderPoint.y) * 2)) withImage:@"Bird.png" lasting:1 withStartAngle:angle withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                [birdProjectiles addObject:bird];

            } else {
                Projectile *bird = [[Projectile alloc] initProjectileFrom:Vector2fMake(fromPoint.x, fromPoint.y) to:Vector2fMake((aEnemy.renderPoint.x - fromPoint.x) * 2, (fromPoint.y - (fromPoint.y - aEnemy.renderPoint.y) * 2)) withImage:@"Bird.png" lasting:1 withStartAngle:angle withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
                [birdProjectiles addObject:bird];
            }
            birdIndex++;
        }
        //NSLog(@"BirdIndex: %d", birdIndex);
        stage = 0;
        duration = 0.5;
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0) {
            switch (stage) {
                case 0:
                    birdIndex--;
                    [target1 addBleeder];
                    duration = 0.5;
                    if ((RANDOM_0_TO_1() * 100) > 50 + target1.rageAffinity) {
                        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
                        [target1 youWereDisoriented:valk.rageAffinity];
                    }
                    if (birdIndex == 0) {
                        stage = 1;
                        duration = 9;
                    }
                    break;
                case 1:
                    [target1 removeBleeder];
                    birdIndex++;
                    //NSLog(@"BirdIndex:%d, birdProjectiles: %d", birdIndex, [birdProjectiles count]);
                    duration = 0.5;
                    if (birdIndex == [birdProjectiles count]) {
                        stage = 2;
                        duration = 1;
                    }
                    break;
                case 2:
                    stage++;
                    active = NO;
                    
                default:
                    break;
            }
        }
        if (stage == 0) {
            int projectileIndex = MAX(0, birdIndex - 1);
            while (projectileIndex < [birdProjectiles count]) {
                Projectile *pro = [birdProjectiles objectAtIndex:projectileIndex];
                [pro updateWithDelta:aDelta];
                projectileIndex++;
            }
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        for (Projectile *pro in birdProjectiles) {
            [pro renderProjectiles];
        }
    }
}

@end
