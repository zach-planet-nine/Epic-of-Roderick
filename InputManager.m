//
//  InputManager.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "InputManager.h"
#import "SynthesizeSingleton.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleElementalEntity.h"
#import "AbstractBattleCharacter.h"
#import "GameController.h"
#import "ScriptReader.h"
#import "Global.h"
#import "BattleRoderick.h"
#import "BattleValkyrie.h"
#import "BattleWizard.h"
#import "BattleRanger.h"
#import "BattlePriest.h"
#import "BattleDwarf.h"
#import "ExperienceScreen.h"
#import "Choicebox.h"
#import "Image.h"
#import "Character.h"
#import "AbstractEntity.h"
#import "MenuSystem.h"
#import "PackedSpriteSheet.h"


@implementation InputManager

@synthesize state;
@synthesize lastAcceleration;
@synthesize currentMenu;

SYNTHESIZE_SINGLETON_FOR_CLASS(InputManager);

- (void)dealloc {
		
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		sharedGameController = [GameController sharedGameController];
        sharedScriptReader = [ScriptReader sharedScriptReader];
		state = 0;
		drawingImageIndex = 0;
		previousDirection = kNotMoving;
		touchDirection = kMovingUp;
		drawCounter = 0;
		gestureCounter = 0;
		countIt = 0;
		playersRect = CGRectMake(0, 0, 120, 320);
		//runeRect = CGRectMake(120, 0, 160, 320);
		enemiesRect = CGRectMake(280, 0, 200, 320);
		runeCancelRect = CGRectMake(0, 0, 120, 320);
		leftRect = CGRectMake(0, 107, 80, 106);
		upLeftRect = CGRectMake(0, 214, 80, 106);
		upRightRect = CGRectMake(400, 214, 80, 106);
		rightRect = CGRectMake(400, 107, 80, 106);
		downRightRect = CGRectMake(400, 0, 80, 106);
		downLeftRect = CGRectMake(0, 0, 80, 106);
		recordTouch = YES;
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / 50.0];
		[[UIAccelerometer sharedAccelerometer] setDelegate:self];
		

	}
	
	return self;
}

- (void)initBattleEntities {
	
	battleRoderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
	battleValkyrie = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
	battleWizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
	battleRanger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
	battlePriest = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
	battleDwarf = [sharedGameController.battleCharacters objectForKey:@"BattleDwarf"];
	if (battleRoderick) {
		//////NSLog(@"You have br.");
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView {
	
	CGPoint touchLocation;
	if (!recordTouch) {
		return;
	}
	for (UITouch *touch in touches) {
		if (recordTouch) {
			//////NSLog(@"Touch made it here, %d, with touchHash %d", state, touch.hash);
			touchLocation = [sharedGameController adjustTouchOrientationForTouch:[touch locationInView:aView]];
			switch (state) {
					//Start battle touches.
					//////NSLog(@"Touch made it to Roderick.");
                case kNoOnesTurn:
                    if (CGRectContainsPoint(playersRect, touchLocation)) {
                        tapHash = touch.hash;
                        [self addSelector:touchLocation];
                        recordTouch = NO;
                        return;
                    }
                    break;
				case kRoderick:
					//Handles Elemental
					for (AbstractBattleElementalEntity *entity in sharedGameController.currentScene.activeEntities) {
						if (CGRectContainsPoint([entity getRect], touchLocation) && [entity isKindOfClass:[AbstractBattleElementalEntity class]]) {
							roderickElementalHash = touch.hash;
							elemental = entity;
							state = kRoderickElementalLineDrawing;
							previousLocation = touchLocation;
							recordTouch = NO;
							return;
						}
					}
					//Handles changing player's turn
					if (CGRectContainsPoint(playersRect, touchLocation)) {
						tapHash = touch.hash;
						////NSLog(@"Tap hash is: %d.", tapHash);
						[self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}
					//Handles Roderick's rune drawing
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						state = kRoderickRuneDrawing;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battleRoderick.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];
						[drawing release];
                        runeRect = CGRectMake(120, 0, 300, 320);
						recordTouch = NO;
						return;
					}
					//Handles Roderick's attack.
					if (CGRectContainsPoint(enemiesRect, touchLocation)) {
						roderickSlashHash = touch.hash;
						state = kRoderickAttacking;
						previousLocation = touchLocation;
						recordTouch = NO;
						return;
					}
					break;
				
				case kValkyrie:
					//Handles switching turns and starting Valkyrie's Rage
					if (CGRectContainsPoint(playersRect, touchLocation)) {
						if (CGRectContainsPoint([battleValkyrie getRect], touchLocation)) {
							valkyrieRageLineDrawingHash = touch.hash;
							previousLocation = touchLocation;
							state = kValkyrieRageLineDrawing;
							recordTouch = NO;
							return;
						}
						tapHash = touch.hash;
						[self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}
					//Handles rune drawing
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						state = kValkyrieRuneDrawing;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battleValkyrie.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];
						[drawing release];
                        runeRect = CGRectMake(120, 0, 300, 320);
                        recordTouch = NO;
						return;
					}
					//Handles Valkyrie attack
					if (CGRectContainsPoint(enemiesRect, touchLocation)) {
						valkyrieTapHash = touch.hash;
						recordTouch = NO;
						return;
					}
					break;
                case kValkyrieMustDrawLine:
                    if (CGRectContainsPoint(playersRect, touchLocation)) {
						if (CGRectContainsPoint([battleValkyrie getRect], touchLocation)) {
							valkyrieRageLineDrawingHash = touch.hash;
							previousLocation = touchLocation;
							recordTouch = NO;
							return;
						}
						return;
					}
                    break;

				
				case kValkyrieRage:
					//Here we might need to add some more sophisticated code,
					//but for now let rage gestures happen everywhere and be 
					//just one finger.
					valkyrieRageHash = touch.hash;
					recordTouch = NO;
					return;
					break;
					
				case kValkyrieFlying:
					//Handles switching turns and starting Valkyrie's Rage
					if (CGRectContainsPoint(playersRect, touchLocation)) {
						if (CGRectContainsPoint([[sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"] getRect], touchLocation)) {
							valkyrieRageHash = touch.hash;
							state = kValkyrieRageLineDrawing;
							recordTouch = NO;
							return;
						}
						tapHash = touch.hash;
						recordTouch = NO;
						return;
					}
					//Handles rune drawing
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						state = kValkyrieRuneDrawing;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];
						[drawing release];
						recordTouch = NO;
						return;
					}
					if (CGRectContainsPoint(enemiesRect, touchLocation)) {
						valkyrieTapHash = touch.hash;
						recordTouch = NO;
						return;
					}
					
					break;


				case kWizard:
					//Handles switching player's turn
					if (CGRectContainsPoint(playersRect, touchLocation)) {
						tapHash = touch.hash;
						[self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}
					//Handles Wizard's rune drawing
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						state = kWizardRuneDrawing;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battleWizard.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];
						[drawing release];
                        runeRect = CGRectMake(120, 0, 300, 320);
                        recordTouch = NO;
						return;
					}
					//Handles Wizard's attack.
					if (CGRectContainsPoint(enemiesRect, touchLocation)) {
						wizardHoldHash = touch.hash;
						[[sharedGameController.battleCharacters objectForKey:@"BattleWizard"] startWizardAttack];
						state = kWizardAttacking;
						recordTouch = NO;
						return;
					}
					break;
					
				case kRanger:
					//Handles switching character turns and the Ranger's animal line drawing
					if (CGRectContainsPoint(playersRect, touchLocation)) {
						if (CGRectContainsPoint([battleRanger getAnimalRect], touchLocation)) {
							rangerAnimalLineHash = touch.hash;
							state = kRangerAnimalLineDrawing;
							previousLocation = touchLocation;
							recordTouch = NO;
							return;
						}
						tapHash = touch.hash;
						[self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}
					//Handles Ranger's rune drawing
					if (CGRectContainsPoint(runeRect, touchLocation)) {
                        if (CGRectContainsPoint([battleRanger getAnimalRect], touchLocation)) {
							rangerAnimalLineHash = touch.hash;
							state = kRangerAnimalLineDrawing;
							previousLocation = touchLocation;
							recordTouch = NO;
							return;
						}
						runeDrawingHash = touch.hash;
						state = kRangerRuneDrawing;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battleRanger.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];
						[drawing release];
                        runeRect = CGRectMake(120, 0, 300, 320);
                        recordTouch = NO;
						return;
					}
					//Handles Ranger's attack
					if (CGRectContainsPoint(enemiesRect, touchLocation)) {
						rangerTapHash = touch.hash;
						recordTouch = NO;
						return;
					}
					break;

				case kPriest:
					//Handles swapping character.
					if (CGRectContainsPoint(playersRect, touchLocation)) {
						tapHash = touch.hash;
						[self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}
					//Handles Priest's rune drawing
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						state = kPriestRuneDrawing;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battlePriest.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];			
                        runeRect = CGRectMake(120, 0, 300, 320);
						recordTouch = NO;
						return;
					}
					//Handles Priest's attack
					if (CGRectContainsPoint(enemiesRect, touchLocation)) {
						for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
							if (CGRectContainsPoint([enemy getRect], touchLocation)) {
								[[sharedGameController.battleCharacters objectForKey:@"BattlePriest"] startAttackingEnemy:enemy];
								break;
							}
						}
						priestHoldHash = touch.hash;
						state = kPriestAttacking;
						recordTouch = NO;
						return;
					}
					break;
					
				case kPriestSacrificing:
					//Put more sophisticated sacrificing code when you do this.
					recordTouch = NO;
					return;
					break;
					
				case kDwarf:
					if (CGRectContainsPoint(playersRect, touchLocation)) {
						tapHash = touch.hash;
						[self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						state = kDwarfBeerOrdering;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battleDwarf.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];			
                        runeRect = CGRectMake(120, 0, 300, 320);
						recordTouch = NO;
						return;
						
					}
					if (CGRectContainsPoint(enemiesRect, touchLocation)) {
						dwarfSlashHash = touch.hash;
						state = kDwarfAttacking;
						previousLocation = touchLocation;
						recordTouch = NO;
						return;
					}
					break;
					
					//Next take care of moving runes around the screen. We want to 
					//Know who's placing the rune to know where to dispatch methods.
				case kRoderickRunePlacement:
					[battleRoderick updateRuneLocationTo:touchLocation];
					runePlacementHash = touch.hash;
					recordTouch = NO;
					return;
					break;
					
				case kValkyrieRunePlacement:
					[battleValkyrie updateRuneLocationTo:touchLocation];
					runePlacementHash = touch.hash;
					recordTouch = NO;
					return;
					break;

				case kWizardRunePlacement:
					[battleWizard updateRuneLocationTo:touchLocation];
					runePlacementHash = touch.hash;
					recordTouch = NO;
					return;
					break;

				case kRangerRunePlacement:
					[battleRanger updateRuneLocationTo:touchLocation];
					runePlacementHash = touch.hash;
					recordTouch = NO;
					return;
					break;

				case kPriestRunePlacement:
					[battlePriest updateRuneLocationTo:touchLocation];
					runePlacementHash = touch.hash;
					recordTouch = NO;
					return;
					break;
					
					//Next we want to handle drawing multiple lines for rune drawing.
				case kRoderickRuneDrawing:
					if (CGRectContainsPoint(runeCancelRect, touchLocation)) {
						tapHash = touch.hash;
                        [self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battleRoderick.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];						
						previousLocation = touchLocation;
						recordTouch = NO;
						return;
					}
					break;
				case kValkyrieRuneDrawing:
					if (CGRectContainsPoint(runeCancelRect, touchLocation)) {
						tapHash = touch.hash;
                        [self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}					
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battleValkyrie.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];						
						previousLocation = touchLocation;
						recordTouch = NO;
						return;
					}
					break;
				case kWizardRuneDrawing:
					if (CGRectContainsPoint(runeCancelRect, touchLocation)) {
						tapHash = touch.hash;
                        [self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}					
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battleWizard.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];						
						previousLocation = touchLocation;
						recordTouch = NO;
						return;
					}
					break;
				case kRangerRuneDrawing:
					if (CGRectContainsPoint(runeCancelRect, touchLocation)) {
						tapHash = touch.hash;
                        [self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}					
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battleRanger.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];						
						previousLocation = touchLocation;
						recordTouch = NO;
						return;
					}
					break;
				case kPriestRuneDrawing:
					if (CGRectContainsPoint(runeCancelRect, touchLocation)) {
						tapHash = touch.hash;
                        [self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}					
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battlePriest.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];						
						previousLocation = touchLocation;
						recordTouch = NO;
						return;
					}
					break;
				case kDwarfBeerOrdering:
					if (CGRectContainsPoint(runeCancelRect, touchLocation)) {
						tapHash = touch.hash;
                        [self addSelector:touchLocation];
						recordTouch = NO;
						return;
					}					
					if (CGRectContainsPoint(runeRect, touchLocation)) {
						runeDrawingHash = touch.hash;
						Image *drawing = [[[sharedGameController.teorPSS imageForKey:@"defaultTexture.png"] imageDuplicate] retain];
						drawing.renderPoint = touchLocation;
						drawing.color = battleDwarf.essenceColor;
						[[sharedGameController currentScene] addImageToDrawingImages:drawing];						
						previousLocation = touchLocation;
						recordTouch = NO;
						return;
					}
					break;
					
					//End battle touches.

					//Begin walking around touches.
				case kWalkingAround_NoTouches:
					if (sharedGameController.gameState == kGameState_World && CGRectContainsPoint(CGRectMake(100, 0, 280, 320), touchLocation)) {
						entityTouchHash = touch.hash;
						////NSLog(@"Set entitytouchhash");
						continue;
					}
					if (CGRectContainsPoint(leftRect, touchLocation)) {
						leftThumbDirection = kMovingLeft;
						leftThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_LeftTouchDown;
					}
					if (CGRectContainsPoint(upLeftRect, touchLocation)) {
						leftThumbDirection = kMovingUpLeft;
						leftThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_LeftTouchDown;
					}
					if (CGRectContainsPoint(downLeftRect, touchLocation)) {
						leftThumbDirection = kMovingDownLeft;
						leftThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_LeftTouchDown;
					}
					if (CGRectContainsPoint(rightRect, touchLocation)) {
						rightThumbDirection = kMovingRight;
						rightThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_RightTouchDown;
					}
					if (CGRectContainsPoint(upRightRect, touchLocation)) {
						rightThumbDirection = kMovingUpRight;
						rightThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_RightTouchDown;
					}
					if (CGRectContainsPoint(downRightRect, touchLocation)) {
						rightThumbDirection = kMovingDownRight;
						rightThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_RightTouchDown;
					}					
					break;
				case kWalkingAround_RightTouchDown:
					if (sharedGameController.gameState == kGameState_World && CGRectContainsPoint(CGRectMake(100, 0, 280, 320), touchLocation)) {
						entityTouchHash = touch.hash;
						////NSLog(@"Set entitytouchhash");
						continue;
					}
					if (CGRectContainsPoint(leftRect, touchLocation)) {
						leftThumbDirection = kMovingLeft;
						leftThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_BothSidesDown;
					}
					if (CGRectContainsPoint(upLeftRect, touchLocation)) {
						leftThumbDirection = kMovingUpLeft;
						leftThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_BothSidesDown;
					}
					if (CGRectContainsPoint(downLeftRect, touchLocation)) {
						leftThumbDirection = kMovingDownLeft;
						leftThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_BothSidesDown;
					}					
					break;
				case kWalkingAround_LeftTouchDown:
					if (sharedGameController.gameState == kGameState_World && CGRectContainsPoint(CGRectMake(100, 0, 280, 320), touchLocation)) {
						entityTouchHash = touch.hash;
						////NSLog(@"Set entitytouchhash");
						continue;
					}
					if (CGRectContainsPoint(rightRect, touchLocation)) {
						rightThumbDirection = kMovingRight;
						rightThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_BothSidesDown;
					}
					if (CGRectContainsPoint(upRightRect, touchLocation)) {
						rightThumbDirection = kMovingUpRight;
						rightThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_BothSidesDown;
					}
					if (CGRectContainsPoint(downRightRect, touchLocation)) {
						rightThumbDirection = kMovingDownRight;
						rightThumbHash = touch.hash;
						[self updateWalkingDirection];
						state = kWalkingAround_BothSidesDown;
					}					
					break;
					//End walking around touches.
					//Begin Menu touches.
				case kMenuOpen:
					menuTapHash = touch.hash;
					[currentMenu fingerIsDownAt:touchLocation];
					return;
					break;
                case kBattleExperienceScreen:
                    experienceScreenTapHash = touch.hash;
                    ////NSLog(@"touch made it to bes case.");
                    break;
                case kCutScene_TextboxOnScreen:
                    cutSceneHash = touch.hash;
                    break;
                case kCutScene_ScriptReader:
                    cutSceneHash = touch.hash;
                    break;
                case kCutScene_LastLine:
                    cutSceneHash = touch.hash;
                    break;
                case kCutScene_MustTapRect:
                    cutSceneHash = touch.hash;
                    break;
                case kChoiceboxOnScreen:
                    cutSceneHash = touch.hash;
                    break;
                case kTutorial_TextboxOnScreen:
                    cutSceneHash = touch.hash;
                    break;
                case kTutorial_LastLine:
                    cutSceneHash = touch.hash;
                    break;
                case kTutorial_MustTapRect:
                    cutSceneHash = touch.hash;
                    break;
                    
                
				default:
					break;
			}
		}
		
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView {
	
	int newDirection;
	CGPoint touchLocation;
	for (UITouch *touch in touches) {
		touchLocation = [sharedGameController adjustTouchOrientationForTouch:[touch locationInView:aView]];
		if (tapHash == touch.hash) {
			[self updateSelector:touchLocation];
			return;
		}		
		switch (state) {
				
				//Start battle touches
			
				
			case kRoderickElementalLineDrawing:
				[sharedGameController.currentScene drawLineFrom:previousLocation to:touchLocation];
				return;
				break;

			case kRoderickRuneDrawing:
				if (runeDrawingHash == touch.hash) {
					[self updateRuneDrawing:touchLocation];
					Image *drawing = [[Image alloc] initWithImageNamed:@"defaultTexture.png" filter:GL_NEAREST];
					drawing.renderPoint = touchLocation;
					drawing.color = battleRoderick.essenceColor;
					[[sharedGameController currentScene] addImageToDrawingImages:drawing];
					[drawing release];
				}
				return;
				break;
                
            case kValkyrieMustDrawLine:
                if (valkyrieRageLineDrawingHash == touch.hash) {
                    [sharedGameController.currentScene drawLineFrom:previousLocation to:touchLocation];
                }
                break;
				
			case kValkyrieRageLineDrawing:
				if (valkyrieRageLineDrawingHash == touch.hash) {
					[sharedGameController.currentScene drawLineFrom:previousLocation to:touchLocation];
				}
				break;
			
			case kValkyrieRage:
				//Implement the rages here.
				break;
				
			case kValkyrieRuneDrawing:
				if (runeDrawingHash == touch.hash) {
					[self updateRuneDrawing:touchLocation];
					Image *drawing = [[Image alloc] initWithImageNamed:@"defaultTexture.png" filter:GL_NEAREST];
					drawing.renderPoint = touchLocation;
					drawing.color = battleValkyrie.essenceColor;
					[[sharedGameController currentScene] addImageToDrawingImages:drawing];
					[drawing release];
				}
				return;				
				break;
				
			case kWizardRuneDrawing:
				if (runeDrawingHash == touch.hash) {
					[self updateRuneDrawing:touchLocation];
					Image *drawing = [[Image alloc] initWithImageNamed:@"defaultTexture.png" filter:GL_NEAREST];
					drawing.renderPoint = touchLocation;
					drawing.color = battleWizard.essenceColor;
					[[sharedGameController currentScene] addImageToDrawingImages:drawing];
					[drawing release];
				}
				return;				
				break;
				
			case kRangerAnimalLineDrawing:
				if (rangerAnimalLineHash == touch.hash) {
					[sharedGameController.currentScene drawLineFrom:previousLocation to:touchLocation];
				}
				return;
				break;
				
			case kRangerRuneDrawing:
				if (runeDrawingHash == touch.hash) {
					[self updateRuneDrawing:touchLocation];
					Image *drawing = [[Image alloc] initWithImageNamed:@"defaultTexture.png" filter:GL_NEAREST];
					drawing.renderPoint = touchLocation;
					drawing.color = battleRanger.essenceColor;
					[[sharedGameController currentScene] addImageToDrawingImages:drawing];
					[drawing release];
				}
				return;				
				break;
				
			case kPriestSacrificing:
				//Implement sacrificing here.
				break;
				
			case kPriestRuneDrawing:
				if (runeDrawingHash == touch.hash) {
					[self updateRuneDrawing:touchLocation];
					Image *drawing = [[Image alloc] initWithImageNamed:@"defaultTexture.png" filter:GL_NEAREST];
					drawing.renderPoint = touchLocation;
					drawing.color = battlePriest.essenceColor;
					[[sharedGameController currentScene] addImageToDrawingImages:drawing];
					[drawing release];
				}
				return;				
				break;

			case kDwarfBeerOrdering:
				if (runeDrawingHash == touch.hash) {
					[self updateRuneDrawing:touchLocation];
					Image *drawing = [[Image alloc] initWithImageNamed:@"defaultTexture.png" filter:GL_NEAREST];
					drawing.renderPoint = touchLocation;
					drawing.color = battleDwarf.essenceColor;
					[[sharedGameController currentScene] addImageToDrawingImages:drawing];
					[drawing release];
				}
				return;				
				break;

			case kRoderickRunePlacement:
				if (runePlacementHash == touch.hash) {
					[battleRoderick updateRuneLocationTo:touchLocation];
				}
				return;
				break;
				
			case kValkyrieRunePlacement:
				if (runePlacementHash == touch.hash) {
					[battleValkyrie updateRuneLocationTo:touchLocation];
				}
				return;
				break;
				
			case kWizardRunePlacement:
				if (runePlacementHash == touch.hash) {
					[battleWizard updateRuneLocationTo:touchLocation];
				}
				return;
				break;
				
			case kRangerRunePlacement:
				if (runePlacementHash == touch.hash) {
					[battleRanger updateRuneLocationTo:touchLocation];
				}
				return;
				break;
				
			case kPriestRunePlacement:
				if (runePlacementHash == touch.hash) {
					[battlePriest updateRuneLocationTo:touchLocation];
				}
				return;
				break;
				//End battle touches.
				//Start walking around touches.
				
			case kWalkingAround_LeftTouchDown:
				leftThumbDirection = leftThumbDirection;
				if (CGRectContainsPoint(upLeftRect, touchLocation)) {
					newDirection = kMovingUpLeft;
				} else if (CGRectContainsPoint(leftRect, touchLocation)) {
					newDirection = kMovingLeft;
				} else if (CGRectContainsPoint(downLeftRect, touchLocation)) {
					newDirection = kMovingDownLeft;
				}
				if (leftThumbHash == touch.hash && leftThumbDirection != newDirection) {
					leftThumbDirection = newDirection;
					[self updateWalkingDirection];
				}
				break;
			case kWalkingAround_RightTouchDown:
				if (CGRectContainsPoint(upRightRect, touchLocation)) {
					newDirection = kMovingUpRight;
				} else if (CGRectContainsPoint(rightRect, touchLocation)) {
					newDirection = kMovingRight;
				} else if (CGRectContainsPoint(downRightRect, touchLocation)) {
					newDirection = kMovingDownRight;
				}
				if (rightThumbHash == touch.hash && rightThumbDirection != newDirection) {
					rightThumbDirection = newDirection;
					[self updateWalkingDirection];
				}
				break;
			case kWalkingAround_BothSidesDown:
				if (CGRectContainsPoint(upLeftRect, touchLocation)) {
					newDirection = kMovingUpLeft;
				} else if (CGRectContainsPoint(leftRect, touchLocation)) {
					newDirection = kMovingLeft;
				} else if (CGRectContainsPoint(downLeftRect, touchLocation)) {
					newDirection = kMovingDownLeft;
				}
				if (leftThumbHash == touch.hash && leftThumbDirection != newDirection) {
					leftThumbDirection = newDirection;
					[self updateWalkingDirection];
				}
				if (CGRectContainsPoint(upRightRect, touchLocation)) {
					newDirection = kMovingUpRight;
				} else if (CGRectContainsPoint(rightRect, touchLocation)) {
					newDirection = kMovingRight;
				} else if (CGRectContainsPoint(downRightRect, touchLocation)) {
					newDirection = kMovingDownRight;
				}
				if (rightThumbHash == touch.hash && rightThumbDirection != newDirection) {
					rightThumbDirection = newDirection;
					[self updateWalkingDirection];
				}
				break;

				//End walking around touches.
			case kMenuOpen:
				if (menuTapHash == touch.hash) {
					[currentMenu fingerIsDownAt:touchLocation];
				}
				break;
           
			default:
				break;
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView {
	
	CGPoint touchLocation;
	for (UITouch *touch in touches) {
		touchLocation = [sharedGameController adjustTouchOrientationForTouch:[touch locationInView:aView]];
		if (tapHash == touch.hash && (state == kRoderickRuneDrawing || state == kValkyrieRuneDrawing || state == kWizardRuneDrawing || state == kRangerRuneDrawing || state == kPriestRuneDrawing || state == kDwarfBeerOrdering)) {
            [sharedGameController.currentScene removeDrawingImages];
            [self selectSelected];
            runeRect = CGRectMake(120, 0, 160, 320);
			tapHash = 0;
			drawCounter = 0;
			recordTouch = YES;
			return;
		}
		if (tapHash == touch.hash && sharedGameController.gameState == kGameState_Battle && state != kCutScene_MustTapRect) {
			[self selectSelected];
			tapHash = 0;
			recordTouch = YES;
			return;
		}
		switch (state) {
				//Begin attack touches.
			case kRoderickAttacking:
				if (roderickSlashHash == touch.hash) {
					CGPoint centerOfSlash = CGPointMake((touchLocation.x + previousLocation.x) / 2, (touchLocation.y + previousLocation.y) / 2);
					for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if (enemy.isAlive) {
                            if (CGRectContainsPoint([enemy getRect], centerOfSlash) && (abs(touchLocation.x - previousLocation.x) > 10 || abs(touchLocation.y - previousLocation.y) > 10)) {
                                [battleRoderick youAttackedEnemy:enemy];
                                state = kRoderick;
                                roderickSlashHash = 0;
                                recordTouch = YES;
                                ////NSLog(@"Slash recorder in enemy %d.", enemy.whichEnemy);
                                return;
                            }
                        }
					}
					state = kRoderick;
					roderickSlashHash = 0;
					recordTouch = YES;
					////NSLog(@"Roderick attacking cancelled.");
					return;
				}
				break;
				
			case kRoderickElementalLineDrawing:
				if (roderickElementalHash == touch.hash) {
					[sharedGameController.currentScene drawLineOff];
					if (CGRectContainsPoint([elemental getRect], touchLocation)) {
						state = kRoderick;
						roderickElementalHash = 0;
						recordTouch = YES;
						////NSLog(@"Elemental cancelled.");
						return;
					}
					for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
						if (CGRectContainsPoint([entity getRect], touchLocation)) {
							if ([entity isKindOfClass:[AbstractBattleEnemy class]] && entity.isAlive) {
								[elemental youAttackedEnemy:entity];
								[battleRoderick resetBattleTimer];
								state = kRoderick;
								roderickElementalHash = 0;
								recordTouch = YES;
								////NSLog(@"Elemental to enemy.");
								return;
							}
							if ([entity isKindOfClass:[AbstractBattleCharacter class]]) {
								[battleRoderick resetBattleTimer];
								[elemental youAffectedCharacter:entity];
								state = kRoderick;
								roderickElementalHash = 0;
								recordTouch = YES;
								////NSLog(@"Elemental to character.");
								return;
							}
						}
					}
					if (CGRectContainsPoint(CGRectMake(0, 0, 240, 320), touchLocation)) {
						[elemental youAffectedAllCharacters];
						[battleRoderick resetBattleTimer];
						state = kRoderick;
						roderickElementalHash = 0;
						////NSLog(@"Elemental to all characters.");
						recordTouch = YES;
						return;
					}
					if (CGRectContainsPoint(CGRectMake(241, 0, 240, 320), touchLocation)) {
						[elemental youAffectedAllEnemies];
						[battleRoderick resetBattleTimer];
						state = kRoderick;
						roderickElementalHash = 0;
						recordTouch = YES;
						////NSLog(@"Elemental to all enemies.");
						return;
					}
				}
				recordTouch = YES;
				return;
				break;
				
			case kRoderickRuneDrawing:
				if (runeDrawingHash == touch.hash) {
					drawCounter += previousDirection;
					runeDrawingHash = 0;
					countIt = 0;
					[self checkRuneDrawn:battleRoderick];
					recordTouch = YES;
					return;
				}
				////NSLog(@"Reached end of touch when it shouldn't.");
				break;

			case kRoderickRunePlacement:
				if (runePlacementHash == touch.hash) {
					for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
						if (CGRectContainsPoint([entity getRect], touchLocation)) {
							if ([entity isKindOfClass:[AbstractBattleEnemy class]] && entity.isAlive) {
								[battleRoderick runeWasPlacedOnEnemy:entity];
								state = kRoderick;
								runePlacementHash = 0;
								[battleRoderick resetBattleTimer];
								recordTouch = YES;
								////NSLog(@"Rune was placed on enemy.");
								return;
							}
							if ([entity isKindOfClass:[AbstractBattleCharacter class]]) {
								[battleRoderick runeWasPlacedOnCharacter:entity];
								state = kRoderick;
								runePlacementHash = 0;
								[battleRoderick resetBattleTimer];
								recordTouch = YES;
								////NSLog(@"Rune was placed on character.");
								return;
							}
						}
					}
					if (CGRectContainsPoint(CGRectMake(0, 0, 240, 320), touchLocation)) {
						[battleRoderick runeAffectedAllCharacters];
						state = kRoderick;
						runePlacementHash = 0;
						[battleRoderick resetBattleTimer];
						recordTouch = YES;
						////NSLog(@"Rune all characters.");
						return;
					}
					if (CGRectContainsPoint(CGRectMake(241, 0, 240, 320), touchLocation)) {
						[battleRoderick runeAffectedAllEnemies];
						state = kRoderick;
						runePlacementHash = 0;
						[battleRoderick resetBattleTimer];
						recordTouch = YES;
						////NSLog(@"Rune all enemies.");
						return;
					}					
				}
				////NSLog(@"Reached end of touch when it shouldn't.");
				break;

			case kValkyrie:
				if (valkyrieTapHash == touch.hash) {
					for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
                        if (entity.isAlive) {
                            if ([entity isKindOfClass:[AbstractBattleEnemy class]] && CGRectContainsPoint([entity getRect], touchLocation)) {
                                [battleValkyrie youAttackedEnemy:entity];
                                state = kValkyrie;
                                valkyrieTapHash = 0;
                                recordTouch = YES;
                                [battleValkyrie resetBattleTimer];
                                ////NSLog(@"Valkyrie attacked.");
                                return;
                            }
                        }
					}
					state = kValkyrie;
					valkyrieTapHash = 0;
					////NSLog(@"Valkyrie attack cancelled.");
					recordTouch = YES;
				}
				return;
				break;
				
			case kValkyrieRage:
				//Implement valkyrie rages here.
				if (valkyrieRageHash == touch.hash) {
					state = kNoOnesTurn;
					[battleValkyrie resetBattleTimer];
					recordTouch = YES;
				}
				return;
				break;

			case kValkyrieFlying:
				if (valkyrieTapHash == touch.hash) {
					for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
						if (CGRectContainsPoint([entity getRect], [battleValkyrie getTargetPoint])) {
							[battleValkyrie youAttackedEnemy:entity];
							state = kValkyrie;
							valkyrieTapHash = 0;
							[battleValkyrie resetBattleTimer];
							////NSLog(@"Valkyrie attacked while flying.");
							recordTouch = YES;
							return;
						}
					}
					state = kValkyrie;
					valkyrieTapHash = 0;
					recordTouch = YES;
					return;
				}
				recordTouch = YES;
				return;
				break;
                
            case kValkyrieMustDrawLine:
                if (valkyrieRageLineDrawingHash == touch.hash) {
                    for (AbstractBattleEnemy *entity in sharedGameController.currentScene.activeEntities) {
                        if (entity.isAlive) {
                            if ([entity isKindOfClass:[AbstractBattleEnemy class]] && CGRectContainsPoint([entity getRect], touchLocation)) {
                                [battleValkyrie rageWasLinkedToEnemy:entity];
                                [sharedGameController.currentScene drawLineOff];
                                [battleValkyrie resetBattleTimer];
                                state = kValkyrie;
                                valkyrieRageLineDrawingHash = 0;
                                recordTouch = YES;
                                [sharedGameController.currentScene moveToNextStageInScene];
                                return;
                            }
                        }
                    }
					state = kValkyrieMustDrawLine;
					valkyrieRageLineDrawingHash = 0;
					[sharedGameController.currentScene drawLineOff];
					////NSLog(@"Rage was cancelled.");
					recordTouch = YES;
					return;
				}


			case kValkyrieRageLineDrawing:
				if (valkyrieRageLineDrawingHash == touch.hash) {
					for (AbstractBattleEnemy *entity in sharedGameController.currentScene.activeEntities) {
                        if (entity.isAlive) {
                            if ([entity isKindOfClass:[AbstractBattleEnemy class]] && CGRectContainsPoint([entity getRect], touchLocation)) {
                                [battleValkyrie rageWasLinkedToEnemy:entity];
                                [sharedGameController.currentScene drawLineOff];
                                [battleValkyrie resetBattleTimer];
                                state = kValkyrie;
                                valkyrieRageLineDrawingHash = 0;
                                ////NSLog(@"Valkyrie rage was linked.");
                                recordTouch = YES;
                                return;
                            }
                        }
                    }
					state = kValkyrie;
					valkyrieRageLineDrawingHash = 0;
					[sharedGameController.currentScene drawLineOff];
					////NSLog(@"Rage was cancelled.");
					recordTouch = YES;
					return;
				}
				return;
				break;
				
			case kValkyrieRuneDrawing:
				if (runeDrawingHash == touch.hash) {
					drawCounter += previousDirection;
					countIt = 0;
					[self checkRuneDrawn:battleValkyrie];
					runeDrawingHash = 0;
					recordTouch = YES;
					return;
				}
				////NSLog(@"Reached end of touch when it shouldn't.");
				break;

			case kValkyrieRunePlacement:
				if (runePlacementHash == touch.hash) {
					for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
                        if (CGRectContainsPoint([entity getRect], touchLocation)) {
                            if ([entity isKindOfClass:[AbstractBattleEnemy class]] && entity.isAlive) {
                                [battleValkyrie runeWasPlacedOnEnemy:entity];
                                [battleValkyrie resetBattleTimer];
                                state = kValkyrie;
                                runePlacementHash = 0;
                                ////NSLog(@"Valk rune placed on enemy.");
                                recordTouch = YES;
                                return;
                            }
                            if ([entity isKindOfClass:[AbstractBattleCharacter class]] && (entity.isAlive || battleValkyrie.queuedRuneNumber == 375)) {
                                [battleValkyrie runeWasPlacedOnCharacter:entity];
                                state = kValkyrie;
                                runePlacementHash = 0;
                                [battleValkyrie resetBattleTimer];
                                ////NSLog(@"Valk rune placed on character.");
                                recordTouch = YES;
                                return;
                            }
                        }	
					}
					if (CGRectContainsPoint(CGRectMake(0, 0, 240, 320), touchLocation)) {
						[battleValkyrie runeAffectedAllCharacters];
						state = kValkyrie;
						runePlacementHash = 0;
						[battleValkyrie resetBattleTimer];
						////NSLog(@"Valk rune placed on all characters.");
						recordTouch = YES;
						return;
					}
					if (CGRectContainsPoint(CGRectMake(241, 0, 240, 320), touchLocation)) {
						[battleValkyrie runeAffectedAllEnemies];
						state = kValkyrie;
						runePlacementHash = 0;
						[battleValkyrie resetBattleTimer];
						recordTouch = YES;
						////NSLog(@"Valk rune placed on all enemies.");
						return;
					}					
				}
				////NSLog(@"Reached end of touch when it shouldn't.");
				break;
				
			case kWizardAttacking:
				////NSLog(@"Crash happens after this.");
				if (wizardHoldHash == touch.hash) {
					for (AbstractBattleEnemy *entity in sharedGameController.currentScene.activeEntities) {
                        if (entity.isAlive) {
                            if ([entity isKindOfClass:[AbstractBattleEnemy class]] && CGRectContainsPoint([entity getRect], touchLocation)) {
                                [battleWizard youAttackedEnemy:entity];
                                [battleWizard resetBattleTimer];
                                state = kWizard;
                                wizardHoldHash = 0;;
                                recordTouch = YES;
                                ////NSLog(@"Wizard attacked!");
                                return;
                            }
                        }
					}
					state = kWizard;
					wizardHoldHash = 0;
					////NSLog(@"Wizard attack cancelled.");
					recordTouch = YES;
					return;
				}
				break;

			case kWizardRuneDrawing:
				if (runeDrawingHash == touch.hash) {
					drawCounter += previousDirection;
					countIt = 0;
					[self checkRuneDrawn:battleWizard];
					runeDrawingHash = 0;
					recordTouch = YES;
					return;
				}
				break;
				
			case kWizardRunePlacement:
				if (runePlacementHash == touch.hash) {
					for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
						if (CGRectContainsPoint([entity getRect], touchLocation)) {
							if ([entity isKindOfClass:[AbstractBattleEnemy class]] && entity.isAlive) {
								[battleWizard runeWasPlacedOnEnemy:entity];
								state = kWizard;
								runePlacementHash = 0;
								[battleWizard resetBattleTimer];
								recordTouch = YES;
								////NSLog(@"Wizard rune placed on enemy.");
								return;
							} 
							if ([entity isKindOfClass:[AbstractBattleCharacter class]]) {
								[battleWizard runeWasPlacedOnCharacter:entity];
								state = kWizard;
								runePlacementHash = 0;
								[battleWizard resetBattleTimer];
								recordTouch = YES;
								////NSLog(@"Wizard rune placed on character.");
								return;
							}
						}
					}
					if (CGRectContainsPoint(CGRectMake(0, 0, 240, 320), touchLocation)) {
						[battleWizard runeAffectedAllCharacters];
						state = kWizard;
						runePlacementHash = 0;
						[battleWizard resetBattleTimer];
						recordTouch = YES;
						////NSLog(@"Wizard rune placed on all characters.");
						return;
					}
					if (CGRectContainsPoint(CGRectMake(241, 0, 240, 320), touchLocation)) {
						[battleWizard runeAffectedAllEnemies];
						state = kWizard;
						runePlacementHash = 0;
						[battleWizard resetBattleTimer];
						recordTouch = YES;
						////NSLog(@"Wizard rune placed on all enemies.");
						return;
					}					
				}
				////NSLog(@"Reached end of touch when it shouldn't.");
				break;

			case kRanger:
				if (rangerTapHash == touch.hash) {
					for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
                        if (entity.isAlive) {
                            if (CGRectContainsPoint([entity getRect], [battleRanger getTargetPoint])) {
                                [battleRanger youAttackedEnemy:entity];
                                state = kRanger;
                                rangerTapHash = 0;
                                [battleRanger resetBattleTimer];
                                recordTouch = YES;
                                ////NSLog(@"Ranger attacked.");
                                return;
                            }
                        }
						
					}
					state = kRanger;
					rangerTapHash = 0;
					recordTouch = YES;
					////NSLog(@"Ranger attack cancelled.");
					return;
				}
				recordTouch = YES;
				return;
				break;
				
			case kRangerAnimalLineDrawing:
				if (rangerAnimalLineHash == touch.hash) {
					for (AbstractBattleEnemy *entity in sharedGameController.currentScene.activeEntities) {
						if (CGRectContainsPoint([entity getRect], touchLocation)) {
							if ([entity isKindOfClass:[AbstractBattleEnemy class]] && entity.isAlive) {
								[battleRanger animalWasLinkedToEnemy:entity];
								state = kRanger;
								rangerAnimalLineHash = 0;
								[battleRanger resetBattleTimer];
								[sharedGameController.currentScene drawLineOff];
								recordTouch = YES;
								////NSLog(@"Animal linked to enemy.");
								return;
							} 
							if ([entity isKindOfClass:[AbstractBattleCharacter class]]) {
								[battleRanger animalWasLinkedToCharacter:entity];
								state = kRanger;
								rangerAnimalLineHash = 0;
								[battleRanger resetBattleTimer];
								recordTouch = YES;
								[sharedGameController.currentScene drawLineOff];
								NSLog(@"Animal linked to character");
								return;
							}
						}
					}
					if (CGRectContainsPoint(CGRectMake(0, 0, 240, 320), touchLocation)) {
						[battleRanger animalWasLinkedToAllCharacters];
						state = kRanger;
						rangerAnimalLineHash = 0;
						[battleRanger resetBattleTimer];
						recordTouch = YES;
						[sharedGameController.currentScene drawLineOff];
						////NSLog(@"Animal linked to all characters.");
						return;
					}
					if (CGRectContainsPoint(CGRectMake(241, 0, 240, 320), touchLocation)) {
						[battleRanger animalWasLinkedToAllEnemies];
						state = kRanger;
						rangerAnimalLineHash = 0;
						[battleRanger resetBattleTimer];
						[sharedGameController.currentScene drawLineOff];
						recordTouch = YES;
						////NSLog(@"Animal linked to all enemies.");
						return;
					}
				}
				break;

			case kRangerRuneDrawing:
				if (runeDrawingHash == touch.hash) {
					drawCounter += previousDirection;
					countIt = 0;
					[self checkRuneDrawn:battleRanger];
					runeDrawingHash = 0;
					recordTouch = YES;
					return;
				}
				break;

			case kRangerRunePlacement:
				if (runePlacementHash == touch.hash) {
					for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
						if (CGRectContainsPoint([entity getRect], touchLocation)) {
							if ([entity isKindOfClass:[AbstractBattleEnemy class]] && entity.isAlive) {
								[battleRanger runeWasPlacedOnEnemy:entity];
								state = kRanger;
								runePlacementHash = 0;
								[battleRanger resetBattleTimer];
								recordTouch = YES;
								////NSLog(@"Ranger rune placed on enemy.");
								return;
							} 
							if ([entity isKindOfClass:[AbstractBattleCharacter class]]) {
								[battleRanger runeWasPlacedOnCharacter:entity];
								state = kRanger;
								runePlacementHash = 0;
								[battleRanger resetBattleTimer];
								recordTouch = YES;
								return;
							}
						}
					}
					if (CGRectContainsPoint(CGRectMake(0, 0, 240, 320), touchLocation)) {
						[battleRanger runeAffectedAllCharacters];
						state = kRanger;
						runePlacementHash = 0;
						[battleRanger resetBattleTimer];
						recordTouch = YES;
						return;
					}
					if (CGRectContainsPoint(CGRectMake(241, 0, 240, 320), touchLocation)) {
						[battleRanger runeAffectedAllEnemies];
						state = kRanger;
						runePlacementHash = 0;
						[battleRanger resetBattleTimer];
						recordTouch = YES;
						return;
					}					
				}
				break;

			case kPriestAttacking:
				if (priestHoldHash == touch.hash) {
					[battlePriest stopAttacking];
					[battlePriest resetBattleTimer];
					state = kPriest;
					priestHoldHash = 0;
					recordTouch = YES;
					////NSLog(@"Priest Attacked.");
					return;
				}
				break;
				
			case kPriestSacrificing:
				//Implement sacrificing code here.
				[battlePriest resetBattleTimer];
				state = kPriest;
				priestSacrificeHash = 0;
				recordTouch = YES;
				////NSLog(@"Priest sacrificed!");
				return;
				break;
				
			case kPriestRuneDrawing:
				if (runeDrawingHash == touch.hash) {
					drawCounter += previousDirection;
					countIt = 0;
					[self checkRuneDrawn:battlePriest];
					runeDrawingHash = 0;
					recordTouch = YES;
					return;
				}
				break;

			case kPriestRunePlacement:
				if (runePlacementHash == touch.hash) {
					for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
						if (CGRectContainsPoint([entity getRect], touchLocation)) {
							if ([entity isKindOfClass:[AbstractBattleEnemy class]] && entity.isAlive) {
								[battlePriest runeWasPlacedOnEnemy:entity];
								state = kPriest;
								runePlacementHash = 0;
								[battlePriest resetBattleTimer];
								recordTouch = YES;
								////NSLog(@"Priest rune was placed on enemy.");
								return;
							}
							if ([entity isKindOfClass:[AbstractBattleCharacter class]]) {
								[battlePriest runeWasPlacedOnCharacter:entity];
								state = kPriest;
								runePlacementHash = 0;
								[battlePriest resetBattleTimer];
								recordTouch = YES;
								return;
							}
						}
					}
					if (CGRectContainsPoint(CGRectMake(0, 0, 240, 320), touchLocation)) {
						[battlePriest runeAffectedAllCharacters];
						state = kPriest;
						runePlacementHash = 0;
						[battlePriest resetBattleTimer];
						recordTouch = YES;
						return;
					}
					if (CGRectContainsPoint(CGRectMake(241, 0, 240, 320), touchLocation)) {
						[battlePriest runeAffectedAllEnemies];
						state = kPriest;
						runePlacementHash = 0;
						[battlePriest resetBattleTimer];
						recordTouch = YES;
						return;
					}			
				}
				break;

			case kDwarfAttacking:
				if (dwarfSlashHash == touch.hash) {
					CGPoint centerOfSlash = CGPointMake((touchLocation.x + previousLocation.x) / 2, (touchLocation.y + previousLocation.y) / 2);
					for (AbstractBattleEntity *enemy in sharedGameController.currentScene.activeEntities) {
                        if (enemy.isAlive) {
                            if (CGRectContainsPoint([enemy getRect], centerOfSlash)) {
                                [battleDwarf youAttackedEnemy:enemy];
                                [battleDwarf resetBattleTimer];
                                state = kDwarf;
                                dwarfSlashHash = 0;
                                ////NSLog(@"Dwarf attacked.");
                                recordTouch = YES;
                                return;
                            }
                        }
						
					}
					state = kDwarf;
					dwarfSlashHash = 0;
					////NSLog(@"Dwarf attack cancelled.");
					recordTouch = YES;
					return;					
				}
				break;
				
			case kDwarfBeerOrdering:
				if (runeDrawingHash == touch.hash) {
					drawCounter += previousDirection;
					countIt = 0;
					[self checkRuneDrawn:battleDwarf];
					runeDrawingHash = 0;
					recordTouch = YES;
					return;
				}
				break;
				//End Battle touches.
				//Begin walking around touches.
			case kWalkingAround_LeftTouchDown:
				if (leftThumbHash == touch.hash) {
					[sharedGameController.player stopMoving];
					leftThumbDirection = kNotMoving;
					leftThumbHash = 0;
					////NSLog(@"Left touch removed from left touch down.");
					state = kWalkingAround_NoTouches;
                    break;
				}
                break;
			case kWalkingAround_RightTouchDown:
				if (rightThumbHash == touch.hash) {
					[sharedGameController.player stopMoving];
					rightThumbDirection = kNotMoving;
					rightThumbHash = 0;
					////NSLog(@"Right touch removed from right touch down.");
					state = kWalkingAround_NoTouches;
                    break;
				}
				break;
			case kWalkingAround_BothSidesDown:
				if (leftThumbHash == touch.hash) {
					leftThumbDirection = kNotMoving;
					leftThumbHash = 0;
					state = kWalkingAround_RightTouchDown;
					////NSLog(@"Left thumb left.");
					[self updateWalkingDirection];
                    break;
				}
				if (rightThumbHash == touch.hash) {
					rightThumbDirection = kNotMoving;
					rightThumbHash = 0;
					state = kWalkingAround_LeftTouchDown;
					////NSLog(@"Right thumb left.");
					[self updateWalkingDirection];
                    break;
				}
				break;
				//End walking around touches.
				//Begin menu 
			case kMenuOpen:
				if (menuTapHash == touch.hash) {
					////NSLog(@"Touch was dispatched.");
					[currentMenu youWereTappedAt:touchLocation];
					tapHash = 0;
					return;
				}
				break;

            case kBattleExperienceScreen:
                for (ExperienceScreen *es in sharedGameController.currentScene.activeObjects) {
                    if ([es isMemberOfClass:[ExperienceScreen class]]) {
                        [es youWereTappedAt:touchLocation];
                        return;
                    }
                }
                break;
				
				//Still a lot to go. Make sure to add needed methods to the sticky
				//And make sure you add runedrawing and rune placement for all characters
				//except no placement for the dwarf.
				

			default:
				break;
		}
		if (entityTouchHash == touch.hash && state != kMenuOpen) {
			CGRect relativeRect = CGRectMake(sharedGameController.player.currentLocation.x - 40, sharedGameController.player.currentLocation.y - 40, 80, 80);
			////NSLog(@"Found the touch ended with relative Rect: (%f, %f, %f, %f).", relativeRect.origin.x, relativeRect.origin.y, relativeRect.size.width, relativeRect.size.height);
			for (AbstractEntity *entity in sharedGameController.currentScene.activeEntities) {
				CGRect entityRect = [entity getRect];
				////NSLog(@"Entity rect is: (%f, %f, %f, %f).", entityRect.origin.x, entityRect.origin.y, entityRect.size.width, entityRect.size.height);
				if (CGRectIntersectsRect(relativeRect, [entity getRect]) && entity != sharedGameController.player) {
					[entity youWereTapped];
					[sharedGameController.player faceEntity:entity];
					entityTouchHash = 0;
					return;
				}
			}
		}
		if (state == kWalkingAround_TextboxOnScreen) {
			[sharedGameController.currentScene removeTextbox];
			state = kWalkingAround_NoTouches;
		}
        if (state == kCutScene_TextboxOnScreen && touch.hash == cutSceneHash) {
            state = kNoTouchesAllowed;
            NSLog(@"Should move to next scene.");
            cutSceneHash = 0;
            [sharedGameController.currentScene removeTextbox];
            [sharedGameController.currentScene moveToNextStageInScene];
            return;
        }
        if (state == kCutScene_ScriptReader && touch.hash == cutSceneHash) {
            state = kNoTouchesAllowed;
            NSLog(@"Script reader should advance.");
            cutSceneHash = 0;
            [sharedScriptReader advanceCutScene];
            return;
        }
        if (state == kCutScene_LastLine && touch.hash == cutSceneHash) {
            state = kNoTouchesAllowed;
            NSLog(@"Script reader should end.");
            cutSceneHash = 0;
            [sharedScriptReader endCutScene];
            return;
        }
        if (state == kCutScene_MustTapRect && CGRectContainsPoint(cutSceneRect, touchLocation) && touch.hash == cutSceneHash) {
            cutSceneHash = 0;
            cutSceneRect = CGRectMake(0, 0, 0, 0);
            [sharedGameController.currentScene removeTextbox];
            [sharedGameController.currentScene moveToNextStageInScene];
            return;
        }
        if (state == kCutScene_MustTapRect && !CGRectContainsPoint(cutSceneRect, touchLocation)) {
            recordTouch = YES;
            cutSceneHash = 0;
            return;
        }
        if (state == kTutorial_TextboxOnScreen && touch.hash == cutSceneHash) {
            state = kNoTouchesAllowed;
            cutSceneHash = 0;
            [sharedScriptReader advanceTutorial];
            return;
        }
        if (state == kTutorial_LastLine && touch.hash == cutSceneHash) {
            state = kNoTouchesAllowed;
            cutSceneHash = 0;
            [sharedScriptReader endTutorial];
            return;
        }
        if (state == kTutorial_MustTapRect && CGRectContainsPoint(cutSceneRect, touchLocation) && touch.hash == cutSceneHash) {
            cutSceneHash = 0;
            cutSceneRect = CGRectMake(0, 0, 0, 0);
            [sharedScriptReader advanceTutorial];
            return;
        }
        if (state == kTutorial_MustTapRect && !CGRectContainsPoint(cutSceneRect, touchLocation)) {
            recordTouch = YES;
            cutSceneHash = 0;
            return;
        }
        if (state == kChoiceboxOnScreen && touch.hash == cutSceneHash) {
            for (Choicebox *cb in sharedGameController.currentScene.activeObjects) {
                if ([cb isMemberOfClass:[Choicebox class]]) { 
                    [cb youWereTappedAt:touchLocation];
                    return;
                }
            }
        }
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView {
    
    switch (sharedGameController.gameState) {
        case kGameState_Menu:
            [self setState:kMenuOpen];
            menuTapHash = 0;
            break;
        case kGameState_Battle:
            [self setState:kNoOnesTurn];
            tapHash = roderickSlashHash = roderickElementalHash = valkyrieTapHash = valkyrieRageLineDrawingHash = valkyrieRageHash = wizardHoldHash = rangerTapHash = rangerAnimalLineHash = priestHoldHash = priestSacrificeHash = dwarfSlashHash = runeDrawingHash = runePlacementHash = 0;
            recordTouch = YES;
            break;
        case kGameState_World:
            [self setState:kWalkingAround_NoTouches];
            [sharedGameController.player stopMoving];
            leftThumbHash = 0;
            rightThumbHash = 0;
            break;
            
        default:
            break;
    }
}


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	
	//////NSLog(@"Acceleration detected with (%f, %f, %f).", acceleration.x, acceleration.y, acceleration.z);
	
	if (self.lastAcceleration) {
		if (!histeresisExcited && L0AccelerationIsShaking(self.lastAcceleration, acceleration, 0.7)) {
			cueBones += 1;
		} else if (cueBones > 3 && !L0AccelerationIsShaking(self.lastAcceleration, acceleration, 0.7)) {
			if (cueBones > 3 && state == kWizard) {
				[battleWizard rollBones];
				[battleWizard resetBattleTimer];
				state = kNoOnesTurn;
			}
			cueBones = NO;
		}
	}
	
	if (state == kRanger) {
		//[battleRanger updateTargetLocationWithAcceleration:acceleration];
        [battleRanger updateTargetLocationWithX:acceleration.x + 0.5 Y:acceleration.y Z:acceleration.z];
	}	
	if (state == kValkyrieFlying) {
		[battleValkyrie updateTargetLocationWithAcceleration:acceleration];
	}
	self.lastAcceleration = acceleration;
}


- (void)enableUIDevice {
	
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(orientationChanged)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
	//Should only be called when its the Priest's turn.
}

- (void)orientationChanged {
	
	if (state == kPriest && [UIDevice currentDevice].orientation == UIInterfaceOrientationPortrait) {
		//////NSLog(@"Here is when you would rotate to sacrafice.");
		state = kPriestSacrificing;
		//[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	}
}

- (void)setState:(int)aState {
	
    recordTouch = YES;
    if (aState == kWalkingAround_NoTouches) {
        leftThumbDirection = rightThumbDirection = 0;
    }
	state = aState;
	////NSLog(@"State has become, '%d'.", state);
}

- (void)addSelector:(CGPoint)aLocation {
	for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
		if (CGRectContainsPoint([entity getRect], aLocation)) {
			[entity addSelectorImage];
			currentSelectorRect = [entity getRect];
		}
	}
}

- (void)updateSelector:(CGPoint)aLocation {
	
	if (!CGRectContainsPoint(currentSelectorRect, aLocation)) {
		for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
			if (CGRectContainsPoint([entity getRect], aLocation)) {
				[entity addSelectorImage];
				currentSelectorRect = [entity getRect];
			}
		}
		/*for (AbstractBattleEntity *entity in sharedGameController.currentScene.activeEntities) {
			[entity removeSelectorImage];
		}*/		
	}
}

- (void)selectSelected {
	
	for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
		if (CGRectContainsRect(currentSelectorRect, [character getRect])) {
			[character removeSelectorImage];
            ////NSLog(@"Test");
			[character gainPriority];
		}
	}
}

- (void)updateRuneDrawing:(CGPoint)aLocation {
	
	Vector2f vector = Vector2fMake(aLocation.x - previousLocation.x, aLocation.y - previousLocation.y);
    if (vector.x == 0) {
        vector.x = 1;
    }
    if (vector.y == 0) {
        vector.y = 1;
    }
	float angle = atanf((vector.y / vector.x)) * 57.2957795;
	if (angle < 0 && vector.x < 0) {
		angle += 180;
	} else if (angle < 0 && vector.y < 0) {
		angle += 360;
	} else if (vector.x < 0 && vector.y < 0) {
		angle += 180;
	}
	if (angle < 19.5 && angle >= 0 || angle < 360 && angle >= 340.5) {
		touchDirection = kMovingRight;
		rightTally++;
	} else if (angle < 70.5 && angle >= 19.5) {
		touchDirection = kMovingUpRight;
		upRightTally++;
	} else if (angle < 109.5 && angle >= 70.5) {
		touchDirection = kMovingUp;
		upTally++;
	} else if (angle < 160.5 && angle >= 109.5) {
		touchDirection = kMovingUpLeft;
		upLeftTally++;
	} else if (angle < 199.5 && angle >= 160.5) {
		touchDirection = kMovingLeft;
		leftTally++;
	} else if (angle < 250.5 && angle >= 199.5) {
		touchDirection = kMovingDownLeft;
		downLeftTally++;
	} else if (angle < 289.5 && angle >= 250.5) {
		touchDirection = kMovingDown;
		downTally++;
	} else if (angle < 340.5 && angle >= 289.5) {
		touchDirection = kMovingDownRight;
		downRightTally++;
	}
	//////NSLog(@"Angle is: %f, Touch direction is: %d, and Previous direction is: %d.", angle, touchDirection, previousDirection );
	/*if (touchDirection != previousDirection) {
		if (countIt > 5) {
			drawCounter += previousDirection;
			////NSLog(@"drawCounter updated to, %d.", drawCounter);
			gestureCounter++;
		}
		drawingImageIndex++;
		countIt = 0;
		previousDirection = touchDirection;
	} else {
		countIt++;
	}*/
	previousLocation = aLocation;
}
	
	
- (void)checkRuneDrawn:(AbstractBattleCharacter *)aBattleCharacter {
	
	if (MAX_8(leftTally, upLeftTally, upTally, upRightTally, rightTally, downRightTally, downTally, downLeftTally) == leftTally) {
		drawCounter += kMovingLeft;
        ////NSLog(@"movingLeft");
	} else if (MAX_8(leftTally, upLeftTally, upTally, upRightTally, rightTally, downRightTally, downTally, downLeftTally) == upLeftTally) {
		drawCounter += kMovingUpLeft;
	} else if (MAX_8(leftTally, upLeftTally, upTally, upRightTally, rightTally, downRightTally, downTally, downLeftTally) == upTally) {
		drawCounter += kMovingUp;
	} else if (MAX_8(leftTally, upLeftTally, upTally, upRightTally, rightTally, downRightTally, downTally, downLeftTally) == upRightTally) {
		drawCounter += kMovingUpRight;
	} else if (MAX_8(leftTally, upLeftTally, upTally, upRightTally, rightTally, downRightTally, downTally, downLeftTally) == rightTally) {
		drawCounter += kMovingRight;
        ////NSLog(@"MovingRight");
	} else if (MAX_8(leftTally, upLeftTally, upTally, upRightTally, rightTally, downRightTally, downTally, downLeftTally) == downRightTally) {
		drawCounter += kMovingDownRight;
	} else if (MAX_8(leftTally, upLeftTally, upTally, upRightTally, rightTally, downRightTally, downTally, downLeftTally) == downTally) {
		drawCounter += kMovingDown;
	} else if (MAX_8(leftTally, upLeftTally, upTally, upRightTally, rightTally, downRightTally, downTally, downLeftTally) == downLeftTally) {
		drawCounter += kMovingDownLeft;
	}
	
	leftTally = upLeftTally = upTally = upRightTally = rightTally = downRightTally = downTally = downLeftTally = 0;
	

	//////NSLog(@"draw counter is: %d", drawCounter);
	/*if ([aBattleCharacter.knownRunes objectForKey:[NSString stringWithFormat:@"Rune%d", drawCounter]]) {
		[aBattleCharacter queueRune:drawCounter];
		recordTouch = YES;
	}*/
    if (aBattleCharacter == battleRoderick) {
        Character *roderick = [sharedGameController.characters objectForKey:@"Roderick"];
        if (drawCounter == 201 && [roderick.knownRunes objectForKey:@"Ansuz"]) {
            [aBattleCharacter queueRune:201];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
            
        }
        if (drawCounter == 53 && [roderick.knownRunes objectForKey:@"Isa"]) {
            [aBattleCharacter queueRune:53];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 332 && [roderick.knownRunes objectForKey:@"Othala"]) {
            [aBattleCharacter queueRune:332];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 179 && [roderick.knownRunes objectForKey:@"Gromanth"]) {
            [aBattleCharacter queueRune:179];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 129 && [roderick.knownRunes objectForKey:@"Nordrin"]) {
            [aBattleCharacter queueRune:129];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 111 && [roderick.knownRunes objectForKey:@"Sudrin"]) {
            [aBattleCharacter queueRune:111];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 39 && [roderick.knownRunes objectForKey:@"Austrin"]) {
            [aBattleCharacter queueRune:39];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 69 && [roderick.knownRunes objectForKey:@"Vestrin"]) {
            [aBattleCharacter queueRune:69];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }

    }
    if (aBattleCharacter == battleValkyrie) {
        Character *alex = [sharedGameController.characters objectForKey:@"Valkyrie"];
        if (drawCounter == 253 && [alex.knownRunes objectForKey:@"Sowilo"]) {
            [aBattleCharacter queueRune:253];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 165 && [alex.knownRunes objectForKey:@"Hagalaz"]) {
            [aBattleCharacter queueRune:165];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 245 && [alex.knownRunes objectForKey:@"Jera"]) {
            [aBattleCharacter queueRune:245];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 116 && [alex.knownRunes objectForKey:@"Nauthiz"]) {
            [aBattleCharacter queueRune:116];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 375 && [alex.knownRunes objectForKey:@"Berkano"]) {
            [aBattleCharacter queueRune:375];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 56 && [alex.knownRunes objectForKey:@"Primaz"]) {
            [aBattleCharacter queueRune:56];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 217 && [alex.knownRunes objectForKey:@"Akath"]) {
            [aBattleCharacter queueRune:217];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 286 && [alex.knownRunes objectForKey:@"Holgeth"]) {
            [aBattleCharacter queueRune:286];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
    }
    if (aBattleCharacter == battleWizard) {
        Character *wizard = [sharedGameController.characters objectForKey:@"Wizard"];
        if (drawCounter == 120 && [wizard.knownRunes objectForKey:@"Kenaz"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 288 && [wizard.knownRunes objectForKey:@"Raidho"]) {
            [aBattleCharacter queueRune:288];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 252 && [wizard.knownRunes objectForKey:@"Mannaz"]) {
            [aBattleCharacter queueRune:252];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 157 && [wizard.knownRunes objectForKey:@"Tiwaz"]) {
            [aBattleCharacter queueRune:157];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 286 && [wizard.knownRunes objectForKey:@"Ingwaz"]) {
            [aBattleCharacter queueRune:287];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 169 && [wizard.knownRunes objectForKey:@"Fyraz"]) {
            [aBattleCharacter queueRune:169];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 143 && [wizard.knownRunes objectForKey:@"Daleyth"]) {
            [aBattleCharacter queueRune:143];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 145 && [wizard.knownRunes objectForKey:@"Ekwaz"]) {
            [aBattleCharacter queueRune:145];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
    }
   	if (aBattleCharacter == battleRanger) {
        Character *ranger = [sharedGameController.characters objectForKey:@"Ranger"];
        if (drawCounter == 201 && [ranger.knownRunes objectForKey:@"Eihwaz"]) {
            [aBattleCharacter queueRune:195];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 149 && [ranger.knownRunes objectForKey:@"Fehu"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 116 && [ranger.knownRunes objectForKey:@"Uruz"]) {
            [aBattleCharacter queueRune:117];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 175 && [ranger.knownRunes objectForKey:@"Thurisaz"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 209 && [ranger.knownRunes objectForKey:@"Algiz"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 104 && [ranger.knownRunes objectForKey:@"Laguz"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 187 && [ranger.knownRunes objectForKey:@"Hoppat"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 135 && [ranger.knownRunes objectForKey:@"Swopaz"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
    }
	if (aBattleCharacter == battlePriest) {
        Character *priest = [sharedGameController.characters objectForKey:@"Priest"];
        if (drawCounter == 209 && [priest.knownRunes objectForKey:@"Wunjo"]) {
            [aBattleCharacter queueRune:210];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 166 && [priest.knownRunes objectForKey:@"Gebo"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 252 && [priest.knownRunes objectForKey:@"Ehwaz"]) {
            [aBattleCharacter queueRune:254];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 218 && [priest.knownRunes objectForKey:@"Dagaz"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 240 && [priest.knownRunes objectForKey:@"Epelth"]) {
            [aBattleCharacter queueRune:241];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 142 && [priest.knownRunes objectForKey:@"Helaz"]) {
            [aBattleCharacter queueRune:144];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 286 && [priest.knownRunes objectForKey:@"Ingreth"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 203 && [priest.knownRunes objectForKey:@"Smeaz"]) {
            [aBattleCharacter queueRune:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
    }
	if (aBattleCharacter == battleDwarf) {
        Character *dwarf = [sharedGameController.characters objectForKey:@"Dwarf"];
        if (drawCounter == 93 && [dwarf.knownRunes objectForKey:@"Dwarfapult"]) {
            [battleDwarf youOrderedADrink:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 37 && [dwarf.knownRunes objectForKey:@"BuyARound"]) {
            [battleDwarf youOrderedADrink:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 36 && [dwarf.knownRunes objectForKey:@"FinishingMove"]) {
            [battleDwarf youOrderedADrink:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 166 && [dwarf.knownRunes objectForKey:@"Boobytrap"]) {
            [battleDwarf youOrderedADrink:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
            
        }
        if (drawCounter == 132 && [dwarf.knownRunes objectForKey:@"SuperAxerang"]) {
            [battleDwarf youOrderedADrink:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 145 && [dwarf.knownRunes objectForKey:@"Motivate"]) {
            [battleDwarf youOrderedADrink:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
        if (drawCounter == 50 && [dwarf.knownRunes objectForKey:@"Bombulus"]) {
            [battleDwarf youOrderedADrink:drawCounter];
            drawCounter = 0;
            [sharedGameController.currentScene removeDrawingImages];
            runeRect = CGRectMake(120, 0, 160, 320);
        }
    }
}

- (void)updateWalkingDirection {
	
	int direction = leftThumbDirection + rightThumbDirection;
	switch (direction) {
		case 0:
			//[sharedGameController.player stopMoving];
			break;
		case 13:
			[sharedGameController.player startMoving:kMovingRight];
			break;
		case 23:
			[sharedGameController.player startMoving:kMovingLeft];
			break;
		case 53:
			[sharedGameController.player startMoving:kMovingUpRight];
			break;
		case 67:
			[sharedGameController.player startMoving:kMovingUpLeft];
			break;
		case 79:
			[sharedGameController.player startMoving:kMovingDownRight];
			break;
		case 87:
			[sharedGameController.player startMoving:kMovingDownLeft];
			break;
		case 120:
			[sharedGameController.player startMoving:kMovingUp];
			break;
		case 80:
			[sharedGameController.player startMoving:kMovingUpRight];
			break;
		case 146:
			//[sharedGameController.player stopMoving];
			break;
		case 76:
			[sharedGameController.player startMoving:kMovingUpLeft];
			break;
		case 36:
			//[sharedGameController.player stopMoving];
			break;
		case 102:
			[sharedGameController.player startMoving:kMovingDownLeft];
			break;
		case 140:
			//[sharedGameController.player stopMoving];
			break;
		case 100:
			[sharedGameController.player startMoving:kMovingDownRight];
			break;
		case 166:
			[sharedGameController.player startMoving:kMovingDown];
			break;
		default:
			break;
	}
}

- (void)thereWasAPinchOpen {
	if (currentMenu == nil) {
		MenuSystem *ms = [[MenuSystem alloc] init];
		[ms openMenu];
		[sharedGameController.currentScene addObjectToActiveObjects:ms];
		currentMenu = ms;
		sharedGameController.gameState = kGameState_Menu;
		[sharedGameController.player stopMoving];
		state = kMenuOpen;
	}
	
}

- (void)thereWasAPinchClose {
	if (currentMenu) {
		[currentMenu closeMenu];
		[currentMenu release];
		currentMenu = nil;
		state = kWalkingAround_NoTouches;
		sharedGameController.gameState = kGameState_World;
	}
	
}

- (void)setStateMustTapRect:(CGRect)aRect {
    
    cutSceneRect = aRect;
    state = kCutScene_MustTapRect;
}

- (void)setStateTutorialMustTapRect:(CGRect)aRect {
    
    cutSceneRect = aRect;
    state = kTutorial_MustTapRect;
}

- (void)setUpRuneRect {
    
    runeRect = CGRectMake(120, 0, 160, 320);
}


@end
