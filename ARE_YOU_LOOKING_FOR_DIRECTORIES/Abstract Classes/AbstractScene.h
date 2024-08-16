//
//  AbstractScene.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "Global.h"

@class TouchManager;
@class InputManager;
@class ImageRenderManager;
@class FontManager;
@class SoundManager;
@class GameController;
@class BitmapFont;
@class Image;
@class TiledMap;
@class ScriptReader;

@interface AbstractScene : NSObject <UIAccelerometerDelegate> {
	
	TouchManager *sharedTouchManager;
	InputManager *sharedInputManager;
	ImageRenderManager *sharedImageRenderManager;
	FontManager *sharedFontManager;
	SoundManager *sharedSoundManager;
	GameController *sharedGameController;
    ScriptReader *sharedScriptReader;
	
	BitmapFont *battleFont;
	
    BOOL doNotUpdate;
    
	NSMutableArray *activeObjects;
	NSMutableArray *activeEntities;
	NSMutableArray *activeImages;
	NSMutableArray *drawingImages;
	NSMutableArray *suspendedEntities;
	NSMutableArray *suspendedObjects;
	
	Image *battleImage;
	
	float inactiveTimer;
	
	BOOL isLineActive;
	Image *linePixel;
    
    CGPoint cameraPosition;
	CGPoint playerPosition;
	TiledMap *sceneMap;
    
    int stage;
    BOOL cutScene;
    float cutSceneTimer;
    
    float battlePossibility;
    BOOL allowBattles;
    
    BOOL wait;
	
	//Drawing lines test
    UIColor *green;
    UIColor *blue;
    UIColor *black;
}

@property (nonatomic, retain) NSMutableArray *activeEntities;
@property (nonatomic, retain) NSMutableArray *activeImages;
@property (nonatomic, retain) NSMutableArray *activeObjects;
@property (nonatomic, retain) BitmapFont *battleFont;
@property (nonatomic, retain) Image *battleImage;


- (void)updateSceneWithDelta:(float)aDelta;

- (void)renderScene;

- (void)updateWithAccelerometer:(UIAcceleration *)aAcceleration;

- (void)transitionToSceneWithKey:(NSString *)aKey;

- (BOOL)isBlocked:(float)x y:(float)y;

- (void)addObjectToActiveObjects:(id)aObject;

- (void)addImageToActiveImages:(id)aImage;

- (void)addEntityToActiveEntities:(id)aEntity;

- (void)addImageToDrawingImages:(id)aImage;

- (void)setCameraPosition:(CGPoint)aCameraPosition;

- (void)removeTextbox;

- (void)removeDrawingImages;

- (void)initBattleCharacters;

- (void)initBattleEnemies;

- (void)initBattle;

- (void)checkIfBattleOver;

- (void)partyHasBeenDefeated;

- (void)endBattle;

- (void)restoreMap;

- (void)drawLineFrom:(CGPoint)aFromPoint to:(CGPoint)aToPoint;

- (void)drawLineOff;

- (void)removeInactiveObjects;

- (void)removeInactiveEntities;

- (void)setCameraPosition:(CGPoint)aCameraPosition;

- (void)moveToNextStageInScene;

- (void)createCollisionMapArray;

- (void)createPortalsArray;

- (BOOL)checkForPortal;

- (void)initChapterOneChampionBattle;

- (void)initChapterOneCampBattle;

- (void)initMidgardBattle;

- (void)initAlfheimBattle;

- (void)initRangerBattleTutorial;

- (void)choiceboxSelectionWas:(int)aSelection;


@end
