//
//  Global.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import "Structures.h"

#define SLQLOG(...) //NSLog(__VA_ARGS__);
//#define SLQLOG(...)

#define SCB 0

#pragma mark -
#pragma mark Macros

#define RANDOM_MINUS_1_TO_1() cosf( ((arc4random() % 100) * 0.01f) * 3.1415927f)

#define RANDOM_0_TO_1() ( ( arc4random() % 100 ) * 0.01f )

// Macro which converts degrees into radians
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

// Macro that allows you to clamp a value within the defined bounds
#define CLAMP(X, A, B) ((X < A) ? A : ((X > B) ? B : X))

// Macro to try to find the max of 8 integers
#define MAX_8(A, B, C, D, E, F, G, H) (MAX(MAX(MAX(MAX(MAX(MAX(MAX(A, B),C),D),E),F),G),H))

#pragma mark -
#pragma mark Enumerators


// Game states
enum {
	kGameState_Battle,
	kGameState_Menu,
	kGameState_Cutscene,
	kGameState_World
};

//Scene ints
enum {
    kRealm_ChapterOneCamp,
    kRealm_ChapterOneChampionBattle,
    kRealm_RangerBattleTutorial,
	kRealm_Midgard,
	kRealm_Alfheim,
    kAllowBattles = 12459
};

// Moving directions. Used for touches and for entities.
enum {
	kNotMoving = 0,
	kMovingRight = 13,
	kMovingLeft = 23,
	kMovingUp = 37,
	kMovingDown = 43,
	kMovingUpRight = 53,
	kMovingUpLeft = 67,
	kMovingDownRight = 79,
	kMovingDownLeft = 87,
	kMovingAutomated = 1337
};

// Input Manager states
enum {
	kNoOnesTurn, // 0
	kRoderick,
	kRoderickAttacking,
	kRoderickElementalLineDrawing,
	kRoderickRuneDrawing,
	kRoderickRunePlacement,
	kValkyrie,
	kValkyrieFlying,
    kValkyrieMustDrawLine,
	kValkyrieRageLineDrawing,
	kValkyrieRage,  //10
	kValkyrieRuneDrawing,
	kValkyrieRunePlacement,
	kWizard,
	kWizardAttacking,
	kWizardRuneDrawing,
	kWizardRunePlacement,
	kRanger,
	kRangerAnimalLineDrawing,
	kRangerRuneDrawing,
	kRangerRunePlacement,  //20
	kPriest,
	kPriestAttacking,
	kPriestSacrificing,
	kPriestRuneDrawing,
	kPriestRunePlacement,
	kDwarf,
	kDwarfAttacking,
	kDwarfBeerOrdering,
    kBattleExperienceScreen,
	kNoTouchesAllowed,  //30
	kTextboxOnScreen,
	kWalkingAround_NoTouches,
	kWalkingAround_RightTouchDown,
	kWalkingAround_LeftTouchDown,
	kWalkingAround_BothSidesDown,
	kWalkingAround_TextboxOnScreen,
	kMenuMayOpen,
	kMenuOpen,
    kCutScene_TextboxOnScreen,
    kCutScene_MustTapRect,  //40
    kChoiceboxOnScreen,
    kCutScene_ScriptReader,
    kCutScene_LastLine,
    kTutorial_TextboxOnScreen,
    kTutorial_LastLine,
    kTutorial_MustTapRect
};

//Battle entity states. Add statuses here.
enum {
	kEntityState_Alive,
	kEntityState_Wounded,
	kEntityState_Dead
};

//Enemies
enum  {
    kSwordMan,
    kAxeMan,
	kSlime,
	kOrc,
	kImp,
    kEnemyChampion
};

// Items
enum {
	kPotion,
	kEther
};

//Elements and stats
enum {
	kNoElement,
	kWater,
    kSky,
    kRage,
    kLife,
    kFire,
    kStone,
    kWood,
	kPoison,
    kDivine,
    kDeath,
	kBone,
	kProtection,
    kLevel,
    kStrength,
    kPower,
    kStamina,
    kAgility,
    kDexterity,
    kAffinity,
    kLuck
};

// Enemy AI
enum {
    kAIAllEnemies,
    kAISelf,
    kAIAllCharacters,
    kAIAnyEnemy,
    kAIEnemyWithLowestHP,
    kAIEnemyWithHighestHP,
    kAIEnemyWithLowestEssence,
    kAIEnemyWithHighestEssence,
    kAIEnemyWithLowestEndurance,
    kAIEnemyWithHighestEndurance,
    kAIEnemyWithLowestDefense, // 10
    kAIEnemyWithLowestAffinity,
    kAIEnemyWithHPBelowPercent,
    kAIEnemyWithEssenceBelowPercent,
    kAIEnemyWithEnduranceBelowPercent,
    kAIFatiguedEnemy,
    kAIDrauraedEnemy,
    kAISlothedEnemy,
    kAIHexedEnemy,
    kAIDisorientedEnemy,
    kAIEnemyHasNegativeStatus, // 20
    kAIEnemyHasBleeders,
    kAINeedsElementalGuard, 
    kAINeedsElementalAttack,
    kAIEnemyNotMotivated,
    kAIEnemyNotAuraed,
    kAIAnyCharacter,
    kAICharacterWithLowestHP,
    kAICharacterWithHighestHP,
    kAICharacterWithLowestStat,
    kAICharacterWithHighestStat, // 30
    kAICharacterWithHighestEssence, 
    kAICharacterWithHighestEndurance, 
    kAICharacterWithLowestEndurance,
    kAICharacterWithLowestEssence,
    kAICharacterWithHPAbovePercent,
    kAICharacterWithEssenceAbovePercent,
    kAICharacterWithEnduranceAbovePercent,
    kAICharacterWithHPBelowPercent,
    kAICharacterWithEssenceBelowPercent,
    kAICharacterWithEnduranceBelowPercent, // 40
    kAIAuraedCharacter, 
    kAIMotivatedCharacter, 
    kAIFatiguedCharacter,
    kAIDrauraedCharacter, 
    kAISlothedCharacter,
    kAIHexedCharacter,
    kAIDisorientedCharacter,
    kAICharacterWithLowestElementalAffinity,
    kAICharacterWithHighestElementalAffinity,
    kAIEndurancePercent, // 50
    kAIEssencePercent, 
    kAIHPPercent, 
    kAIEnduranceAmount,
    kAIEssenceAmount, 
    kAIHPAmount,
    
    //Start abilities
    kAIEnemySmash,
    kAIEnemyBite,
    kAIEnemyEnergyBall,
    kAIEnemyHeal,
    kAIEnemyFire, // 60
    kAIEnemyFireAllCharacters,
    kAIEnemyFatigueCure, 
    kAIEnemyHealNegativeStatus,
    kAIEnemyArrow,
    kAIEnemySlash,
    kAIEnemyHealBleeder,
    kAIEnemyPoisonAllCharacters,
    kAIEnemyPoison,
    kAIEnemyWaterAllCharacters,
    kAIEnemyWater, // 70
    kAIEnemyRage,
    kAIEnemyRageAllCharacters,
    
    //Start dwarf abilities
    kAIDoNothing,
    kAIDwarfapult,
    kAIBombulus,
    kAIFinishingMove,
    kAIBoobyTrap,
    kAISuperAxerang,
    kAIBuyARound,
    kAIMotivate,
    kAISuperSecretAttack
    
};

#pragma mark -
#pragma mark Constants

// Name of the scenes
#define kGame_Scene_Name @"game"
#define kMenu_Scene_Name @"menu"

// Tile map details
#define kTile_Width 40
#define kTile_Height 40
#define kMax_Map_Width 200
#define kMax_Map_Height 200

// Spawning
#define kMax_Player_Distance 6

#pragma mark -
#pragma mark Inline Functions

// Converts a tile position into a pixel position
static inline CGPoint tileMapPositionToPixelPosition(CGPoint tmp) {
	return CGPointMake((int)(tmp.x * kTile_Width), (int)(tmp.y * kTile_Height));
}

// Returns YES is the point provided is inside the closed poly defined by
// the vertices provided
static inline BOOL isPointInPoly(int sides, float *px, float *py, CGPoint point) {
	int sideCount;
	int totalSides = sides - 1;
	BOOL inside = NO;
	
	for (sideCount = 0; sideCount < sides; sideCount++) {
		if ((py[sideCount] < point.y && py[totalSides] >= point.y) ||
			(py[totalSides] < point.y && py[sideCount] >= point.y)) {
			if (px[sideCount] + (point.y - py[sideCount]) / (py[totalSides] - py[sideCount]) * (px[totalSides] - px[sideCount]) < point.x) {
				inside = !inside;
			}
		}
	}
	return inside;
}

// Returns YES if the rectangle and circle interset each other.  This include the circle being fulling inside
// the rectangle.
static inline BOOL RectIntersectsCircle(CGRect aRect, Circle aCircle) {
	
	float testX = aCircle.x;
	float testY = aCircle.y;
	
	if (testX < aRect.origin.x)
		testX = aRect.origin.x;
	if (testX > (aRect.origin.x + aRect.size.width))
		testX = (aRect.origin.x + aRect.size.width);
	if (testY < aRect.origin.y)
		testY = aRect.origin.y;
	if (testY > (aRect.origin.y + aRect.size.height))
		testY = (aRect.origin.y + aRect.size.height);
	
	return ((aCircle.x - testX) * (aCircle.x - testX) + (aCircle.y - testY) * (aCircle.y - testY)) < aCircle.radius * aCircle.radius;		
}

// Returns YES if the two circles provided intersect each other
static inline BOOL CircleIntersectsCircle(Circle aCircle1, Circle aCircle2) {
	float dx = aCircle2.x - aCircle1.x;
	float dy = aCircle2.y - aCircle1.y;
	float radii = aCircle1.radius + aCircle2.radius;
	
	return ((dx * dx) + (dy * dy)) < radii * radii;
}

// Return a Color4f structure populated with 1.0's
static const Color4f Color4fOnes = {1.0f, 1.0f, 1.0f, 1.0f};

static const Color4f Red = {1.0f, 0.0f, 0.0f, 1.0f};

static const Color4f Green = {0.0f, 1.0f, 0.0f, 1.0f};

static const Color4f Blue = {0.0f, 0.0f, 1.0f, 1.0f};

static const Color4f Yellow = {1.0f, 1.0f, 0.0f, 1.0f};

// Return a zero populated Vector2f
static const Vector2f Vector2fZero = {0.0f, 0.0f};

// Return a Scale2f structure populated with the provided floats
static inline Scale2f Scale2fMake(float x, float y) {
    return (Scale2f) {x, y};
}

// Return a populated Vector2d structure from the floats passed in
static inline Vector2f Vector2fMake(GLfloat x, GLfloat y) {
	return (Vector2f) {x, y};
}

static inline CGPoint vm(GLfloat x, GLfloat y) {
	return (CGPoint) {x, y};
}

// Return a Color4f structure populated with the color values passed in
static inline Color4f Color4fMake(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha) {
	return (Color4f) {red, green, blue, alpha};
}

// Return a Vector2f containing v multiplied by s
static inline Vector2f Vector2fMultiply(Vector2f v, GLfloat s) {
	return (Vector2f) {v.x * s, v.y * s};
}

// Return a Vector2f containing v1 + v2
static inline Vector2f Vector2fAdd(Vector2f v1, Vector2f v2) {
	return (Vector2f) {v1.x + v2.x, v1.y + v2.y};
}

// Return a Vector2f containing v1 - v2
static inline Vector2f Vector2fSub(Vector2f v1, Vector2f v2) {
	return (Vector2f) {v1.x - v2.x, v1.y - v2.y};
}

// Return the dot product of v1 and v2
static inline GLfloat Vector2fDot(Vector2f v1, Vector2f v2) {
	return (GLfloat) v1.x * v2.x + v1.y * v2.y;
}

// Return the length of the vector v
static inline GLfloat Vector2fLength(Vector2f v) {
	return (GLfloat) sqrtf(Vector2fDot(v, v));
}

// Return a Vector2f containing a normalized vector v
static inline Vector2f Vector2fNormalize(Vector2f v) {
	return Vector2fMultiply(v, 1.0f/Vector2fLength(v));
}

// Make the AI stuff
static inline EnemyAI EnemyAISet(int stat, int threshold, int decider, int parameter, int ability) {
    return (EnemyAI) {stat, threshold, decider, parameter, ability};
}
