//
//  BattleEnemyChampion.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleEnemyChampion.h"
#import "PackedSpriteSheet.h"
#import "GameController.h"
#import "BattleRoderick.h"
#import "SpriteSheet.h"
#import "Image.h"
#import "PackedSpriteSheet.h"
#import "Textbox.h"

@implementation BattleEnemyChampion

- (void)dealloc {
	
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
		
        PackedSpriteSheet *teorPSS = [[PackedSpriteSheet alloc] initWithImageNamed:@"TEORSpriteSheetMasterv3.png" controlFile:@"TEORSpriteSheetMasterv3" filter:GL_NEAREST];
		defaultImage = [[[[SpriteSheet spriteSheetForImage:[teorPSS imageForKey:@"EnemyChampion.png"] sheetKey:@"EnemyChampion.png" spriteSize:CGSizeMake(49, 53) spacing:10 margin:0] spriteImageAtCoords:CGPointMake(3, 0)] imageDuplicate] retain];
        defaultImage.scale = Scale2fMake(2, 2);
        whichEnemy = kEnemyChampion;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 3;
		hp = 10000;
		maxHP = 10000;
		essence = 0;
		maxEssence = 0;
        endurance = 200;
        maxEndurance = 200;
		strength = 15;
		agility = 11;
		stamina = 110;
		dexterity = 11;
		power = 0;
		luck = 0;
		battleTimer = 0.0;
		experience = 40;
        ai = EnemyAISet(kAIEndurancePercent, 75, kAIAnyCharacter, 0, kAIEnemySlash);
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
	isAlive = YES;
	return self;
}

- (void)decideWhatToDo {
    
    if ([super canIDoThis:ai]) {
        [super doThis:ai decider:self];
    }
}

@end
