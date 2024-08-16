//
//  InputManager.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AbstractScene;
@class GameController;
@class BattleRoderick;
@class BattleValkyrie;
@class BattleWizard;
@class BattleRanger;
@class BattlePriest;
@class BattleDwarf;
@class AbstractBattleElementalEntity;
@class AbstractBattleCharacter;
@class MenuSystem;
@class ScriptReader;

// This is for detecting shakes. 

static BOOL L0AccelerationIsShaking(UIAcceleration *last, UIAcceleration *current, double threshold) {
	
	double
	deltaX = fabs(last.x - current.x),
	deltaY = fabs(last.y - current.y),
	deltaZ = fabs(last.z - current.z);
	
	return
	((deltaX > threshold && deltaY > threshold) ||
	 (deltaX > threshold && deltaZ > threshold) ||
	 (deltaY > threshold && deltaZ > threshold));
}


@interface InputManager : NSObject <UIAccelerometerDelegate> {

	GameController *sharedGameController;
    ScriptReader *sharedScriptReader;
	
	//Properties
	int state;
	UIAcceleration *lastAcceleration;
	
	//Most entities that the input manager will need to interact with
	//Are all initialized at the beginning of the game. So when the 
	//Input manager is initialized we can create references to all
	//Of those entities so that we won't have to check anything through
	//Whacky for loops very often. This mostly helps with battle.
	BattleRoderick *battleRoderick;
	BattleValkyrie *battleValkyrie;
	BattleWizard *battleWizard;
	BattleRanger *battleRanger;
	BattlePriest *battlePriest;
	BattleDwarf *battleDwarf;
	
	AbstractBattleElementalEntity *elemental; //For Roderick's elemental ability
	
	//Menu is sort of like an entity.
	MenuSystem *currentMenu;
    
	
	//There are various rects used repeatedly to indicate what type of touch is
	//happening.
	//Battle Rects:
	CGRect playersRect;
	CGRect runeRect;
	CGRect enemiesRect;
	CGRect runeCancelRect;
	CGRect currentSelectorRect;
	
	//Walking around Rects:
	CGRect leftRect;
	CGRect upLeftRect;
	CGRect upRightRect;
	CGRect rightRect;
	CGRect downRightRect;
	CGRect downLeftRect;
    
    //CutScene Rects
    CGRect cutSceneRect;
	
	//Put all instance variables used to track touches here:
	BOOL recordTouch; //Use this when only one touch is allowed.
	
	//Hashes
	int tapHash; //Used to switch player turns
	int roderickSlashHash;
	int roderickElementalHash;
	int valkyrieTapHash;
	int valkyrieRageLineDrawingHash;
	int valkyrieRageHash;
	int wizardHoldHash;
	int rangerAnimalLineHash;
	int rangerTapHash;
	int priestHoldHash;
	int priestSacrificeHash;
	int dwarfSlashHash;
	int runeDrawingHash; //hash for rune drawing.
	int runePlacementHash; //hash for rune placement.
	//End battle hashes
	//Walking hashes:
	int leftThumbHash;
	int rightThumbHash;
	int entityTouchHash;
	//Menu hash
	int menuTapHash;
    int experienceScreenTapHash;
    //CutScene hash
    int cutSceneHash;
	
	
	CGPoint previousLocation; //Used to track moving touches, used for most touches.
	int previousDirection; //Used for rune drawing
	int touchDirection; //Used for rune drawing
	int leftTally;		//Changing to tally system for rune recognition.
	int upLeftTally;
	int upTally;
	int upRightTally;
	int rightTally;
	int downRightTally;
	int downTally;
	int downLeftTally;
	int drawCounter; //Used for rune drawing
	int drawingImageIndex; //Used for rune drawing
	int countIt; //Used to track if a drawing touch was long enough in rune drawing.
	int inEnemyRect; //Used to track Roderick's slashes. May not be necessary
	int notInEnemyRect; //See above.
	int gestureCounter; //Used to track multiple taps.
	int rageTap; //Used to track multiple taps for Valkyrie's rage.
	BOOL histeresisExcited; //Used to check for shakes.
	int cueBones; //Used for Wizard's bones. Changed to int so that a few shakes are needed.
	
	//Walking around instance variables.
	int leftThumbDirection;
	int rightThumbDirection;
    
    	
}

@property (nonatomic, assign) int state;
@property (retain) UIAcceleration *lastAcceleration;
@property (nonatomic, retain) MenuSystem *currentMenu;

+ (InputManager *)sharedInputManager;

- (void)initBattleEntities;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView;

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView;

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView;

- (void)enableUIDevice;

- (void)orientationChanged;

- (void)setState:(int)aState;

- (void)checkRuneDrawn:(AbstractBattleCharacter *)aBattleCharacter;

- (void)addSelector:(CGPoint)aLocation;

- (void)updateSelector:(CGPoint)aLocation;

- (void)selectSelected;

- (void)updateRuneDrawing:(CGPoint)aLocation;

- (void)updateWalkingDirection;

- (void)thereWasAPinchOpen;

- (void)thereWasAPinchClose;

- (void)setStateMustTapRect:(CGRect)aRect;

- (void)setStateTutorialMustTapRect:(CGRect)aRect;

- (void)setUpRuneRect;


@end
