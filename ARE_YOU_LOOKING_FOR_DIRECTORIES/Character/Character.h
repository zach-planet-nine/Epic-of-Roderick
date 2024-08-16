//
//  Character.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Image;
@class GameController;
@class AbstractRuneDrawingAnimation;
@class AbstractSkillAnimation;

@interface Character : NSObject {

	GameController *sharedGameController;
	
	Image *characterImage;
	int whichCharacter;
	int state;
	int level;
	int hp;
	int maxHP;
	int essence;
	int maxEssence;
    int endurance;
    int maxEndurance;
	int strength;
	int agility;
	int stamina;
	int dexterity;
	int power;
    int affinity;
	int magic;
	int luck;
	int experience;
	int toNextLevel;
    int waterAffinity;
    int skyAffinity;
    int rageAffinity;
    int lifeAffinity;
    int fireAffinity;
    int stoneAffinity;
    int woodAffinity;
    int poisonAffinity;
    int divineAffinity;
    int deathAffinity;
	BOOL isAlive;
	NSString *name;
	NSMutableDictionary *knownRunes;
	NSMutableArray *weaponRuneStones;
	NSMutableArray *armorRuneStones;
	AbstractSkillAnimation *skillAnimation;
	
}

@property (nonatomic, assign) int whichCharacter;
@property (nonatomic, assign) int state;
@property (nonatomic, assign) int level;
@property (nonatomic, assign) int hp;
@property (nonatomic, assign) int maxHP;
@property (nonatomic, assign) int essence;
@property (nonatomic, assign) int maxEssence;
@property (nonatomic, assign) int endurance;
@property (nonatomic, assign) int maxEndurance;
@property (nonatomic, assign) int strength;
@property (nonatomic, assign) int agility;
@property (nonatomic, assign) int stamina;
@property (nonatomic, assign) int dexterity;
@property (nonatomic, assign) int power;
@property (nonatomic, assign) int affinity;
@property (nonatomic, assign) int magic;
@property (nonatomic, assign) int luck;
@property (nonatomic, assign) int skyAffinity;
@property (nonatomic, assign) int waterAffinity;
@property (nonatomic, assign) int rageAffinity;
@property (nonatomic, assign) int lifeAffinity;
@property (nonatomic, assign) int fireAffinity;
@property (nonatomic, assign) int stoneAffinity;
@property (nonatomic, assign) int woodAffinity;
@property (nonatomic, assign) int poisonAffinity;
@property (nonatomic, assign) int deathAffinity;
@property (nonatomic, assign) int divineAffinity;
@property (nonatomic, assign) int experience;
@property (nonatomic, assign) int toNextLevel;
@property (nonatomic, retain) Image *characterImage;
@property (nonatomic, assign) BOOL isAlive;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableDictionary *knownRunes;
@property (nonatomic, retain) AbstractSkillAnimation *skillAnimation;
@property (nonatomic, retain) NSMutableArray *weaponRuneStones;
@property (nonatomic, retain) NSMutableArray *armorRuneStones;

- (id)initRoderick;

- (id)initValkyrie;

- (id)initWizard;

- (id)initRanger;

- (id)initPriest;

- (id)initDwarf;

- (void)learnRune:(AbstractRuneDrawingAnimation *)aRune withKey:(NSString *)aKey;

- (void)levelUp;

- (NSString *)getNameForCharacter:(int)aCharacter;

@end
