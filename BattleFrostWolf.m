//
//  BattleFrostWolf.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleFrostWolf.h"
#import "PackedSpriteSheet.h"
#import "SpriteSheet.h"
#import "Image.h"
#import "OverMind.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"

@implementation BattleFrostWolf

- (void)dealloc {
	
    if (defaultImage) {
        [defaultImage release];
    }
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
		
		defaultImage = [[[[SpriteSheet spriteSheetForImage:[[[PackedSpriteSheet alloc] initWithImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" filter:GL_LINEAR] imageForKey:@"frost_wolf_spritesheet.png"] sheetKey:@"frost_wolf_spritesheet.png" spriteSize:CGSizeMake(80, 40) spacing:10 margin:0] spriteImageAtCoords:CGPointMake(0, 0)] imageDuplicate] retain];
		whichEnemy = kSlime;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 1;
		hp = 80;
		maxHP = 80;
		essence = 10;
		maxEssence = 10;
        endurance = 10;
        maxEndurance = 10;
		strength = 12;
		agility = 12;
		stamina = 8;
		dexterity = 12;
		power = 8;
        affinity = 8;
		luck = 1;
        affinity = 8;
		battleTimer = 0.0;
		experience = 40;
        waterAffinity = 3;
        damageDealt = 20;
        ai[0] = EnemyAISet(kAIEssenceAmount, 10, kAIEnemyWithHPBelowPercent, 25, kAIEnemyHeal);
        ai[1] = EnemyAISet(kAIEndurancePercent, 90, kAICharacterWithHighestHP, 0, kAIEnemyBite);
        ai[2] = EnemyAISet(kAIEndurancePercent, 60, kAICharacterWithLowestEndurance, 0, kAIEnemySmash);
        ai[3] = EnemyAISet(kAIEssencePercent, 80, kAICharacterWithLowestStat, kAffinity, kAIEnemyEnergyBall);
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
	isAlive = YES;
	return self;
}

- (void)decideWhatToDo {
    /*
    if ([sharedOverMind enemyWithHPBelowPercent:25]) {
        //NSLog(@"Wolf Would heal enemy!");
        [[sharedOverMind enemyWithHPBelowPercent:25] youWereHealed:100];
        essence -= 40;
        return;
    } else if (endurance / maxEndurance > 0.9) {
        //NSLog(@"Wolf would Double attack %d", [sharedOverMind characterWithHighestHP].whichCharacter);
        endurance -= 40;
        return;
    } else if (endurance / maxEndurance > 0.6) {
        //NSLog(@"Wolf would Attack %d", [sharedOverMind characterWithLowestEndurance].whichCharacter);
        endurance -= 50;
        return;
    } else if (essence / maxEssence > 0.8) {
        //NSLog(@"Wolf would Frost attack all characters!");
        essence -= 100;
        return;
    }*/
    for (int i = 0; i < 4; i++) {
        if ([super canIDoThis:ai[i]]) {
            [super doThis:ai[i] decider:self];
            //NSLog(@"Frost Wolf did something. %f, %f", endurance, essence);
            return;
        }
    }
    //NSLog(@"Wolf Can't do anything %f, %f", endurance, essence);
}

@end
