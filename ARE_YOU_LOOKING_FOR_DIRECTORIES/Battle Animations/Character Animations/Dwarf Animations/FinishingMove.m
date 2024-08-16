//
//  FinishingMove.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/11/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "FinishingMove.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleDwarf.h"

@implementation FinishingMove

- (void)dealloc {
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
    
    self = [super init];
    if (self) {
        
        dwarf = [sharedGameController.battleCharacters objectForKey:@"BattleDwarf"];
        target1 = aEnemy;
        originalPoint = dwarf.renderPoint;
        enemyOriginalPoint = target1.renderPoint;
        dwarfVelocity = Vector2fMake((target1.renderPoint.x - 20 - dwarf.renderPoint.x) * 3, (target1.renderPoint.y - dwarf.renderPoint.y) * 3);
        enemyVelocity = Vector2fMake(500, 500);
        stage = 0;
        duration = 0.3;
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
                    [target1 youTookDamage:(int)(target1.hp * 10)];
                    duration = 0.3;
                    break;
                case 1:
                    stage++;
                    dwarfVelocity = Vector2fMultiply(dwarfVelocity, -1);
                    duration = 0.3;
                    break;
                case 2:
                    stage++;
                    dwarf.renderPoint = originalPoint;
                    duration = 1;
                    break;
                case 3:
                    stage++;
                    target1.renderPoint = enemyOriginalPoint;
                    active = NO;
                    break;
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                stage = stage;
                Vector2f temp = Vector2fMultiply(dwarfVelocity, aDelta);
                dwarf.renderPoint = CGPointMake(dwarf.renderPoint.x + temp.x, dwarf.renderPoint.y + temp.y);
                break;
            case 1:
                stage = stage;
                Vector2f dwarfTemp = Vector2fMultiply(dwarfVelocity, aDelta);
                Vector2f enemyTemp = Vector2fMultiply(enemyVelocity, aDelta);
                dwarf.renderPoint = CGPointMake(dwarf.renderPoint.x + dwarfTemp.x, dwarf.renderPoint.y + dwarfTemp.y);
                target1.renderPoint = CGPointMake(target1.renderPoint.x + enemyTemp.x, target1.renderPoint.y + enemyTemp.y);
            default:
                break;
        }
    }
}

@end
