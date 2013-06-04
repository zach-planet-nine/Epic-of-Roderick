//
//  BattleRageDemonWarrior.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/4/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleRageDemonWarrior.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "PackedSpriteSheet.h"
#import "Image.h"

@implementation BattleRageDemonWarrior

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
        
        defaultImage = [[[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" imageFilter:GL_NEAREST] imageForKey:@"demon_shadow_warrior.png"] imageDuplicate] retain];
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
        ai[0] = EnemyAISet(kAIEndurancePercent, 80, kAICharacterWithLowestStat, kAgility, kAIEnemySmash);
        ai[1] = EnemyAISet(kAIEndurancePercent, 60, kAIAnyCharacter, 0, kAIEnemySlash);
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
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
