//
//  ChapterOneDemoTestV2.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/18/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "ChapterOneDemoTestV2.h"
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
#import "StringWithDuration.h"
#import "AbstractBattleEnemy.h"
#import "BattleSwordMan.h"
#import "BattleAxeMan.h"
#import "BattlePriest.h"
#import "NPCBrownHairedRoderick.h"
#import "NPCBlondeHairedRoderick.h"
#import "NPCBlackHairedRoderick.h"
#import "NPCRedHairedRoderick.h"
#import "NPCEnemyAxeMan.h"
#import "NPCEnemySwordMan.h"
#import "NPCVolur.h"
#import "NPCRatatosk.h"
#import "OldMan.h"
#import "EnemyChampion.h"
#import "Surt.h"
#import "BattleRoderick.h"
#import "Robo.h"
#import "Roderick.h"
#import "Valkyrie.h"
#import "CameraMan.h"
#import "Textbox.h"
#import "Choicebox.h"
#import "FadeInOrOut.h"
#import "WorldFlashColor.h"
#import "Global.h"
#import "Alfheim.h"
#import "WalkingAroundTutorial.h"
#import "RoderickBattleTutorial.h"

//Used for testing
#import "ChapterOneDemoTest.h"

@implementation ChapterOneDemoTestV2

@synthesize roderickBattleTutorial;

- (void)dealloc {
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        battleImage = [[Image alloc] initWithImageNamed:@"jotunheim.png" filter:GL_LINEAR];
        battleFont = [sharedFontManager getFontWithKey:@"battleFont"];
        sceneMap = [[TiledMap alloc] initWithFileName:@"SnowyCamp" fileExtension:@"tmx"];
        [sharedSoundManager loadMusicWithKey:@"battle" musicFile:@"battle mode.mp3"];
        [sharedSoundManager loadMusicWithKey:@"opening" musicFile:@"opening cut until battle-1.mp3"];
        [sharedSoundManager loadMusicWithKey:@"RoderickTheme" musicFile:@"Roderick's Theme.mp3"];
        [sharedSoundManager loadMusicWithKey:@"RoderickDead" musicFile:@"hero cutscene.mp3"];
        sharedGameController.realm = kRealm_ChapterOneCamp;
        [self createCollisionMapArray];
        [self createPortalsArray];
        sharedGameController.gameState = kGameState_Cutscene;
        cameraPosition = CGPointMake(0, 0);
        allowBattles = NO;
        stage = -1;
        cutScene = YES;
        cutSceneTimer = 0.5;
        roderickHasDied = NO;
    }
    
    return self;
}

- (void)updateSceneWithDelta:(float)aDelta {
    
    [super updateSceneWithDelta:aDelta];
    //if (sharedGameController.player != nil) {
      //  [self checkForPortal];
    //}
    
}

- (void)moveToNextStageInScene {
    
    switch (stage) {
        case -1:
            stage++;
            [sharedSoundManager playMusicWithKey:@"opening" timesToRepeat:-1];
            sharedGameController.realm = kRealm_ChapterOneCamp;
            [StringWithDuration narrativeString:@"An oath was sworn by all living things not to harm the god Baldur." withDuration:5];
            cutSceneTimer = 6.5;
            doNotUpdate = NO;
            break;
        case 0:
            stage++;
            [StringWithDuration narrativeString:@"But Locki found a way. During a game, Locki tricked Hodur into killing Baldur." withDuration:5];
            cutSceneTimer = 6.5;
            break;
        case 1:
            stage++;
            [StringWithDuration narrativeString:@"In the realm of the living, Roderick and his Nyrmidons have been engaged in war with the Nillians for far too long." withDuration:6];
            cutSceneTimer = 7.5;
            break;
        case 2:
            stage++;
            [StringWithDuration narrativeString:@"In a world where even invincible gods fall, what hope is there for man..." withDuration:5];
            cutSceneTimer = 6.5;
            break;
        case 3:
            stage++;
            NSLog(@"trying to figure out what's crashing.");
            [FadeInOrOut fadeInWithDuration:2];
            CameraMan *cm = [[CameraMan alloc] initAtLocation:CGPointMake(1120, 3400)];
            sharedGameController.player = cm;
            NSLog(@"Fade out works.");
            cameraPosition = CGPointMake(27, 85);
            ParticleEmitter *mapFireEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"MapFireEmitter.pex"];
            mapFireEmitter.sourcePosition = Vector2fMake(425, 3185);
            [self addEntityToActiveEntities:mapFireEmitter];
            [mapFireEmitter release];
            NSLog(@"fire emitter works.");
            //NPCBlondeHairedRoderick *blohr = [[NPCBlondeHairedRoderick alloc] initAtLocation:CGPointMake(460, 3200)];
            NPCBlondeHairedRoderick *blohr = [[NPCBlondeHairedRoderick alloc] initAtTile:CGPointMake(11, 79)];
            NSLog(@"Blonde alloc inited");
            [blohr faceLeft];
            NSLog(@"Face left works.");
            [self addEntityToActiveEntities:blohr];
            NSLog(@"adding to entities works.");
            [blohr release];
            NSLog(@"Blonde one works.");
            //NPCBrownHairedRoderick *brhr = [[NPCBrownHairedRoderick alloc] initAtLocation:CGPointMake(380, 3200)];
            NPCBrownHairedRoderick *brhr = [[NPCBrownHairedRoderick alloc] initAtTile:CGPointMake(9, 79)];
            [brhr faceRight];
            [self addEntityToActiveEntities:brhr];
            [brhr release];
            //NPCBlackHairedRoderick *blahr = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(640, 3200)];
            NPCBlackHairedRoderick *blahr = [[NPCBlackHairedRoderick alloc] initAtTile:CGPointMake(16, 79)];
            
            //[blahr moveToPoint:CGPointMake(480, 3320) duration:4];
            [blahr moveToTile:CGPointMake(11, 82) duration:4];
            [self addEntityToActiveEntities:blahr];
            sharedGameController.gameState = kGameState_World;
            [cm moveWithMapToPoint:CGPointMake(480, 3200) duration:4];
            [self addEntityToActiveEntities:cm];
            [cm release];
            cutSceneTimer = 4;
            NSLog(@"Gets to the end of stage 3.");
            break;
        case 4:
            stage++;
            NSLog(@"moves to stage 4.");
            [sharedGameController.player moveWithMapToPoint:CGPointMake(240, 3160) duration:2];
            cutSceneTimer = 2;
            break;
        case 5:
            stage++;
            NSLog(@"Moves to stage 5.");
            [FadeInOrOut fadeOutWithDuration:2];
            cutSceneTimer = 2;
            break;
        case 6:
            stage++;
            NSLog(@"Moves to stage 6.");
            [super removeDrawingImages];
            //Roderick *roderick = [[Roderick alloc] initAtLocation:CGPointMake(2600, 3120)];
            Roderick *roderick = [[Roderick alloc] initAtTile:CGPointMake(64, 78)];
            sharedGameController.player = roderick;
            [super setCameraPosition:CGPointMake(64.5 * 40, 78.5 * 40)];
            NPCRedHairedRoderick *rhr = [[NPCRedHairedRoderick alloc] initAtTile:CGPointMake(62, 78)];
            [self addEntityToActiveEntities:roderick];
            [self addEntityToActiveEntities:rhr];
            FadeInOrOut *fadeIn = [[FadeInOrOut alloc] initFadeInWithDuration:2];
            [self addObjectToActiveObjects:fadeIn];
            [fadeIn release];
            cutSceneTimer = 2;
            cutScene = YES;
            break;
        case 7:
            stage++;
            [Textbox textboxWithText:@"Red: We've been fighting for so long that I've forgotten what we are fighting for."];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 8:
            stage++;
            //[sharedGameController.player moveToPoint:CGPointMake(sharedGameController.player.currentLocation.x, sharedGameController.player.currentLocation.y + 60) duration:1];
            [sharedGameController.player moveToTile:CGPointMake(sharedGameController.player.currentTile.x, sharedGameController.player.currentTile.y + 2) duration:1];
            [Textbox textboxWithText:@"Roderick: We fight for our freedom. Never forget that it was not us Nyrmidons who started this war."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 9:
            stage++;
            [sharedGameController.player faceDown];
            [Textbox textboxWithText:@"Roderick: The Nillians will stop at nothing to wrest Helga from us. Nevermind she married my brother of her own free will."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 10:
            stage++;
            [Textbox textboxWithText:@"Red: But is it worth it? How is one Nillian woman worth all this loss and death?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 11:
            stage++;
            [Textbox textboxWithText:@"Roderick: Perhaps it's not. But we have no choice now. The war has already been brought to us. All that's left is to win it."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 12:
            stage++;
            [Textbox textboxWithText:@"Roderick: Tell the men to prepare. I feel the Nillians will surge tomorrow."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 13:
            stage++;
            [Textbox textboxWithText:@"Red: Yes your highness."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 14:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isKindOfClass:[NPCRedHairedRoderick class]]) {
                    //[entity moveToPoint:CGPointMake(2590, 3120) duration:1];
                    [entity moveToTile:CGPointMake(64, 78) duration:1];
                }
            }
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 15:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isKindOfClass:[NPCRedHairedRoderick class]]) {
                    //[entity moveToPoint:CGPointMake(2590, 3040) duration:1.5];
                    [entity moveToTile:CGPointMake(64, 75) duration:1.5];
                }
            }
            cutScene = YES;
            cutSceneTimer = 1.5;
            break;
        case 16:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isKindOfClass:[NPCRedHairedRoderick class]]) {
                    [entity fadeOut];
                }
            }
            [Textbox textboxWithText:@"May the gods protect us on the field tomorrow. I feel we shall need their help."];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 17:
            stage++;
            [FadeInOrOut fadeOutWithDuration:2];
            cutScene = YES;
            cutSceneTimer = 2;
            break;
        case 18:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            CameraMan *cameraman = [[CameraMan alloc] init];
            sharedGameController.player = cameraman;
            cameraman.currentLocation = CGPointMake(400, 400);
            cameraPosition = CGPointMake(0, 0);
            [StringWithDuration narrativeString:@"Though he beseeches help, none shall come for Roderick. The gods are too busy lamenting the death of Baldur." withDuration:6];
            cutSceneTimer = 7.5;
            break;
        case 19:
            stage++;
            [activeEntities removeAllObjects];
            cameraPosition = CGPointMake(70, 70);
            [FadeInOrOut fadeInWithDuration:2];
            cutSceneTimer = 2;
            //Valkyrie *valk = [[Valkyrie alloc] initAtLocation:CGPointMake(2800, 2800)];
            Valkyrie *valk = [[Valkyrie alloc] initAtTile:CGPointMake(70, 70)];
            sharedGameController.player = valk;
            [self addEntityToActiveEntities:valk];
            //OldMan *oldMan = [[OldMan alloc] initAtLocation:CGPointMake(2880, 2880)];
            OldMan *oldMan = [[OldMan alloc] initAtTile:CGPointMake(72, 72)];
            oldMan.triggerNextStage = YES;
            [oldMan setWanderInRect:CGRectMake(67, 67, 10, 8)];
            [self addEntityToActiveEntities:oldMan];
            [oldMan release];
            // Init god entities here.
            break;
        /*case 20:
            stage++;
            cutScene = NO;
            for (AbstractEntity *entity in activeEntities) {
                //NSLog(@"Entity's tile is (%f, %f).", entity.currentTile.x, entity.currentTile.y);
            }
            [Textbox textboxWithText:@"You can now control a valkyrie. To move touch and hold the left or right edges of the screen."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 21:
            stage++;
            [Textbox textboxWithText:@"You can combine your right and left thumbs for directions. Hold both down towards the top to move up and towards the bottom to move down."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 22:
            stage++;
            [Textbox textboxWithText:@"Tap towards the middle of the screen to interact with the world around your character."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;*/
        case 20:
            stage = 23;
            cutScene = NO;
            [WalkingAroundTutorial loadWalkingAroundTutorial];
            break;
        case 23:
            stage = 1000;
            sharedGameController.gameState = kGameState_World;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 1000:
            stage = 24;
            [Textbox textboxWithText:@"Old man: Valkyrie, I sense a darkness upon you exceeding the loss of Baldur."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 24:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: This tragedy... it feels  like the world has changed."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 25:
            stage++;
            [Textbox textboxWithText:@"Old man: Perhaps that's because it has. The old stories tell that this may be a sign."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 26:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: A sign...? A sign of what."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 27:
            stage++;
            [Textbox textboxWithText:@"Old man: Of the end of days. Ragnarok."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 28:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Ragnarok?! Then truly this is a doom that has befallen us."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 29:
            stage++;
            [Textbox textboxWithText:@"Old man: Perhaps. I must consult the ancient tales, and so long as this war rages among the Nyrmidons and Nillians, you have your work to attend to as well."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 30:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: It is a busy time in Asgard isn't it."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 31:
            stage++;
            [FadeInOrOut fadeOutWithDuration:2];
            cutScene = YES;
            cutSceneTimer = 2;
            break;
        case 32:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            for (int i = 0; i < 12; i++) {
                NPCRedHairedRoderick *nrhr = [[NPCRedHairedRoderick alloc] initAtLocation:CGPointMake(1560, 3260 - (30 * i))];
                NPCBlackHairedRoderick *nblahr = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(1520, 3260 - (30 * i))];
                NPCBlondeHairedRoderick *nblohr = [[NPCBlondeHairedRoderick alloc] initAtLocation:CGPointMake(1480, 3260 - (30 * i))];
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
            Roderick *rod = [[Roderick alloc] initAtLocation:CGPointMake(1600, 3120)];
            sharedGameController.player = rod;
            sharedGameController.gameState = kGameState_Cutscene;
            [self addEntityToActiveEntities:rod];
            [rod release];
            [self setCameraPosition:CGPointMake(42.5 * 40, 78.5 * 40)];    
            [FadeInOrOut fadeInWithDuration:2];
            cutSceneTimer = 2;
            break;
        case 33:
            stage++;
            cutScene = NO;
            [sharedGameController.player moveToPoint:CGPointMake(1600, 3260) duration:2.5];
            [Textbox textboxWithText:@"Roderick: Stand your ground men. The Nillians approach. Let's show them what the Nyrmidons are made of!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 34:
            stage++;
            for (int xi = 0; xi < 12; xi++) {
                float firstRow = RANDOM_0_TO_1();
                float secondRow = RANDOM_0_TO_1();
                float thirdRow = RANDOM_0_TO_1();
                AbstractEntity *firstEntity;
                AbstractEntity *secondEntity;
                AbstractEntity *thirdEntity;
                if (firstRow < 0.5) {
                    firstEntity = [[NPCEnemyAxeMan alloc] initAtLocation:CGPointMake(2000, 3300 - (xi * 40))];
                } else {
                    firstEntity = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(2000, 3300 - (xi * 40))];
                }
                if (secondRow < 0.5) {
                    secondEntity = [[NPCEnemyAxeMan alloc] initAtLocation:CGPointMake(2040, 3300 - (xi * 40))];
                } else {
                    secondEntity = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(2040, 3300 - (xi * 40))];
                }
                if (thirdRow < 0.5) {
                    thirdEntity = [[NPCEnemyAxeMan alloc] initAtLocation:CGPointMake(2080, 3300 - (xi * 40))];
                } else {
                    thirdEntity = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(2080, 3300 - (xi * 40))];
                }
                [firstEntity moveToPoint:CGPointMake(firstEntity.currentLocation.x - 160, firstEntity.currentLocation.y) duration:2];
                [secondEntity moveToPoint:CGPointMake(secondEntity.currentLocation.x - 160, firstEntity.currentLocation.y) duration:2];
                [thirdEntity moveToPoint:CGPointMake(thirdEntity.currentLocation.x - 160, firstEntity.currentLocation.y) duration:2];
                [self addEntityToActiveEntities:firstEntity];
                [self addEntityToActiveEntities:secondEntity];
                [self addEntityToActiveEntities:thirdEntity];
                [firstEntity release];
                [secondEntity release];
                [thirdEntity release];
            }
            [sharedGameController.player moveToPoint:CGPointMake(1600, 3120) duration:1];
            [Textbox textboxWithText:@"Roderick: Here we are men!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 35:
            stage++;
            [Textbox timedTextboxWithText:@"Roderick: Attack!" andDuration:1.8];
            Character *roder = [sharedGameController.characters objectForKey:@"Roderick"];
            [sharedGameController.party addObject:roder];
            cutScene = YES;
            cutSceneTimer = 0.3;
            break;
        case 36:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                [entity moveToPoint:CGPointMake(1720, entity.currentLocation.y) duration:1.5];
            }
            cutSceneTimer = 1.3;
            break;
        case 37:
            stage = 46;
            cutScene = NO;
            //[self initBattle];
            [sharedSoundManager playMusicWithKey:@"battle" timesToRepeat:-1];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            NSLog(@"Begin tutorial loading");
            [RoderickBattleTutorial loadRoderickBattleTutorial];
            NSLog(@"End tutorial loading.");
            //[Textbox centerTextboxWithText:@"This is the battle screen. Battles here work a little differently than what you might be used to."];
            break;
        /*case 38:
            stage++;
            [Textbox centerTextboxWithText:@"At the beginning of battle you can select a character. You don't have many choices now so go ahead and select Roderick by tapping him."];
            [sharedInputManager setState:kNoTouchesAllowed];
            cutScene = YES;
            cutSceneTimer = 0.2;
            break;
        case 39:
            stage++;
            [Textbox centerTextboxWithText:@"At the beginning of battle you can select a character. You don't have many choices now so go ahead and select Roderick by tapping him."];
            cutScene = NO;
            [sharedInputManager setStateMustTapRect:CGRectMake(10, 230, 50, 80)];
            break;
        case 40:
            stage++;
            for (BattleRoderick *br in activeEntities) {
                if ([br isKindOfClass:[BattleRoderick class]]) {
                    [br gainPriority];
                }
            }
            [Textbox centerTextboxWithText:@"Great! Now that Roderick is selected you can attack your enemies. Roderick attacks by slashing. Go ahead and slash through the enemy to attack."];
            roderickBattleTutorial = YES;
            [sharedInputManager setState:kRoderick];
            break;
        case 41:
            stage++;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            [self removeTextbox];
            [Textbox centerTextboxWithText:@"Excellent! Every time Roderick attacks, he loses some stamina. Having less stamina makes attacks weaker. Try to strike a balance between attacking multiple times and attacking with high stamina."];
            roderickBattleTutorial = NO;
            break;
        case 42:
            stage++;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            [Textbox centerTextboxWithText:@"Ok. I think you're ready to take on this enemy soldier. Tap the screen when you're ready and defeat him!"];
            break;
        case 43:
            stage++;
            for (AbstractBattleEnemy *enemy in activeEntities) {
                if ([enemy isMemberOfClass:[BattleSwordMan class]]) {
                    BattleSwordMan *bsm = enemy;
                    bsm.shouldAttack = YES;
                }
                if ([enemy isMemberOfClass:[BattleAxeMan class]]) {
                    BattleSwordMan *bam = enemy;
                    bam.shouldAttack = YES;
                }
            }
            [sharedInputManager setState:kRoderick];
            break;
        case 44:
            stage++;
            [Textbox centerTextboxWithText:@"This is the experience screen. Whenever you win a battle Roderick will become stronger."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 45:
            stage++;
            [sharedInputManager setState:kBattleExperienceScreen];
            break;*/
        case 46:
            stage++;
            sharedGameController.gameState = kGameState_World;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCBlackHairedRoderick class]] || [entity isMemberOfClass:[NPCBlondeHairedRoderick class]] || [entity isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    entity.currentLocation = CGPointMake(1480 + (40 * (11 * RANDOM_0_TO_1())), 3220 - (40 * (6 * RANDOM_0_TO_1())));
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x + 20, entity.currentLocation.y) duration:3];
                }
                if ([entity isMemberOfClass:[NPCEnemyAxeMan class]] || [entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                    entity.currentLocation = CGPointMake(1500 + (40 * (11 * RANDOM_0_TO_1())), 3220 - (40 * (6 * RANDOM_0_TO_1())));
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x - 20, entity.currentLocation.y) duration:3];
                }
            }
            cutScene = YES;
            cutSceneTimer = 2;
            break;
        case 47:
            stage = 1001;
            [self initBattle];
            cutScene = NO;
            break;
        case 1001:
            stage = 48;
            break;
        case 48:
            stage++;
            [sharedSoundManager playMusicWithKey:@"RoderickTheme" timesToRepeat:-1];
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            sharedGameController.player.active = YES;
            [super removeInactiveEntities];
            //sharedGameController.player.currentTile = CGPointMake(14, 79);
            sharedGameController.player.currentLocation = CGPointMake(580, 3180);
            //NPCBlondeHairedRoderick *blohr2 = [[NPCBlondeHairedRoderick alloc] initAtLocation:CGPointMake(440, 3200)];
            NPCBlondeHairedRoderick *blohr2 = [[NPCBlondeHairedRoderick alloc] initAtTile:CGPointMake(11, 79)];
            [blohr2 faceLeft];
            blohr2.message = @"Please don't make us go back out there. This was truly a terrible day.";
            [self addEntityToActiveEntities:blohr2];
            [blohr2 release];
            //NPCBrownHairedRoderick *brhr2 = [[NPCBrownHairedRoderick alloc] initAtLocation:CGPointMake(360, 3200)];
            NPCBrownHairedRoderick *brhr2 = [[NPCBrownHairedRoderick alloc] initAtTile:CGPointMake(9, 79)];
            [brhr2 faceRight];
            brhr2.message = @"That battle was terrible. I cannot believe the Nillians' power.";
            [self addEntityToActiveEntities:brhr2];
            [brhr2 release];
            //NPCBlackHairedRoderick *blahr2 = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(120, 2560)];
            NPCBlackHairedRoderick *blahr2 = [[NPCBlackHairedRoderick alloc] initAtTile:CGPointMake(3, 63)];
            [blahr2 faceDown];
            blahr2.message = @"We will care for the wounded in this tent your highness. Don't you worry, we will do our best!";
            [self addEntityToActiveEntities:blahr2];
            [blahr2 release];
            //NPCBrownHairedRoderick *soldierInTent = [[NPCBrownHairedRoderick alloc] initAtLocation:CGPointMake(800, 2600)];
            NPCBrownHairedRoderick *soldierInTent = [[NPCBrownHairedRoderick alloc] initAtTile:CGPointMake(20, 64)];
            soldierInTent.message = @"The Nillians! Who knew they were so powerful. It was like fighting a bear.";
            [self addEntityToActiveEntities:soldierInTent];
            [soldierInTent release];
            //NPCRedHairedRoderick *red = [[NPCRedHairedRoderick alloc] initAtLocation:CGPointMake(2520, 3160)];
            NPCRedHairedRoderick *red = [[NPCRedHairedRoderick alloc] initAtTile:CGPointMake(63, 78)];
            red.triggerNextStage = YES;
            [self addEntityToActiveEntities:red];
            [red release];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isKindOfClass:[AbstractEntity class]]) {
                    //NSLog(@"Entity's current tile is (%f, %f).", entity.currentTile.x, entity.currentTile.y);
                }
            }
            break;
        case 49:
            stage++;
            [Textbox textboxWithText:@"Red: The Nillians seem to have gotten more powerful. How can we hope to defeat them?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            sharedGameController.gameState = kGameState_Cutscene;
            break;
        case 50:
            stage++;
            [Textbox textboxWithText:@"Roderick: So many dead..."];
            //[sharedGameController.player moveToPoint:CGPointMake(sharedGameController.player.currentLocation.x + 80, 3160) duration:1];
            [sharedGameController.player moveToTile:CGPointMake(sharedGameController.player.currentTile.x + 2, 78) duration:1];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 51:
            stage++;
            [Textbox textboxWithText:@"Roderick: It's time to end this war. We won't survive much more of this constant onslaught."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 52:
            stage++;
            [Textbox textboxWithText:@"Red: How do you propose to do that?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 53:
            stage++;
            [Textbox textboxWithText:@"Roderick: Send a messenger to their camp. Tell them I will face their champion Hektir in one on one combat. The winner's side will be the victor in this war."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 54:
            stage++;
            [Textbox textboxWithText:@"Red: Hektir?! But he's unbeatable!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 55:
            stage++;
            [Textbox textboxWithText:@"Roderick: They used to say the same about me. We'll have two unbeatable foes meet tomorrow and let the gods sort them out."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 56:
            stage++;
            [Textbox textboxWithText:@"Red: Very well your highness. May the gods save us..."];
            [sharedInputManager setState:kNoTouchesAllowed];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 57:
            stage++;
            [FadeInOrOut fadeOutWithDuration:2];
            cutSceneTimer = 2;
            break;
        case 58:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            sharedGameController.player.active = YES;
            sharedGameController.player.currentLocation = CGPointMake(1600, 3120);
            
            [self removeTextbox];
            [FadeInOrOut fadeInWithDuration:2];
            for (int i = 0; i < 12; i++) {
                NPCRedHairedRoderick *nrhr = [[NPCRedHairedRoderick alloc] initAtLocation:CGPointMake(1560, 3260 - (30 * i))];
                NPCBlackHairedRoderick *nblahr = [[NPCBlackHairedRoderick alloc] initAtLocation:CGPointMake(1520, 3260 - (30 * i))];
                NPCBlondeHairedRoderick *nblohr = [[NPCBlondeHairedRoderick alloc] initAtLocation:CGPointMake(1480, 3260 - (30 * i))];
                [nrhr faceRight];
                [nblahr faceRight];
                [nblohr faceRight];
                if (RANDOM_0_TO_1() < 0.66) {
                    [self addEntityToActiveEntities:nrhr];
                }
                if (RANDOM_0_TO_1() < 0.66) {
                    [self addEntityToActiveEntities:nblahr];
                }
                if (RANDOM_0_TO_1() < 0.66) {
                    [self addEntityToActiveEntities:nblohr];
                }
                [nrhr release];
                [nblahr release];
                [nblohr release];
            }
            for (int xi = 0; xi < 12; xi++) {
                float firstRow = RANDOM_0_TO_1();
                float secondRow = RANDOM_0_TO_1();
                float thirdRow = RANDOM_0_TO_1();
                AbstractEntity *firstEntity;
                AbstractEntity *secondEntity;
                AbstractEntity *thirdEntity;
                if (firstRow < 0.5) {
                    firstEntity = [[NPCEnemyAxeMan alloc] initAtLocation:CGPointMake(2000, 3300 - (xi * 40))];
                } else {
                    firstEntity = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(2000, 3300 - (xi * 40))];
                }
                if (secondRow < 0.5) {
                    secondEntity = [[NPCEnemyAxeMan alloc] initAtLocation:CGPointMake(2040, 3300 - (xi * 40))];
                } else {
                    secondEntity = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(2040, 3300 - (xi * 40))];
                }
                if (thirdRow < 0.5) {
                    thirdEntity = [[NPCEnemyAxeMan alloc] initAtLocation:CGPointMake(2080, 3300 - (xi * 40))];
                } else {
                    thirdEntity = [[NPCEnemySwordMan alloc] initAtLocation:CGPointMake(2080, 3300 - (xi * 40))];
                }
                [firstEntity moveToPoint:CGPointMake(firstEntity.currentLocation.x - 160, firstEntity.currentLocation.y) duration:2];
                [secondEntity moveToPoint:CGPointMake(secondEntity.currentLocation.x - 160, firstEntity.currentLocation.y) duration:2];
                [thirdEntity moveToPoint:CGPointMake(thirdEntity.currentLocation.x - 160, firstEntity.currentLocation.y) duration:2];
                [self addEntityToActiveEntities:firstEntity];
                [self addEntityToActiveEntities:secondEntity];
                [self addEntityToActiveEntities:thirdEntity];
                [firstEntity release];
                [secondEntity release];
                [thirdEntity release];
            }
            sharedGameController.gameState = kGameState_Cutscene;
            [self setCameraPosition:CGPointMake(42.5 * 40, 78.5 * 40)];
            cutSceneTimer = 2;
            break;
        case 59:
            stage++;
            [Textbox textboxWithText:@"Hektir! Hektir! Hektir!"];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 60:
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
        case 61:
            stage++;
            cutScene = NO;
            [Textbox textboxWithText:@"Hektir: Roderick, prepare to meet your doom."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 62:
            sharedGameController.realm = kRealm_ChapterOneChampionBattle;
            [self initBattle];
            [sharedSoundManager playMusicWithKey:@"battle" timesToRepeat:-1];
            break;
        case 63:
            stage++;
            cutScene = NO;
            [self restoreMap];
            [sharedSoundManager playMusicWithKey:@"RoderickDead" timesToRepeat:-1];
            break;
        case 64:
            stage++;
            sharedGameController.player.currentAnimation.currentFrameImage.rotation = 270;
            [FadeInOrOut fadeInWithDuration:2];
            cutScene = YES;
            cutSceneTimer = 2;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCRedHairedRoderick class]] || [entity isMemberOfClass:[NPCBlackHairedRoderick class]] || [entity isMemberOfClass:[NPCBlondeHairedRoderick class]]) {
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x + (fabsf(entity.currentLocation.y - 3120) / 2), entity.currentLocation.y) duration:1];
                }
            }
            [Textbox textboxWithText:@"Your highness!"];
            break;
        case 65:
            stage++;
            [self removeTextbox];
            [Textbox textboxWithText:@"What will we do now?"];
            [FadeInOrOut fadeOutWithDuration:3];
            cutSceneTimer = 3;
            break;
        case 66:
            stage++;
            //[sharedGameController.party addObject:[sharedGameController.characters objectForKey:@"Roderick"]];
            [self removeTextbox];
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            sharedGameController.player.active = YES;
            [self removeInactiveEntities];
            Roderick *deadRod = [[Roderick alloc] initAtTile:CGPointMake(3, 10)];
            sharedGameController.player = deadRod;
            cameraPosition = deadRod.currentTile;
            [self addEntityToActiveEntities:deadRod];
            [deadRod release];
            [FadeInOrOut fadeInWithDuration:2];
            cutSceneTimer = 2;
            break;
        case 67:
            stage++;
            [Textbox textboxWithText:@"Roderick: Where am I? What is this place...?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            cutScene = NO;
            break;
        case 68:
            stage++;
            [WorldFlashColor worldFlashColor:Yellow];
            cutScene = YES;
            cutSceneTimer = 0.6;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 69:
            stage++;
            Valkyrie *valkyrie = [[Valkyrie alloc] initAtTile:CGPointMake(0, 15)];
            [valkyrie moveToTile:CGPointMake(3, 11) duration:2];
            [self addEntityToActiveEntities:valkyrie];
            [valkyrie release];
            cutSceneTimer = 2;
            break;
        case 70:
            stage++;
            cutScene = NO;
            [sharedGameController.player faceUp];
            [Textbox textboxWithText:@"Roderick: Who or what are you? Where am I? What's going on?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 71:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: You disappoint me Roderick. You've disappointed all of us."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 72:
            stage++;
            [Textbox textboxWithText:@"Roderick: What do you mean disappoint? I don't even know who you are. The last thing I remember is facing Hektir in battle and then..."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 73:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: And then you lost. You lost Roderick. You lost a battle that you should have won, and now your Nyrmidons are doomed to serve the Nillians."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 74:
            stage++;
            [sharedGameController.player faceDown];
            [Textbox textboxWithText:@"Roderick: I-I lost? But how is that possible? I the mighty Roderick."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 75:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Exactly! The mighty Roderick has fallen. Now we cannot even welcome you into Valhalla."];
            [sharedGameController.player faceUp];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 76:
            stage++;
            [Textbox textboxWithText:@"Roderick: We? So you must be a Valkyrie then."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 77:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Indeed."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 78:
            stage++;
            [Textbox textboxWithText:@"Roderick: But if you're not here to take me to Valhalla, why are you here?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 79:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: I am charged with taking you to join your fellow failed warriors in Helheim."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 80:
            stage++;
            [Textbox textboxWithText:@"Roderick: So that is my doom then? Very well, I shall not fight it. How do we get there?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 81:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: First we must travel East to Yggdrassil, the tree of life. There will be angry spirits along the way, but that is why I am here."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 82:
            stage++;
            [Textbox textboxWithText:@"Roderick: Very well, lead the way."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 83:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            sharedGameController.player.active = YES;
            [sharedGameController.player teleportToTile:CGPointMake(16, 9)];
            cameraPosition = CGPointMake(sharedGameController.player.currentTile.x + 0.5, sharedGameController.player.currentTile.y + 0.5); 
            [FadeInOrOut fadeInWithDuration:2];
            cutScene = YES;
            cutSceneTimer = 2;
            break;
        case 84:
            stage++;
            cutScene = NO;
            Valkyrie *characterValkyrie = [sharedGameController.characters objectForKey:@"Valkyrie"];
            [sharedGameController.party addObject:characterValkyrie];
            sharedGameController.realm = kRealm_Midgard;
            sharedGameController.gameState = kGameState_World;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 85:
            stage++;
            [self initBattle];
            [sharedSoundManager playMusicWithKey:@"battle" timesToRepeat:-1];
            allowBattles = YES;
            for (AbstractBattleEnemy *enemy in activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                    enemy.wait = YES;
                    enemy.waitTimer = -1;
                }
            }
            [sharedInputManager setStateMustTapRect:[[sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"] getRect]];
            [Textbox centerTextboxWithText:@"The Valkyrie will now help you in battle. Select her just like you would Roderick."];
            break;
        case 86:
            stage++;
            [Textbox centerTextboxWithText:@"Great! The Valkyrie attacks by tapping enemis. Go ahead and tap the screen to get rid of this dialog box and then tap some enemies."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 87:
            stage++;
            [sharedInputManager setState:kValkyrie];
            cutScene = YES;
            cutSceneTimer = 3;
            break;
        case 88:
            stage++;
            cutScene = NO;
            [sharedInputManager setState:kValkyrie];
            [Textbox centerTextboxWithText:@"In addition to attacks, the Valkyrie will also exact revenge on your enemies. You can set the Valkyrie's 'Rage' target by drawing a line from her to an enemy. Try it now."];
            break;
        case 89:
            stage++;
            [self removeTextbox];
            cutScene = YES;
            cutSceneTimer = 1.5;
            break;
        case 90:
            stage++;
            cutScene = NO;
            [Textbox centerTextboxWithText:@"When you link to an enemy, the Valkyrie has a chance to perform a rage attack. When the rage meter refills, she'll perform a rage attack again."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 91:
            stage++;
            [Textbox centerTextboxWithText:@"Tap the screen when you're ready to start this battle."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 92:
            stage++;
            [sharedInputManager setState:kValkyrie];
            for (AbstractBattleEnemy *enemy in activeEntities) {
                if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                    enemy.wait = NO;
                }
            }
            [sharedInputManager setState:kValkyrie];
            //for (int i = 0; i < 50; i++) {
              //  [[sharedGameController.characters objectForKey:@"Roderick"] levelUp];
                //[[sharedGameController.characters objectForKey:@"Valkyrie"] levelUp];
            //}
            break;
        case 93:
            stage++;
            [self moveToNextStageInScene];
            break;
        case 94:
            stage++;
            allowBattles = NO;
            [FadeInOrOut fadeOutWithDuration:1];
            [sharedGameController.player fadeOut];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 95:
            stage++;
            [sharedGameController.player stopMoving];
            [sharedGameController.player teleportToTile:CGPointMake(68, 19)];
            cameraPosition = CGPointMake(68.5, 19.5);
            [sharedGameController.player fadeIn];
            [FadeInOrOut fadeInWithDuration:1];
            cutScene = NO;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            allowBattles = NO;
            break;
        case 96:
            stage++;
            Valkyrie *alex = [[Valkyrie alloc] initAtLocation:CGPointMake(sharedGameController.player.currentLocation.x, sharedGameController.player.currentLocation.y)];
            [sharedGameController.player stopMoving];
            [alex fadeIn];
            [alex moveToPoint:CGPointMake(alex.currentLocation.x, alex.currentLocation.y - 40) duration:1];
            [self addEntityToActiveEntities:alex];
            [alex release];
            sharedGameController.gameState = kGameState_Cutscene;
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 97:
            stage++;
            for (AbstractEntity *valk in activeEntities) {
                if ([valk isMemberOfClass:[Valkyrie class]]) {
                    [valk faceUp];
                }
            }
            [sharedGameController.player faceDown];
            [Textbox textboxWithText:@"Valkyrie: We should find the entrance to Helheim here. One of the roots of Yggdrassil leads to that realm."];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 98:
            stage++;
            for (AbstractEntity *valk in activeEntities) {
                if ([valk isMemberOfClass:[Valkyrie class]]) {
                    [valk faceRight];
                }
            }
            [Textbox textboxWithText:@"Valkyrie: It's around here somewhere, it's just been a while since I've used it."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 99:
            stage = 101;
            [sharedGameController.player faceRight];
            NPCVolur *volur = [[NPCVolur alloc] initAtTile:CGPointMake(85, 19)];
            [volur fadeIn];
            [volur moveToTile:CGPointMake(83, 19) duration:1]; 
            [self addEntityToActiveEntities:volur];
            [volur release];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 101:
            stage++;
            cutScene = NO;
            [Textbox textboxWithText:@"Volur: Winged one. Why do you seek passage below?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 102:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: This warrior failed his duty in battle. It is now my duty to usher him to Helheim. What concern is it of yours, Volur?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 103:
            stage++;
            [Textbox textboxWithText:@"Volur: To Helheim? Surely you are aware of the death of Baldur. You must take this warrior to Asgard."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 104:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: The death of Baldur is no reason to abandon my code Volur. Now get out of the way."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 105:
            stage++;
            [Textbox textboxWithText:@"Volur: We cannot allow that. We know not yet if he is he, but you must bring him above to Asgard."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 106:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: I answer to Freya not to you and your visions. Our path is determined."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 107:
            stage++;
            [Textbox textboxWithText:@"Volur: We know of your allegiance, but if you fail to bring him to Asgard, you may be dooming all of the gods including Freya."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 108:
            stage++;
            [Textbox textboxWithText:@"Volur: And besides, all that you lose by going to Asgard first is time. He and you both have plenty of that now."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 109:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Doom all of the gods you say? What have you seen."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 110:
            stage++;
            [Textbox textboxWithText:@"Volur: The Old man may be correct. We too have seen the end of days... Ragnarok."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 111:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: You know the Old man. Who is he?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 112:
            stage++;
            [Textbox textboxWithText:@"Volur: We call him Wu. We know no more than that, but in Asgard you may find more answers."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 113:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: So be it Volur. I will take this warrior to Asgard if you'll let us ride upon Ratatosk."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 114:
            stage++;
            [Textbox textboxWithText:@"Volur: Your request is granted. Ratatosk!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            NPCRatatosk *ratatosk = [[NPCRatatosk alloc] initAtLocation:CGPointMake(sharedGameController.player.currentLocation.x + 300, sharedGameController.player.currentLocation.y + 200)];
            [ratatosk moveToTile:CGPointMake(sharedGameController.player.currentTile.x + 1, sharedGameController.player.currentTile.y) duration:1];
            [ratatosk fadeIn];
            [self addEntityToActiveEntities:ratatosk];
            [ratatosk release];
            break;
        case 115:
            stage++;
            NSLog(@" Got here.");

            [Textbox textboxWithText:@"Volur: Take these two to Asgard."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 116:
            stage++;
            for (AbstractEntity *valk in activeEntities) {
                if ([valk isMemberOfClass:[Valkyrie class]]) {
                    [valk moveToTile:CGPointMake(sharedGameController.player.currentTile.x, sharedGameController.player.currentTile.y) duration:1];
                    [valk fadeOut];
                }
            }
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 117:
            stage++;
            [sharedGameController.player moveToPoint:CGPointMake(sharedGameController.player.currentLocation.x + 50, sharedGameController.player.currentLocation.y) duration:0.8];
            [sharedGameController.player fadeOut];
            cutSceneTimer = 1;
            break;
        case 118:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCRatatosk class]]) {
                    entity.active = NO;
                }
            }
            Projectile *ratatosk2 = [[Projectile alloc] initProjectileFrom:Vector2fMake(310, 160) to:Vector2fMake(500, 360) withImage:@"Ratatosk.png" lasting:1 withStartAngle:15 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(0.3, 0.3)];
            [self addObjectToActiveObjects:ratatosk2];
            [FadeInOrOut fadeOutWithDuration:2];
            cutSceneTimer = 2;
            break;
        case 119:
            stage++;
            [sharedGameController.player teleportToTile:CGPointMake(77, 35)];
            cameraPosition = CGPointMake(77.5, 35.5);
            [sharedGameController.player fadeIn];
            [FadeInOrOut fadeInWithDuration:2];
            cutSceneTimer = 2;
            break;
        case 120:
            stage = 1220;
            cutScene = NO;
            NSLog(@" Got here.");
            doNotUpdate = NO;
            sharedGameController.gameState = kGameState_World;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 121:
            stage = 123;
            sharedGameController.gameState = kGameState_Cutscene;
            [sharedInputManager setState:kNoTouchesAllowed];
            [sharedGameController.player stopMoving];
            Surt *surt = [[Surt alloc] initAtTile:CGPointMake(78, 41)];
            [surt fadeIn];
            [self addEntityToActiveEntities:surt];
            [WorldFlashColor worldFlashColor:Color4fMake(0.6, 0, 0, 0.3)];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 1220:
            stage++;
            [sharedGameController.player stopMoving];
            Valkyrie *ally = [[Valkyrie alloc] initAtLocation:sharedGameController.player.currentLocation];
            [ally fadeIn];
            [ally moveToPoint:CGPointMake(ally.currentLocation.x + 40, ally.currentLocation.y) duration:0.5];
            [ally faceUp];
            [self addEntityToActiveEntities:ally];
            [ally release];
            cutScene = YES;
            cutSceneTimer = 0.5;
            break;
        case 1221:
            stage++;
            cutScene = NO;
            [Textbox textboxWithText:@"Valkyrie: That lousy Volur. I knew this was a waste of time."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 1222:
            stage++;
            [Textbox textboxWithText:@"Roderick: So this is the great hall. I should be inside there. Let me join my fellow warriors!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 1223:
            stage = 121;
            [Textbox textboxWithText:@"Valkyrie: Ha! I'll have no more of this foolish errand. Now we're off to Helheim where you belong."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 123:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Surt the fire giant?! What's he doing here?"];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 124:
            stage++;
            [Textbox textboxWithText:@"Surt: I shall burn Asgard to the ground! Feel the wrath of Surt."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 125:
            stage++;
            [WorldFlashColor worldFlashColor:Red];
            cutScene = YES;
            cutSceneTimer = 0.5;
            for (AbstractEntity *surt in activeEntities) {
                if ([surt isMemberOfClass:[Surt class]]) {
                    [surt teleportToTile:CGPointMake(82, 43)];
                }
            }
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 126:
            stage++;
            [WorldFlashColor worldFlashColor:Red];
            for (AbstractEntity *surt in activeEntities) {
                if ([surt isMemberOfClass:[Surt class]]) {
                    [surt teleportToTile:CGPointMake(74, 43)];
                }
            }
            cutSceneTimer = 0.5;
            break;
        case 127:
            stage++;
            for (AbstractEntity *surt in activeEntities) {
                if ([surt isMemberOfClass:[Surt class]]) {
                    [surt moveToTile:CGPointMake(78, 41) duration:1.5];
                }
            }
            cutSceneTimer = 1.5;
            [Textbox textboxWithText:@"Surt: BWAHAHAHAHHAHAHA!"];
            break;
        case 128:
            stage++;
            [self removeTextbox];
            cutScene = NO;
            //Insert Freyr here.
            OldMan *freyr = [[OldMan alloc] initAtTile:CGPointMake(84, 36)];
            [freyr fadeIn];
            [freyr moveToTile:CGPointMake(79, 40) duration:1];
            [self addEntityToActiveEntities:freyr];
            [freyr release];
            [Textbox textboxWithText:@"Freyr: Surt! I will not allow you to destroy Valhalla!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 129:
            stage++;
            [sharedInputManager setState:kNoTouchesAllowed];
            cutScene = YES;
            cutSceneTimer = 0.3;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[OldMan class]]) {
                    [entity moveToTile:CGPointMake(78, 41) duration:0.5];
                }
            }
            break;
        case 130:
            stage++;
            cutSceneTimer = 0.3;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Surt class]]) {
                    [entity moveToTile:CGPointMake(77, 41) duration:0.5];
                }
            }
            break;
        case 131:
            stage = 1300;
            cutScene = NO;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]]) {
                    [entity faceLeft];
                }
            }
            [Textbox textboxWithText:@"Valkyrie: That's Freyr fighting. Should we help him?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 1300:
            stage++;
            [Choicebox choiceboxWithChoices:[NSArray arrayWithObjects:@"Of course!", @"No way!", nil]];
            break;
        case 1301:
            stage = 133;
            [Textbox textboxWithText:@"Valkyrie: You coward Roderick. I'll drag you into this fight!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 132:
            stage++;
            [sharedGameController.player faceRight];
            [Textbox textboxWithText:@"Roderick: Finally a fight worthy of Roderick. Lead the way valkyrie."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 133:
            stage++;
            [sharedGameController.player moveToTile:CGPointMake(sharedGameController.player.currentTile.x, sharedGameController.player.currentTile.y + 1) duration:0.5];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]]) {
                    [entity moveToTile:CGPointMake(entity.currentTile.x, entity.currentTile.y + 1) duration:0.5];
                }
            }
            OldMan *wu = [[OldMan alloc] initAtTile:CGPointMake(sharedGameController.player.currentTile.x, sharedGameController.player.currentTile.y - 4)];
            [wu fadeIn];
            [wu moveToTile:CGPointMake(sharedGameController.player.currentTile.x, sharedGameController.player.currentTile.y - 1) duration:1];
            [self addEntityToActiveEntities:wu];
            [wu release];
            cutScene = YES;
            cutSceneTimer = 0.5;
            break;
        case 134:
            stage++;
            cutScene = NO;
            [Textbox textboxWithText:@"Wait!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 135:
            stage++;
            [Textbox textboxWithText:@"Wu: This is not a battle you can win."];
            [sharedGameController.player faceDown];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]]) {
                    [entity faceDown];
                }
            }
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 136:
            stage++;
            [Textbox textboxWithText:@"Wu: Come, I will transport us out of here."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 137:
            stage++;
            cutScene = YES;
            cutSceneTimer = 1;
            ParticleEmitter *teleporter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Teleporter.pex"];
            teleporter.sourcePosition = Vector2fMake(240, 160);
            [sharedGameController.player fadeOut];
            [self addObjectToActiveObjects:teleporter];
            [teleporter release];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isKindOfClass:[AbstractEntity class]]) {
                    [entity fadeOut];
                }
            }
            break;
        case 138:
            stage++;
            cutSceneTimer = 1;
            [sharedGameController.player teleportToTile:CGPointMake(65, 62)];
            cameraPosition = CGPointMake(65.5, 62.5);
            sharedGameController.player.active = YES;
            [sharedGameController.player fadeIn];
            ParticleEmitter *teleporter2 = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Teleporter.pex"];
            teleporter2.sourcePosition = Vector2fMake(65 * 40, 62 * 40);
            [self addObjectToActiveObjects:teleporter2];
            [teleporter2 release];
            break;
        case 139:
            stage++;
            cutSceneTimer = 2;
            [self removeInactiveEntities];
            OldMan *oldManWu = [[OldMan alloc] initAtTile:CGPointMake(65, 62)];
            [oldManWu fadeIn];
            [oldManWu moveToTile:CGPointMake(62, 62) duration:2];
            [self addEntityToActiveEntities:oldManWu];
            [oldManWu release];
            Valkyrie *lastValk = [[Valkyrie alloc] initAtTile:CGPointMake(65, 62)];
            [lastValk fadeIn];
            [lastValk moveToTile:CGPointMake(65, 61) duration:1];
            [lastValk faceLeft];
            [self addEntityToActiveEntities:lastValk];
            [lastValk release];
            break;
        case 140:
            stage++;
            cutScene = NO;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[OldMan class]]) {
                    [entity faceRight];
                }
            }
            [Textbox textboxWithText:@"Wu: I should have gotten there earlier. Now it may be too late."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 141:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Too late for what? The Volur said you may have answers old man."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 142:
            stage++;
            [Textbox textboxWithText:@"Wu: This battle between Freyr and Surt is yet another sign of Ragnarok."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 143:
            stage++;
            [Textbox textboxWithText:@"Roderick: Ragnarok..."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 144:
            stage++;
            [Textbox textboxWithText:@"Wu: Indeed. Luckily this battle shall last for days. Freyr will not be defeated easily."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 145:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: What do you mean luckily?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 146:
            stage++;
            [Textbox textboxWithText:@"Wu: There may still be time to reverse the signs and prevent the end of days."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 147:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Reverse the signs? How can we do that?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 148:
            stage++;
            [Textbox textboxWithText:@"Wu: The elves speak of a way to undo death. If we could somehow use that to bring Baldur back, we may be able..."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 149:
            stage++;
            [Textbox textboxWithText:@"Roderick: Elves?! You mean to tell me the stories are true? Are there really elves?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 150:
            stage++;
            [Textbox textboxWithText:@"Wu: Just what we need to prevent Ragnarok, someone who knows nothing."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 151:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: I've heard it's wise not to interrupt old men in cloaks."];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]]) {
                    [entity faceDown];
                }
            }
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 152:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: So do we know how to use this elven power?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 153:
            stage++;
            [Textbox textboxWithText:@"Wu: No not yet. That is why I've brought us here to Alfheim. I need you to go speak with Urundyl, the king of the elves."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 154:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Will you not come with us?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 155:
            stage++;
            [Textbox textboxWithText:@"Wu: I have more research to do elsewhere. I will find you again once you've reached the king."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 156:
            stage++;
            [Textbox textboxWithText:@"Wu: Head West through these trees. An old hermit lives in a house that way. He may know how to get to Urundyl's castle. Now I must be off."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 157:
            stage++;
            ParticleEmitter *tele = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"Teleporter.pex"];
            tele.sourcePosition = Vector2fMake(140, 180);
            [self addObjectToActiveObjects:tele];
            [tele release];
            cutScene = YES;
            cutSceneTimer = 1;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[OldMan class]]) {
                    [entity fadeOut];
                }
            }
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 158:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Are there really elves? Let's go see the hermit 'mighty' Roderick."];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]]) {
                    [entity moveToTile:CGPointMake(entity.currentTile.x, entity.currentTile.y + 1) duration:1];
                    [entity fadeOut];
                }
            }
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 159:
            stage++;
            sharedGameController.gameState = kGameState_World;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 160:
            stage++;
            [FadeInOrOut fadeOutWithDuration:2];
            cutScene = YES;
            cutSceneTimer = 2;
            break;
        case 161:
            stage++;
            doNotUpdate = YES;
            Alfheim *alfheim = [[Alfheim alloc] init];
            [sharedGameController.gameScenes setValue:alfheim forKey:@"Alfheim"];
            sharedGameController.currentScene = [sharedGameController.gameScenes objectForKey:@"Alfheim"];
            [alfheim release];

            break;
            
            
            
            

            
            
            
        case 100:
            if (!roderickHasDied) {
                stage = 63;
                [self moveToNextStageInScene];
                break;
            } else {
                stage++;
            }
            cutScene = NO;
            sharedGameController.gameState = kGameState_Cutscene;
            Textbox *youHaveDied = [[Textbox alloc] initWithRect:CGRectMake(80, 120, 300, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"You have died."];
            [self addObjectToActiveObjects:youHaveDied];
            [youHaveDied release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
            
            
        default:
            break;
    }
}

- (void)initBattle {
    
    if (allowBattles) {
        [sharedSoundManager playMusicWithKey:@"battle" timesToRepeat:-1];
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
    if (allowBattles) {
        [sharedSoundManager playMusicWithKey:@"RoderickDead" timesToRepeat:-1];
    }
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
    portals[17][79] = 1;
    portals[11][82] = 2;
    portals[5][78] = 3;
    portalDestination[1] = CGPointMake(3, 62);
    portalDestination[2] = CGPointMake(23, 62);
    portalDestination[3] = CGPointMake(63, 77);
    portals[2][60] = 4;
    portalDestination[4] = CGPointMake(18, 80);
    portals[22][60] = 5;
    portalDestination[5] = CGPointMake(12, 83);
    portals[64][23] = 6;
    portalDestination[6] = CGPointMake(6, 79);
    portals[25][15] = 99;
    portals[25][14] = 99;
    portals[25][13] = 99;
    portals[25][12] = 99;
    portals[25][11] = 99;
    portals[25][10] = 99;
    portals[25][9] = 99;
    portals[47][26] = 99;
    portals[47][25] = 99;
    portals[47][24] = 99;
    portals[47][23] = 99;
    portals[47][22] = 99;
    portals[47][21] = 99;
    portals[47][20] = 99;
    portals[80][15] = 99;
    portals[80][16] = 99;
    portals[80][17] = 99;
    portals[80][18] = 99;
    portals[80][19] = 99;
    portals[80][20] = 99;
    portals[80][21] = 99;
    portals[80][22] = 99;
    portals[80][23] = 99;
    portals[72][39] = 99;
    portals[73][39] = 99;
    portals[74][39] = 99;
    portals[75][39] = 99;
    portals[76][39] = 99;
    portals[77][39] = 99;
    portals[78][39] = 99;
    portals[79][39] = 99;
    portals[80][39] = 99;
    portals[81][39] = 99;
    portals[82][39] = 99;
    portals[55][61] = 99;
}

- (BOOL)isBlocked:(float)x y:(float)y {
    
    return blocked[(int)x][(int)y];
}

- (BOOL)checkForPortal {
    
    if (portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y] == 99) {
        [sharedInputManager setState:kNoTouchesAllowed];
        [self moveToNextStageInScene];
    }
    if (sharedGameController.player != nil && stage == 49) {
        // //NSLog(@"Player's current tile location is: (%d, %d).", (int)sharedGameController.player.currentLocation.x / 40 - 1, (int)sharedGameController.player.currentLocation.y / 40);
        if (portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y] != 0) {
            ////NSLog(@"Destination is: (%f, %f).", portalDestination[(portals[(int)sharedGameController.player.currentLocation.x / 40 - 1][(int)sharedGameController.player.currentLocation.y / 40]) - 1].x, portalDestination[(portals[(int)sharedGameController.player.currentLocation.x / 40 - 1][(int)sharedGameController.player.currentLocation.y / 40]) - 1].y);
            //sharedGameController.player.currentLocation = portalDestination[(portals[(int)sharedGameController.player.currentLocation.x / 40 - 1][(int)sharedGameController.player.currentLocation.y / 40]) - 1];
            ////NSLog(@"Should teleport to (%f, %f).", portalDestination[portals[(int)(sharedGameController.player.currentTile.x)][(int)(sharedGameController.player.currentTile.y)]].x, portalDestination[portals[(int)(sharedGameController.player.currentTile.x)][(int)(sharedGameController.player.currentTile.y)]].y);
            [sharedGameController.player teleportToTile:portalDestination[portals[(int)(sharedGameController.player.currentTile.x)][(int)(sharedGameController.player.currentTile.y)]]];
            return YES;
        }
    }
    if (sharedGameController.player != nil && stage == 73) {
        if (sharedGameController.player.currentLocation.x > 1800) {
            [self moveToNextStageInScene];
            return YES;
        }
    }
    return NO;
}

- (void)drawLineOff {
    
    if (stage == 89) {
        [self moveToNextStageInScene];
    }
    [super drawLineOff];
}

- (void)choiceboxSelectionWas:(int)aSelection {
    
    BattlePriest *priest = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
    [self removeTextbox];
    if (stage == 1301) {
        switch (aSelection) {
            case 0:
                stage = 133;
                priest.freyaFavor++;
                priest.odinFavor++;
                [self moveToNextStageInScene];
                break;
            case 1:
                priest.freyaFavor--;
                priest.odinFavor--;
                [self moveToNextStageInScene];
                break;
                
            default:
                break;
        }
    }
    NSLog(@"Freya favor is: %f", priest.freyaFavor);
}


@end
