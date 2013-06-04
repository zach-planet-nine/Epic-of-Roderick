//
//  GameController.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "Global.h"

@class AbstractScene;
@class AbstractEntity;
@class TouchManager;
@class InputManager;
@class ScriptReader;
@class PackedSpriteSheet;
@class FontManager;

@interface GameController : NSObject <UIAccelerometerDelegate> {
	
	NSMutableDictionary *gameScenes;
	
	AbstractScene *currentScene;
	FontManager *sharedFontManager;
	TouchManager *sharedTouchManager;
	InputManager *sharedInputManager;
    ScriptReader *sharedScriptReader;
	int gameState;
	int realm;
	AbstractEntity *player;
	NSDictionary *characters;
	NSMutableArray *party;
	NSDictionary *battleCharacters;
	NSCountedSet *runeStones;
	PackedSpriteSheet *teorPSS;
	
	//Item BOOLs
	BOOL healingLeaf;
	BOOL antidote;
	BOOL bandage;
	
    float beginningTime;
    
}

@property (nonatomic, retain) AbstractScene *currentScene;
@property (nonatomic, retain) NSMutableDictionary *gameScenes;
@property (nonatomic, assign) int gameState;
@property (nonatomic, assign) int realm;
@property (nonatomic, retain) AbstractEntity *player;
@property (nonatomic, retain) NSMutableArray *party;
@property (nonatomic, retain) NSDictionary *characters;
@property (nonatomic, retain) NSDictionary *battleCharacters;
@property (nonatomic, retain) PackedSpriteSheet *teorPSS;
@property (nonatomic, assign) BOOL healingLeaf;
@property (nonatomic, assign) BOOL antidote;
@property (nonatomic, assign) BOOL bandage;
@property (nonatomic, retain) NSCountedSet *runeStones;


+ (GameController *)sharedGameController;

- (void)updateCurrentSceneWithDelta:(float)aDelta;
- (void)renderCurrentScene;

- (CGPoint)adjustTouchOrientationForTouch:(CGPoint)aTouch;

@end
