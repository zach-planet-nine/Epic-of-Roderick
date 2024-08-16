//
//  BattleWaterSpirit.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleWaterSpirit.h"
#import "PackedSpriteSheet.h"
#import "Image.h"

@implementation BattleWaterSpirit

- (void)dealloc {
	
    if (defaultImage) {
        [defaultImage release];
    }
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
		
		defaultImage = [[[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" imageFilter:GL_LINEAR] imageForKey:@"spirit_ice_70x97.png"] imageDuplicate] retain];
		whichEnemy = kSlime;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 3;
		hp = 110;
		maxHP = 110;
        endurance = 14;
        maxEndurance = 14;
		essence = 15;
		maxEssence = 15;
		strength = 3;
		agility = 4;
		stamina = 4;
		dexterity = 3;
		power = 2;
        affinity = 2;
        fireAffinity = 2;
        while (level < partyLevel) {
            [self levelUp];
        }
		experience = 55 * level;
		luck = 0;
		battleTimer = 0.0;
		experience = 40;
        ai[0] = EnemyAISet(kAIEssenceAmount, 8, kAIEnemyWithHPBelowPercent, 33, kAIEnemyHeal);
        ai[1] = EnemyAISet(kAIHPAmount, (int)(maxHP * 0.1), kAISelf, 0, kAIEnemyHeal);
        ai[2] = EnemyAISet(kAIEssencePercent, 80, kAIAnyCharacter, 0, kAIEnemyWaterAllCharacters);
        ai[3] = EnemyAISet(kAIEssencePercent, 60, kAIAnyCharacter, 0, kAIEnemyWater);
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
	isAlive = YES;
	return self;
}

- (void)decideWhatToDo {
    
    for (int i = 0; i < 4; i++) {
        if ([super canIDoThis:ai[i]]) {
            [super doThis:ai[i] decider:self];
            return;
        }
    }
}

@end
