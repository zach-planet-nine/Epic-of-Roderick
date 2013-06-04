//
//  ChapterOneDemoTest.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ChapterOneDemoTest.h"
#import "GameController.h"
#import "FontManager.h"
#import "InputManager.h"
#import "SoundManager.h"
#import "PackedSpriteSheet.h"
#import "TiledMap.h"
#import "ParticleEmitter.h"
#import "Animation.h"
#import "Image.h"
#import "Projectile.h"
#import "Character.h"
#import "AbstractEntity.h"
#import "NPCBrownHairedRoderick.h"
#import "NPCBlondeHairedRoderick.h"
#import "NPCBlackHairedRoderick.h"
#import "NPCRedHairedRoderick.h"
#import "NPCEnemyAxeMan.h"
#import "NPCEnemySwordMan.h"
#import "EnemyChampion.h"
#import "Surt.h"
#import "BattleRoderick.h"
#import "Robo.h"
#import "Roderick.h"
#import "Valkyrie.h"
#import "CameraMan.h"
#import "Textbox.h"
#import "FadeInOrOut.h"
#import "WorldFlashColor.h"
#import "Global.h"

@implementation ChapterOneDemoTest

@synthesize roderickBattleTutorial;

- (id)init
{
    self = [super init];
    if (self) {
    
        [sharedSoundManager loadMusicWithKey:@"RoderickTheme" musicFile:@"Roderick's Theme.mp3"];
        [sharedSoundManager loadMusicWithKey:@"BattleMusic" musicFile:@"bad dude.mp3"];
        [sharedSoundManager loadMusicWithKey:@"RoderickHasDied" musicFile:@"hero cutscene.mp3"];
        battleImage = [sharedGameController.teorPSS imageForKey:@"BeachBackground480x320.png"];
        battleFont = [sharedFontManager getFontWithKey:@"battleFont"];
        sceneMap = [[TiledMap alloc] initWithFileName:@"SnowyCamp" fileExtension:@"tmx"];
        [self createCollisionMapArray];
        [self createPortalsArray];
        cameraPosition = CGPointMake(27, 85);
        ParticleEmitter *mapFireEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"MapFireEmitter.pex"];
        mapFireEmitter.sourcePosition = Vector2fMake(425, 3185);
        [self addEntityToActiveEntities:mapFireEmitter];
        [mapFireEmitter release];
        NPCBlondeHairedRoderick *blohr = [[NPCBlondeHairedRoderick alloc] initAtLocation:CGPointMake(460, 3200)];
        [blohr faceLeft];
        [self addEntityToActiveEntities:blohr];
        [blohr release];
        NPCBrownHairedRoderick *brhr = [[NPCBrownHairedRoderick alloc] initAtLocation:CGPointMake(380, 3200)];
        [brhr faceRight];
        [self addEntityToActiveEntities:brhr];
        [brhr release];
        NPCBlackHairedRoderick *blahr = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(640, 3200)];
      
        [blahr moveToPoint:CGPointMake(480, 3320) duration:4];
        [self addEntityToActiveEntities:blahr];
        CameraMan *cm = [[CameraMan alloc] initAtLocation:CGPointMake(1120, 3400)];
        sharedGameController.player = cm;
        [cm moveWithMapToPoint:CGPointMake(480, 3200) duration:4];
        [self addEntityToActiveEntities:cm];
        [cm release];
        //NSLog(@"Active entities count is: %d", [activeEntities count]);
        [sharedInputManager setState:kNoTouchesAllowed];
        stage = 0;
        cutSceneTimer = 4;
        cutScene = YES;
        [sharedSoundManager playMusicWithKey:@"RoderickTheme" timesToRepeat:4];
        //NSLog(@"%f", RANDOM_MINUS_1_TO_1());
        //NSLog(@"%f", RANDOM_MINUS_1_TO_1());
        //NSLog(@"%f", RANDOM_MINUS_1_TO_1());
        //NSLog(@"%f", RANDOM_MINUS_1_TO_1());
        //NSLog(@"%f", RANDOM_MINUS_1_TO_1());
        //NSLog(@"%f", RANDOM_MINUS_1_TO_1());
        allowBattles = NO;
        //Image *colorFilter = [[Image alloc] initWithImageNamed:@"WhitePixel.png" filter:GL_NEAREST];
        //colorFilter.color = Color4fMake(0.1, 0.1, 0.1, 0.3);
        //colorFilter.scale = Scale2fMake(480, 320);
        //colorFilter.renderPoint = CGPointMake(240, 160);
        //[self addImageToDrawingImages:colorFilter];
        //[colorFilter release];

    }
    
    return self;
}

- (void)updateSceneWithDelta:(float)aDelta {
    
    [super updateSceneWithDelta:aDelta];
    if (sharedGameController.player != nil) {
        [self checkForPortal];
    }
        
}

- (void)moveToNextStageInScene {
    
    switch (stage) {
        case 0:
            stage++;
            
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isKindOfClass:[NPCBlackHairedRoderick class]]) {
                    [entity fadeOut];
                }
            }
            Textbox *brohrTB = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0, 0, 0.7, 0.9) duration:3 animating:YES text:@"Boy it sure is cold outside."];
            [self addObjectToActiveObjects:brohrTB];
            [brohrTB release];
            cutSceneTimer = 3.5;
            sharedGameController.gameState = kGameState_Cutscene;

            break;
        case 1:
            stage++;
            Textbox *responseToBROHR = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0, 0, 0.7, 0.9) duration:3 animating:YES text:@"No kidding. I wish I could hang out in Roderick's tent. It looks real warm."];
            [self addObjectToActiveObjects:responseToBROHR];
            [responseToBROHR release];
            cutSceneTimer = 3.5;
            break;
        case 2:
            stage++;
            [sharedGameController.player moveWithMapToPoint:CGPointMake(240, 3160) duration:2];
            cutSceneTimer = 2;
            break;
        case 3:
            stage++;
            FadeInOrOut *fadeOut = [[FadeInOrOut alloc] initFadeOutWithDuration:2];
            [self addObjectToActiveObjects:fadeOut];
            [fadeOut release];
            cutSceneTimer = 2;
            break;
        case 4:
            stage++;
            [super removeDrawingImages];
            Roderick *roderick = [[Roderick alloc] initAtLocation:CGPointMake(2600, 3120)];
            sharedGameController.player = roderick;
            [super setCameraPosition:CGPointMake(65, 78)];
            //NSLog(@"Camera position is: (%f, %f)", cameraPosition.x, cameraPosition.y);
            //NSLog(@"Game state is: %d", sharedGameController.gameState);
            NPCRedHairedRoderick *rhr = [[NPCRedHairedRoderick alloc] initAtLocation:CGPointMake(2520, 3120)];
            [self addEntityToActiveEntities:roderick];
            [self addEntityToActiveEntities:rhr];
            FadeInOrOut *fadeIn = [[FadeInOrOut alloc] initFadeInWithDuration:2];
            [self addObjectToActiveObjects:fadeIn];
            [fadeIn release];
            cutSceneTimer = 2;
            cutScene = YES;
            break;
        case 5:
            stage++;
            Textbox *redToRoderick = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.5, 0.4, 0.4, 0.6) duration:-1 animating:YES text:@"Red: It's no use your highness. The Evilgoths will not agree to peace. We have no choice but to go to war."];
            [self addObjectToActiveObjects:redToRoderick];
            [redToRoderick release];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 6:
            stage++;
            [sharedGameController.player moveToPoint:CGPointMake(sharedGameController.player.currentLocation.x, sharedGameController.player.currentLocation.y + 60) duration:1];
            Textbox *roderickToRed = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.5, 0.5, 0.5, 0.5) duration:-1 animating:YES text:@"Roderick: I was afraid of this. The Evilgoths have never wanted anything but bloodshed. Well if it is battle they want, it is battle they'll get!"];
            [self addObjectToActiveObjects:roderickToRed];
            [roderickToRed release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 7:
            stage++;
            [sharedGameController.player faceDown];
            Textbox *roderickToRed2 = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.4, 0.4, 0.4, 0.4) duration:-1 animating:YES text:@"Tell the men to prepare themselves. Tomorrow we go to war."];
            [self addObjectToActiveObjects:roderickToRed2];
            [roderickToRed2 release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 8:
            stage++;
            Textbox *redToRoderick2 = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.4, 0.4, 0.4, 0.4) duration:-1 animating:YES text:@"Yes your highness."];
            [self addObjectToActiveObjects:redToRoderick2];
            [redToRoderick2 release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 9:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isKindOfClass:[NPCRedHairedRoderick class]]) {
                    [entity moveToPoint:CGPointMake(2590, 3120) duration:1];
                }
            }
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 10:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isKindOfClass:[NPCRedHairedRoderick class]]) {
                    [entity moveToPoint:CGPointMake(2590, 3040) duration:1.5];
                }
            }
            cutScene = YES;
            cutSceneTimer = 1.5;
            break;
        case 11:
            stage++;
            Textbox *roderickThought = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.6) duration:-1 animating:YES text:@"May the gods protect us on the battle field tomorrow. I feel we shall need all the help we can get."];
            [self addObjectToActiveObjects:roderickThought];
            [roderickThought release];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isKindOfClass:[NPCRedHairedRoderick class]]) {
                    [entity fadeOut];
                }
            }
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            cutScene = NO;
            break;
        case 12:
            stage++;
            FadeInOrOut *fadeOut2 = [[FadeInOrOut alloc] initFadeOutWithDuration:2];
            [self addObjectToActiveObjects:fadeOut2];
            cutSceneTimer = 2;
            cutScene = YES;
            break;
        case 13:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            for (int i = 0; i < 8; i++) {
                NPCRedHairedRoderick *nrhr = [[NPCRedHairedRoderick alloc] initAtLocation:CGPointMake(1560, 3260 - (40 * i))];
                 NPCBlackHairedRoderick *nblahr = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(1520, 3260 - (40 * i))];
                 NPCBlondeHairedRoderick *nblohr = [[NPCBlondeHairedRoderick alloc] initAtLocation:CGPointMake(1480, 3260 - (40 * i))];
                [nrhr faceRight];
                [nblahr faceRight];
                [nblohr faceRight];
                [self addEntityToActiveEntities:nrhr];
                [self addEntityToActiveEntities:nblahr];
                [self addEntityToActiveEntities:nblohr];
                [nrhr release];
                [nblahr release];
                [nblohr release];
            }
            sharedGameController.player.active = YES;
            sharedGameController.player.currentLocation = CGPointMake(1600, 3120);
            [self setCameraPosition:CGPointMake(42, 78)];    
            FadeInOrOut *fadeIn2 = [[FadeInOrOut alloc] initFadeInWithDuration:2];
            [self addObjectToActiveObjects:fadeIn2];
            [fadeIn2 release];
            cutSceneTimer = 2;
            break;
        case 14:
            stage++;
            [sharedGameController.player moveToPoint:CGPointMake(1600, 3260) duration:2.5];
            Textbox *roderickEncouraging1 = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.6, 0.6, 0.6, 0.95) duration:-1 animating:YES text:@"Roderick: Stand your ground men. The Evilgoths approach. Let us show them what the Awesomians are made of!"];
            [self addObjectToActiveObjects:roderickEncouraging1];
            [roderickEncouraging1 release];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 15:
            stage++;
            [super removeInactiveEntities];
            Textbox *huzzah = [[Textbox alloc] initWithRect:CGRectMake(100, 100, 120, 40) color:Color4fMake(0.6, 0.6, 0.6, 0.6) duration:1.5 animating:YES text:@"HUZZAH!"];
            Textbox *hooray = [[Textbox alloc] initWithRect:CGRectMake(200, 150, 120, 40) color:Color4fMake(0.6, 0.6, 0.6, 0.6) duration:1.5 animating:YES text:@"HOORAY!"];
            Textbox *hearhear = [[Textbox alloc] initWithRect:CGRectMake(80, 15, 120, 40) color:Color4fMake(0.6, 0.6, 0.6, 0.6) duration:1.5 animating:YES text:@"HEAR HEAR!"];
            [self addObjectToActiveObjects:huzzah];
            [self addObjectToActiveObjects:hooray];
            [self addObjectToActiveObjects:hearhear];
            [huzzah release];
            [hooray release];
            [hearhear release];
            cutSceneTimer = 2;
            cutScene = YES;
            break;
        case 16:
            stage++;
            [sharedGameController.player moveToPoint:CGPointMake(1600, 3000) duration:3];
            Textbox *roderickEncouraging2 = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.6, 0.6, 0.6, 0.95) duration:-1 animating:YES text:@"Roderick: Steady now! The enemy draws near. Hold your ground until I give the signal!"];
            [self addObjectToActiveObjects:roderickEncouraging2];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            [roderickEncouraging2 release];
            for (int xi = 0; xi < 3; xi++) {
                for (int i = 0; i < 8; i++) {
                    NPCEnemyAxeMan *neam = [[NPCEnemyAxeMan alloc] initAtLocation:CGPointMake(2000 + (xi * 40), 3300 - (40 * i))];
                    NPCEnemySwordMan *nesm = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(2000 + (xi * 40), 3300 - (40 * i))];
                    if (RANDOM_0_TO_1() < 0.5) {
                        [self addEntityToActiveEntities:nesm];
                        neam.currentLocation = CGPointMake(neam.currentLocation.x, neam.currentLocation.y - 40);
                        [self addEntityToActiveEntities:neam];
                    } else {
                        [self addEntityToActiveEntities:neam];
                        neam.currentLocation = CGPointMake(nesm.currentLocation.x, neam.currentLocation.y - 40);
                        [self addEntityToActiveEntities:nesm];
                    }
                    [neam moveToPoint:CGPointMake(neam.currentLocation.x - 160, neam.currentLocation.y) duration:2];
                    [nesm moveToPoint:CGPointMake(neam.currentLocation.x - 160, neam.currentLocation.y) duration:2];
                    [neam release];
                    [nesm release];
                }
            }
            break;
        case 17:
            stage++;
            [sharedGameController.player moveToPoint:CGPointMake(1600, 3120) duration:2];
            Textbox *steady1 = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.6, 0.6, 0.6, 0.95) duration:-1 animating:YES text:@"Steady"];
            [self addObjectToActiveObjects:steady1];
            [steady1 release];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 18:
            stage++;
            [sharedGameController.player moveToPoint:CGPointMake(1600, 3120) duration:2];
            Textbox *steady2 = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.6, 0.6, 0.6, 0.95) duration:-1 animating:YES text:@"Steady"];
            [self addObjectToActiveObjects:steady2];
            [steady2 release];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 19:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                [entity moveToPoint:CGPointMake(1720, entity.currentLocation.y) duration:1.5];
            }
            Textbox *charge = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.6, 0.3, 0.3, 0.9) duration:1 animating:NO text:@"CHARGE!!!"];
            [self addObjectToActiveObjects:charge];
            cutSceneTimer = 0.8;
            cutScene = YES;
            break;
        case 20:
            stage++;
            cutScene = YES;
            cutSceneTimer = 0.2;
            [sharedSoundManager playMusicWithKey:@"BattleMusic" timesToRepeat:-1];
            break;
        case 21:
            stage++;
            cutScene = NO;
            [self initBattle];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            Textbox *battleExplanation = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0, 0, 0.6, 0.9) duration:-1 animating:YES text:@"This is the battle screen. Battles here work a little differently than what you might be used to."];
            [self addObjectToActiveObjects:battleExplanation];
            [battleExplanation release];
            //NSLog(@"Stage 21 completed.");
            break;
        case 22:
            stage++;
            Textbox *chooseCharacterExplanation = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0, 0.6, 0, 0.9) duration:-1 animating:YES text:@"At the beginning of battle you can select a character. You don't have many choices now so go ahead and select Roderick by tapping him."];
            [self addObjectToActiveObjects:chooseCharacterExplanation];
            [chooseCharacterExplanation release];
            [sharedInputManager setStateMustTapRect:CGRectMake(10, 230, 50, 80)];
             //NSLog(@"Stage 22 completed.");
            break;
        case 23:
            stage++;
            for (BattleRoderick *br in activeEntities) {
                if ([br isKindOfClass:[BattleRoderick class]]) {
                    [br gainPriority];
                }
            }
            Textbox *explainAttacking = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.4, 0.4, 0.4, 0.9) duration:-1 animating:YES text:@"Great! Now that Roderick is selected you can attack your enemies. Roderick attacks by slashing. Go ahead and slash through the enemy to attack."];
            [self addObjectToActiveObjects:explainAttacking];
            [explainAttacking release];
            roderickBattleTutorial = YES;
            [sharedInputManager setState:kRoderick];
             //NSLog(@"Stage 23 completed.");
            break;
        case 24:
            stage++;
            [self removeTextbox];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            Textbox *finishBattleTutorial = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0, 0.4, 0.4, 0.9) duration:-1 animating:YES text:@"Excellent! Every time Roderick attacks, he loses some stamina. Having less stamina makes attacks weaker. Try to strike a balance between attacking multiple times and attacking with high stamina."];
            [self addObjectToActiveObjects:finishBattleTutorial];
            [finishBattleTutorial release];
            roderickBattleTutorial = NO;
            break;
        case 25:
            stage++;
            Textbox *startTheBattle = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.8) duration:-1 animating:YES text:@"Ok. I think you're ready to take on this enemy soldier. Tap the screen when you're ready and defeat him!"];
            [self addObjectToActiveObjects:startTheBattle];
            [startTheBattle release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 26:
            stage++;
            [sharedInputManager setState:kRoderick];
            break;
        case 27:
            stage++;
            Textbox *experienceScreen = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.2, 0.2, 0.2, 0.9) duration:-1 animating:YES text:@"This is the experience screen. Whenever you win a battle Roderick will become stronger."];
            [self addObjectToActiveObjects:experienceScreen];
            [experienceScreen release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 28:
            stage++;
            [sharedInputManager setState:kBattleExperienceScreen];
            break;
        case 29:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCBlackHairedRoderick class]] || [entity isMemberOfClass:[NPCBlondeHairedRoderick class]] || [entity isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    entity.currentLocation = CGPointMake(1480 + (40 * (11 * RANDOM_0_TO_1())), 3300 - (40 * (6 * RANDOM_0_TO_1())));
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x + 20, entity.currentLocation.y) duration:3];
                }
                if ([entity isMemberOfClass:[NPCEnemyAxeMan class]] || [entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                    entity.currentLocation = CGPointMake(1500 + (40 * (11 * RANDOM_0_TO_1())), 3300 - (40 * (6 * RANDOM_0_TO_1())));
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x - 20, entity.currentLocation.y) duration:3];
                }
            }
            cutScene = YES;
            cutSceneTimer = 2;
            break;
        case 30:
            stage++;
            [self initBattle];
            cutScene = NO;
            break;
        case 31:
            stage++;
            break;
        case 32:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            sharedGameController.player.active = YES;
            [super removeInactiveEntities];
            sharedGameController.player.currentLocation = CGPointMake(560, 3160);
            NPCBlondeHairedRoderick *blohr = [[NPCBlondeHairedRoderick alloc] initAtLocation:CGPointMake(460, 3200)];
            [blohr faceLeft];
            blohr.message = @"Please don't make us go back out there. This was truly a terrible day.";
            [self addEntityToActiveEntities:blohr];
            [blohr release];
            NPCBrownHairedRoderick *brhr = [[NPCBrownHairedRoderick alloc] initAtLocation:CGPointMake(380, 3200)];
            [brhr faceRight];
            brhr.message = @"That battle was terrible. I cannot believe the Evilgoth's power.";
            [self addEntityToActiveEntities:brhr];
            [brhr release];
            NPCBlackHairedRoderick *blahr = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(120, 2560)];
            [blahr faceDown];
            blahr.message = @"We will care for the wounded in this tent your highness. Don't you worry, we will do our best!";
            [self addEntityToActiveEntities:blahr];
            [blahr release];
            NPCBrownHairedRoderick *soldierInTent = [[NPCBrownHairedRoderick alloc] initAtLocation:CGPointMake(800, 2600)];
            soldierInTent.message = @"The Evilgoths! Who knew they were so powerful. It was like fighting a bear.";
            [self addEntityToActiveEntities:soldierInTent];
            [soldierInTent release];
            NPCRedHairedRoderick *red = [[NPCRedHairedRoderick alloc] initAtLocation:CGPointMake(2520, 3160)];
            red.triggerNextStage = YES;
            [self addEntityToActiveEntities:red];
            [red release];
            break;
        case 33:
            stage++;
            //NSLog(@"This does get called.");
            Textbox *redToRoderickAgain = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.8) duration:-1 animating:YES text:@"Red: The Evilgoths... they are so powerful. How can we hope to defeat them?"];
            [self addObjectToActiveObjects:redToRoderickAgain];
            [redToRoderickAgain release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            sharedGameController.gameState = kGameState_Cutscene;
            break;
        case 34:
            stage++;
            Textbox *roderickLaments = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.4, 0.3, 0.9) duration:-1 animating:YES text:@"Roderick: So many dead."];
            [self addObjectToActiveObjects:roderickLaments];
            [roderickLaments release];
            [sharedGameController.player moveToPoint:CGPointMake(sharedGameController.player.currentLocation.x + 80, 3160) duration:1];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 35:
            stage++;
            [sharedGameController.player faceDown];
            Textbox *roderickEndures = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.4, 0.85) duration:-1 animating:YES text:@"Still there must be something that we can do."];
            [self addObjectToActiveObjects:roderickEndures];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 36:
            stage++;
            NPCBlackHairedRoderick *messenger = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(2520, 3040)];
            [messenger moveToPoint:CGPointMake(2520, 3120) duration:1];
            [self addEntityToActiveEntities:messenger];
            Textbox *messengersMessage = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Your highness, an enemy soldier approaches."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            [self addObjectToActiveObjects:messengersMessage];
            [messengersMessage release];
            break;
        case 37:
            stage++;
            Textbox *roderickToMessenger = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.5, 0.4, 0.9) duration:-1 animating:YES text:@"Roderick: Indeed. I will meet him outside."];
            [self addObjectToActiveObjects:roderickToMessenger];
            [roderickToMessenger release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 38:
            stage++;
            Textbox *messengerSaysYes = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:1.2 animating:YES text:@"Yes sir!"];
            [self addObjectToActiveObjects:messengerSaysYes];
            [messengerSaysYes release];
            FadeInOrOut *anotherFadeOut = [[FadeInOrOut alloc] initFadeOutWithDuration:2];
            [self addObjectToActiveObjects:anotherFadeOut];
           
            cutScene = YES;
            cutSceneTimer = 2;
            break;
        case 39:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            sharedGameController.player.active = YES;

            sharedGameController.player.currentLocation = CGPointMake(380, 3000);
            [sharedGameController.player moveWithMapToPoint:CGPointMake(580, 3000) duration:2.5];
            [super removeInactiveEntities];
            NPCRedHairedRoderick *redOutside = [[NPCRedHairedRoderick alloc] initAtLocation:CGPointMake(340, 3040)];
            [redOutside moveToPoint:CGPointMake(340 + 200, 3040) duration:2.5];
            [self addEntityToActiveEntities:redOutside];
            [redOutside release];
            NPCBlackHairedRoderick *messengerOutside = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(340, 2960)];
            [messengerOutside moveToPoint:CGPointMake(540, 2960) duration:2.5];
            [self addEntityToActiveEntities:messengerOutside];
            NPCEnemySwordMan *enemySoldier = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(860, 3000)];
            [enemySoldier moveToPoint:CGPointMake(660, 3000) duration:2.5];
            [self addEntityToActiveEntities:enemySoldier];
            FadeInOrOut *anotherFadeIn = [[FadeInOrOut alloc] initFadeInWithDuration:2];
            [self addObjectToActiveObjects:anotherFadeIn];
            [sharedInputManager setState:kNoTouchesAllowed];
            Textbox *enemySoldierSpeaks = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.2, 0.2, 0.2, 0.9) duration:-1 animating:YES text:@"Hail king Roderick. I come as a messenger from the Evilgoths."];
            [self addObjectToActiveObjects:enemySoldierSpeaks];
            [enemySoldierSpeaks release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            cutScene = NO;
            break;
        case 40:
            stage++;
            Textbox *roderickToSoldier = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Speak your peace soldier."];
            [self addObjectToActiveObjects:roderickToSoldier];
            [roderickToSoldier release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 41:
            stage++;
            Textbox *soldierAgain = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.2, 0.2, 0.9) duration:-1 animating:YES text:@"There has been enough blood shed today. We offer a way to end this war tomorrow. Will you agree to meet our champion tomorrow on the battle field?"];
            [self addObjectToActiveObjects:soldierAgain];
            [soldierAgain release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 42:
            stage++;
            Textbox *roderickAccepts = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"I accept your challenge. It shall be a mighty battle."];
            [self addObjectToActiveObjects:roderickAccepts];
            [roderickAccepts release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 43:
            stage++;
            Textbox *soldierAcknowledges = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:1.5 animating:YES text:@"Then tomorrow our fates are decided."];
            [self addObjectToActiveObjects:soldierAcknowledges];
            [soldierAcknowledges release];
            cutScene = YES;
            cutSceneTimer = 1.3;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 44:
            stage++;
            FadeInOrOut *fadeOutted = [[FadeInOrOut alloc] initFadeOutWithDuration:2];
            [self addObjectToActiveObjects:fadeOutted];
            [fadeOutted release];
            cutSceneTimer = 2;
            cutScene = YES;
            break;
        case 45:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            for (int i = 0; i < 8; i++) {
                NPCRedHairedRoderick *nrhr = [[NPCRedHairedRoderick alloc] initAtLocation:CGPointMake(1560, 3260 - (40 * i))];
                NPCBlackHairedRoderick *nblahr = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(1520, 3260 - (40 * i))];
                NPCBlondeHairedRoderick *nblohr = [[NPCBlondeHairedRoderick alloc] initAtLocation:CGPointMake(1480, 3260 - (40 * i))];
                [nrhr faceRight];
                [nblahr faceRight];
                [nblohr faceRight];
                [self addEntityToActiveEntities:nrhr];
                [self addEntityToActiveEntities:nblahr];
                [self addEntityToActiveEntities:nblohr];
                [nrhr release];
                [nblahr release];
                [nblohr release];
            }
            sharedGameController.player.active = YES;
            sharedGameController.player.currentLocation = CGPointMake(1600, 3120);
            sharedGameController.gameState = kGameState_Cutscene;
            [self setCameraPosition:CGPointMake(42, 78)];
            
            for (int xi = 0; xi < 3; xi++) {
                for (int i = 0; i < 8; i++) {
                    NPCEnemyAxeMan *neam = [[NPCEnemyAxeMan alloc] initAtLocation:CGPointMake(2000 + (xi * 40), 3300 - (40 * i))];
                    NPCEnemySwordMan *nesm = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(2000 + (xi * 40), 3300 - (40 * i))];
                    if (RANDOM_0_TO_1() < 0.5) {
                        [self addEntityToActiveEntities:nesm];
                        neam.currentLocation = CGPointMake(neam.currentLocation.x, neam.currentLocation.y - 40);
                        [self addEntityToActiveEntities:neam];
                    } else {
                        [self addEntityToActiveEntities:neam];
                        neam.currentLocation = CGPointMake(nesm.currentLocation.x, neam.currentLocation.y - 40);
                        [self addEntityToActiveEntities:nesm];
                    }
                    [neam moveToPoint:CGPointMake(neam.currentLocation.x - 160, neam.currentLocation.y) duration:2];
                    [nesm moveToPoint:CGPointMake(neam.currentLocation.x - 160, neam.currentLocation.y) duration:2];
                    [neam release];
                    [nesm release];
                }
            }
            FadeInOrOut *fadedIn = [[FadeInOrOut alloc] initFadeInWithDuration:2];
            [self addObjectToActiveObjects:fadedIn];
            [fadedIn release];
            cutSceneTimer = 2;
            cutScene = YES;
            break;
        case 46:
            stage++;
            Textbox *championChant = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.4, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Champion! Champion! Champion!"];
            [self addObjectToActiveObjects:championChant];
            [championChant release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            cutScene = NO;
            break;
        case 47:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCEnemyAxeMan class]] || [entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                    if (entity.currentLocation.y > 3100) {
                        [entity moveToPoint:CGPointMake(entity.currentLocation.x, entity.currentLocation.y + 40) duration:1];
                    } else {
                        [entity moveToPoint:CGPointMake(entity.currentLocation.x, entity.currentLocation.y - 40) duration:1];
                    }
                }
            }
            EnemyChampion *ec = [[EnemyChampion alloc] initAtLocation:CGPointMake(2000, 3120)];
            [ec moveToPoint:CGPointMake(1760, 3120) duration:3];
            [self addEntityToActiveEntities:ec];
            [ec release];
            cutSceneTimer = 3;
            cutScene = YES;
            break;
        case 48:
            stage++;
            Textbox *ecSpeaks = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Roderick, prepare to meet your doom."];
            [self addObjectToActiveObjects:ecSpeaks];
            [ecSpeaks release];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 49:
            stage++;
            /*Textbox *roderickDies = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"This is where Roderick dies."];
            [self addObjectToActiveObjects:roderickDies];
            [roderickDies release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            //NSLog(@"SUCCESS!!");*/
            cutScene = NO;
            sharedGameController.realm = kRealm_ChapterOneChampionBattle;
            [self initBattle];
            break;
        case 50:
            stage++;
            FadeInOrOut *battleFadeOut = [[FadeInOrOut alloc] initFadeOutWithDuration:2];
            [self addObjectToActiveObjects:battleFadeOut];
            [battleFadeOut release];
            [sharedInputManager setState:kNoTouchesAllowed];
            cutSceneTimer = 2;
            cutScene = YES;
            break;
        case 51:
            stage++;
            [self restoreMap];
            break;
        case 52:
            stage++;
            [sharedSoundManager playMusicWithKey:@"RoderickHasDied" timesToRepeat:-1];
            sharedGameController.player.currentAnimation.currentFrameImage.rotation = 270;
            FadeInOrOut *rodericksDeadFadeIn = [[FadeInOrOut alloc] initFadeInWithDuration:2];
            [self addObjectToActiveObjects:rodericksDeadFadeIn];
            [rodericksDeadFadeIn release];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCRedHairedRoderick class]] || [entity isMemberOfClass:[NPCBlackHairedRoderick class]] || [entity isMemberOfClass:[NPCBlondeHairedRoderick class]]) {
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x + (fabsf(entity.currentLocation.y - 3120) / 2), entity.currentLocation.y) duration:1];
                }
            }
            Textbox *lament = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.7, 0.7, 0.7, 0.9) duration:-1 animating:YES text:@"Your highness!"];
            [self addObjectToActiveObjects:lament];
            [lament release];
            cutScene = NO;    
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 53:
            stage++;
            FadeInOrOut *fadeToBlack = [[FadeInOrOut alloc] initFadeOutWithDuration:2.5];
            [self addObjectToActiveObjects:fadeToBlack];
            [fadeToBlack release];
            Textbox *whatNow = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.1, 0.1, 0.1, 0.7) duration:2 animating:-1 text:@"What will we do now? We're doomed..."];
            [self addObjectToActiveObjects:whatNow];
            [whatNow release];
            [sharedInputManager setState:kNoTouchesAllowed];
            cutScene = YES;
            cutSceneTimer = 2.5;
            break;
        case 54:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            FadeInOrOut *fadeInRoderick = [[FadeInOrOut alloc] initFadeInWithDuration:2];
            [self addObjectToActiveObjects:fadeInRoderick];
            [fadeInRoderick release];
            sharedGameController.player.active = YES;
            sharedGameController.player.currentAnimation.currentFrameImage.rotation = 0;
            sharedGameController.player.currentLocation = CGPointMake(120, 400);
            cameraPosition = CGPointMake(3, 10);
            sharedGameController.gameState = kGameState_Cutscene;
            cutSceneTimer = 2;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 55:
            stage++;
            [super removeInactiveEntities];
            Textbox *whereAmI = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.5, 0.9) duration:-1 animating:YES text:@"Where am I? What is this place..."];
            [self addObjectToActiveObjects:whereAmI];
            [whereAmI release];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 56:
            stage++;
            WorldFlashColor *wfc = [[WorldFlashColor alloc] initColorFlashWithColor:Color4fMake(0.9, 0.9, 0.9, 0.8)];
            [self addObjectToActiveObjects:wfc];
            [wfc release];
            cutSceneTimer = 0.6;
            cutScene = YES;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 57:
            stage++;
            Valkyrie *valk = [[Valkyrie alloc] initAtLocation:CGPointMake(0, 600)];
            [valk moveToPoint:CGPointMake(80, 400) duration:2];
            [self addEntityToActiveEntities:valk];
            [valk release];
            cutScene = YES;
            cutSceneTimer = 2;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 58:
            stage++;
            [sharedGameController.player faceLeft];
            Textbox *roderickToValk = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.5, 0.5, 0.5, 0.9) duration:-1 animating:YES text:@"Roderick: Who or what are you. Where am I. What's going on?"];
            [self addObjectToActiveObjects:roderickToValk];
            [roderickToValk release];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 59:
            stage++;
            Textbox *valkToRoderick = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.5, 0.5, 0.5, 0.9) duration:-1 animating:YES text:@"Strange Woman: My name is Bryn. I am a Valkyrie and I'm here to take you to join your fellow fallen warriors in Valhalla."];
            [self addObjectToActiveObjects:valkToRoderick];
            [valkToRoderick release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 60:
            stage++;
            Textbox *roderickRealizes = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.4, 0.4, 0.4, 0.9) duration:-1 animating:YES text:@"Roderick: My fellow fallen warriors...? You mean..."];
            [self addObjectToActiveObjects:roderickRealizes];
            [roderickRealizes release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 61:
            stage++;
            Textbox *valkyrieTellsRoderick = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.4, 0.4, 0.4, 0.9) duration:-1 animating:YES text:@"Bryn: Yes, Roderick. You died on the battle field at the hands of the Evilgoths. Now come along. We must get you to Asgard."];
            [self addObjectToActiveObjects:valkyrieTellsRoderick];
            [valkyrieTellsRoderick release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 62:
            stage++;
            Textbox *roderickAboutAsgard = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.4, 0.4, 0.4, 0.9) duration:-1 animating:YES text:@"Roderick: Asgard?! But how can we possibly get there? Isn't that the realm of the gods?"];
            [self addObjectToActiveObjects:roderickAboutAsgard];
            [roderickAboutAsgard release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 63:
            stage++;
            Textbox *valkyrieExplains = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.4, 0.4, 0.4, 0.9) duration:-1 animating:YES text:@"Bryn: We must travel to the Bifrost that bridges our realms. I'll show you the way. But be on your guard as there are spirits less fortunate than you that will try to impede our journey."];
            [self addObjectToActiveObjects:valkyrieExplains];
            [valkyrieExplains release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 64:
            stage++;
            [sharedInputManager setState:kNoTouchesAllowed];
            sharedGameController.player.currentLocation = CGPointMake(600, 400);
            cameraPosition = CGPointMake(0, 0);
            Textbox *valkyrieJoins = [[Textbox alloc] initWithRect:CGRectMake(60, 80, 360, 80) color:Color4fMake(0.5, 0.3, 0.5, 0.9) duration:2 animating:NO text:@"The Valkyrie Bryn has joined your party."];
            [self addObjectToActiveObjects:valkyrieJoins];
            [valkyrieJoins release];
            cutScene = YES;
            cutSceneTimer = 2;
            break;
        case 65:
            stage++;
            cutScene = NO;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            Character *characterValk = [sharedGameController.characters objectForKey:@"Valkyrie"];
            [sharedGameController.party addObject:characterValk];
            cameraPosition = CGPointMake(15, 10);
            sharedGameController.gameState = kGameState_World;
            sharedGameController.realm = kRealm_Midgard;
            allowBattles = YES;
            //NSLog(@"Should be fine here.");
            break;
        case 66:
            stage++;
            [super initBattle];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            Textbox *valkBattle = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Now there are two characters to select. Go ahead and tap on Bryn."];
            [self addObjectToActiveObjects:valkBattle];
            [sharedInputManager setStateMustTapRect:[[sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"] getRect]];
            break;
        case 67:
            stage++;
            Textbox *valkTaps = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:6.5 animating:YES text:@"Great! Bryn attacks by tapping on enemies. Her attacks are faster than Roderick's but they're also a little less powerful. Go ahead and attack some enemies."];
            [self addObjectToActiveObjects:valkTaps];
            [valkTaps release];
            cutScene = YES;
            cutSceneTimer = 6.5;
            [sharedInputManager setState:kValkyrie];
            break;
        case 68:
            stage++;
            [self removeTextbox];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            Textbox *valkRage = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.4, 0.3, 0.4, 0.9) duration:-1 animating:YES text:@"In addition to her attacks, Bryn has another ability."];
            [self addObjectToActiveObjects:valkRage];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 69:
            stage++;
            Textbox *valkRageLine = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.4, 0.3, 0.4, 0.9) duration:-1 animating:YES text:@"Valkyries can harness their inner rage to take revenge on those that harm them. Draw a line from Bryn to an enemy in order to have her focus her rage on that enemy."];
            [self addObjectToActiveObjects:valkRageLine];
            [valkRageLine release];
            [sharedInputManager setState:kValkyrieMustDrawLine];
            break;
        case 70:
            stage++;
            [self removeTextbox];
            Textbox *valkRageMeter = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.4, 0.3, 0.4, 0.9) duration:-1 animating:YES text:@"Once linked to an enemy, Bryn will attack whenever her rage becomes uncontrollable. Use this ability to get your revenge on enemies."];
            [self addObjectToActiveObjects:valkRageMeter];
            [valkRageMeter release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 71:
            stage++;
            Textbox *battleContinues = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Alright, whenever you're ready go ahead and proceed with the battle."];
            [self addObjectToActiveObjects:battleContinues];
            [battleContinues release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 72:
            stage++;
            [sharedInputManager setState:kValkyrie];
            break;
        case 73:
            stage++;
            allowBattles = NO;
            FadeInOrOut *leaveSnowMap = [[FadeInOrOut alloc] initFadeOutWithDuration:2];
            [self addObjectToActiveObjects:leaveSnowMap];
            [leaveSnowMap release];
            [sharedInputManager setState:kNoTouchesAllowed];
            cutSceneTimer = 2;
            cutScene = YES;
            break;
        case 74:
            stage++;
            [sharedGameController.player stopMoving];
            [sharedGameController.player faceUp];
            [sharedGameController.player stopMoving];
            FadeInOrOut *getToQuickMap = [[FadeInOrOut alloc] initFadeInWithDuration:2];
            cameraPosition = CGPointMake(5, 12);
            TiledMap *newMap = [[TiledMap alloc] initWithFileName:@"QuickMap" fileExtension:@"tmx"];
            TiledMap *oldMap = sceneMap;
            sceneMap = newMap;
            [oldMap release];
            [self addObjectToActiveObjects:getToQuickMap];
            [getToQuickMap release];
            sharedGameController.player.currentLocation = CGPointMake(240, 320);
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]]) {
                    entity.currentLocation = CGPointMake(200, 320);
                }
            }
            cutSceneTimer = 2;
            break;
        case 75:
            stage++;
            cutScene = NO;
            [sharedGameController.player moveToPoint:CGPointMake(240, 440) duration:2];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]]) {
                    [entity moveToPoint:CGPointMake(200, 440) duration:2];
                }
            }
            Textbox *hereWeAre = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.4, 0.3, 0.4, 0.9) duration:-1 animating:YES text:@"Bryn: Here we are at Valhalla. Go inside and meet your fellow warriors."];
            [self addObjectToActiveObjects:hereWeAre];
            [hereWeAre release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 76:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                [entity stopMoving];
            }
            [sharedSoundManager playMusicWithKey:@"BattleMusic" timesToRepeat:-1];
            WorldFlashColor *redWFC = [[WorldFlashColor alloc] initColorFlashWithColor:Color4fMake(1, 0.2, 0, 0.45)];
            [self addObjectToActiveObjects:redWFC];
            [redWFC release];
            cutScene = YES;
            cutSceneTimer = 0.4;
            break;
        case 77:
            stage++;
            cutScene = NO;
            Surt *surt = [[Surt alloc] initAtLocation:CGPointMake(220, 560)];
            [surt fadeIn];
            [self addEntityToActiveEntities:surt];
            [surt release];
            Textbox *surtLaughing = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 40) color:Color4fMake(0.43, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Fire Giant: BWAHAHAHHAHAHAHAHAH!"];
            [self addObjectToActiveObjects:surtLaughing];
            [surtLaughing release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 78:
            stage++;
            Textbox *surtThreatens = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.4, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Fire Giant: I shall destroy your precious Valhalla Odin! And then I shall come for you!!"];
            [self addObjectToActiveObjects:surtThreatens];
            [surtThreatens release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 79:
            stage++;
            Textbox *brynSpeaks = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 60) color:Color4fMake(0.4, 0.3, 0.4, 0.9) duration:-1 animating:YES text:@"Bryn: Oh no, it's Surt! What is he doing here? This is not good."];
            [self addObjectToActiveObjects:brynSpeaks];
            [brynSpeaks release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 80:
            stage++;
            Textbox *surtNotices = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.4, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Surt: Pesky Valkyrie. Be gone with you!"];
            [self addObjectToActiveObjects:surtNotices];
            [surtNotices release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 81:
            stage++;
            WorldFlashColor *redWFC2 = [[WorldFlashColor alloc] initColorFlashWithColor:Color4fMake(1, 0.2, 0, 0.45)];
            [self addObjectToActiveObjects:redWFC2];
            [redWFC2 release];
            sharedGameController.gameState = kGameState_Cutscene;
            Projectile *roderickProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(240, 160) to:Vector2fMake(-60, 520) withSSImage:sharedGameController.player.currentAnimation.currentFrameImage lasting:5 withStartAngle:125 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(0.5, 0.5) revolving:YES];
            [self addObjectToActiveObjects:roderickProjectile];
            [roderickProjectile release];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]]) {
                    Projectile *valkProjectile = [[Projectile alloc] initProjectileFrom:Vector2fMake(200, 160) to:Vector2fMake(-60, 520) withSSImage:entity.currentAnimation.currentFrameImage lasting:5 withStartAngle:125 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(0.5, 0.5) revolving:YES];
                    [self addObjectToActiveObjects:valkProjectile];
                    [valkProjectile release];
                }
            }
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]] || [entity isMemberOfClass:[Roderick class]]) {
                    entity.active = NO;
                }
            }
            sharedGameController.player = nil;
            [sharedInputManager setState:kNoTouchesAllowed];
            cutScene = YES;
            cutSceneTimer = 1.5;
            break;
        case 82:
            stage++;
            FadeInOrOut *finalFadeOut = [[FadeInOrOut alloc] initFadeOutWithDuration:2];
            [self addObjectToActiveObjects:finalFadeOut];
            [finalFadeOut release];
            cameraPosition = CGPointMake(-5, -5);
            cutSceneTimer = 2;
            Textbox *surtLaughsAgain = [[Textbox alloc] initWithRect:CGRectMake(0, 280, 480, 40) color:Color4fMake(0.4, 0.3, 0.3, 0.9) duration:3 animating:YES text:@"Surt: BWHAHAHAHHWHWHAHAHAHAH!"];
            [self addObjectToActiveObjects:surtLaughsAgain];
            [surtLaughsAgain release];
            break;
            

            
        default:
            break;

    }
}

- (void)initBattle {
    if (stage == 66) {
        [self moveToNextStageInScene];
        return;
    }
    [super initBattle];
}

- (void)endBattle {
    [super endBattle];
    if (!allowBattles) {
        [self moveToNextStageInScene];
    }
}

- (void)restoreMap {
    [super restoreMap];
    BattleRoderick *bro = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
    [bro youHaveBeenRevived];
    bro.hp = bro.maxHP;
    if (!allowBattles) {
        [self moveToNextStageInScene];
    }
}

- (void)createCollisionMapArray {
    
    int collisionLayerIndex = [sceneMap layerIndexWithName:@"Collisions"];
    Layer *collisionLayer = [[sceneMap layers] objectAtIndex:collisionLayerIndex];
    for (int yy = 0; yy < 100; yy++) {
        for (int xx = 0; xx < 100; xx++) {
            int globalTileId = [collisionLayer globalTileIDAtTile:CGPointMake(xx, yy)];
            if (globalTileId != -1) {
                blocked[xx][yy] = YES;
            }
        }
    }
}

- (void)createPortalsArray {
    portals[16][80] = 1;
    portals[10][83] = 2;
    portals[4][79] = 3;
    portalDestination[0] = CGPointMake(120, 2480);
    portalDestination[1] = CGPointMake(920, 2480);
    portalDestination[2] = CGPointMake(2520, 3080);
    portals[1][60] = 4;
    portalDestination[3] = CGPointMake(720, 3200);
    portals[21][60] = 5;
    portalDestination[4] = CGPointMake(480, 3320);
    portals[63][23] = 6;
    portalDestination[5] = CGPointMake(240, 3160);
    
}

- (BOOL)isBlocked:(float)x y:(float)y {
  
    return blocked[(int)x][(int)y];
}

- (void)checkForPortal {
    
    if (sharedGameController.player != nil && stage == 33) {
       // //NSLog(@"Player's current tile location is: (%d, %d).", (int)sharedGameController.player.currentLocation.x / 40 - 1, (int)sharedGameController.player.currentLocation.y / 40);
        if (portals[(int)sharedGameController.player.currentLocation.x / 40 - 1][(int)sharedGameController.player.currentLocation.y / 40] != 0) { 
            //NSLog(@"Destination is: (%f, %f).", portalDestination[(portals[(int)sharedGameController.player.currentLocation.x / 40 - 1][(int)sharedGameController.player.currentLocation.y / 40]) - 1].x, portalDestination[(portals[(int)sharedGameController.player.currentLocation.x / 40 - 1][(int)sharedGameController.player.currentLocation.y / 40]) - 1].y);
            sharedGameController.player.currentLocation = portalDestination[(portals[(int)sharedGameController.player.currentLocation.x / 40 - 1][(int)sharedGameController.player.currentLocation.y / 40]) - 1];
        }
    }
    if (sharedGameController.player != nil && stage == 73) {
        if (sharedGameController.player.currentLocation.x > 1800) {
            [self moveToNextStageInScene];
        }
    }
}

@end
