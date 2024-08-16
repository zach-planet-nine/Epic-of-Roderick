//
//  WalkingAroundTest.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 5/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WalkingAroundTest.h"
#import "StringWithDuration.h"
#import "ImageRenderManager.h"
#import "Textbox.h"
#import "TiledMap.h"
#import "TouchManager.h"
#import "InputManager.h"
#import "SoundManager.h"
#import "FontManager.h"
#import "GameController.h"
#import "MoveMap.h"
#import "Robo.h"
#import "SpriteSheet.h"
#import "Global.h"
#import "TreasureChest.h"
#import "AbstractEntity.h"
#import "BlueRobo.h"
#import "EnemyChampion.h"
#import "NPCEnemySwordMan.h"
#import "NPCRedHairedRoderick.h"
#import "NPCBlondeHairedRoderick.h"
#import "NPCBlackHairedRoderick.h"
#import "NPCBrownHairedRoderick.h"
#import "NPCEnemyAxeMan.h"
#import "ParticleEmitter.h"
#import "PackedSpriteSheet.h"
#import "AbstractBattleEntity.h"

@implementation WalkingAroundTest

- (id)init {
	
	if (self = [super init]) {
		
		sceneMap = [[TiledMap alloc] initWithFileName:@"QuickMap" fileExtension:@"tmx"];
		cameraPosition = CGPointMake(5, 5);
		character = [[Robo alloc] init];
		character.currentLocation = CGPointMake(200, 400);
		sharedGameController.player = character;
        [self addEntityToActiveEntities:character];
		sharedTouchManager.state = kWalkingAround_NoTouches;
		sharedInputManager.state = kWalkingAround_NoTouches;
		TreasureChest *chest = [[TreasureChest alloc] initAtPosition:CGPointMake(320, 280) withItem:kPotion];
		[self addEntityToActiveEntities:chest];
		
		NPCBlondeHairedRoderick *blohr = [[NPCBlondeHairedRoderick alloc] initAtLocation:CGPointMake(160, 160)];
		[self addEntityToActiveEntities:blohr];
		[blohr release];
        NPCBlackHairedRoderick *blahr = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(200, 160)];
		[self addEntityToActiveEntities:blahr];
		[blahr release];
        NPCBrownHairedRoderick *brhr = [[NPCBrownHairedRoderick alloc] initAtLocation:CGPointMake(240, 160)];
		[self addEntityToActiveEntities:brhr];
		[brhr release];
        NPCRedHairedRoderick *rhr = [[NPCRedHairedRoderick alloc] initAtLocation:CGPointMake(280, 160)];
		[self addEntityToActiveEntities:rhr];
		[rhr release];
        EnemyChampion *ec = [[EnemyChampion alloc] initAtLocation:CGPointMake(320, 160)];
		[self addEntityToActiveEntities:ec];
		[ec release];
        NPCEnemyAxeMan *eam = [[NPCEnemyAxeMan alloc] initAtLocation:CGPointMake(360, 160)];
		[self addEntityToActiveEntities:eam];
		[eam release];
        
        NPCEnemySwordMan *esm = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(200, 480)];
        [self addEntityToActiveEntities:esm];
        [esm release];
		//NSLog(@"Entity count. %d", [activeEntities count]);
		battleImage = [sharedGameController.teorPSS imageForKey:@"BeachBackground480x320.png"];
		battleFont = [[FontManager sharedFontManager] getFontWithKey:@"battleFont"];
		//ParticleEmitter *lightning = [[ParticleEmitter alloc] initSinWaveEmitterWithFile:@"LightningSinWaveTest.pex" fromPoint:CGPointMake(100, 100) toPoint:CGPointMake(300, 100)];
		//[self addObjectToActiveObjects:lightning];
		//[lightning release];
		//Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 100) color:Color4fMake(0.3, 0.3, 0.3, 0.3) duration:-1 animating:YES text:@"This is a to see how well my string wrapping works. It works with a small font for the menus, but this is a bigger font so we'll see if it still wraps well."];
		//[self addObjectToActiveObjects:tb];
		//[tb release];
	}
	
	return self;
}

- (void)updateSceneWithDelta:(float)aDelta {
	
	
	[super updateSceneWithDelta:aDelta];
	/*if (sharedGameController.gameState != kGameState_Menu) {
		for (int index = 0; index < [activeObjects count]; index++) {
			[[activeObjects objectAtIndex:index] updateWithDelta:aDelta];
		}
		
		[character updateWithDelta:aDelta];
		
		for (AbstractEntity *entity in activeEntities) {
			[entity updateWithDelta:aDelta];
		}
		
		if (sharedGameController.gameState == kGameState_World) {
			cameraPosition = CGPointMake(character.currentLocation.x / 40, character.currentLocation.y / 40);
		}
		
	}
	if (sharedGameController.gameState == kGameState_Menu) {
		[sharedInputManager.currentMenu updateWithDelta:aDelta];
	}*/
}

/*- (void)renderScene {
	if (sharedGameController.gameState == kGameState_World || sharedGameController.gameState == kGameState_Menu) {
		glClear(GL_COLOR_BUFFER_BIT);
		glPushMatrix();
		//glScalef(cameraPositionZ.x, cameraPositionZ.y, 0);
		glTranslatef(240 - (int)(cameraPosition.x * 40), 
					 160 - (int)(cameraPosition.y * 40), 0);
		
		[sceneMap renderLayer:0 mapx:cameraPosition.x - 6 mapy:cameraPosition.y - 5 width:14 height:11 useBlending:YES];
		[sceneMap renderLayer:1 mapx:cameraPosition.x - 6 mapy:cameraPosition.y - 5 width:14 height:11 useBlending:YES];
		[character render];
		for (AbstractEntity *entity in activeEntities) {
			[entity render];
		}	
		
		[sharedImageRenderManager renderImages];
		
		glPopMatrix();
		
		
		
		for (int index = 0; index < [activeObjects count]; index++) {
			[[activeObjects objectAtIndex:index] render];
		}
		
		for (Image *drawingImage in drawingImages) {
			[drawingImage renderCenteredAtPoint:drawingImage.renderPoint];
		}
		[sharedImageRenderManager renderImages];
	} else if (sharedGameController.gameState == kGameState_Battle) {
		[battleImage renderCenteredAtPoint:CGPointMake(240, 160)];
		
		for (AbstractBattleEntity *entity in activeEntities) {
			[entity render];
		}
		for (Image *image in drawingImages) {
			[image renderCenteredAtPoint:image.renderPoint];
		}
		[sharedImageRenderManager renderImages];
		for (int objectIndex = 0; objectIndex < [activeObjects count]; objectIndex++) {
			[[activeObjects objectAtIndex:objectIndex] render];
		}
		if (isLineActive == YES) {
			[linePixel renderAtPoint:linePixel.renderPoint];
		}
		[sharedImageRenderManager renderImages];
	}
	
}*/

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
