//
//  CutSceneTest.m
//  TEORCutSceneTest
//
//  Created by Zach Babb on 5/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "CutSceneTest.h"
#import "StringWithDuration.h"
#import "ImageRenderManager.h"
#import "Textbox.h"
#import "TiledMap.h"
#import "TouchManager.h"
#import "MoveMap.h"
#import "Robo.h"
#import "Marle.h"
#import "SpriteSheet.h"
#import "GreenRobo.h"


@implementation CutSceneTest

- (id)init {
	
	if (self = [super init]) {
		/*StringWithDuration *stringTest = [[StringWithDuration alloc] initWithDuration:4.0
																			  atPoint:CGPointMake(100, 100) 
																			 withText:@"This is a test" 
																			 withFont:@"battleFont"];
		[self addObjectToActiveObjects:stringTest];
		[stringTest release];*/
		
		Textbox *textbox = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) 
												   color:Color4fMake(0.5, 0.5, 0.2, 0.6) 
												duration:-1 
											   animating:YES 
													text:@"Robo: Hey there green. You be lookin' pretty good."];
		[self addObjectToActiveObjects:textbox];
		[textbox release];
		sceneMap = [[TiledMap alloc] initWithFileName:@"QuickMap" fileExtension:@"tmx"];
		cameraPosition = CGPointMake(5, 5);
		cameraPositionZ = Scale2fMake(1, 1);
		zoomer = 1;
		
		character = [[Robo alloc] init];
		character.currentLocation = CGPointMake(200, 200);
		
		character2 = [[GreenRobo alloc] init];
		character2.currentLocation = CGPointMake(200, 280);
		[character2 faceDown];
		
		/*SpriteSheet *marleSheet = [[SpriteSheet alloc] initWithImageNamed:@"MarleSheet.png" spriteSize:CGSizeMake(40, 40) spacing:0 margin:0 imageFilter:GL_LINEAR];
		for (int i = 3; i < 10; i++) {
			Image *image = [marleSheet spriteImageAtCoords:CGPointMake(i, i + 10)];
			if (image) {
				image.renderPoint = CGPointMake((i - 3) * 40, 250);
				[activeImages addObject:image];
				//NSLog(@"Image coords ('%d', '%d') were successful", i, i);
			}
			
		}
		[marleSheet release];*/
		
		
	}
	stage = 0;
	return self;
}

- (void)updateSceneWithDelta:(float)aDelta {
	
	for (int index = 0; index < [activeObjects count]; index++) {
		[[activeObjects objectAtIndex:index] updateWithDelta:aDelta];
	}

	
	//Zooming test, makes tiles visible? try to correct at some point.
	/*cameraPositionZ = Scale2fMake(cameraPositionZ.x + (zoomer * aDelta / 10), cameraPositionZ.y + (zoomer * aDelta / 10));
	if (cameraPositionZ.x > 1.4 || cameraPositionZ.x < 0.6) {
		zoomer *= -1;
	}*/
	[character updateWithDelta:aDelta];
	[character2 updateWithDelta:aDelta];
	
	

	
}

- (void)renderScene {
	
	glClear(GL_COLOR_BUFFER_BIT);
	glPushMatrix();
	//glScalef(cameraPositionZ.x, cameraPositionZ.y, 0);
	glTranslatef(240 - (int)(cameraPosition.x * 40), 
				 160 - (int)(cameraPosition.y * 40), 0);
	
	[sceneMap renderLayer:0 mapx:cameraPosition.x - 6 mapy:cameraPosition.y - 5 width:14 height:11 useBlending:YES];
	[sceneMap renderLayer:1 mapx:cameraPosition.x - 6 mapy:cameraPosition.y - 5 width:14 height:11 useBlending:YES];
	[character render];
	[character2 render];
	[sharedImageRenderManager renderImages];

	glPopMatrix();
	
	
	for (int index = 0; index < [activeObjects count]; index++) {
		[[activeObjects objectAtIndex:index] render];
	}
	for (int index = 0; index < [activeImages count]; index++) {
		[[activeImages objectAtIndex:index] render];
	}

		[sharedImageRenderManager renderImages];
}

- (void)moveToNextStageInScene {
	
	switch (stage) {
		case 0:
			stage = 1;
			for (int index = 0; index < [activeObjects count]; index++) {
				if ([[activeObjects objectAtIndex:index] isKindOfClass:[Textbox class]]) {
					[activeObjects removeObjectAtIndex:index];
				}
			}
			Textbox *textbox = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) 
													   color:Color4fMake(0.35, 0.1, 0.4, 0.7) 
													duration:-1 animating:YES 
														text:@"Green: Whatever Robot. You should get out of here."];
			[self addObjectToActiveObjects:textbox];
			[textbox release];
			
			//MoveMap *mapMove2 = [[MoveMap alloc] initMoveFromMapXY:cameraPosition to:CGPointMake(4, 10) withDuration:4.0];
			//[character moveToPoint:CGPointMake(160, 400) duration:4.0];
			//[character moveWithMapToPoint:CGPointMake(160, 400) duration:4.0];
			//[self addObjectToActiveObjects:mapMove2];
			//[mapMove2 release];
			
			break;
		
		case 1:
			stage = 2;
			for (int index = 0; index < [activeObjects count]; index++) {
				if ([[activeObjects objectAtIndex:index] isKindOfClass:[Textbox class]]) {
					[activeObjects removeObjectAtIndex:index];
				}
			}
			Textbox *textbox2 = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) 
													   color:Color4fMake(0.5, 0.5, 0.2, 0.6) 
													duration:-1 animating:NO 
														text:@"Robo: Whatever you say ma'am."];
			[self addObjectToActiveObjects:textbox2];
			[textbox2 release];
			
			//MoveMap *moveMap = [[MoveMap alloc] initMoveFromMapXY:cameraPosition to:CGPointMake(15, 4) withDuration:4.0];
			//[self addObjectToActiveObjects:moveMap];
			//[moveMap release];
			[character moveWithMapToPoint:CGPointMake(280, 400) duration:3.0];
			break;
		
		case 2:
			stage = 3;
			for (int index = 0; index < [activeObjects count]; index++) {
				if ([[activeObjects objectAtIndex:index] isKindOfClass:[Textbox class]]) {
					[activeObjects removeObjectAtIndex:index];
				}
			}
			Textbox *textbox3 = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) 
													   color:Color4fMake(0.35, 0.1, 0.4, 0.7) 
													duration:-1 animating:YES 
														text:@"Green: Wait!"];
			[self addObjectToActiveObjects:textbox3];
			[textbox3 release];
			[character2 moveToPoint:CGPointMake(character.destination.x + 40, character.currentLocation.y) duration:1.0];
			[character stopAnimation];
			[character faceRight];
			
			break;
		case 3:
			stage = 4;
			for (int index = 0; index < [activeObjects count]; index++) {
				if ([[activeObjects objectAtIndex:index] isKindOfClass:[Textbox class]]) {
					[activeObjects removeObjectAtIndex:index];
				}
			}
			Textbox *textbox4 = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) 
														color:Color4fMake(0.35, 0.1, 0.4, 0.7) 
													 duration:-1 animating:YES text:@"Lady: Why don't you run out of here?"];
			[self addObjectToActiveObjects:textbox4];
			[textbox4 release];
			break;
		case 4:
			[character moveToPoint:CGPointMake(0, 400) duration:1.0];
			break;


		default:
			break;
	}
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

	

	
@end
