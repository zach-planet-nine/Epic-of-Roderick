//
//  GameController.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "GameController.h"
#import "AnimationManagementTest.h"
#import "CutSceneTest.h"
#import "FontManager.h"
#import "TouchManager.h"
#import "InputManager.h"
#import "ScriptReader.h"
#import "BitmapFont.h"
#import "Image.h"
#import "WalkingAroundTest.h"
#import "ChapterOneDemoTest.h"
#import "ChapterOneDemoTestV2.h"
#import "Alfheim.h"
#import "Arena.h"
#import "Global.h"
#import "AbstractEntity.h"
#import "Character.h"
#import "BattleDwarf.h"
#import "BattlePriest.h"
#import "BattleRanger.h"
#import "BattleWizard.h"
#import "BattleValkyrie.h"
#import "BattleRoderick.h"
#import "PackedSpriteSheet.h"
#import "AnsuzMenuAnimation.h"
#import "EihwazMenuAnimation.h"
#import "DwarfapultMenuAnimation.h"
#import "BuyARoundMenuAnimation.h"
#import "FinishingMoveMenuAnimation.h"
#import "BoobytrapMenuAnimation.h"
#import "SuperAxerangMenuAnimation.h"


//#import "Common.h"

@interface GameController (Private)

- (void)initGame;

- (void)initCharacters;

- (void)initBattleCharacters;

@end


@implementation GameController

@synthesize currentScene;
@synthesize gameScenes;
@synthesize gameState;
@synthesize player;
@synthesize characters;
@synthesize realm;
@synthesize battleCharacters;
@synthesize teorPSS;
@synthesize party;
@synthesize healingLeaf;
@synthesize antidote;
@synthesize bandage;
@synthesize runeStones;


SYNTHESIZE_SINGLETON_FOR_CLASS(GameController);

- (id)init {
	self = [super init];
	if (self != nil) {
		currentScene = nil;
		sharedFontManager = [FontManager sharedFontManager];
		sharedTouchManager = [TouchManager sharedTouchManager];
		sharedInputManager = [InputManager sharedInputManager];
        sharedScriptReader = [ScriptReader sharedScriptReader];
		teorPSS = [[PackedSpriteSheet alloc] initWithImageNamed:@"TEORPackedSheet5.png" controlFile:@"TEORPackedSheet5" filter:GL_NEAREST];
        beginningTime = CACurrentMediaTime();
        //NSLog(@"beginningTime is: %f.", beginningTime);
		[self initGame];
	}
	return self;
}

- (void)updateCurrentSceneWithDelta:(float)aDelta {
	[currentScene updateSceneWithDelta:aDelta];
}

- (void)renderCurrentScene {
	[currentScene renderScene];
}

#pragma mark -
#pragma mark Accelerometer

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	
}

- (void)dealloc {
	[gameScenes release];
	[super dealloc];
}

- (CGPoint)adjustTouchOrientationForTouch:(CGPoint)aTouch {
	
	CGPoint touchLocation;
	
	touchLocation.x = aTouch.y;
	touchLocation.y = aTouch.x;
	
	return touchLocation;
}

@end

@implementation GameController (Private)

- (void)initGame {
	
	[self initCharacters];
	
	BitmapFont *battleFont = [[BitmapFont alloc] initWithFontImageNamed:@"Impact32.png" controlFile:@"Impact32" scale:Scale2fMake(1, 1) filter:GL_LINEAR];
	[sharedFontManager addFont:battleFont withKey:@"battleFont"];
	[battleFont release];
	
	BitmapFont *textboxFont = [[BitmapFont alloc] initWithFontImageNamed:@"Hiragano18.png" controlFile:@"Hiragano18" scale:Scale2fMake(1, 1) filter:GL_LINEAR];
	[sharedFontManager addFont:textboxFont withKey:@"textboxFont"];
	[textboxFont release];
	
	BitmapFont *menuFont = [[BitmapFont alloc] initWithFontImageNamed:@"ComicSans12.png" controlFile:@"ComicSans12" scale:Scale2fMake(1, 1) filter:GL_LINEAR];
	[sharedFontManager addFont:menuFont withKey:@"menuFont"];
	[menuFont release];
	
	gameState = kGameState_World;
	
	gameScenes = [[NSMutableDictionary alloc] initWithCapacity:5];
	//AbstractScene *scene = [[ChapterOneDemoTestV2 alloc] init];
    AbstractScene *scene = [[Arena alloc] init];
	[gameScenes setValue:scene forKey:@"ChapterOne"];
	[scene release];
	
	currentScene = [gameScenes objectForKey:@"ChapterOne"];
	//realm = kRealm_Midgard;

	
	antidote = YES;
	healingLeaf = YES;
	
	//Image *ansuzRuneStone = [[[teorPSS imageForKey:@"AnsuzRuneStone.png"] imageDuplicate] retain];
	//Image *eihwazRuneStone = [[[teorPSS imageForKey:@"EihwazRuneStone.png"] imageDuplicate] retain];
	runeStones = [[NSCountedSet alloc] init];
	/*[runeStones addObject:ansuzRuneStone];
	[runeStones addObject:ansuzRuneStone];
	[runeStones addObject:eihwazRuneStone];
	[runeStones addObject:ansuzRuneStone];
	[runeStones addObject:eihwazRuneStone];
	[ansuzRuneStone release];
	[eihwazRuneStone release];*/
	[self initBattleCharacters];
	
}

- (void)initCharacters {
	
	Character *roderick = [[Character alloc] initRoderick];
	Character *valkyrie = [[Character alloc] initValkyrie];
	Character *wizard = [[Character alloc] initWizard];
	Character *ranger = [[Character alloc] initRanger];
	Character *priest = [[Character alloc] initPriest];
	Character *dwarf = [[Character alloc] initDwarf];
	
	/*Image *ansuzRuneStone = [[[teorPSS imageForKey:@"AnsuzRuneStone.png"] imageDuplicate] retain];
	Image *eihwazRuneStone = [[[teorPSS imageForKey:@"EihwazRuneStone.png"] imageDuplicate] retain];
	[roderick.weaponRuneStones addObject:ansuzRuneStone];
	[roderick.armorRuneStones addObject:eihwazRuneStone];
	[ansuzRuneStone release];
	[eihwazRuneStone release];*/
	
	characters = [[NSDictionary alloc] initWithObjectsAndKeys:roderick, @"Roderick", 
				  valkyrie, @"Valkyrie", wizard, @"Wizard", ranger, @"Ranger",
				  priest, @"Priest", dwarf, @"Dwarf", nil];
	
	//AnsuzMenuAnimation *ansuz = [[AnsuzMenuAnimation alloc] init];
	//EihwazMenuAnimation *eihwaz = [[EihwazMenuAnimation alloc] init];
	
	/*[roderick learnRune:ansuz];
	[valkyrie learnRune:ansuz];
	[wizard learnRune:ansuz];
	[ranger learnRune:eihwaz];
	[priest learnRune:eihwaz];
	[dwarf learnRune:eihwaz];*/

	//[ansuz release];
	//[eihwaz release];
    
    /*DwarfapultMenuAnimation *dma = [[DwarfapultMenuAnimation alloc] init];
    BuyARoundMenuAnimation *bma = [[BuyARoundMenuAnimation alloc] init];
    FinishingMoveMenuAnimation *fma = [[FinishingMoveMenuAnimation alloc] init];
    BoobytrapMenuAnimation *btma = [[BoobytrapMenuAnimation alloc] init];
    SuperAxerangMenuAnimation *sama = [[SuperAxerangMenuAnimation alloc] init];
    [dwarf learnRune:dma withKey:@"Dwarfapult"];
    [dwarf learnRune:bma withKey:@"BuyARound"];
    [dwarf learnRune:fma withKey:@"FinishingMove"];
    [dwarf learnRune:btma withKey:@"Boobytrap"];
    [dwarf learnRune:sama withKey:@"SuperAxerang"];
    [dma release];
    [bma release];
    [fma release];
    [btma release];
    [sama release];*/
	
	party = [[NSMutableArray alloc] init];
	//[party addObject:roderick];
    //[party addObject:valkyrie];
	//[party addObject:wizard];
	//[party addObject:dwarf];
	//[party addObject:priest];
	//[party addObject:ranger];
	
	//NSLog(@"Party count is: %d", [party count]);
	
	[roderick release];
	[valkyrie release];
	[wizard release];
	[ranger release];
	[priest release];
	[dwarf release];
}

- (void)initBattleCharacters {
	
	BattleRoderick *br = [[BattleRoderick alloc] initWithBattleLocation:0];
	BattleValkyrie *bv = [[BattleValkyrie alloc] initWithBattleLocation:1];
	BattleWizard *bw = [[BattleWizard alloc] initWithBattleLocation:2];
	BattleRanger *bn = [[BattleRanger alloc] initWithBattleLocation:3];
	BattlePriest *bp = [[BattlePriest alloc] initWithBattleLocation:4];
	BattleDwarf *bd = [[BattleDwarf alloc] initWithBattleLocation:5];
	
	battleCharacters = [[NSDictionary alloc] initWithObjectsAndKeys:br, @"BattleRoderick",
						bv, @"BattleValkyrie", bw, @"BattleWizard", bn, @"BattleRanger",
						bp, @"BattlePriest", bd, @"BattleDwarf", nil];
	
	[br release];
	[bv release];
	[bw release];
	[bn release];
	[bp release];
	[bd release];
	[sharedInputManager initBattleEntities];
}


@end



