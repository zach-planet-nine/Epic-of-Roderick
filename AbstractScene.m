//
//  AbstractScene.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractScene.h"
#import "ImageRenderManager.h"
#import "TouchManager.h"
#import "InputManager.h"
#import "FontManager.h"
#import "SoundManager.h"
#import "GameController.h"
#import "ScriptReader.h"
#import "OverMind.h"
#import "Textbox.h"
#import "Image.h"
#import "Animation.h"
#import "ParticleEmitter.h"
#import "BattleRoderick.h"
#import "BattleValkyrie.h"
#import "BattleWizard.h"
#import "BattleRanger.h"
#import "BattlePriest.h"
#import "BattleDwarf.h"
#import "BattleSlime.h"
#import "BattleOrc.h"
#import "BattleImp.h"
#import "BattleSwordMan.h"
#import "BattleAxeMan.h"
#import "BattleFireGiant.h"
#import "BattleFireGiantGrunt.h"
#import "BattleFireGiantBerserker.h"
#import "BattleFireGiantShaman.h"
#import "BattleGiant.h"
#import "BattleGiantGrunt.h"
#import "BattleGiantBerserker.h"
#import "BattleGiantShaman.h"
#import "BattleFrostGiant.h"
#import "BattleFrostGiantGrunt.h"
#import "BattleFrostGiantBerserker.h"
#import "BattleFrostGiantShaman.h"
#import "BattleGiant.h"
#import "BattleGiantGrunt.h"
#import "BattleGiantBerserker.h"
#import "BattleGiantShaman.h"
#import "BattleWaterSpirit.h"
#import "BattleSkySpirit.h"
#import "BattleFireSpirit.h"
#import "BattleStoneSpirit.h"
#import "BattleDeathSpirit.h"
#import "BattleWolf.h"
#import "BattleWolfCub.h"
#import "BattleWolfAlpha.h"
#import "BattleFrostWolf.h"
#import "BattleFrostWolfCub.h"
#import "BattleFrostWolfAlpha.h"
#import "BattleHellHound.h"
#import "BattleEnemyChampion.h"
#import "BattleFrostDemonArcher.h"
#import "BattlePoisonDemonRider.h"
#import "BattleFireDemonMage.h"
#import "ExperienceScreen.h"
#import "Global.h"
#import "Character.h"
#import "AbstractBattleAnimation.h"
#import "MenuSystem.h"
#import "AbstractEntity.h"
#import "TiledMap.h"
#import "FadeInOrOut.h"


@implementation AbstractScene

@synthesize activeEntities;
@synthesize activeObjects;
@synthesize activeImages;
@synthesize battleFont;
@synthesize battleImage;


- (id)init {
	
	if (self = [super init]) {
		activeImages = [[NSMutableArray alloc] init];
		activeObjects = [[NSMutableArray alloc] init];
		activeEntities = [[NSMutableArray alloc] init];
		drawingImages = [[NSMutableArray alloc] init];
		suspendedEntities = [[NSMutableArray alloc] init];
		suspendedObjects = [[NSMutableArray alloc] init];

		sharedFontManager = [FontManager sharedFontManager];
		sharedImageRenderManager = [ImageRenderManager sharedImageRenderManager];
		sharedTouchManager = [TouchManager sharedTouchManager];
		sharedSoundManager = [SoundManager sharedSoundManager];
		sharedGameController = [GameController sharedGameController];
		sharedInputManager = [InputManager sharedInputManager];
        sharedScriptReader = [ScriptReader sharedScriptReader];
		
		inactiveTimer = 2;
		linePixel = [[Image alloc] initWithImageNamed:@"WhiteLine.png" filter:GL_LINEAR];
		linePixel.renderPoint = CGPointMake(0, 0);
		linePixel.color = Color4fMake(0, 0.0, 1.0, 1.0);
        battlePossibility = 0.25;
		isLineActive = NO;
        doNotUpdate = NO;
        
        //Added for the line drawing test
        green = [[UIColor alloc] initWithRed:0.56f green:0.86f blue:0.30f alpha:1.0f];
        black = [[UIColor alloc] initWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
	}
	
	return self;
}

- (void)updateSceneWithDelta:(float)aDelta {

    //if (doNotUpdate == NO) {
    if (doNotUpdate) {
        return;
    }
        if (sharedGameController.gameState != kGameState_Menu) {
            for (int index = 0; index < [activeObjects count]; index++) {
                [[activeObjects objectAtIndex:index] updateWithDelta:aDelta];
            }
            CGPoint currentTile;
            if (sharedGameController.player) {
                currentTile = sharedGameController.player.currentTile;
            }
            for (AbstractEntity *entity in activeEntities) {
                [entity updateWithDelta:aDelta];
            }
            
            if (sharedGameController.gameState == kGameState_World) {
                 cameraPosition = CGPointMake(sharedGameController.player.currentLocation.x / 40, sharedGameController.player.currentLocation.y / 40);
                if (currentTile.x != sharedGameController.player.currentTile.x || currentTile.y != sharedGameController.player.currentTile.y) {
                    NSLog(@"Checking for portal at (%f, %f).", sharedGameController.player.currentTile.x, sharedGameController.player.currentTile.y);
                    BOOL isPortal = [sharedGameController.currentScene checkForPortal];
                    if (!isPortal && allowBattles) {
                        if (arc4random() % 100 - 1 < battlePossibility) {
                            battlePossibility = 0.25;
                            [self initBattle];
                        } else {
                            battlePossibility += MIN(battlePossibility * 0.5, 3);
                        }
                    } 
                }
                /*if (allowBattles && (currentTile.x != sharedGameController.player.currentTile.x || currentTile.y != sharedGameController.player.currentTile.y)) {
                    //NSLog(@"is testing if there is a battle with possibility %f.", battlePossibility);
                    if (arc4random() % 100 < battlePossibility) {
                        battlePossibility = 0.25;
                        [self initBattle];
                    } else {
                        battlePossibility += MIN(battlePossibility * 0.5, 5);
                    }
                }*/
                /*if (allowBattles && cameraPosition.x != (sharedGameController.player.currentLocation.x / 40) && cameraPosition.y != (sharedGameController.player.currentLocation.y / 40  )) {
                    cameraPosition = CGPointMake(sharedGameController.player.currentLocation.x / 40, sharedGameController.player.currentLocation.y / 40);
                    float battleRoll = arc4random() % 100;
                    //NSLog(@"BattleRoll: %f, battlePossibility: %f.", battleRoll, battlePossibility);
                    if (battleRoll < battlePossibility) {
                        battlePossibility = 0;
                        [self initBattle];
                    } else if (battleRoll >= battlePossibility) {
                        battlePossibility += aDelta;
                    }
                }*/
               
            } 
            
        }
        if (sharedGameController.gameState == kGameState_Menu) {
            [sharedInputManager.currentMenu updateWithDelta:aDelta];
        }
        inactiveTimer -= aDelta;
        if (inactiveTimer < 0) {
            inactiveTimer = 2;
            [self removeInactiveObjects];
        }
        if (cutScene) {
            cutSceneTimer -= aDelta;
            if (cutSceneTimer < 0) {
                cutSceneTimer = 0.2;
                [self moveToNextStageInScene];
            }
        }

    //}
}


- (void)updateWithAccelerometer:(UIAcceleration *)aAcceleration {}
- (void)transitionToSceneWithKey:(NSString *)aKey {}

- (void)renderScene {
    
    //if (doNotUpdate == NO) {
    if (doNotUpdate) {
        return;
    }
        if (sharedGameController.gameState == kGameState_World || sharedGameController.gameState == kGameState_Menu || sharedGameController.gameState == kGameState_Cutscene) {
            glClear(GL_COLOR_BUFFER_BIT);
            glPushMatrix();
            //glScalef(cameraPositionZ.x, cameraPositionZ.y, 0);
            glTranslatef(240 - (int)(cameraPosition.x * 40), 
                         160 - (int)(cameraPosition.y * 40), 0);
            
            [sceneMap renderLayer:0 mapx:cameraPosition.x - 6 mapy:cameraPosition.y - 5 width:14 height:11 useBlending:YES];
            [sceneMap renderLayer:1 mapx:cameraPosition.x - 6 mapy:cameraPosition.y - 5 width:14 height:11 useBlending:YES];
            for (AbstractEntity *entity in activeEntities) {
                if (entity != sharedGameController.player) {
                    [entity render];
                }
            }	
            [sharedGameController.player render];
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
            [sharedImageRenderManager renderImages];
            for (Image *image in drawingImages) {
                [image renderCenteredAtPoint:image.renderPoint];
            }
            for (int objectIndex = 0; objectIndex < [activeObjects count]; objectIndex++) {
                [[activeObjects objectAtIndex:objectIndex] render];
            }
            if (isLineActive == YES) {
                [linePixel renderAtPoint:linePixel.renderPoint];
            }
            [sharedImageRenderManager renderImages];
        }
    /*
    //Line drawing tests
    GLfloat vertices[24];
    vertices[0] = 50.0f;
    vertices[1] = 50.0f;
    vertices[2] = 100.0f;
    vertices[3] = 100.0f;
    vertices[4] = 150.0f;
    vertices[5] = 100.0f;
    vertices[6] = 45.0f;
    vertices[7] = 45.0f;
    vertices[8] = 95.0f;
    vertices[9] = 105.0f;
    vertices[10] = 155.0f;
    vertices[11] = 105.0f;
    vertices[12] = 40.0f;
    vertices[13] = 40.0f;
    vertices[14] = 90.0f;
    vertices[15] = 110.0f;
    vertices[16] = 160.0f;
    vertices[17] = 110.0f;
    vertices[18] = 35.0f;
    vertices[19] = 35.0f;
    vertices[20] = 85.0f;
    vertices[21] = 115.0f;
    vertices[22] = 165.0f;
    vertices[23] = 115.0f;
    vertices[12] = 50.0f;
    vertices[13] = 50.0f;
    vertices[14] = 100.0f;
    vertices[15] = 100.0f;
    vertices[16] = 50.0f;
    vertices[17] = 50.0f;
    vertices[18] = 100.0f;
    vertices[19] = 100.0f;
    
    Color4f colors[5];
    colors[0] = Color4fMake(0, 1, 0, 0.2);
    colors[1] = Color4fMake(0, 1, 0, 0.4);
    colors[2] = Color4fMake(0, 1, 0, 0.6);
    colors[3] = Color4fMake(0, 1, 0, 0.8);
    colors[4] = Color4fMake(0, 1, 0, 1);

    
    glDisableClientState(GL_COLOR_ARRAY);
    glDisable(GL_TEXTURE_2D);
    glPushMatrix();
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    //glColorPointer(2, GL_FLOAT, 0, colors);
    //glScalef(1, 1, 0);
    glPointSize(2);
    glColor4f(0, 1, 0, 1);
    glLineWidth(2);
    glDrawArrays(GL_LINES, 0, 3);
    glDrawArrays(GL_POINTS, 0, 3);
    //glScalef(1.1, 1.1, 0);
    glColor4f(0, 1, 0, 0.8);
    glLineWidth(4);
    glPointSize(4);
    glDrawArrays(GL_LINES, 0, 3);
    glDrawArrays(GL_POINTS, 0, 3);
    //glScalef(1.2, 1.2, 0);
    glColor4f(0, 1, 0, 0.6);
    glLineWidth(8);
    glPointSize(8);
    glDrawArrays(GL_LINES, 0, 3);
    glDrawArrays(GL_POINTS, 0, 3);
    glColor4f(0, 1, 0, 0.4);
    glLineWidth(14);
    glDrawArrays(GL_LINES, 0, 6);
    //glScalef(1.3, 1.3, 0);
    glColor4f(0, 1, 0, 0.2);
    glLineWidth(16);
    glPointSize(16);
    glDrawArrays(GL_LINES, 0, 3);
    glDrawArrays(GL_POINTS, 0, 3);
    glPopMatrix();
    glEnableClientState(GL_COLOR_ARRAY);
    glEnable(GL_TEXTURE_2D);*/
    
    //}
	
}

- (BOOL)isBlocked:(float)x y:(float)y { return NO;}

- (void)initBattle {

    battleImage.color = Color4fOnes;
    sharedGameController.player.moving = kNotMoving;
    sharedGameController.player.currentAnimation.state = kAnimationState_Stopped;
    BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
    roderick.battles++;
    ParticleEmitter *battleStartEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"BattleStartEmitter.pex"];
    [self addObjectToActiveObjects:battleStartEmitter];
    [battleStartEmitter release];
    for (AbstractGameObject *obj in activeEntities) {
        [suspendedEntities addObject:obj];
    }
	[activeEntities removeAllObjects];
	sharedGameController.gameState = kGameState_Battle;
	[self initBattleCharacters];
	[self initBattleEnemies];
    for (AbstractBattleCharacter *character in activeEntities) {
        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
            [character youHaveBeenRevived];
            [character initBattleAttributes];
        }
    }
    //NSLog(@"Is it getting here?");
    [[OverMind sharedOverMind] setUpArrays];
    [[InputManager sharedInputManager] setState:kNoOnesTurn];
}

- (void)initBattleCharacters {
	//NSLog(@"party count is: '%d'",[sharedGameController.party count]);
	for (int i = 0; i < MIN([sharedGameController.party count], 3); i++) {
		Character *character = [sharedGameController.party objectAtIndex:i];
		if (character) {
			//NSLog(@"Character is fine, and it is: %d and should be: %d", character.whichCharacter, kRoderick);
		}
		switch (character.whichCharacter) {
			case kRoderick:
				i = i;
				BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
				if (roderick) {
					//NSLog(@"BattleRoderick was found.");
				}
				[roderick battleLocationIs:i];
				[self addEntityToActiveEntities:roderick];
				break;
			case kValkyrie:
				i = i;
				BattleValkyrie *valkyrie = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
				[valkyrie battleLocationIs:i];
				[self addEntityToActiveEntities:valkyrie];
				break;
			case kWizard:
				i = i;
				BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
				[wizard battleLocationIs:i];
				[self addEntityToActiveEntities:wizard];
				break;
			case kRanger:
				i = i;
				BattleRanger *ranger = [sharedGameController.battleCharacters objectForKey:@"BattleRanger"];
				[ranger battleLocationIs:i];
				[self addEntityToActiveEntities:ranger];
				break;
			case kPriest:
				i = i;
				BattlePriest *priest = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
				[priest battleLocationIs:i];
				[self addEntityToActiveEntities:priest];
				break;
			case kDwarf:
				i = i;
				BattleDwarf *dwarf = [sharedGameController.battleCharacters objectForKey:@"BattleDwarf"];
				[dwarf battleLocationIs:i];
				[self addEntityToActiveEntities:dwarf];
				break;
			default:
				break;
		}
	}
}

- (void)checkIfBattleOver {
    
    for (AbstractBattleEnemy *enemy in activeEntities) {
        if ([enemy isKindOfClass:[AbstractBattleEnemy class]] && enemy.isAlive) {
            //NSLog(@"There are some enemies still alive.");
            return;
        }
    }
    //NSLog(@"Battle should end.");
    [self endBattle];
}

- (void)partyHasBeenDefeated {
    
    [sharedInputManager setState:kNoTouchesAllowed];
    [activeEntities removeAllObjects];
    for (AbstractGameObject *ago in activeObjects) {
        ago.active = NO;
    }
    FadeInOrOut *fadeToBlack = [[FadeInOrOut alloc] initFadeOutToAlpha:0.15 withDuration:1];
    [self addObjectToActiveObjects:fadeToBlack];
    [fadeToBlack release];
    stage = 100;
    cutScene = YES;
    cutSceneTimer = 1;
}

- (void)endBattle {
    
    for (AbstractBattleCharacter *character in activeEntities) {
        if ([character isKindOfClass:[AbstractBattleCharacter class]] && [character hasBleeders]) {
            while ([character hasBleeders]) {
                [character removeBleeder];
            }
        }
    }
    ExperienceScreen *es = [[ExperienceScreen alloc] init];
    [self removeDrawingImages];
    [activeObjects addObject:es];
    [es release];
    [sharedInputManager setState:kBattleExperienceScreen];
}

- (void)restoreMap {
    
    [sharedInputManager setState:kWalkingAround_NoTouches];
    for (AbstractGameObject *ago in activeObjects) {
        ago.active = NO;
    }
    sharedGameController.gameState = kGameState_World;
    for (AbstractBattleCharacter *character in activeEntities) {
        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
            [character youHaveBeenRevived];
        }
    }
    [activeEntities removeAllObjects];

    for (NSObject *obj in suspendedEntities) {
        [activeEntities addObject:obj];
    }
    [suspendedEntities removeAllObjects];
    for (AbstractBattleAnimation *es in activeObjects) {
        if ([es isMemberOfClass:[ExperienceScreen class]]) {
            es.active = NO;
        }
    }
}


- (void)addObjectToActiveObjects:(id)aObject {
	
	[activeObjects addObject:aObject];
	//NSLog(@"Object added. Count is now: %d.", [activeObjects count]);
}


- (void)addImageToActiveImages:(id)aImage {
	
	[activeImages addObject:aImage];
}

- (void)addImageToDrawingImages:(id)aImage {
	
	[drawingImages addObject:aImage];
}


- (void)addEntityToActiveEntities:(id)aEntity {
	
	[activeEntities addObject:aEntity];
    //NSLog(@"Entity added. Count is: %d.", [activeEntities count]);
}

- (void)removeTextbox {
	
	for (Textbox *tb in activeObjects) {
        if ([tb isKindOfClass:[Textbox class]]) {
            tb.active = NO;
        }
    }
}

- (void)removeDrawingImages {
	
	[drawingImages removeAllObjects];
}

- (void)removeInactiveObjects {
	
	for (int i = [activeObjects count] - 1; i >= 0; i--) {
		AbstractGameObject *ago = [activeObjects objectAtIndex:i];
        if (ago.active == NO) {
            [activeObjects removeObjectAtIndex:i];
        }
    }
}

- (void)removeInactiveEntities {
    
    for (int i = [activeEntities count] - 1; i >= 0; i--) {
        if ([[activeEntities objectAtIndex:i] isKindOfClass:[AbstractEntity class]]) {
            AbstractEntity *ae = [activeEntities objectAtIndex:i];
            if (ae.active == NO) {
                [activeEntities removeObjectAtIndex:i];
                //NSLog(@"active entities count is: %d", [activeEntities count]);
            }
        } else if ([[activeEntities objectAtIndex:i] isKindOfClass:[ParticleEmitter class]]) {
            ParticleEmitter *pe = [activeEntities objectAtIndex:i];
            if (pe.active == NO) {
                [activeEntities removeObjectAtIndex:i];
            }
        }
    }
}
	
- (void)initBattleEnemies {
	
	switch (sharedGameController.realm) {
        case kRealm_ChapterOneCamp:
            [self initChapterOneCampBattle];
            break;
        case kRealm_ChapterOneChampionBattle:
            [self initChapterOneChampionBattle];
            break;
        case kRealm_RangerBattleTutorial:
            [self initRangerBattleTutorial];
            break;
		case kRealm_Midgard:
			[self initMidgardBattle];
			break;
		case kRealm_Alfheim:
			[self initAlfheimBattle];
			break;
			
		default:
			break;
	}
}

- (void)initChapterOneCampBattle {
    
    int whichEnemy = 1 + arc4random() % 2;
    NSLog(@"%d", whichEnemy);
    switch (whichEnemy) {
        case 1:
            whichEnemy = whichEnemy;
            BattleSwordMan *bsm = [[BattleSwordMan alloc] initWithBattleLocation:1];
            bsm.renderPoint = CGPointMake(360, 240);
            [self addEntityToActiveEntities:bsm];
            [bsm release];
            break;
        case 2:
            //NSLog(@"Switch is being called.");
            whichEnemy = whichEnemy; 
            BattleAxeMan *bam = [[BattleAxeMan alloc] initWithBattleLocation:1];
           
            bam.renderPoint = CGPointMake(360, 240);
            [self addEntityToActiveEntities:bam];
            [bam release];
            break;
            
        default:
            break;
    }
    
}

- (void)initMidgardBattle {
	
    Character *roderick = [sharedGameController.characters objectForKey:@"Roderick"];
	int numberOfEnemies = 1 + arc4random() % MIN(3, roderick.level);
	for (int enemyIndex = 1; enemyIndex < numberOfEnemies + 1; enemyIndex++) {
		int whichEnemy = 1 + arc4random() % 3;
		//NSLog(@"enemyIndex is: %d.", enemyIndex);
		switch (whichEnemy) {
			case 1:
				whichEnemy = whichEnemy;
				//BattleSlime *slime = [[BattleSlime alloc] initWithBattleLocation:enemyIndex];
				//slime.whichEnemy = enemyIndex;
				//[self addEntityToActiveEntities:slime];
				////NSLog(@"Enemy hp = %f for enemy %d.", slime.hp, enemyIndex);
				//[slime release];
                //BattleFireGiant *bfg = [[BattleFireGiant alloc] initWithBattleLocation:enemyIndex];
                //bfg.whichEnemy = enemyIndex;
                //[self addEntityToActiveEntities:bfg];
                //[bfg release];
                BattleFrostDemonArcher *bfda = [[BattleFrostDemonArcher alloc] initWithBattleLocation:enemyIndex];
                bfda.whichEnemy = enemyIndex;
                [self addEntityToActiveEntities:bfda];
                [bfda release];
				break;
			case 2:
				whichEnemy = whichEnemy;
				//BattleFrostWolf *orc = [[BattleFrostWolf alloc] initWithBattleLocation:enemyIndex];
				//orc.whichEnemy = enemyIndex;
				//[self addEntityToActiveEntities:orc];
				////NSLog(@"Enemy hp = %f for enemy %d.", orc.hp, enemyIndex);
				//[orc release];
                BattlePoisonDemonRider *bpdr = [[BattlePoisonDemonRider alloc] initWithBattleLocation:enemyIndex];
                bpdr.whichEnemy = enemyIndex;
                [self addEntityToActiveEntities:bpdr];
                [bpdr release];
				break;
			case 3:
				whichEnemy = whichEnemy;
				//BattleSkySpirit *imp = [[BattleSkySpirit alloc] initWithBattleLocation:enemyIndex];
				//imp.whichEnemy = enemyIndex;
				//[self addEntityToActiveEntities:imp];
				////NSLog(@"Enemy hp = %f for enemy %d.", imp.hp, enemyIndex);
				//[imp release];
                BattleFireDemonMage *bfdm = [[BattleFireDemonMage alloc] initWithBattleLocation:enemyIndex];
                [self addEntityToActiveEntities:bfdm];
                [bfdm release];
				break;
			default:
				break;
		}
	}
}

- (void)initAlfheimBattle {
	
	int numberOfEnemies = 1;
	BattleEnemyChampion *bec = [[BattleEnemyChampion alloc] initWithBattleLocation:1];
	[self addEntityToActiveEntities:bec];
	[bec release];
	
	/*BattleImp *imp = [[BattleImp alloc] initWithBattleLocation:1];
	 [self addEntityToActiveEntities:imp];
	 [imp release];*/
}

- (void)initChapterOneChampionBattle {
    
    int numberOfEnemies = 1;
	BattleEnemyChampion *bec = [[BattleEnemyChampion alloc] initWithBattleLocation:1];
	[self addEntityToActiveEntities:bec];
	[bec release];
}

- (void)initRangerBattleTutorial {
 
    BattleStoneSpirit *bss = [[BattleStoneSpirit alloc] initWithBattleLocation:1];
    bss.wait = YES;
    [self addEntityToActiveEntities:bss];
    [bss release];
}

- (void)drawLineFrom:(CGPoint)aFromPoint to:(CGPoint)aToPoint {
	
	linePixel.scale = Scale2fMake(sqrt(powf((aToPoint.x - aFromPoint.x), 2) + powf((aToPoint.y - aFromPoint.y), 2)), 3);
	linePixel.rotationPoint = CGPointMake(0, 0);
	float angle = atanf((aToPoint.y - aFromPoint.y) / (aToPoint.x - aFromPoint.x)) * 57.2957795;
	if (angle < 0 && (aToPoint.x - aFromPoint.x) < 0) {
		angle += 180;
	} else if (angle < 0 && (aToPoint.y - aFromPoint.y) < 0) {
		angle += 360;
	} else if ((aToPoint.x - aFromPoint.x) < 0 && (aToPoint.y - aFromPoint.y) < 0) {
		angle += 180;
	}
	linePixel.rotation = angle;
	linePixel.renderPoint = CGPointMake(aFromPoint.x, aFromPoint.y);
	isLineActive = YES;
}

- (void)drawLineOff {
	
	isLineActive = NO;
}

- (void)setCameraPosition:(CGPoint)aCameraPosition {
	
	cameraPosition = CGPointMake(aCameraPosition.x / 40, aCameraPosition.y / 40);
}

- (void)moveToNextStageInScene {}

- (void)createCollisionMapArray {}

- (void)createPortalsArray {}

- (BOOL)checkForPortal {}

- (void)choiceboxSelectionWas:(int)aSelection {}

@end
