//
//  FinishingMove.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/11/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimation.h"
#import "Global.h"

@class BattleDwarf;

@interface FinishingMove : AbstractBattleAnimation {
    
    Vector2f dwarfVelocity;
    Vector2f enemyVelocity;
    CGPoint originalPoint;
    CGPoint enemyOriginalPoint;
    BattleDwarf *dwarf;
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy;

@end
