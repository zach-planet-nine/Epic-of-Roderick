//
//  AbstractBattleEntity.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

@class GameController;
@class TouchManager;
@class InputManager;
@class Image;
@class BitmapFont;


@interface AbstractBattleEntity : NSObject {

	GameController *sharedGameController;
	TouchManager *sharedTouchManager;
	InputManager *sharedInputManager;
	
    int whichCharacter;
    
	int state;
	float level;
	float levelModifier;
	float hp;
	float maxHP;
	float essence;
	float maxEssence;
    float endurance;
    float maxEndurance;
	float strength;
	float strengthModifier;
	float agility;
	float agilityModifier;
	float stamina;
	float staminaModifier;
	float dexterity;
	float dexterityModifier;
	float power;
	float powerModifier;
    float affinity;
    float affinityModifier;
	float luck;
	float luckModifier;
    int criticalChance;
	int bleeders;
	float bleederTimers[10];
	BOOL isAlive;
	BOOL hasSelectorImage;
	CGRect rect;
	CGPoint renderPoint;
	NSMutableArray *statuses;
	Image *selectorImage;
	float battleTimer;
    
    //Elemental Affinities
    float waterAffinity;
    float skyAffinity;
    float fireAffinity;
    float stoneAffinity;
    float lifeAffinity;
    float deathAffinity;
    float woodAffinity;
    float poisonAffinity;
    float divineAffinity;
    float rageAffinity;
    
    //Flags for elements
    int isProtectedFromWater;
    int isProtectedFromSky;
    int isProtectedFromFire;
    int isProtectedFromStone;
    int isProtectedFromLife;
    int isProtectedFromDeath;
    int isProtectedFromWood;
    int isProtectedFromPoison;
    int isProtectedFromDivine;
    int isProtectedFromRage;
    
    BOOL waterProtectionEquipped;
    BOOL skyProtectionEquipped;
    BOOL fireProtectionEquipped;
    BOOL stoneProtectionEquipped;
    BOOL lifeProtectionEquipped;
    BOOL rageProtectionEquipped;
    BOOL woodProtectionEquipped;
    BOOL poisonProtectionEquipped;
    BOOL divineProtectionEquipped;
    BOOL deathProtectionEquipped;
    
    int waterAttack;
    int skyAttack;
    int fireAttack;
    int stoneAttack;
    int lifeAttack;
    int rageAttack;
    int woodAttack;
    int poisonAttack;
    int deathAttack;
    int divineAttack;
    
    BOOL waterAttackEquipped;
    BOOL skyAttackEquipped;
    BOOL fireAttackEquipped;
    BOOL stoneAttackEquipped;
    BOOL lifeAttackEquipped;
    BOOL rageAttackEquipped;
    BOOL woodAttackEquipped;
    BOOL poisonAttackEquipped;
    BOOL deathAttackEquipped;
    BOOL divineAttackEquipped;
    
    //Bools and timers for statuses;
	BOOL isBlind;
	float blindTimer;
	BOOL isParalyzed;
	float paralyzeTimer;
    BOOL isFatigued;
    float fatigueTimer;
    BOOL isMotivated;
    float motivatedTimer;
    BOOL isDrauraed;
    float drauraTimer;
    BOOL isAuraed;
    float auraTimer;
    BOOL isDisoriented;
    float disorientedTimer;
    BOOL isHexed;
    float hexTimer;
    BOOL isSlothed;
    float slothTimer;
    
    BOOL fatigueAttack;
    BOOL drauraAttack;
    BOOL disorientedAttack;
    BOOL hexAttack;
    BOOL slothAttack;
    
    BOOL fatigueProtection;
    BOOL drauraProtection;
    BOOL disorientedProtection;
    BOOL hexProtection;
    BOOL slothProtection;
    BOOL deathProtection;
    
    //Flags and ints for battle effects
    int essenceHelper; // for Ansuz weapon equip
    BOOL geboPotential;
    BOOL othalaPotential;
    int numberOfAttacks;
    int doubleAttack;
    BOOL cannotBeHealed;
    BOOL attacksRefillItemTimers;
    BOOL essenceDrain;
    BOOL mayCounterAttack;
    BOOL receiveDoubleHealing;
    BOOL doubleHealingGiven;
    BOOL attacksAddToRageMeter;
    BOOL attacksAddToStatusTimers;
    BOOL protectedFromBleeders;
    BOOL willTakeDoubleDamage;
    uint attackModifier;
    uint effectModifier;
    BOOL doubleEffect;
    BOOL enduranceAttack;
    BOOL enduranceDoesNotDeplete;
    BOOL halfEnduranceExpenditure;
    BOOL attackAttacksAllEnemies;
    BOOL enhanceBleederDamage;
    BOOL damageEssence;
    BOOL rainIsHealingYou;
    BOOL damageEndurance;
    BOOL attacksCauseBleeders;
    BOOL attackAddsSkeletonsToWunjo;
    BOOL boneShield;
    BOOL attackEnhancesFavor;
    BOOL hpAttack;
    BOOL autoRaise;
    BOOL drainAttack;
    BOOL drainAttackEquipped;
    
	
	//Variables for rendering effects. Probably change to font render manager eventually
	BitmapFont *battleFont;
	CGPoint fontRenderPoint;
	BOOL renderDamage;
	CGPoint damageRenderPoint;
	int damage;
	int healing;
	BOOL renderHealing;
	CGPoint healingRenderPoint;
	BOOL renderEssenceGain;
	int essenceGain;
	CGPoint essenceRenderPoint;
	
	//Properties for animations
	Color4f essenceColor;
	
	//For flashes
	Color4f flashColor;
	BOOL isFlashing;
	int flashes;
	float flashTimer;
    
    BOOL active;
    
    BOOL wait;
    float waitTimer;
	
}

@property (nonatomic, assign) int whichCharacter;
@property (nonatomic, assign) int state;
@property (nonatomic, assign) float level;
@property (nonatomic, assign) float levelModifier;
@property (nonatomic, assign) float hp;
@property (nonatomic, assign) float maxHP;
@property (nonatomic, assign) float essence;
@property (nonatomic, assign) float maxEssence;
@property (nonatomic, assign) float endurance;
@property (nonatomic, assign) float maxEndurance;
@property (nonatomic, assign) float strength;
@property (nonatomic, assign) float strengthModifier;
@property (nonatomic, assign) float agility;
@property (nonatomic, assign) float agilityModifier;
@property (nonatomic, assign) float stamina;
@property (nonatomic, assign) float staminaModifier;
@property (nonatomic, assign) float dexterity;
@property (nonatomic, assign) float dexterityModifier;
@property (nonatomic, assign) float power;
@property (nonatomic, assign) float powerModifier;
@property (nonatomic, assign) float affinity;
@property (nonatomic, assign) float affinityModifier;
@property (nonatomic, assign) float luck;
@property (nonatomic, assign) float luckModifier;
@property (nonatomic, readonly) int criticalChance;
@property (nonatomic, assign) float waterAffinity;
@property (nonatomic, assign) float skyAffinity;
@property (nonatomic, assign) float lifeAffinity;
@property (nonatomic, assign) float rageAffinity;
@property (nonatomic, assign) float fireAffinity;
@property (nonatomic, assign) float stoneAffinity;
@property (nonatomic, assign) float woodAffinity;
@property (nonatomic, assign) float poisonAffinity;
@property (nonatomic, assign) float divineAffinity;
@property (nonatomic, assign) float deathAffinity;
@property (nonatomic, readonly) int isProtectedFromSky;
@property (nonatomic, readonly) int isProtectedFromWater;
@property (nonatomic, readonly) int isProtectedFromRage;
@property (nonatomic, readonly) int isProtectedFromLife;
@property (nonatomic, readonly) int isProtectedFromFire;
@property (nonatomic, readonly) int isProtectedFromStone;
@property (nonatomic, readonly) int isProtectedFromWood;
@property (nonatomic, readonly) int isProtectedFromPoison;
@property (nonatomic, readonly) int isProtectedFromDeath;
@property (nonatomic, readonly) int isProtectedFromDivine;
@property (nonatomic, assign) int essenceHelper;
@property (nonatomic, assign) BOOL isAlive;
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) CGPoint renderPoint;
@property (nonatomic, assign) float battleTimer;
@property (nonatomic, assign) Color4f essenceColor;
@property (nonatomic, assign) BOOL isBlind;
@property (nonatomic, assign) BOOL isParalyzed;
@property (nonatomic, assign) BOOL isFatigued;
@property (nonatomic, assign) BOOL isMotivated;
@property (nonatomic, assign) BOOL isDrauraed;
@property (nonatomic, assign) BOOL isAuraed;
@property (nonatomic, assign) BOOL isDisoriented;
@property (nonatomic, assign) BOOL isHexed;
@property (nonatomic, assign) BOOL isSlothed;
@property (nonatomic, assign) BOOL cannotBeHealed;
@property (nonatomic, assign) BOOL enhanceBleederDamage;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) BOOL wait;
@property (nonatomic, assign) float waitTimer;
@property (nonatomic, assign) BOOL waterProtectionEquipped;
@property (nonatomic, assign) BOOL skyProtectionEquipped;
@property (nonatomic, assign) BOOL rageProtectionEquipped;
@property (nonatomic, assign) BOOL lifeProtectionEquipped;
@property (nonatomic, assign) BOOL fireProtectionEquipped;
@property (nonatomic, assign) BOOL stoneProtectionEquipped;
@property (nonatomic, assign) BOOL woodProtectionEquipped;
@property (nonatomic, assign) BOOL poisonProtectionEquipped;
@property (nonatomic, assign) BOOL divineProtectionEquipped;
@property (nonatomic, assign) BOOL deathProtectionEquipped;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

- (void)takeDamage:(int)aDamage;

- (BOOL)isDead;

- (void)resetBattleTimer;

- (CGRect)getRect;  //Override for different entities based on their size.

- (void)addSelectorImage;

- (void)removeSelectorImage;

- (void)relinquishPriority;

- (void)youHaveDied;

- (void)youWereRaised;

- (void)addBleeder;

- (void)removeBleeder;

- (BOOL)hasBleeders;

- (int)calculateBleederDamage;

- (void)youTookDamage:(int)aDamage;

- (void)youTookCriticalDamage:(int)aDamage;

- (void)youTookEssenceDamage:(int)aEssenceDamage;

- (void)youWereHealed:(int)aHealing;

- (void)youWereGivenEssence:(int)aEssence;

- (void)youWereGivenEndurance:(int)aEndurance;

- (void)gainPriority;

- (void)flashColor:(Color4f)aColor;

- (void)increaseLevelModifierBy:(int)aMod;

- (void)decreaseLevelModifierBy:(int)aMod;

- (void)increaseStrengthModifierBy:(int)aMod;

- (void)decreaseStrengthModifierBy:(int)aMod;

- (void)increaseAgilityModifierBy:(int)aMod;

- (void)decreaseAgilityModifierBy:(int)aMod;

- (void)increaseStaminaModifierBy:(int)aMod;

- (void)decreaseStaminaModifierBy:(int)aMod;

- (void)increaseDexterityModifierBy:(int)aMod;

- (void)decreaseDexterityModifierBy:(int)aMod;

- (void)increasePowerModifierBy:(int)aMod;

- (void)decreasePowerModifierBy:(int)aMod;

- (void)increaseAffinityModifierBy:(int)aMod;

- (void)decreaseAffinityModifierBy:(int)aMod;

- (void)increaseLuckModifierBy:(int)aMod;

- (void)decreaseLuckModifierBy:(int)aMod;

- (void)youWereBlinded:(int)aBlindRoll;

- (void)youWereFatigued:(int)aFatigueRoll;

- (void)youWereMotivated:(int)aMotivationRoll;

- (void)youWereDrauraed:(int)aDrauraRoll;

- (void)youWereAuraed:(int)aAuraRoll;

- (void)youWereDisoriented:(int)aDisorientedRoll;

- (void)youWereHexed:(int)aHexRoll;

- (void)youWereSlothed:(int)aSlothRoll;

- (void)unlockGeboPotential;

- (void)unlockOthalaPotential;

- (void)unlockOthalaEquippedPotential;

- (void)enduranceDoesNotDeplete;

- (void)enduranceDoesDeplete;

- (void)gainElementalAttack:(int)aElement;

- (void)loseElementalAttack:(int)aElement;

- (void)gainElementalProtection:(int)aElement;

- (void)loseElementalProtection:(int)aElement;

- (void)youGainedDoubleHealing;

- (void)youLostDoubleHealing;

- (void)youWereBerkanoed;

- (void)gainProtectionFromDying;

- (void)loseProtectionFromDying;

- (void)addToStatusDurations:(float)aDuration;

- (void)youWillTakeDoubleDamage;

- (void)gainDoubleEffect;

- (void)youWillNotLoseEndurance;

- (void)youWillLoseEndurance;

- (void)youWillLoseHalfEndurance;

- (void)youWillNotLoseHalfEndurance;

- (void)attacksWillCauseBleeders;

- (void)attacksWillNotCauseBleeders;

- (void)gainAutoRaise;

- (void)loseAutoRaise;

- (void)gainDrainAttack;

- (void)loseDrainAttack;

@end
