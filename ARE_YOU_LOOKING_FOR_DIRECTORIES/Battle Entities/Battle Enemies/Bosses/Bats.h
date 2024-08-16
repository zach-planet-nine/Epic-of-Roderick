//
//  Bats.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleEnemy.h"

typedef struct {
    
    CGPoint renderPoint;
    Color4f color;
    float rotation;
} Bat;

@interface Bats : AbstractBattleEnemy {
    
    Bat bats[20];
    EnemyAI ai;
    int damageThreshold;
    Image *batImage;
    int batIndex;
}


@end
