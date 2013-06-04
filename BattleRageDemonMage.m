//
//  BattleRageDemonMage.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleRageDemonMage.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "Image.h"

@implementation BattleRageDemonMage

- (void)dealloc {
    
    if (defaultImage) {
        [defaultImage release];
    }
    [super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation
{
    self = [super initWithBattleLocation:aLocation];
    if (self) {
        
        defaultImage = [[[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" imageFilter:GL_NEAREST] imageForKey:@"demon_shadow_mage.png"] imageDuplicate] retain];
		whichEnemy = kSlime;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 3;
		hp = 125;
		maxHP = 125;
		essence = 13;
		maxEssence = 13;
        endurance = 14;
        maxEndurance = 14;
		strength = 3;
		agility = 3;
		stamina = 3;
		dexterity = 3;
		power = 5;
        affinity = 5;
		luck = 1;
		battleTimer = 0.0;
        fireAffinity = 3;
        while (level < partyLevel) {
            [self levelUp];
        }
		experience = 55 * level;
        damageDealt = 0;
        ai[0] = EnemyAISet(kAIEssencePercent, 80, kAIAnyCharacter, 0, kAIEnemyRageAllCharacters);
        ai[1] = EnemyAISet(kAIEssencePercent, 60, kAICharacterWithLowestElementalAffinity, kRage, kAIEnemyRage);
        ai[2] = EnemyAISet(kAIEndurancePercent, 80, kAICharacterWithLowestHP, 0, kAIEnemySmash);
        ai[3] = EnemyAISet(kAIEndurancePercent, 50, kAIAnyCharacter, 0, kAIEnemyEnergyBall);
	}
	isAlive = YES;
	return self;
}

- (void)decideWhatToDo {
    
    for (int i = 0; i < 3; i++) {
        if ([super canIDoThis:ai[i]]) {
            [super doThis:ai[i] decider:self];
            return;
        }
    }
}


@end
