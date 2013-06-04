//
//  AnimationManagementTest.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AnimationManagementTest.h"
#import "Projectile.h"
#import "Animation.h"
#import "SpriteSheet.h"
#import "ImageRenderManager.h"
#import "TouchManager.h"
#import "BitmapFont.h"
#import "RuneObject.h"
#import "Image.h"
#import "Slash.h"
#import "WaterElemental.h"
#import "AbstractBattleAnimation.h"


@implementation AnimationManagementTest

@synthesize whereWasTouch;

- (id)init {
	
	if (self = [super init]) {
		
		//sharedTouchManager = [TouchManager sharedTouchManager];
		[sharedTouchManager setState:kNoOnesTurn];
		//sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
		
		//activeObjects = [[NSMutableArray alloc] init];
		//activeImages = [[NSMutableArray alloc] init];
		drawingImages = [[NSMutableArray alloc] init];
		
		enemy = [[Image alloc] initWithImageNamed:@"Enemy.png" filter:GL_LINEAR];
		enemy.renderPoint = CGPointMake(350, 150);
		[self addImageToActiveImages:enemy];
		[enemy release];
		
		pond = [[Image alloc] initWithImageNamed:@"Pond.png" filter:GL_LINEAR];
		pond.renderPoint = CGPointMake(100, 220);
		[self addImageToActiveImages:pond];
		[pond release];
		
		linePixel = [[Image alloc] initWithImageNamed:@"WhiteLine.png" filter:GL_LINEAR];
		linePixel.renderPoint = CGPointMake(0, 0);
		linePixel.color = Color4fMake(0, 0.0, 1.0, 1.0);
		
		/*fireball = [[Projectile alloc] initProjectileFrom:Vector2fMake(50, 250) 
		 to:Vector2fMake(300, 50) 
		 withImage:@"fireball.png" 
		 lasting:1.0 
		 withStartAngle:15
		 withStartSize:Scale2fMake(0.0, 0.0)
		 toFinishSize:Scale2fMake(1.0, 1.0)];
		 [self addObjectToActiveObjects:fireball];*/
		
		walkerSpriteSheet = [[SpriteSheet alloc] initWithImageNamed:@"SpriteSheetTexture3.png" spriteSize:CGSizeMake(64, 128) spacing:0 margin:0 imageFilter:GL_LINEAR];
		walkerAnimation = [[Animation alloc] init];
		
		float delay = 0.3f;
		
		[walkerAnimation addFrameWithImage:[walkerSpriteSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[walkerAnimation addFrameWithImage:[walkerSpriteSheet spriteImageAtCoords:CGPointMake(0, 0)] delay:delay];
		[walkerAnimation addFrameWithImage:[walkerSpriteSheet spriteImageAtCoords:CGPointMake(0, 2)] delay:delay];
		[walkerAnimation addFrameWithImage:[walkerSpriteSheet spriteImageAtCoords:CGPointMake(0, 1)] delay:delay];
		walkerAnimation.state = kAnimationState_Stopped;
		walkerAnimation.type = kAnimationType_Repeating;
		
		//[self addObjectToActiveObjects:walkerAnimation];
		
		Image *walker = [walkerSpriteSheet spriteImageAtCoords:CGPointMake(0, 0)];
		walker.renderPoint = CGPointMake(50, 230);
		[self addImageToActiveImages:walker];
		[walker release];
		
		bmf = [[BitmapFont alloc] initWithFontImageNamed:@"TimesNewRoman32.png" controlFile:@"TimesNewRoman32"
												   scale:Scale2fMake(0.75, 0.75) filter:GL_LINEAR];
		
		timerRect = [[Image alloc] initWithImageNamed:@"TimerRect.png" filter:GL_LINEAR];
		timer = [[Image alloc] initWithImageNamed:@"TimerPixel.png" filter:GL_LINEAR];
		
		player1agi = 0.2;
		player2agi = 0.3;
		
		
	}
	
	return self;
}

- (void)updateSceneWithDelta:(float)aDelta {
	
	for (int index = 0; index < [activeObjects count]; index++) {
		id obj = [activeObjects objectAtIndex:index];
		[obj updateWithDelta:aDelta];
		if ([obj isKindOfClass:[Slash class]]) {
			Slash *slashObj = obj;
			if (slashObj.active == NO) {
				[activeObjects removeObjectAtIndex:index];
			}
		}
		if ([obj isKindOfClass:[WaterElemental class]]) {
			WaterElemental *waterObj = obj;
			if (waterObj.active == NO) {
				[activeObjects removeObjectAtIndex:index];
			}
		}
		if ([obj isKindOfClass:[AbstractBattleAnimation class]]) {
			AbstractBattleAnimation *ba = obj;
			if (ba.active == NO) {
				[activeObjects removeObjectAtIndex:index];
			}
		}
	}
	if (player1Timer < 1.0) {
		player1Timer += aDelta * player1agi;
	} else if (player1Timer > 1.0) {
		player1Timer = 1.0;
	}
	if (player2Timer < 1.0) {
		player2Timer += aDelta * player2agi;
	} else if (player2Timer > 1.0) {
		player2Timer = 1.0;
	}	
	if (player1Timer == 1 && sharedTouchManager.state == kNoOnesTurn ) {
		[sharedTouchManager setState:kRoderick];
	}
	if (player2Timer == 1 && sharedTouchManager.state == kNoOnesTurn ) {
		[sharedTouchManager setState:kValkyrie];
	}
	
}

- (void)renderScene {
	
	
	for (int index = 0; index < [activeImages count]; index++) {
		Image *currentImage = [activeImages objectAtIndex:index];
		[currentImage renderCenteredAtPoint:currentImage.renderPoint];
	}
	for (int index = 0; index < [drawingImages count]; index++) {
		Image *currentImage = [drawingImages objectAtIndex:index];
		[currentImage renderCenteredAtPoint:currentImage.renderPoint];
	}
	[sharedImageRenderManager renderImages];
	for (int index = 0; index < [activeObjects count]; index++) {
		[[activeObjects objectAtIndex:index] render];
	}
	if (isLineActive == YES) {
		[linePixel renderAtPoint:linePixel.renderPoint];
	}
	
	[timerRect renderAtPoint:CGPointMake(20, 230)];
	[timerRect renderAtPoint:CGPointMake(20, 140)];
	
	timer.scale = Scale2fMake(80 * player1Timer, 3);
	timer.color = Color4fMake(0.0, 1.0, 0.0, 1.0);
	[timer renderAtPoint:CGPointMake(21, 231)];
	
	timer.scale = Scale2fMake(80 * player2Timer, 3);
	timer.color = Color4fMake(0, 0, 1.0, 1.0);
	[timer renderAtPoint:CGPointMake(21, 141)];
	
	where = [NSString stringWithFormat:@"there was a touch at (%f, %f).", whereWasTouch.x, whereWasTouch.y];
	[bmf renderStringAt:whereWasTouch 
				   text:where];
	[sharedImageRenderManager renderImages];
}

- (void)addObjectToActiveObjects:(id)aObject {
	
	[activeObjects addObject:aObject];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView {
	
	[sharedTouchManager touchesBegan:touches withEvent:event view:aView sender:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView {
	
	[sharedTouchManager touchesMoved:touches withEvent:event view:aView sender:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView {
	
	[sharedTouchManager touchesEnded:touches withEvent:event view:aView sender:self];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event view:(UIView *)aView {
	
	[sharedTouchManager touchesCancelled:touches withEvent:event view:aView sender:self];
}


- (void)setWhereWasTouch:(CGPoint)aTouch {
	whereWasTouch = aTouch;
}

- (void)addImageToActiveImages:(id)aImage {
	
	[activeImages addObject:aImage];
}

- (void)addImageToDrawingImages:(id)aImage {
	
	[drawingImages addObject:aImage];
}

- (id)getDrawingImageAt:(int)aIndex {
	
	return [drawingImages objectAtIndex:aIndex];
}

- (void)removeDrawingImages {
	
	[drawingImages removeAllObjects];
}

- (void)setRuneRenderPoint:(CGPoint)aRenderPoint {
	for (int index = 0; index < [activeObjects count]; index++) {
		if ([[activeObjects objectAtIndex:index] isKindOfClass:[RuneObject class]]) {
			[[activeObjects objectAtIndex:index] setRenderPoint:aRenderPoint];
		}
	}
}

- (void)removeRuneObject {
	for (int index = 0; index < [activeObjects count]; index++) {
		if ([[activeObjects objectAtIndex:index] isKindOfClass:[RuneObject class]]) {
			[activeObjects removeObjectAtIndex:index];
		}
	}
}

- (void)removeObject:(id)aObject {
	for (int index = 0; index < [activeObjects count]; index++) {
		if ([[activeObjects objectAtIndex:index] isEqual:aObject]) {
			[activeObjects removeObjectAtIndex:index];
		}
	}
}	

- (void)resetPlayer1Timer {
	player1Timer = 0.0f;
}

- (void)resetPlayer2Timer {
	player2Timer = 0.0f;
}

- (void)drawLineFrom:(CGPoint)aFromPoint to:(CGPoint)aToPoint {
	
	linePixel.scale = Scale2fMake(sqrt(powf((aToPoint.x - aFromPoint.x), 2) + powf((aToPoint.y - aFromPoint.y), 2)), 3);
	linePixel.rotationPoint = CGPointMake(0, 0);
	linePixel.rotation = atanf((aToPoint.y - aFromPoint.y) / (aToPoint.x - aFromPoint.x)) * 57.2957795;
	linePixel.renderPoint = CGPointMake(aFromPoint.x, aFromPoint.y);
	isLineActive = YES;
}

- (void)drawLineOff {
	
	isLineActive = NO;
}

@end
