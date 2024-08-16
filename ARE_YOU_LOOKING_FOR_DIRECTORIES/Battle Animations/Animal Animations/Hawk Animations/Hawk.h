//
//  Hawk.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractBattleAnimalEntity.h"

@class Image;
@class BattleRanger;

@interface Hawk : AbstractBattleAnimalEntity {
    
    Image *defaultImage;
	CGPoint destination;
	BattleRanger *ranger;
    Vector2f velocity;
    BOOL defenseMode;
}

@property (nonatomic, retain) Image *defaultImage;
@property (nonatomic, assign) BOOL defenseMode;

- (void)flyBackToRanger;

- (int)calculateHawkDropDamageTo:(AbstractBattleEntity *)aEntity;

- (int)calculateHawkDamage;

- (float)calculateMotivationDurationTo:(AbstractBattleEntity *)aEntity;

@end
