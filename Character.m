//
//  Character.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Character.h"
#import "Image.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "AbstractRuneDrawingAnimation.h"
#import "RoderickSkillAnimation.h"
#import "ValkyrieSkillAnimation.h"
#import "WizardSkillAnimation.h"
#import "RangerSkillAnimation.h"
#import "PoetSkillAnimation.h"
#import "DwarfSkillAnimation.h"


@implementation Character

@synthesize whichCharacter;
@synthesize state;
@synthesize level;
@synthesize hp;
@synthesize maxHP;
@synthesize essence;
@synthesize maxEssence;
@synthesize endurance;
@synthesize maxEndurance;
@synthesize strength;
@synthesize agility;
@synthesize stamina;
@synthesize dexterity;
@synthesize power;
@synthesize affinity;
@synthesize magic;
@synthesize luck;
@synthesize skyAffinity;
@synthesize waterAffinity;
@synthesize rageAffinity;
@synthesize lifeAffinity;
@synthesize fireAffinity;
@synthesize stoneAffinity;
@synthesize woodAffinity;
@synthesize poisonAffinity;
@synthesize deathAffinity;
@synthesize divineAffinity;
@synthesize experience;
@synthesize toNextLevel;
@synthesize characterImage;
@synthesize isAlive;
@synthesize name;
@synthesize knownRunes;
@synthesize skillAnimation;
@synthesize weaponRuneStones;
@synthesize armorRuneStones;

- (id)initRoderick {
	
	if (self = [super init]) {
		sharedGameController = [GameController sharedGameController];
		whichCharacter = kRoderick;
		state = kEntityState_Alive;
		level = 1;
		hp = 70;
		maxHP = 70;
		essence = 0;
		maxEssence = 0;
        endurance = 10;
        maxEndurance = 10;
		strength = 2;
		agility = 1;
		stamina = 1;
		dexterity = 1;
		power = 2;
		luck = 1;
        affinity = 2;
		experience = 0;
		toNextLevel = 75;
        waterAffinity = 10;
        skyAffinity = 10;
        rageAffinity = lifeAffinity = fireAffinity = stoneAffinity = woodAffinity = poisonAffinity = divineAffinity = deathAffinity = 10;
		characterImage = [sharedGameController.teorPSS imageForKey:@"RoderickFacingForward50x80.png"];
		isAlive = YES;
		name = @"Roderick";
		knownRunes = [[NSMutableDictionary alloc] init];
		skillAnimation = [[RoderickSkillAnimation alloc] init];
		weaponRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
		armorRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
	}
	
	return self;
}

- (id)initValkyrie {
	
	if (self = [super init]) {
		sharedGameController = [GameController sharedGameController];
		whichCharacter = kValkyrie;
		state = kEntityState_Alive;
		level = 1;
		hp = 75;
		maxHP = 75;
		essence = 10;
		maxEssence = 0;
        endurance = 0;
        maxEndurance = 10;
		strength = 1;
		agility = 2;
		stamina = 2;
		dexterity = 2;
		power = 1;
		luck = 1;
        affinity = 2;
        waterAffinity = 10;
        skyAffinity = 10;
        stoneAffinity = 10;
        rageAffinity = 10;
        lifeAffinity = 10;
        deathAffinity = 10;
        fireAffinity = woodAffinity = poisonAffinity = divineAffinity = 10;
		experience = 25;
		toNextLevel = 50;
		characterImage = [sharedGameController.teorPSS imageForKey:@"Valkyrie50x80.png"];
		isAlive = YES;
		name = @"Valkyrie";
		knownRunes = [[NSMutableDictionary alloc] init];
		skillAnimation = [[ValkyrieSkillAnimation alloc] init];
		weaponRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
		armorRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
	}
	
	return self;
	
}

- (id)initWizard {
	
	if (self = [super init]) {
		sharedGameController = [GameController sharedGameController];
		whichCharacter = kWizard;
		state = kEntityState_Alive;
		level = 1;
		hp = 60;
		maxHP = 60;
		essence = 20;
		maxEssence = 20;
        endurance = 10;
        maxEndurance = 10;
		strength = 1;
		agility = 1;
		stamina = 1;
		dexterity = 1;
		power = 2;
		magic = 1;
		luck = 2;
        affinity = 2;
        waterAffinity = 10;
        skyAffinity = 10;
        rageAffinity = 10;
        fireAffinity = 10;
        stoneAffinity = 10;
        divineAffinity = 10;
        lifeAffinity = woodAffinity = poisonAffinity = deathAffinity = 10;
		experience = 0;
		toNextLevel = 75;
		characterImage = [sharedGameController.teorPSS imageForKey:@"Wizard50x80.png"];
		isAlive = YES;
		name = @"Wizard";
		knownRunes = [[NSMutableDictionary alloc] init];
		skillAnimation = [[WizardSkillAnimation alloc] init];
		weaponRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
		armorRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
	}
	
	return self;
	
}

- (id)initRanger {
	
	if (self = [super init]) {
		sharedGameController = [GameController sharedGameController];
		whichCharacter = kRanger;
		state = kEntityState_Alive;
		level = 1;
		hp = 75;
		maxHP = 75;
		essence = 12;
		maxEssence = 12;
        endurance = 12;
        maxEndurance = 12;
		strength = 1;
		agility = 2;
		stamina = 1;
		dexterity = 2;
		power = 1;
		luck = 3;
        affinity = 2;
        waterAffinity = 10;
        skyAffinity = 10;
        lifeAffinity = 10;
        stoneAffinity = 10;
        woodAffinity = 10;
        poisonAffinity = 10;
        rageAffinity = fireAffinity = divineAffinity = deathAffinity = 10;
		experience = 0;
		toNextLevel = 75;
		characterImage = [sharedGameController.teorPSS imageForKey:@"Ranger50x80.png"];
		isAlive = YES;
		name = @"Ranger";
		knownRunes = [[NSMutableDictionary alloc] init];
		skillAnimation = [[RangerSkillAnimation alloc] init];
		weaponRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
		armorRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
	}
	
	return self;
}	
	
- (id)initPriest {
	
	if (self = [super init]) {
		sharedGameController = [GameController sharedGameController];
		whichCharacter = kPriest;
		state = kEntityState_Alive;
		level = 1;
		hp = 75;
		maxHP = 75;
		essence = 12;
		maxEssence = 12;
        endurance = 12;
        maxEndurance = 12;
		strength = 1;
		agility = 1;
		stamina = 1;
		dexterity = 1;
		power = 2;
		luck = 3;
        affinity = 2;
        waterAffinity = 10;
        skyAffinity = 8;
        poisonAffinity = 80;
        lifeAffinity = 4;
        divineAffinity = 12;
        deathAffinity = 5;
        rageAffinity = fireAffinity = stoneAffinity = woodAffinity = 2;
		experience = 0;
		toNextLevel = 75;
		characterImage = [sharedGameController.teorPSS imageForKey:@"Priest50x80.png"];
		isAlive = YES;
		name = @"Poet";
		knownRunes = [[NSMutableDictionary alloc] init];
		skillAnimation = [[PoetSkillAnimation alloc] init];
		weaponRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
		armorRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
	}
	
	return self;
}

- (id)initDwarf {
	
	if (self = [super init]) {
		sharedGameController = [GameController sharedGameController];
		whichCharacter = kDwarf;
		state = kEntityState_Alive;
		level = 1;
		hp = 75;
		maxHP = 75;
		essence = 12;
		maxEssence = 12;
        endurance = 13;
        maxEndurance = 13;
		strength = 2;
		agility = 1;
		stamina = 2;
		dexterity = 1;
		power = 1;
		luck = 3;
        affinity = 2;
        waterAffinity = 10;
        skyAffinity = 8;
        rageAffinity = lifeAffinity = fireAffinity = stoneAffinity = woodAffinity = poisonAffinity = divineAffinity = deathAffinity = 2;
		experience = 0;
		toNextLevel = 75;
		characterImage = [sharedGameController.teorPSS imageForKey:@"Dwarf50x80.png"];
		isAlive = YES;
		name = @"Dwarf";
		knownRunes = [[NSMutableDictionary alloc] init];
		skillAnimation = [[DwarfSkillAnimation alloc] init];
		weaponRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
		armorRuneStones = [[NSMutableArray alloc] initWithCapacity:1];
	}
	
	return self;
}
	
	
- (void)learnRune:(AbstractRuneDrawingAnimation *)aRune withKey:(NSString *)aKey {
    
    [knownRunes setObject:aRune forKey:aKey];

}

- (void)levelUp {
    
    level++;
    strength++;
    agility++;
    stamina++;
    dexterity++;
    power++;
    affinity++;
    if (maxEssence != 0) {
        maxEssence++;
    }
    maxEndurance++;
    switch (whichCharacter) {
        case kRoderick:
            if (RANDOM_0_TO_1() > 0.5) {
                strength++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                agility++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                stamina++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                dexterity++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                power++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                affinity++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                luck++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                endurance++;
            }
            if (essence > 0 && RANDOM_0_TO_1() > 0.66) {
                essence++;
            }
            break;
        case kValkyrie:
            if (RANDOM_0_TO_1() > 0.66) {
                strength++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                agility++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                stamina++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                dexterity++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                power++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                affinity++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                luck++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                endurance++;
            }
            if (essence > 0 && RANDOM_0_TO_1() > 0.66) {
                essence++;
            }
            break;
        case kWizard:
            if (RANDOM_0_TO_1() > 0.66) {
                strength++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                agility++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                stamina++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                dexterity++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                power++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                affinity++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                luck++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                endurance++;
            }
            if (essence > 0 && RANDOM_0_TO_1() > 0.5) {
                essence++;
            }
            break;
        case kRanger:
            if (RANDOM_0_TO_1() > 0.57) {
                strength++;
            }
            if (RANDOM_0_TO_1() > 0.57) {
                agility++;
            }
            if (RANDOM_0_TO_1() > 0.57) {
                stamina++;
            }
            if (RANDOM_0_TO_1() > 0.57) {
                dexterity++;
            }
            if (RANDOM_0_TO_1() > 0.57) {
                power++;
            }
            if (RANDOM_0_TO_1() > 0.57) {
                affinity++;
            }
            if (RANDOM_0_TO_1() > 0.57) {
                luck++;
            }
            if (RANDOM_0_TO_1() > 0.57) {
                endurance++;
            }
            if (essence > 0 && RANDOM_0_TO_1() > 0.7) {
                essence++;
            }
            break;
        case kPriest:
            if (RANDOM_0_TO_1() > 0.66) {
                strength++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                agility++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                stamina++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                dexterity++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                power++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                affinity++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                luck++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                endurance++;
            }
            if (essence > 0 && RANDOM_0_TO_1() > 0.5) {
                essence++;
            }
            break;
        case kDwarf:
            if (RANDOM_0_TO_1() > 0.5) {
                strength++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                agility++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                stamina++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                dexterity++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                power++;
            }
            if (RANDOM_0_TO_1() > 0.66) {
                affinity++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                luck++;
            }
            if (RANDOM_0_TO_1() > 0.5) {
                endurance++;
            }
            if (essence > 0 && RANDOM_0_TO_1() > 0.66) {
                essence++;
            }
            break;
        default:
            break;
    }
    endurance = maxEndurance;
    essence = maxEssence;
    maxHP += (level + (level * 0.5) + stamina);
    hp = maxHP;
    toNextLevel = level * (level * 0.5) * 64;
}

- (NSString *)getNameForCharacter:(int)aCharacter {
    NSString *characterName;
    switch (aCharacter) {
        case kRoderick:
            characterName = @"Roderick";
            break;
        case kValkyrie:
            characterName = @"Ally";
            break;
        case kWizard:
            characterName = @"Seior";
            break;
        case kRanger:
            characterName = @"Ranger";
            break;
        case kPriest:
            characterName = @"Poet";
            break;
        case kDwarf:
            characterName = @"Alvis";
            break;
            
            
        default:
            break;
    }
    return characterName;
}

@end
