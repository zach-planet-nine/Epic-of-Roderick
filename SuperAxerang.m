//
//  SuperAxerang.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/13/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "SuperAxerang.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "Projectile.h"
#import "BattleDwarf.h"
#import "PackedSpriteSheet.h"

@implementation SuperAxerang

- (void)dealloc {
    if (axerang) {
        [axerang release];
    }
    [super dealloc];
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        BattleDwarf *dwarf = [sharedGameController.battleCharacters objectForKey:@"BattleDwarf"];
        int index = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
                damages[index] = [dwarf calculateSuperAxerangDamageTo:enemy];
                projectilePoints[index] = Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y);
                index++;
            }
        }
        float angle = atanf((projectilePoints[0].y - dwarf.renderPoint.y) / (projectilePoints[0].x - dwarf.renderPoint.x));
		angle *= 57.2957795;
		if (angle < 0 && projectilePoints[0].x - dwarf.renderPoint.x < 0) {
			angle += 180;
		} else if (angle < 0 && projectilePoints[0].y - dwarf.renderPoint.y < 0) {
			angle += 360;
		} else if (projectilePoints[0].x - dwarf.renderPoint.x < 0 && projectilePoints[0].y - dwarf.renderPoint.y < 0) {
			angle += 180;
		}
        axerang = [[Projectile alloc] initProjectileFrom:Vector2fMake(dwarf.renderPoint.x, dwarf.renderPoint.y) to:projectilePoints[0] withSSImage:[sharedGameController.teorPSS imageForKey:@"Scythe.png"] lasting:0.4 withStartAngle:angle withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1) revolving:YES];
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
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && CGRectContainsPoint([enemy getRect], axerang.currentPoint)) {
                            [enemy youTookDamage:damages[0]];
                        }
                    }
                    if (projectilePoints[1].x == 0) {
                        stage = 6;
                        duration = 0;
                        break;
                    }
                    [axerang release];
                    float angle = atanf((projectilePoints[1].y - projectilePoints[0].y) / (projectilePoints[1].x - projectilePoints[0].x));
                    angle *= 57.2957795;
                    if (angle < 0 && projectilePoints[1].x - projectilePoints[0].x < 0) {
                        angle += 180;
                    } else if (angle < 0 && projectilePoints[1].y - projectilePoints[0].y < 0) {
                        angle += 360;
                    } else if (projectilePoints[1].x - projectilePoints[0].x < 0 && projectilePoints[1].y - projectilePoints[0].y < 0) {
                        angle += 180;
                    }
                    axerang = [[Projectile alloc] initProjectileFrom:projectilePoints[0] to:projectilePoints[1] withSSImage:[sharedGameController.teorPSS imageForKey:@"Scythe.png"] lasting:0.4 withStartAngle:angle withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1) revolving:YES];
                    duration = 0.4;
                    break;
                case 1:
                    stage++;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && CGRectContainsPoint([enemy getRect], axerang.currentPoint)) {
                            [enemy youTookDamage:damages[1]];
                        }
                    }
                    if (projectilePoints[2].x == 0) {
                        stage = 6;
                        duration = 0;
                        break;
                    }
                    [axerang release];
                    float angle1 = atanf((projectilePoints[2].y - projectilePoints[1].y) / (projectilePoints[2].x - projectilePoints[1].x));
                    angle1 *= 57.2957795;
                    if (angle1 < 0 && projectilePoints[2].x - projectilePoints[1].x < 0) {
                        angle1 += 180;
                    } else if (angle1 < 0 && projectilePoints[2].y - projectilePoints[1].y < 0) {
                        angle1 += 360;
                    } else if (projectilePoints[2].x - projectilePoints[1].x < 0 && projectilePoints[2].y - projectilePoints[1].y < 0) {
                        angle1 += 180;
                    }
                    axerang = [[Projectile alloc] initProjectileFrom:projectilePoints[1] to:projectilePoints[2] withSSImage:[sharedGameController.teorPSS imageForKey:@"Scythe.png"] lasting:0.4 withStartAngle:angle1 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1) revolving:YES];
                    duration = 0.4;
                    break;
                case 2:
                    stage++;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && CGRectContainsPoint([enemy getRect], axerang.currentPoint)) {
                            [enemy youTookDamage:damages[2]];
                        }
                    }
                    if (projectilePoints[3].x == 0) {
                        stage = 6;
                        duration = 0;
                        break;
                    }
                    [axerang release];
                    float angle2 = atanf((projectilePoints[3].y - projectilePoints[2].y) / (projectilePoints[3].x - projectilePoints[2].x));
                    angle2 *= 57.2957795;
                    if (angle2 < 0 && projectilePoints[3].x - projectilePoints[2].x < 0) {
                        angle2 += 180;
                    } else if (angle < 0 && projectilePoints[3].y - projectilePoints[2].y < 0) {
                        angle2 += 360;
                    } else if (projectilePoints[3].x - projectilePoints[2].x < 0 && projectilePoints[3].y - projectilePoints[2].y < 0) {
                        angle2 += 180;
                    }
                    axerang = [[Projectile alloc] initProjectileFrom:projectilePoints[2] to:projectilePoints[3] withSSImage:[sharedGameController.teorPSS imageForKey:@"Scythe.png"] lasting:0.4 withStartAngle:angle2 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1) revolving:YES];
                    duration = 0.4;
                    break;
                case 3:
                    stage++;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && CGRectContainsPoint([enemy getRect], axerang.currentPoint)) {
                            [enemy youTookDamage:damages[3]];
                        }
                    }
                    float angle3 = atanf((projectilePoints[4].y - axerang.currentPoint.y) / (projectilePoints[4].x - axerang.currentPoint.x));
                    angle3 *= 57.2957795;
                    if (angle3 < 0 && projectilePoints[4].x - axerang.currentPoint.x < 0) {
                        angle3 += 180;
                    } else if (angle3 < 0 && projectilePoints[4].y - axerang.currentPoint.y < 0) {
                        angle3 += 360;
                    } else if (projectilePoints[4].x - axerang.currentPoint.x < 0 && projectilePoints[4].y - axerang.currentPoint.y < 0) {
                        angle3 += 180;
                    }
                    CGPoint currentPoint = axerang.currentPoint;
                    [axerang release];
                    axerang = [[Projectile alloc] initProjectileFrom:Vector2fMake(currentPoint.x, currentPoint.y) to:projectilePoints[4] withSSImage:[sharedGameController.teorPSS imageForKey:@"Scythe.png"] lasting:0.4 withStartAngle:angle3 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1) revolving:YES];
                    duration = 0.4;
                    break;
                case 6:
                    stage = 4;
                    float angle4 = atanf((projectilePoints[4].y - axerang.currentPoint.y) / (projectilePoints[4].x - axerang.currentPoint.x));
                    angle4 *= 57.2957795;
                    if (angle4 < 0 && projectilePoints[4].x - axerang.currentPoint.x < 0) {
                        angle4 += 180;
                    } else if (angle3 < 0 && projectilePoints[4].y - axerang.currentPoint.y < 0) {
                        angle4 += 360;
                    } else if (projectilePoints[4].x - axerang.currentPoint.x < 0 && projectilePoints[4].y - axerang.currentPoint.y < 0) {
                        angle4 += 180;
                    }
                    CGPoint currentPoint2 = axerang.currentPoint;
                    [axerang release];
                    axerang = [[Projectile alloc] initProjectileFrom:Vector2fMake(currentPoint2.x, currentPoint2.y) to:projectilePoints[4] withSSImage:[sharedGameController.teorPSS imageForKey:@"Scythe.png"] lasting:0.4 withStartAngle:angle3 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1) revolving:YES];
                    duration = 0.4;
                    break;
                case 4:
                    stage++;
                    duration = 0.5;
                    break;
                case 5:
                    stage++;
                    active = NO;
                    break;
                default:
                    break;
            }

        }
        if (stage < 5) {
            [axerang updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage < 5) {
        [axerang renderProjectiles];
    }
}

@end
