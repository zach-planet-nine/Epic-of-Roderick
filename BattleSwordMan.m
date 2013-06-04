//
//  BattleSwordMan.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleSwordMan.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"
#import "PackedSpriteSheet.h"
#import "SpriteSheet.h"
#import "ChapterOneDemoTestV2.h"


@implementation BattleSwordMan

@synthesize shouldAttack;

- (void)dealloc {
	
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
        PackedSpriteSheet *teorPSS = [[PackedSpriteSheet alloc] initWithImageNamed:@"TEORSpriteSheetMasterv3.png" controlFile:@"TEORSpriteSheetMasterv3" filter:GL_NEAREST];

        SpriteSheet *swordManSprites = [SpriteSheet spriteSheetForImage:[teorPSS imageForKey:@"BattleSwordMan.png"] sheetKey:@"BattleSwordMan.png" spriteSize:CGSizeMake(49, 53) spacing:10 margin:0];
		defaultImage = [[[swordManSprites spriteImageAtCoords:CGPointMake(3, 0)] imageDuplicate] retain];
		whichEnemy = kSwordMan;
		battleLocation = aLocation;
		state = kEntityState_Alive;
        level = 1;
		hp = 30;
		maxHP = 30;
		essence = 0;
		maxEssence = 0;
        endurance = 10;
        maxEndurance = 10;
		strength = 2;
		agility = 1;
		stamina = 1;
		dexterity = 0;
		power = 0;
		luck = 0;
		battleTimer = 0.0;
		experience = 40;
        ai = EnemyAISet(kAIEnduranceAmount, 9, kAIAnyCharacter, 0, kAIEnemySlash);
        ChapterOneDemoTestV2 *codt = [sharedGameController.gameScenes objectForKey:@"ChapterOne"];
        shouldAttack = YES;
        if (codt.roderickBattleTutorial) {
            shouldAttack = NO;
        }

	}
    //NSLog(@"Got through if part");
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
	isAlive = YES;
	return self;
    //NSLog(@"Should be returned.");
}

- (void)updateWithDelta:(float)aDelta {
    
    if (!shouldAttack) {
        return;
    }
    [super updateWithDelta:aDelta];
}

- (void)decideWhatToDo {
    
    if ([super canIDoThis:ai]) {
        [super doThis:ai decider:self];
        return;
    }
    //NSLog(@"Swordman can't do anything.");
}


- (void)youTookDamage:(int)aDamage {
    
    [super youTookDamage:aDamage];
    ChapterOneDemoTestV2 *codt = [sharedGameController.gameScenes objectForKey:@"ChapterOne"];
    if (codt.roderickBattleTutorial) {
        [sharedGameController.currentScene moveToNextStageInScene];
    }
}

- (void)youTookCriticalDamage:(int)aDamage {
    
    [super youTookCriticalDamage:aDamage];
    ChapterOneDemoTestV2 *codt = [sharedGameController.gameScenes objectForKey:@"ChapterOne"];
    if (codt.roderickBattleTutorial) {
        [sharedGameController.currentScene moveToNextStageInScene];
    }
}



@end
