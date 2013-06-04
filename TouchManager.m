//
//  TouchManager.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TouchManager.h"
#import "SynthesizeSingleton.h"
#import "AbstractScene.h"
#import "AnimationManagementTest.h"
#import "GameController.h"
#import "Image.h"
#import "Global.h"
#import "RuneObject.h"
#import "Projectile.h"
#import "Fire.h"
#import "Slash.h"
#import "WaterElemental.h"
#import "Spear.h"
#import "AbstractEntity.h"


@implementation TouchManager

@synthesize state;

SYNTHESIZE_SINGLETON_FOR_CLASS(TouchManager);

- (void)dealloc {
	[super dealloc];
}

- (id)init {
	
	if (self = [super init]) {
		
		sharedGameController = [GameController sharedGameController];
		state = 0;
		drawingImageIndex = 0;
		isTouchDrawing = NO;
		previousDirection = kNotMoving;
		touchDirection = kNotMoving;
		drawCounter = 0;
		gestureCounter = 0;
	}
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView sender:(AbstractScene *)aScene{
	
	CGPoint touchLocation;
	UITouch *thisTouch;
	for (UITouch *touch in touches) {
		touchLocation = [sharedGameController adjustTouchOrientationForTouch:[touch locationInView:aView]];
		thisTouch = touch;
		//NSLog(@"Touch was detected in state: '%d'.", state);
		break;
	}
	
	//Walking around code.
	if (state == kWalkingAround_NoTouches) {
		if (CGRectContainsPoint(CGRectMake(400, 0, 80, 320), touchLocation)) {
			state = kWalkingAround_RightTouchDown;
			walkingRightTouchHash = thisTouch.hash;
			rightTouchLocation = touchLocation;
			if (CGRectContainsPoint(CGRectMake(400, 0, 80, 106), touchLocation)) {
				[sharedGameController.player startMoving:kMovingDownRight];
			}
			if (CGRectContainsPoint(CGRectMake(400, 107, 80, 106), touchLocation)) {
				[sharedGameController.player startMoving:kMovingRight];
			}
			if (CGRectContainsPoint(CGRectMake(400, 214, 80, 106), touchLocation)) {
				[sharedGameController.player startMoving:kMovingUpRight];
			}
		}
		if (CGRectContainsPoint(CGRectMake(0, 0, 80, 320), touchLocation)) {
			state = kWalkingAround_LeftTouchDown;
			walkingLeftTouchHash = thisTouch.hash;
			leftTouchLocation = touchLocation;
			if (CGRectContainsPoint(CGRectMake(0, 0, 80, 106), touchLocation)) {
				[sharedGameController.player startMoving:kMovingDownLeft];
			}
			if (CGRectContainsPoint(CGRectMake(0, 107, 80, 106), touchLocation)) {
				[sharedGameController.player startMoving:kMovingLeft];
			}
			if (CGRectContainsPoint(CGRectMake(0, 214, 80, 106), touchLocation)) {
				[sharedGameController.player startMoving:kMovingUpLeft];
			}
		}
	}
	
	else if (state == kWalkingAround_LeftTouchDown) {
		if (CGRectContainsPoint(CGRectMake(400, 0, 80, 320), touchLocation)) {
			state = kWalkingAround_BothSidesDown;
			walkingRightTouchHash = thisTouch.hash;
			rightTouchLocation = touchLocation;
			if (CGRectContainsPoint(CGRectMake(400, 0, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingDownLeft) {
				[sharedGameController.player startMoving:kMovingDown];
			} else if (CGRectContainsPoint(CGRectMake(400, 0, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingLeft) {
				[sharedGameController.player startMoving:kMovingDownLeft];
			} else if (CGRectContainsPoint(CGRectMake(400, 0, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingUpLeft) {
				[sharedGameController.player stopMoving];
			}
			
			if (CGRectContainsPoint(CGRectMake(400, 107, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingLeft) {
				[sharedGameController.player stopMoving];
			} else if (CGRectContainsPoint(CGRectMake(400, 107, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingDownLeft) {
				[sharedGameController.player startMoving:kMovingDownRight];
			} else if (CGRectContainsPoint(CGRectMake(400, 107, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingUpLeft) {
				[sharedGameController.player startMoving:kMovingUpRight];
			}
			if (CGRectContainsPoint(CGRectMake(400, 214, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingUpLeft) {
				[sharedGameController.player startMoving:kMovingUp];
			} else if (CGRectContainsPoint(CGRectMake(400, 214, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingLeft) {
				[sharedGameController.player startMoving:kMovingUpLeft];
			} else if (CGRectContainsPoint(CGRectMake(400, 214, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingDownLeft) {
				[sharedGameController.player stopMoving];
			}
		}
	}
	else if (state == kWalkingAround_RightTouchDown) {
		if (CGRectContainsPoint(CGRectMake(0, 0, 80, 320), touchLocation)) {
			state = kWalkingAround_BothSidesDown;
			walkingLeftTouchHash = thisTouch.hash;
			leftTouchLocation = touchLocation;
			if (CGRectContainsPoint(CGRectMake(0, 0, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingDownRight) {
				[sharedGameController.player startMoving:kMovingDown];
			} else if (sharedGameController.player.moving == kMovingRight) {
				[sharedGameController.player startMoving:kMovingDownRight];
			} else if (CGRectContainsPoint(CGRectMake(0, 0, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingUpRight) {
				[sharedGameController.player stopMoving];
			}
			if (CGRectContainsPoint(CGRectMake(0, 107, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingRight) {
				[sharedGameController.player stopMoving];
			} else if (CGRectContainsPoint(CGRectMake(0, 107, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingDownRight) {
				[sharedGameController.player startMoving:kMovingDownLeft];
			} else if (CGRectContainsPoint(CGRectMake(0, 107, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingUpRight) {
				[sharedGameController.player startMoving:kMovingUpLeft];
			} 
			if (CGRectContainsPoint(CGRectMake(0, 214, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingUpRight) {
				[sharedGameController.player startMoving:kMovingUp];
			} else if (CGRectContainsPoint(CGRectMake(0, 214, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingRight) {
				[sharedGameController.player startMoving:kMovingUpRight];
			} else if (CGRectContainsPoint(CGRectMake(0, 214, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingDownRight) {
				[sharedGameController.player stopMoving];
			}
		}
	}
	
	//Entity square for walking around.
	if (sharedGameController.gameState == kGameState_World && CGRectContainsPoint(CGRectMake(200, 120, 80, 80), touchLocation)) {
		//NSLog(@"There was a touch in a rect.");
		CGPoint relativePoint = CGPointMake(sharedGameController.player.currentLocation.x + (touchLocation.x - 240), sharedGameController.player.currentLocation.y + (touchLocation.y - 160));
		for (AbstractEntity *entity in [sharedGameController currentScene].activeEntities) {
			CGRect entityRect = [entity getRect];
			//NSLog(@"Entity rect is: (%f, %f, %f, %f).", entityRect.origin.x, entityRect.origin.y, entityRect.size.width, entityRect.size.height);
			//NSLog(@"TouchLocation is: (%f, %f).", relativePoint.x, relativePoint.y);
			if (CGRectContainsPoint(entityRect, relativePoint)) {
				entityTouchHash = thisTouch.hash;
				//NSLog(@"Entity detected.");
			}
		}
	}
	
	//This tests states and is trying to move a rune.
	if (state == kRangerRunePlacement) {
		[aScene setRuneRenderPoint:touchLocation];
	}
	
	//The following will be a simple rune logic tester for the game
	if (state == kRoderick) {
		if (CGRectContainsPoint(CGRectMake(80, 0, 260, 320), touchLocation)) {
			state = kRoderickRuneDrawing;
		}
		//This corresponds to when a slash is detected.
		if (CGRectContainsPoint(CGRectMake(260, 0, 220, 320), touchLocation)) {
			state = kRoderickAttacking;
			inEnemyRect++;
			previousLocation = touchLocation;
		}
		//This corresponds to an elemental selection detected.
		if (CGRectContainsPoint(CGRectMake(80, 200, 40, 40), touchLocation)) {
			state = kRoderickElementalLineDrawing;
			previousLocation = touchLocation;
		}
	}
	
	//Here are the touches began for character2 rune drawing not implemented.
	if (state == kValkyrie) {
		if (CGRectContainsPoint(CGRectMake(290, 90, 120, 120), touchLocation)) {
			inEnemyRect = 0;
			state = kValkyrie;
			previousLocation = touchLocation;
		}
	}
	
	//This sets the beginning of rune drawing.
	if (state == kRoderickRuneDrawing) {
		
		drawingHash = [thisTouch hash];
		Image *drawing = [[Image alloc] initWithImageNamed:@"defaultTexture.png" filter:GL_NEAREST];
		drawing.renderPoint = touchLocation;
		[aScene addImageToDrawingImages:drawing];
		previousLocation = touchLocation;
		
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView sender:(AbstractScene *)aScene{
	
	CGPoint touchLocation;
	UITouch *thisTouch;
	
	for (UITouch *touch in touches) {
		touchLocation = [sharedGameController adjustTouchOrientationForTouch:[touch locationInView:aView]];
		thisTouch = touch;
		break;
	}
	
	if (state == kWalkingAround_RightTouchDown) {
		if (thisTouch.hash == walkingRightTouchHash) {
			if (CGRectContainsPoint(CGRectMake(400, 0, 80, 106), touchLocation) && sharedGameController.player.moving != kMovingDownRight) {
				[sharedGameController.player startMoving:kMovingDownRight];
			}
			if (CGRectContainsPoint(CGRectMake(400, 107, 80, 106), touchLocation) && sharedGameController.player.moving != kMovingRight) {
				[sharedGameController.player startMoving:kMovingRight];
			}
			if (CGRectContainsPoint(CGRectMake(400, 214, 80, 106), touchLocation) && sharedGameController.player.moving != kMovingUpRight) {
				[sharedGameController.player startMoving:kMovingUpRight];
			}			
		}
	}
	
	if (state == kWalkingAround_LeftTouchDown) {
		if (thisTouch.hash == walkingLeftTouchHash) {
			if (CGRectContainsPoint(CGRectMake(0, 0, 80, 106), touchLocation) && sharedGameController.player.moving != kMovingDownLeft) {
				[sharedGameController.player startMoving:kMovingDownLeft];
			}
			if (CGRectContainsPoint(CGRectMake(0, 107, 80, 106), touchLocation) && sharedGameController.player.moving != kMovingLeft) {
				[sharedGameController.player startMoving:kMovingLeft];
			}
			if (CGRectContainsPoint(CGRectMake(0, 214, 80, 106), touchLocation) && sharedGameController.player.moving != kMovingUpLeft) {
				[sharedGameController.player startMoving:kMovingUpLeft];
			}			
		}
	}
	
	/*if (state == kWalkingAround_BothSidesDown) {
		if (thisTouch.hash == walkingRightTouchHash) {
			if (CGRectContainsPoint(CGRectMake(400, 0, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingDownRight) {
				[sharedGameController.player startMoving:kMovingDown];
			} else if (CGRectContainsPoint(CGRectMake(400, 0, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingUpRight) {
				[sharedGameController.player stopMoving];
			}
			if (CGRectContainsPoint(CGRectMake(400, 107, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingDown) {
				[sharedGameController.player startMoving:kMovingDownRight];
			} else if (CGRectContainsPoint(CGRectMake(400, 107, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingUp) {
				[sharedGameController.player startMoving:kMovingUpRight];
			} else if (CGRectContainsPoint(CGRectMake(400, 107, 80, 106), touchLocation) && sharedGameController.player.moving == kNotMoving) {
				
			}
			if (CGRectContainsPoint(CGRectMake(400, 213, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingUpRight) {
				[sharedGameController.player startMoving:kMovingUp];
			} else if (CGRectContainsPoint(CGRectMake(400, 213, 80, 106), touchLocation) && sharedGameController.player.moving == kMovingDownRight) {
				[sharedGameController.player stopMoving];
			}
		}
	}*/
	
	if (state == kWalkingAround_BothSidesDown) {
		//NSLog(@"Movement detected.");
		if (thisTouch.hash == walkingRightTouchHash) {
			rightTouchLocation = touchLocation;
		}
		if (thisTouch.hash == walkingLeftTouchHash) {
			leftTouchLocation = touchLocation;
		}
		[self updatePlayerMovementWithLeftTouchLocation:leftTouchLocation andRightTouchLocation:rightTouchLocation];

	}
	
	//This again tests states and is trying to move a rune.
	if (state == kRangerRunePlacement) {
		[aScene setRuneRenderPoint:touchLocation];
	}
	//The following will be a simple rune logic tester for the game
	if (state == kRoderickRuneDrawing) {
		
		for (UITouch *touch in touches) {
			if ([touch hash] == drawingHash) {
				CGPoint touchLocation = [sharedGameController adjustTouchOrientationForTouch:[touch locationInView:aView]];
				Vector2f vector = Vector2fMake(touchLocation.x - previousLocation.x, touchLocation.y - previousLocation.y);
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
				} else if (angle < 70.5 && angle >= 19.5) {
					touchDirection = kMovingUpRight;
				} else if (angle < 109.5 && angle >= 70.5) {
					touchDirection = kMovingUp;
				} else if (angle < 160.5 && angle >= 109.5) {
					touchDirection = kMovingUpLeft;
				} else if (angle < 199.5 && angle >= 160.5) {
					touchDirection = kMovingLeft;
				} else if (angle < 250.5 && angle >= 199.5) {
					touchDirection = kMovingDownLeft;
				} else if (angle < 289.5 && angle >= 250.5) {
					touchDirection = kMovingDown;
				} else if (angle < 340.5 && angle >= 289.5) {
					touchDirection = kMovingDownRight;
				}
				if (touchDirection != previousDirection) {
					
					if (countIt > 5) {
						drawCounter += touchDirection;
						gestureCounter++;
					}
					Image *drawing = [[Image alloc] initWithImageNamed:@"defaultTexture.png" filter:GL_NEAREST];
					drawing.renderPoint = touchLocation;
					[aScene addImageToDrawingImages:drawing];
					drawingImageIndex++;
					countIt = 0;
					previousDirection = touchDirection;
				} else {
					Image *drawing = [[Image alloc] initWithImageNamed:@"defaultTexture.png" filter:GL_NEAREST];
					drawing.renderPoint = touchLocation;
					[aScene addImageToDrawingImages:drawing];
					countIt++;
				}
				////NSLog(@"Angle is: '%f'.", angle);
				////NSLog(@"Touch direction is: '%d'.", touchDirection);
				
			}
		}}
	//End if for rune drawing
	//Start if for character attacking
	if (state == kRoderickAttacking) {
		if (CGRectContainsPoint(CGRectMake(290, 90, 120, 120), touchLocation)) {
			inEnemyRect++;
		} else {
			notInEnemyRect++;
		}
	}
	//End slash for character attacking
	
	//Start character tap attacking
	if (state == kValkyrie) {
		if (CGRectContainsPoint(CGRectMake(290, 90, 120, 120), touchLocation)) {
			inEnemyRect++;
		}
	}
	
	//Start drawing a line for elemental state
	if (state == kRoderickElementalLineDrawing) {
		[aScene drawLineFrom:previousLocation to:touchLocation];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView sender:(AbstractScene *)aScene{
	
	UITouch *thisTouch;
	CGPoint touchLocation;
	for (UITouch *touch in touches) {
		touchLocation = [sharedGameController adjustTouchOrientationForTouch:[touch locationInView:aView]];
		thisTouch = touch;
		//NSLog(@"Touch was detected in state: '%d'.", state);

		break;
	}
	
		//This is for rune moving and execution
	if (state == kRangerRunePlacement) {
			for (int i = 0; i < 4; i++) {
				float angle = 15 * (i * RANDOM_MINUS_1_TO_1());
				if (drawCounter == 18) {
					/*Projectile *fireball = [[Projectile alloc] initProjectileFrom:Vector2fMake(50, 250) 
					 to:Vector2fMake(touchLocation.x, touchLocation.y) 
					 withImage:@"fireball.png" 
					 lasting:1.5 
					 withStartAngle:angle
					 withStartSize:Scale2fMake(0.0, 0.0)
					 toFinishSize:Scale2fMake(1.0, 1.0)];
					 [aScene addObjectToActiveObjects:fireball];
					 [fireball release];*/
					
					Fire *fire = [[Fire alloc] initFromCharacter:1 toEnemy:1];
					[aScene addObjectToActiveObjects:fire];
					
				}
				if (drawCounter == 3) {
					Projectile *fireball = [[Projectile alloc] initProjectileFrom:Vector2fMake(50, 250) 
																			   to:Vector2fMake(touchLocation.x, touchLocation.y) 
																		withImage:@"Waterball.png" 
																		  lasting:1.5 
																   withStartAngle:angle
																	withStartSize:Scale2fMake(0.0, 0.0)
																	 toFinishSize:Scale2fMake(1.0, 1.0)];
					[aScene addObjectToActiveObjects:fireball];
					[fireball release];
					
				}
			
		}	
		drawCounter = 0;
		[aScene removeRuneObject];
		[aScene resetPlayer1Timer];
		state = kNoOnesTurn;
	}
	
	//This is for rune drawing
	if (state == kRoderickRuneDrawing) {
		if (countIt > 5) {
			drawCounter += touchDirection;
			countIt = 0;
		}
		if (drawCounter == 18) {
			RuneObject *fireRune = [[RuneObject alloc] initWithTypeOfRune:drawCounter];
			[aScene addObjectToActiveObjects:fireRune];
			[aScene removeDrawingImages];
			state = kRangerRunePlacement;
		}
		if (drawCounter == 3) {
			RuneObject *waterRune = [[RuneObject alloc] initWithTypeOfRune:drawCounter];
			[aScene addObjectToActiveObjects:waterRune];
			[aScene removeDrawingImages];
			state = kRangerRunePlacement;
		}	
		if (gestureCounter >= 5) {
			state = kRoderick;
			gestureCounter = 0;
			drawCounter = 0;
			[aScene removeDrawingImages];
		}
		//NSLog(@"Rune number '%d' was drawn.", drawCounter);
	}
	//End state rune drawing
	//Begin state character1attacking
	if (state == kRoderickAttacking) {
		//NSLog(@"In enemy rect is: '%d'.", inEnemyRect);
		//NSLog(@"Not in enemey rect is: '%d'.", notInEnemyRect);
		if(inEnemyRect > 5 && inEnemyRect > notInEnemyRect) {
			Slash *slash = [[Slash alloc] initWithCharacter:1 enemy:1 fromPoint:previousLocation toPoint:touchLocation];
			[aScene addObjectToActiveObjects:slash];
			[slash release];
			[aScene resetPlayer1Timer];
			inEnemyRect = 0;
			notInEnemyRect = 0;
			state = kNoOnesTurn;
		} else {
			state = kRoderick;
		}
		
	}
	//End character1attacking
	
	//Begin character1elemental
	if (state == kRoderickElementalLineDrawing) {
		for (UITouch *touch in touches) {
			touchLocation = [sharedGameController adjustTouchOrientationForTouch:[touch locationInView:aView]];
			break;
		}
		if (CGRectContainsPoint(CGRectMake(290, 90, 120, 120), touchLocation)) {
			WaterElemental *water = [[WaterElemental alloc] initWithCharacter:1 enemy:1 fromPoint:previousLocation toPoint:touchLocation];
			[aScene addObjectToActiveObjects:water];
			[water release];
			[aScene resetPlayer1Timer];
			[aScene drawLineOff];
			state = kNoOnesTurn;
		} else {
			state = kRoderick;
		}
		
	}
	//End character1attacking
	//Begin character2attacking
	if (state == kValkyrie) {
		if (inEnemyRect < 5) {
			Spear *spear = [[Spear alloc] initWithCharacter:2 enemy:1 atPoint:previousLocation];
			[aScene addObjectToActiveObjects:spear];
			[spear release];
			[aScene resetPlayer2Timer];
			state = kNoOnesTurn;
		}
	}
	
	
	
	
	//Here are non-battle controls
	if (state == kTextboxOnScreen) {
		[aScene moveToNextStageInScene];
	}
	
	//Walking around controls
	if (state == kWalkingAround_LeftTouchDown && thisTouch.hash == walkingLeftTouchHash) {
		state = kWalkingAround_NoTouches;
		//NSLog(@"We got here.");
		[sharedGameController.player stopMoving];
	}
	
	if (state == kWalkingAround_RightTouchDown && thisTouch.hash == walkingRightTouchHash) {
		state = kWalkingAround_NoTouches;
		[sharedGameController.player stopMoving];
	}
	
	if (state == kWalkingAround_BothSidesDown && thisTouch.hash == walkingRightTouchHash) {
		state = kWalkingAround_LeftTouchDown;
		if (CGRectContainsPoint(CGRectMake(0, 0, 100, 106), leftTouchLocation)) {
			[sharedGameController.player startMoving:kMovingDownLeft];
		}
		if (CGRectContainsPoint(CGRectMake(0, 107, 100, 106), leftTouchLocation)) {
			[sharedGameController.player startMoving:kMovingLeft];
		}
		if (CGRectContainsPoint(CGRectMake(0, 214, 100, 106), leftTouchLocation)) {
			[sharedGameController.player startMoving:kMovingUpLeft];
		}
	}
	
	if (state == kWalkingAround_BothSidesDown && thisTouch.hash == walkingLeftTouchHash) {
		state = kWalkingAround_RightTouchDown;
		if (CGRectContainsPoint(CGRectMake(380, 0, 100, 106), rightTouchLocation)) {
			[sharedGameController.player startMoving:kMovingDownRight];
		}
		if (CGRectContainsPoint(CGRectMake(380, 107, 100, 106), rightTouchLocation)) {
			[sharedGameController.player startMoving:kMovingRight];
		}
		if (CGRectContainsPoint(CGRectMake(380, 214, 100, 106), rightTouchLocation)) {
			[sharedGameController.player startMoving:kMovingUpRight];
		}
	}
	
	//NSLog(@"State is: '%d'", state);
	
	//To interact with entities
	if (sharedGameController.gameState == kGameState_World && CGRectContainsPoint(CGRectMake(200, 120, 80, 80), touchLocation) && thisTouch.hash == entityTouchHash) {
		CGPoint relativePoint = CGPointMake(sharedGameController.player.currentLocation.x + (touchLocation.x - 240), sharedGameController.player.currentLocation.y + (touchLocation.y - 160));
		//NSLog(@"There was a tap in a rect near the middle.");
		for (AbstractEntity *entity in [sharedGameController currentScene].activeEntities) {
			CGRect entityRect = [entity getRect];
			if (CGRectContainsPoint(entityRect, relativePoint)) {
				[entity youWereTapped];
				return;
			}
		}
	}
	
	if (state == kWalkingAround_TextboxOnScreen) {
		[sharedGameController.currentScene removeTextbox];
		state = kWalkingAround_NoTouches;
	}
	
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView sender:(AbstractScene *)aScene{
}

- (void)setState:(int)aState {
	
	state = aState;
}
		 

- (void)updatePlayerMovementWithLeftTouchLocation:(CGPoint)aLeftPoint andRightTouchLocation:(CGPoint)aRightTouchLocation {
	
	if (CGRectContainsPoint(CGRectMake(0, 0, 100, 106), aLeftPoint) && CGRectContainsPoint(CGRectMake(380, 0, 100, 106), aRightTouchLocation)) {
		if (sharedGameController.player.moving != kMovingDown) {
			[sharedGameController.player startMoving:kMovingDown];
		}
	}
	if (CGRectContainsPoint(CGRectMake(0, 0, 100, 106), aLeftPoint) && CGRectContainsPoint(CGRectMake(380, 107, 100, 106), aRightTouchLocation)) {
		if (sharedGameController.player.moving != kMovingDownRight) {
			[sharedGameController.player startMoving:kMovingDownRight];
		}
	}
	if (CGRectContainsPoint(CGRectMake(0, 0, 100, 106), aLeftPoint) && CGRectContainsPoint(CGRectMake(380, 214, 100, 106), aRightTouchLocation)) {
		if (sharedGameController.player.moving != kNotMoving) {
			[sharedGameController.player stopMoving];
		}
	}
	if (CGRectContainsPoint(CGRectMake(0, 107, 100, 106), aLeftPoint) && CGRectContainsPoint(CGRectMake(380, 0, 100, 106), aRightTouchLocation)) {
		if (sharedGameController.player.moving != kMovingDownLeft) {
			[sharedGameController.player startMoving:kMovingDownLeft];
		}
	}
	if (CGRectContainsPoint(CGRectMake(0, 107, 100, 106), aLeftPoint) && CGRectContainsPoint(CGRectMake(380, 107, 100, 106), aRightTouchLocation)) {
		if (sharedGameController.player.moving != kNotMoving) {
			[sharedGameController.player stopMoving];
		}
	}
	if (CGRectContainsPoint(CGRectMake(0, 107, 100, 106), aLeftPoint) && CGRectContainsPoint(CGRectMake(380, 214, 100, 106), aRightTouchLocation)) {
		if (sharedGameController.player.moving != kMovingUpLeft) {
			[sharedGameController.player startMoving:kMovingUpLeft];
		}
	}
	if (CGRectContainsPoint(CGRectMake(0, 214, 100, 106), aLeftPoint) && CGRectContainsPoint(CGRectMake(380, 0, 100, 106), aRightTouchLocation)) {
		if (sharedGameController.player.moving != kNotMoving) {
			[sharedGameController.player stopMoving];
		}
	}
	if (CGRectContainsPoint(CGRectMake(0, 214, 100, 106), aLeftPoint) && CGRectContainsPoint(CGRectMake(380, 107, 100, 106), aRightTouchLocation)) {
		if (sharedGameController.player.moving != kMovingUpRight) {
			[sharedGameController.player startMoving:kMovingUpRight];
		}
	}
	if (CGRectContainsPoint(CGRectMake(0, 214, 100, 106), aLeftPoint) && CGRectContainsPoint(CGRectMake(380, 214, 100, 106), aRightTouchLocation)) {
		if (sharedGameController.player.moving != kMovingUp) {
			[sharedGameController.player startMoving:kMovingUp];
		}
	}
}


@end
