//
//  BattleFireDemonMage.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/14/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleFireDemonMage.h"
#import "GameController.h"
#import "OverMind.h"
#import "PackedSpriteSheet.h"
#import "Image.h"

@implementation BattleFireDemonMage

- (void)dealloc {
	
    if (defaultImage) {
        [defaultImage release];
    }
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
		
		defaultImage = [[[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" imageFilter:GL_LINEAR] imageForKey:@"demon_fire_mage.png"] imageDuplicate] retain];
        NSLog(@"You should have fire mage.");
        //defaultImage = [[Image alloc] initWithImageNamed:@"fire_elemental.png" filter:GL_NEAREST];
		whichEnemy = kSlime;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 1;
		hp = 65;
		maxHP = 65;
		essence = 10;
		maxEssence = 10;
        endurance = 10;
        maxEndurance = 10;
		strength = 2;
		agility = 1;
		stamina = 1;
		dexterity = 1;
		power = 1;
        affinity = 1;
		luck = 1;
        affinity = 1;
		battleTimer = 0.0;
        while (level < partyLevel) {
            [self levelUp];
        }
		experience = 55 * level;
        waterAffinity = 1;
        rageAffinity = 1;
        fireAffinity = 1;
        damageDealt = 0;
        ai[0] = EnemyAISet(kAIEndurancePercent, 80, kAICharacterWithHPBelowPercent, 20, kAIEnemySmash);
        ai[1] = EnemyAISet(kAIEndurancePercent, 80, kAIAnyCharacter, 0, kAIEnemySmash);
        ai[2] = EnemyAISet(kAIEssencePercent, 60, kAICharacterWithEssenceBelowPercent, 10, kAIEnemyFire);
        ai[3] = EnemyAISet(kAIEssencePercent, 60, kAICharacterWithLowestElementalAffinity, kFire, kAIEnemyFire);
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
            //NSLog(@"Fire mage did something %d, %f, %f", i, endurance, essence);
            return;
        }
    }
    //NSLog(@"Fire mage can't do anything %f, %f", endurance, essence);
}

@end
