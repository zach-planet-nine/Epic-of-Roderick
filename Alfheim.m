//
//  Alfheim.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Alfheim.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "FontManager.h"
#import "InputManager.h"
#import "SoundManager.h"
#import "ScriptReader.h"
#import "PackedSpriteSheet.h"
#import "TiledMap.h"
#import "ParticleEmitter.h"
#import "Animation.h"
#import "Image.h"
#import "Projectile.h"
#import "Character.h"
#import "StringWithDuration.h"
#import "AbstractBattleEnemy.h"
#import "AbstractEntity.h"
#import "Roderick.h"
#import "OldMan.h"
#import "Valkyrie.h"
#import "NPCVolur.h"
#import "FadeInOrOut.h"
#import "Textbox.h"
#import "Choicebox.h"
#import "Teleportal.h"
#import "Seior.h"
#import "NPCEnemySwordMan.h"
#import "NPCRedHairedRoderick.h"
#import "KenazMenuAnimation.h"
#import "SowiloMenuAnimation.h"
#import "IsaMenuAnimation.h"
#import "SwopazMenuAnimation.h"
#import "BattleWaterSpirit.h"
#import "BattlePoisonDemonMage.h"
#import "BattlePoisonDemonRider.h"
#import "BattleWizard.h"
#import "BattlePriest.h"
#import "BattleRoderick.h"
#import "OverMind.h"
#import "PackedSpriteSheet.h"
#import "MoveMap.h"
#import "WorldFlashColor.h"
#import "Bats.h"
#import "RuneTomb.h"
#import "EkwazMenuAnimation.h"
#import "GromanthMenuAnimation.h"
#import "HagalazMenuAnimation.h"
#import "RangerBattleTutorial.h"
#import "Nioavellir.h"

@implementation Alfheim

- (id)init
{
    self = [super init];
    if (self) {
        
        battleImage = [[Image alloc] initWithImageNamed:@"AlfheimBackground.png" filter:GL_NEAREST];
        battleFont = [sharedFontManager getFontWithKey:@"battleFont"];
        sceneMap = [[TiledMap alloc] initWithFileName:@"AlfheimMap" fileExtension:@"tmx"];
        cutScene = YES;
        cutSceneTimer = 0.5;
        [sharedInputManager setState:kNoTouchesAllowed];
        [FadeInOrOut fadeInWithDuration:2];
        sharedGameController.gameState = kGameState_World;
        sharedGameController.realm = kRealm_Alfheim;
        [self createCollisionMapArray];
        [self createPortalsArray];
        [sharedSoundManager loadMusicWithKey:@"Cave" musicFile:@"evil cave.mp3"];
        [sharedSoundManager loadMusicWithKey:@"Mountain" musicFile:@"overworld 1.mp3"];
        allowBattles = NO;
        stage = 0;
        
        //Stuff added so that I can start the scene here
        /*Character *roderick = [sharedGameController.characters objectForKey:@"Roderick"];
        Character *alex = [sharedGameController.characters objectForKey:@"Valkyrie"];
        Character *seior = [sharedGameController.characters objectForKey:@"Wizard"];
        int level = 1;
        while (level < 5) {
            [roderick levelUp];
            [alex levelUp];
            [seior levelUp];
            level++;
        }
        IsaMenuAnimation *isam = [[IsaMenuAnimation alloc] init];
        SowiloMenuAnimation *sowilo = [[SowiloMenuAnimation alloc] init];
        KenazMenuAnimation *kenaz = [[KenazMenuAnimation alloc] init];
        [sharedGameController.party addObject:roderick];
        [sharedGameController.party addObject:alex];
        [sharedGameController.party addObject:seior];
        [roderick learnRune:isam withKey:@"Isa"];
        [alex learnRune:sowilo withKey:@"Sowilo"];
        [seior learnRune:kenaz withKey:@"Kenaz"];
        [isam release];
        [sowilo release];
        [kenaz release];
        roderick.essence = roderick.maxEssence = 10 + roderick.level;
        alex.essence = alex.maxEssence = 10 + alex.level;
        [sharedInputManager setUpRuneRect];
        stage = 195;
        Roderick *rod = [[Roderick alloc] initAtTile:CGPointMake(58, 90)];
        sharedGameController.player = rod;
        [self addEntityToActiveEntities:rod];
        [rod release];
        
        //Added to start at stage 165.
        NPCVolur *dauphine = [[NPCVolur alloc] initAtTile:CGPointMake(25, 70)];
        dauphine.triggerNextStage = YES;
        [self addEntityToActiveEntities:dauphine];
        [dauphine release];*/
    }
    
    return self;
}

- (void)moveToNextStageInScene {
    
    switch (stage) {
        case 0:
            stage++;
            [FadeInOrOut fadeInWithDuration:2];
            Roderick *roderick = [[Roderick alloc] initAtTile:CGPointMake(76, 32)];
            sharedGameController.player = roderick;
            [self addEntityToActiveEntities:roderick];
            //[sharedGameController.gameScenes removeObjectForKey:@"ChapterOne"];
            doNotUpdate = NO;
            [roderick release];
            OldMan *oldMan = [[OldMan alloc] initAtTile:CGPointMake(70, 36)];
            oldMan.triggerNextStage = YES;
            [self addEntityToActiveEntities:oldMan];
            [oldMan release];
            cutSceneTimer = 2;
            break;
        case 1:
            stage++;
            cutScene = NO;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 2:
            stage++;
            [Textbox textboxWithText:@"Hermit: Who'sa what now? Who's there?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 3:
            stage++;
            Valkyrie *valk = [[Valkyrie alloc] initAtLocation:sharedGameController.player.currentLocation];
            [valk fadeIn];
            [valk faceUp];
            [valk moveToPoint:CGPointMake(valk.currentLocation.x + 40, valk.currentLocation.y) duration:1];
            [self addEntityToActiveEntities:valk];
            [valk release];
            [Textbox textboxWithText:@"Roderick: Listen old man. We need you to tell us where Urundyl's castle is."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 4:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: You need to learn some respect Roderick."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 5:
            stage++;
            [Textbox textboxWithText:@"Hermit: You? Hahaha! You'll never make it."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 6:
            stage++;
            [Textbox textboxWithText:@"Roderick: What do you mean? Do you doubt our skills? I'll show you old man!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 7:
            stage++;
            [Textbox textboxWithText:@"Hermit: Oh? I just think you'll need help."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 8:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: What kind of help could we use?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 9:
            stage++;
            [Textbox textboxWithText:@"Hermit: Head West. There is a clearing where you might find Seior. Seior will help you."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 10:
            stage++;
            [Textbox textboxWithText:@"Roderick: Seior? Who's Seior?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 11:
            stage++;
            [Textbox textboxWithText:@"Hermit: An old wisened wizard."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 12:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Come, let's go find this wizard."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 13:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]]) {
                    [entity fadeOut];
                    [entity moveToPoint:sharedGameController.player.currentLocation duration:1];
                }
                if ([entity isMemberOfClass:[OldMan class]]) {
                    entity.triggerNextStage = NO;
                    entity.message = @"Hermit: Head West. You will find Seior there.";
                }
            }
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 14:
            stage = 1400;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            sharedGameController.player.active = YES;
            Seior *seior = [[Seior alloc] initAtTile:CGPointMake(60, 23)];
            [self addEntityToActiveEntities:seior];
            [seior release];
            [sharedInputManager setState:kWalkingAround_NoTouches];
            cutScene = NO;
            break;
        case 1400:
            stage = 15;
            allowBattles = YES;
            break;
        case 15:
            stage = 1500;
            [sharedGameController.player stopMoving];
            sharedGameController.gameState = kGameState_Cutscene;
            MoveMap *moveMap = [[MoveMap alloc] initMoveFromMapXY:sharedGameController.player.currentLocation to:CGPointMake(sharedGameController.player.currentLocation.x, sharedGameController.player.currentLocation.y + 120) withDuration:1];
            [self addObjectToActiveObjects:moveMap];
            [moveMap release];
            [Textbox textboxWithText:@"Young Woman: It's got to be around here somewhere. I know it."];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 1500:
            stage = 16;
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 16:
            stage++;
            cutScene = NO;
            Valkyrie *valk2 = [[Valkyrie alloc] initAtLocation:sharedGameController.player.currentLocation];
            [valk2 fadeIn];
            [valk2 moveToPoint:CGPointMake(sharedGameController.player.currentLocation.x + 40, sharedGameController.player.currentLocation.y) duration:1];
            [valk2 faceUp];
            [self addEntityToActiveEntities:valk2];
            [valk2 release];
            [Textbox textboxWithText:@"Roderick: Excuse me miss. We were told we would find a wizard around here. Have you seen him?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 17:
            stage++;
            [Textbox textboxWithText:@"Young Woman: A wizard eh? I think he may have gone East."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 18:
            stage++;
            [Textbox textboxWithText:@"Roderick: Great! Let's get on with it."];
            [sharedGameController.player faceRight];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 19:
            stage++;
            [Textbox textboxWithText:@"Young Woman: Or maybe it was West..."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 20:
            stage++;
            [Textbox textboxWithText:@"Roderick: Well which was it?"];
            [sharedGameController.player faceUp];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 21:
            stage++;
            [Textbox textboxWithText:@"Young Woman: Well you're an impatient one. What do you know of this wizard? Maybe that will help me remember."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 22:
            stage++;
            [Textbox textboxWithText:@"Roderick: He is a wise old wizard. Probably grey hair. They seem to like cloaks."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 23:
            stage++;
            NPCEnemySwordMan *esm = [[NPCEnemySwordMan alloc] initAtTile:CGPointMake(57, 24)];
            [esm fadeIn];
            [esm moveToTile:CGPointMake(58, 23) duration:1];
            [self addEntityToActiveEntities:esm];
            [esm release];
            [Textbox textboxWithText:@"Young Woman: Grey hair and cloak huh? Doesn't ring a bell."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 24:
            stage++;
            [Textbox textboxWithText:@"Roderick: Hey watch out. There's a monster!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 25:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                    [entity moveToTile:CGPointMake(60, 24) duration:1];
                }
            }
            [Textbox timedTextboxWithText:@"Lookout!" andDuration:0.7];
            cutScene = YES;
            cutSceneTimer = 0.7;
            break;
        case 26:
            stage++;
            [self removeTextbox];
            cutScene = NO;
            Character *wizard = [sharedGameController.characters objectForKey:@"Wizard"];
            [sharedGameController.party addObject:wizard];
            KenazMenuAnimation *kma = [[KenazMenuAnimation alloc] init];
            [wizard learnRune:kma withKey:@"Kenaz"];
            while (wizard.level < 5) {
                [wizard levelUp];
            }
            [self initBattle];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 27:
            stage++;
            for (AbstractBattleEntity *abe in activeEntities) {
                if ([abe isKindOfClass:[AbstractBattleEntity class]]) {
                    abe.wait = YES;
                    abe.waitTimer = -1;
                }
            }
            [Textbox textboxWithText:@"Young Woman: Ha! It's only a water spirit. Don't worry I'll handle this."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 28:
            stage++;
            [Textbox textboxWithText:@"Young Woman: Kenaz!"];
            cutScene = YES;
            cutSceneTimer = 0.7;
            break;
        case 29:
            stage = 300;
            cutScene = NO;
            BattleWizard *wiz = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
            AbstractBattleEnemy *waterSpirit;
            for (AbstractBattleEnemy *entity in activeEntities) {
                if ([entity isMemberOfClass:[BattleWaterSpirit class]]) {
                    waterSpirit = entity;
                    waterSpirit.wait = NO;
                }
            }
            [wiz queueRune:120];
            [sharedInputManager setState:kNoTouchesAllowed];
            [wiz runeWasPlacedOnEnemy:waterSpirit];
            break;
        case 300:
            stage++;
            [self removeTextbox];
            allowBattles = NO;
            [Textbox textboxWithText:@"Young Woman: Ahh, that's where it was."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 301:
            stage = 302;
            Image *ansuzRuneStone = [[[sharedGameController.teorPSS imageForKey:@"AnsuzRuneStone.png"] imageDuplicate] retain];
            [sharedGameController.runeStones addObject:ansuzRuneStone];
            [sharedGameController.runeStones addObject:ansuzRuneStone];
            [ansuzRuneStone release];
            [Textbox centerTextboxWithText:@"Ansuz Runestone received!"];
            cutScene = YES;
            cutSceneTimer = 0.5;
            break;
        case 302:
            stage = 30;
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 30:
            stage++;
            [Textbox textboxWithText:@"Roderick: Whoa! What the heck was that?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 31:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: That looked like runic power. Where did you learn that?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 32:
            stage++;
            [Textbox textboxWithText:@"Roderick: Runic power? What is that?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 33:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Don't you know anything Roderick?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 34:
            stage++;
            [Textbox textboxWithText:@"Young Woman: Runes let you harness the power of the world around you."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 35:
            stage++;
            [Textbox textboxWithText:@"Young Woman: That was Kenaz. It is a fire rune. That water spirit didn't stand a chance."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 36:
            stage++;
            [Textbox textboxWithText:@"Roderick: So runes are like magic?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 37:
            stage++;
            [Textbox textboxWithText:@"Young Woman: Fool! This isn't some hocus pocus, these runes have real power."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 38:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: It seems you might be more than you seem at first glance."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 39:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Roderick, I think this might be our old wizard."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 40:
            stage++;
            [Choicebox choiceboxWithChoices:[NSArray arrayWithObjects:@"No way, she's just a young lady.", @"Yeah, I think you might be right.", nil]];
            break;
        case 41:
            stage++;
            [Textbox textboxWithText:@"Young Woman: Hahahah! So you've found me out. I am indeed Seior."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 410:
            stage = 42;
            [Textbox textboxWithText:@"Young Woman: Your ignorance will be your undoing sir. I am indeed Seior!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 42:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Seior, can you help us find Urundyl's castle? We must speak with the king."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 43:
            stage++;
            [Textbox textboxWithText:@"Seior: I was just heading that way after I had found this runestone. Come on, we need to head West from here."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 44:
            stage++;
            [Textbox centerTextboxWithText:@"You have now learned about runes. You can use runes you have learned in battle by drawing the rune on the middle of the screen."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 45:
            stage++;
            [Textbox centerTextboxWithText:@"The runes that each character knows will be shown in your runes menu. Check out that menu to see how to draw them and what they will do."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 46:
            stage++;
            [Textbox centerTextboxWithText:@"After drawing the rune, if you drew it correctly, you can then place it in one of four positions. On an enemy, on the enemy side but not on an enemy to affect all enemies, on a character, or on the character side but not on a character to affect all characters."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 47:
            stage = 470;
            [Textbox centerTextboxWithText:@"You have also found your first runestone. You can equip those to your weapon or armor to help you in battle. Check 'em out in the equipment menu."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 470:
            stage++;
            [Textbox textboxWithText:@"Seior: If you have a few moments, I can teach you both a rune. It should be helpful on the path to Urundyl."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 471:
            stage++;
            [Textbox centerTextboxWithText:@"Roderick has learned the rune Isa!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 472:
            stage++;
            [Textbox centerTextboxWithText:@"The Valkyrie has learned the rune Sowilo."];
            IsaMenuAnimation *isam = [[IsaMenuAnimation alloc] init];
            SowiloMenuAnimation *sowilo = [[SowiloMenuAnimation alloc] init];
            Character *roder = [sharedGameController.characters objectForKey:@"Roderick"];
            Character *valky = [sharedGameController.characters objectForKey:@"Valkyrie"];
            [roder learnRune:isam withKey:@"Isa"];
            [valky learnRune:sowilo withKey:@"Sowilo"];
            [isam release];
            [sowilo release];
            roder.essence = roder.maxEssence = 10 + roder.level;
            valky.essence = valky.maxEssence = 10 + valky.level;
            [sharedInputManager setUpRuneRect];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 473:
            stage = 48;
            [Textbox centerTextboxWithText:@"Check out how to draw them in the runes menu."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 48:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]]) {
                    [entity moveToPoint:sharedGameController.player.currentLocation duration:1];
                    [entity fadeOut];
                } else if ([entity isMemberOfClass:[Seior class]]) {
                    [entity moveToPoint:sharedGameController.player.currentLocation duration:1];
                    [entity fadeOut];
                }
            }
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 49:
            stage++;
            [self removeInactiveEntities];
            Character *sei = [sharedGameController.characters objectForKey:@"Wizard"];
            sei.fireAffinity = 4;
            sei.power = sei.level * 2;
            cutScene = NO;
            allowBattles = YES;
            for (int i = 0; i < 3; i++) {
                NPCEnemySwordMan *nesm = [[NPCEnemySwordMan alloc] initAtTile:CGPointMake(35, 2 + (i * 2))];
                NPCRedHairedRoderick *nrhr = [[NPCRedHairedRoderick alloc] initAtTile:CGPointMake(37, 2 + (i * 2))];
                [nesm faceRight];
                [nrhr faceLeft];
                [self addEntityToActiveEntities:nesm];
                [self addEntityToActiveEntities:nrhr];
                [nesm release];
                [nrhr release];
            }
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 50:
            stage = 500;
            [sharedGameController.player stopMoving];
            sharedGameController.gameState = kGameState_Cutscene;
            MoveMap *moveMap2 = [[MoveMap alloc] initMoveFromMapXY:sharedGameController.player.currentLocation to:CGPointMake(sharedGameController.player.currentLocation.x - 120, sharedGameController.player.currentLocation.y) withDuration:1];
            [self addObjectToActiveObjects:moveMap2];
            [moveMap2 release];    
            [Textbox textboxWithText:@"Elven Hunter: We've got them cornered men. Attack!"];
            cutScene = YES;
            cutSceneTimer = 1;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 500:
            stage = 51;
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 51:
            stage++;
            [self removeTextbox];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x + 20, entity.currentLocation.y) duration:0.3];
                } else if ([entity isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x - 20, entity.currentLocation.y) duration:0.3];
                }
            }
            [WorldFlashColor worldFlashColor:Color4fMake(1, 1, 1, 0.3)];
            cutScene = YES;
            cutSceneTimer = 0.4;
            Valkyrie *ally = [[Valkyrie alloc] initAtTile:sharedGameController.player.currentTile];
            [ally fadeIn];
            [ally moveToTile:CGPointMake(sharedGameController.player.currentTile.x - 1, sharedGameController.player.currentTile.y) duration:1];
            [ally faceRight];
            Seior *seior2 = [[Seior alloc] initAtTile:sharedGameController.player.currentTile];
            [seior2 fadeIn];
            [seior2 moveToTile:CGPointMake(sharedGameController.player.currentTile.x, sharedGameController.player.currentTile.y + 1) duration:1];
            [seior2 faceLeft];
            [self addEntityToActiveEntities:ally];
            [self addEntityToActiveEntities:seior2];
            [ally release];
            [seior2 release];
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 52:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x - 20, entity.currentLocation.y) duration:0.5];
                    entity.currentAnimation = entity.rightAnimation;
                } else if ([entity isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x + 20, entity.currentLocation.y) duration:0.5];
                    [entity.currentAnimation retain];
                    entity.currentAnimation = entity.leftAnimation;
                    NSLog(@"Right animation state is: %d", entity.rightAnimation.state);
                }
            }
            cutScene = YES;
            cutSceneTimer = 0.6;
            [Textbox textboxWithText:@"Elven Hunter: Damn! Their too strong. Keep at it men!"];
            break;
        case 53:
            stage++;
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 54:
            stage++;
            [Textbox textboxWithText:@"Seior: Roderick! Use the rune I taught you."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 55:
            stage++;
            [Textbox textboxWithText:@"Roderick: ISA!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 56:
            stage++;
            [WorldFlashColor worldFlashColor:Color4fMake(0, 0, 1, 0.4)];
            cutScene = YES;
            cutSceneTimer = 0.3;
            break;
        case 57:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                    entity.currentAnimation.state = kAnimationState_Stopped;
                    [entity.currentAnimation currentFrameImage].color = Blue;
                }
            }
            cutSceneTimer = 0.3;
            break;
        case 58:
            stage++;
            cutScene = YES;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    NSLog(@"Right animation state is: %d", entity.rightAnimation.state);
                    [entity moveToPoint:CGPointMake(entity.currentLocation.x - 100, entity.currentLocation.y) duration:0.5];
                }
            }
            cutSceneTimer = 0.4;
            break;
        case 59:
            stage++;
            [WorldFlashColor worldFlashColor:Color4fMake(1, 1, 1, 0.3)];
            cutSceneTimer = 0.2;
            break;
        case 60:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                    [entity fadeOut];
                } else if ([entity isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    NSLog(@"Current tile is (%f, %f). %d and current location is (%f, %f).", entity.currentTile.x, entity.currentTile.y, entity.currentAnimation.state, entity.currentLocation.x, entity.currentLocation.y);
                    NSLog(@"Right animation state is: %d", entity.rightAnimation.state);
                    [entity moveToTile:CGPointMake(38, entity.currentTile.y) duration:1.5];
                    //[entity moveToPoint:CGPointMake(1540, entity.currentLocation.y) duration:1];
                }
            }
            cutSceneTimer = 1.5;
            break;
        case 61:
            stage++;
            cutScene = NO;
            [Textbox textboxWithText:@"Elven Hunter: Ahh Seior, well met! You and your companions have our thanks."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 62:
            stage++;
            [Textbox textboxWithText:@"Seior: Kelthe, what are you doing all the way out here?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 63:
            stage++;
            [Textbox textboxWithText:@"Kelthe: Monsters have been marauding our lands. We chased a group to this clearing, but they found reinforcements."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 64:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: I thought Elven lands were free of monsters."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 65:
            stage++;
            [Textbox textboxWithText:@"Kelthe: They were, but recently they've returned. The land is being corrupted."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 66:
            stage++;
            [Textbox textboxWithText:@"Kelthe: If you had not happened along, we may have been corrupted as well..."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 67:
            stage++;
            [Choicebox choiceboxWithChoices:[NSArray arrayWithObjects:@"Damn right!", @"Roderick saves the day as usual.", @"Great luck indeed.", nil]];
            break;
        case 68:
            stage++;
            [Textbox textboxWithText:@"Kelthe: The gods employ a special kind of luck."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 680:
            stage = 69;
            [Textbox textboxWithText:@"Kelthe: Boasting, is not the way to the gods favor sir."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 6800:
            stage = 69;
            [Textbox textboxWithText:@"Kelthe: Roderick eh? Never heard of you. Perhaps you haven't saved enough days."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 69:
            stage++;
            [Textbox textboxWithText:@"Kelthe: What brought you all to this place?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 70:
            stage++;
            [Textbox textboxWithText:@"Seior: We were on our way to see Urundyl."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 71:
            stage++;
            [Textbox textboxWithText:@"Kelthe: Well let us accompany you then. We can head back now that these monsters have been dispatched."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 72:
            stage++;
            [Textbox textboxWithText:@"Seior: Your escort is appreciated. Let us be off."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 73:
            stage++;
            
            //Added to start here.
            cutScene = NO;
            
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            sharedGameController.player.active = YES;
            NPCRedHairedRoderick *rhr = [[NPCRedHairedRoderick alloc] initAtTile:CGPointMake(95, 36)];
            [rhr faceDown];
            rhr.triggerNextStage = YES;
            [self addEntityToActiveEntities:rhr];
            [rhr release];
            sharedGameController.gameState = kGameState_World;
            allowBattles = NO;
            [Teleportal teleportalToTile:CGPointMake(95, 26)];
            break;
        case 74:
            stage++;
            [self removeInactiveEntities];
            Valkyrie *alexdot = [[Valkyrie alloc] initAtTile:sharedGameController.player.currentTile];
            Seior *wizzie = [[Seior alloc] initAtTile:sharedGameController.player.currentTile];
            [alexdot fadeIn];
            [wizzie fadeIn];
            [alexdot moveToTile:CGPointMake(alexdot.currentTile.x + 1, alexdot.currentTile.y) duration:1];
            [wizzie moveToTile:CGPointMake(wizzie.currentTile.x - 1, wizzie.currentTile.y) duration:1];
            [alexdot faceUp];
            [wizzie faceUp];
            [self addEntityToActiveEntities:alexdot];
            [self addEntityToActiveEntities:wizzie];
            [alexdot release];
            [wizzie release];
            [Textbox textboxWithText:@"Urundyl: Seior, how have you been? Kelthe tells me you came to his aid on the hunt."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 75:
            stage++;
            [Textbox textboxWithText:@"Seior: Indeed we did. Kelthe says that monsters have begun to appear in these lands."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 76:
            stage++;
            [Textbox textboxWithText:@"Roderick: We need to ask you some questions."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 77:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Because you helped Kelthe, I'll stay my hand, but your impertinance is ill received."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 78:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Forgive this loud mouth your highness, but we are in need of some information."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 79:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Unfortunately valkyrie, I have no time for discussion right now. My men and I are hunting down these monsters and driving them from our land."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 80:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Understood. We will help you deal with this threat then. Then we can talk yes?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 81:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Once the threat is neutralized, I'll answer any questions you have."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 82:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: Excellent. What would you like us to do?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 83:
            stage++;
            [Textbox textboxWithText:@"Urundyl: We have tracked groups of monsters to three locations."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 84:
            stage++;
            [Textbox textboxWithText:@"Urundyl: To the North on Mount Kolbathe, to Northwest in the Swimpy Swamp, and to the Southwest in the Cave of Arank."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 85:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Choose whichever path you'd like, my men will chase the monsters in the other two."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 86:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[Valkyrie class]] || [entity isMemberOfClass:[Seior class]]) {
                    [entity moveToTile:sharedGameController.player.currentTile duration:1];
                    [entity fadeOut];
                } else if ([entity isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    entity.message = @"Mount Kolbathe is a small mountain. The Swimpy Swamp is not too long, but the Cave of Arank is a deep cavern. Choose wisely.";
                }
            }
            //Add once RuneTomb image is added to TEORPSS
            RuneTomb *gromanthRuneTomb = [[RuneTomb alloc] initAtTile:CGPointMake(50, 22) withRune:[[GromanthMenuAnimation alloc] init] withRuneKey:@"Gromanth" forCharacter:[sharedGameController.characters objectForKey:@"Wizard"] withTriggerNextStage:YES];
            [self addEntityToActiveEntities:gromanthRuneTomb];
            [gromanthRuneTomb release];
            RuneTomb *hagalazRuneTomb = [[RuneTomb alloc] initAtTile:CGPointMake(78, 59) withRune:[[HagalazMenuAnimation alloc] init] withRuneKey:@"Hagalaz" forCharacter:[sharedGameController.characters objectForKey:@"Valkyrie"] withTriggerNextStage:YES];
            [self addEntityToActiveEntities:hagalazRuneTomb];
            [hagalazRuneTomb release];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 87:
            stage++;
            cutScene = NO;
            sharedGameController.gameState = kGameState_World;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 88:
            stage++;
            allowBattles = YES;
            if (sharedGameController.player.currentTile.x == 33) {
                stage = 890;
                [sharedSoundManager playMusicWithKey:@"Cave" timesToRepeat:-1];
                RuneTomb *ekwazRuneTomb = [[RuneTomb alloc] initAtTile:CGPointMake(23, 51) withRune:[[EkwazMenuAnimation alloc] init] withRuneKey:@"Ekwaz" forCharacter:[sharedGameController.characters objectForKey:@"Wizard"] withTriggerNextStage:YES];
                [self addEntityToActiveEntities:ekwazRuneTomb];
                [ekwazRuneTomb release];
                
            } else if (sharedGameController.player.currentTile.x == 35) {
                stage = 8900;
                [sharedSoundManager playMusicWithKey:@"Mountain" timesToRepeat:-1];
            }
            break;
        case 89:
            stage++;
            break;
        case 890:
            stage++;
            [sharedGameController.player stopMoving];
            [Textbox textboxWithText:@"Roderick: BATS!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 891:
            stage = 90;
            [self initCaveBoss];
            break;
            
            break;
        case 8900:
            stage = 90;
            break;
        case 90:
            stage = 910;
            [Teleportal teleportalToTile:CGPointMake(95, 33)];
            cutScene = YES;
            cutSceneTimer = 0.55;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 910:
            stage = 91;
            cutSceneTimer = 0.55;
            sharedGameController.gameState = kGameState_Cutscene;
            cameraPosition = CGPointMake(95, 35);
            [sharedGameController.player faceUp];
            [Valkyrie valkyrieAppearAt:sharedGameController.player.currentLocation move:kMovingRight andFace:kMovingUp];
            [Seior seiorAppearAt:sharedGameController.player.currentLocation move:kMovingLeft andFace:kMovingUp];
            allowBattles = NO;
            break;
        case 91:
            stage++;
            cutScene = NO;
            [Textbox textboxWithText:@"Urundyl: Thank you for assisting us. It seems we have staved off this invasion for now."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 92:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: You are welcome Urundyl. Now if we may ask you some questions."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 93:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Of course. Ask what you will."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 94:
            stage++;
            [Textbox textboxWithText:@"Roderick: We need to know your secret way of bringing the dead back to life."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 95:
            stage++;
            [Textbox textboxWithText:@"Urundyl: What? I know not what you speak of. Who are you people and how did you come to ask this question."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 96:
            stage++;
            [Textbox textboxWithText:@"Roderick: I am Roderick. I too was a king amongst my people."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 97:
            stage++;
            [Textbox textboxWithText:@"Valkyrie: And I am Alexdottir Falyndryl Amgernoth of Freya's Valkyries."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 98:
            stage++;
            [Textbox textboxWithText:@"Roderick: Really? I'm just going to call you Ally for short."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 99:
            stage = 103;
            [Textbox textboxWithText:@"Urundyl: Well Valkyrie, what has possessed you to enter Alfheim on such a foolish errand?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 103:
            stage++;
            [Textbox textboxWithText:@"Ally: The one the Volur call old man Wu said you may be able to help us resurrect Baldur."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 104:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Old man Wu?!"];
            Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:NO text:@"Seior: Old man Wu?!"];
            [self addObjectToActiveObjects:tb];
            [tb release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 105:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Seior, what do you know about this?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 106:
            stage++;
            [Textbox textboxWithText:@"Seior: I have seen a shadow cast upon the gods. But for Wu to be here..."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 107:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Where did you meet this Wu?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 108:
            stage++;
            [Textbox textboxWithText:@"Roderick: He saved us from a fire giant that was attacking Valhalla."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 109:
            stage++;
            for (AbstractEntity *seior in activeEntities) {
                if ([seior isMemberOfClass:[Seior class]]) {
                    [seior moveToPoint:CGPointMake(seior.currentLocation.x - 40, seior.currentLocation.y) duration:1];
                }
            }
            Textbox *teb = [[Textbox alloc] initWithRect:CGRectMake(0, 0, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Seior: Wu and Surt..."];
            [self addObjectToActiveObjects:teb];
            [teb release];
            [Textbox textboxWithText:@"Urundyl: I see. The signs are moving quickly..."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 110:
            stage++;
            [Textbox textboxWithText:@"Urundyl: There is no secret to raising the dead Alexdottir."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 111:
            stage++;
            [Textbox textboxWithText:@"Ally: Then there is no hope."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 112:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Oh there is hope. There just is no secret."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 113:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Surely you must know that the living can move freely through eight of the nine realms should they know the paths."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 114:
            stage++;
            [Textbox textboxWithText:@"Ally: Indeed, we Valkyries travel the realms often."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 115:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Well in the beginning, the ninth realm Helheim was no different. It was only when Helagrimm arrived that the path was closed."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 116:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Now that the path is closed, souls may enter Helheim, but they cannot leave."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 117:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Few elves remember the original path that joined Helheim to the other realms anymore."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 118:
            stage++;
            [Textbox textboxWithText:@"Roderick: But some do? Who do we have to talk to now?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 119:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Sometimes I wonder why Men even have kings. I of course know the path."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 120:
            stage++;
            [Textbox textboxWithText:@"Urundyl: But it's not the path that's the worry. It's the Jotun that Helagrimm has posted there."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 121:
            stage++;
            [Textbox textboxWithText:@"Urundyl: And I assume that is why Wu sent you to me. There has only been one elf to pass the Jotun."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 122:
            stage++;
            [Textbox textboxWithText:@"Urundyl: My daughter Dauphine..."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 123:
            stage++;
            [Textbox textboxWithText:@"Seior: The king hasn't spoken to his daughter in many years."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 124:
            stage++;
            [Textbox textboxWithText:@"Urundyl: We may not have spoken, but this doom necessitates our bridging those gaps."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 125:
            stage++;
            [Textbox textboxWithText:@"Urundyl: Take this and show it to Dauphine. Tell her of your quest, and hopefully she will help."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 126:
            stage++;
            [Textbox centerTextboxWithText:@"You have received the Eihwaz Runestone!"];
            Image *eihwazRuneStone = [[[sharedGameController.teorPSS imageForKey:@"EihwazRuneStone.png"] imageDuplicate] retain];
            [sharedGameController.runeStones addObject:eihwazRuneStone];
            [sharedGameController.runeStones addObject:eihwazRuneStone];
            [eihwazRuneStone release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 127:
            stage++;
            [Textbox textboxWithText:@"Urundyl: You will most likely find her in Midgard."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 128:
            stage++;
            [Textbox textboxWithText:@"Ally: Thank you your highness."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 129:
            stage++;
            [Valkyrie joinParty];
            cutScene = YES;
            cutSceneTimer = 1;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 130:
            stage++;
            cutScene = NO;
            [Textbox textboxWithText:@"Roderick: Off to Midgard then."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 131:
            stage++;
            cutScene = YES;
            cutSceneTimer = 0.7;
            [sharedGameController.player moveToPoint:CGPointMake(sharedGameController.player.currentLocation.x, sharedGameController.player.currentLocation.y - 40) duration:1];
            Textbox *texb = [[Textbox alloc] initWithRect:CGRectMake(0, 240, 480, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"Seior: Wait!"];
            [self addObjectToActiveObjects:texb];
            [texb release];
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 132:
            stage++;
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 133:
            stage++;
            [sharedGameController.player faceUp];
            [Textbox textboxWithText:@"Seior: Let me come with you. I have never seen Helheim. I feel there may be runes undiscovered there."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 134:
            stage++;
            [Seior joinParty];
            [Textbox centerTextboxWithText:@"The great wizard Seior has joined your party!"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 135:
            stage++;
            for (AbstractEntity *rhr in activeEntities) {
                if ([rhr isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    rhr.message = @"Are you ready to travel to Midgard?";
                    rhr.triggerNextStage = YES;
                }
            }
            sharedGameController.gameState = kGameState_World;
            //Allow battles portals
            
             portals[33][33] = CGPointMake(99, kAllowBattles);
             portals[33][34] = CGPointMake(99, kAllowBattles);
             portals[33][35] = CGPointMake(99, kAllowBattles);
             portals[76][49] = CGPointMake(99, kAllowBattles);
             portals[75][49] = CGPointMake(99, kAllowBattles);
             portals[35][21] = CGPointMake(99, kAllowBattles);
             portals[35][22] = CGPointMake(99, kAllowBattles);
             portals[35][23] = CGPointMake(99, kAllowBattles);
             portals[21][47] = CGPointMake(99, kAllowBattles);
             portals[22][47] = CGPointMake(99, kAllowBattles);
             portals[23][47] = CGPointMake(99, kAllowBattles);
             portals[24][47] = CGPointMake(99, kAllowBattles);
             portals[25][47] = CGPointMake(99, kAllowBattles);
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 136:
            stage++;
            if (sharedGameController.player.currentTile.x > 90) {
                [Textbox textboxWithText:@"Urundyl: Are you ready to travel to Midgard?"];
                [Choicebox choiceboxWithChoices:[NSArray arrayWithObjects:@"Yes let's go!", @"Not yet, I'd like to look around first.", nil]];
            } else {
                [Teleportal teleportalToTile:CGPointMake(95, 35)];
                allowBattles = NO;
                stage = 136;
            }
            
            break;
        case 137:
            stage++;
            OldMan *oldManWu = [[OldMan alloc] initAtTile:CGPointMake(sharedGameController.player.currentTile.x, sharedGameController.player.currentTile.y - 3)];
            [oldManWu moveToTile:CGPointMake(sharedGameController.player.currentTile.x, sharedGameController.player.currentTile.y - 2) duration:1];
            [oldManWu fadeIn];
            [self addEntityToActiveEntities:oldManWu];
            cutScene = YES;
            cutSceneTimer = 1;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 138:
            stage++;
            cutScene = NO;
            [Textbox textboxWithText:@"Wu: I see you found Urundyl. What did you find out?"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 139:
            stage++;
            cutScene = YES;
            cutSceneTimer = 0.5;
            [FadeInOrOut fadeOutWithDuration:0.5];
            break;
        case 140:
            stage++;
            [FadeInOrOut fadeInWithDuration:0.5];
            cutSceneTimer = 0.5;
            break;
        case 141:
            stage++;
            [Textbox textboxWithText:@"Wu: I see. So we're off to Midgard then. Come, I will teleport us there."];
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 142:
            stage++;
            [WorldFlashColor worldFlashColor:Color4fMake(1, 1, 1, 0.4)];
            cutScene = YES;
            cutSceneTimer = 0.15;
            break;
        case 143:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                entity.active = NO;
            }
            sharedGameController.player.active = YES;
            [Teleportal teleportalToTile:CGPointMake(2, 65)];
            cutSceneTimer = 1;
            break;
        case 144:
            stage = 1440;
            cutSceneTimer = 1;  
            [self removeInactiveEntities];
            [Textbox textboxWithText:@"Roderick: Where'd Wu go?"];
            [Seior seiorAppearAt:sharedGameController.player.currentLocation move:kMovingLeft andFace:kMovingRight];
            break;
        case 1440:
            stage = 145;
            cutScene = NO;
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 145:
            stage++;
            cutScene = NO;
            [Textbox textboxWithText:@"Seior: Wu has many things to attend to. We should get on with the one we have."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 146:
            stage++;
            [Textbox textboxWithText:@"Seior: If we head East we should come across a village I think. Maybe someone there will know where Dauphine is."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 147:
            stage++;
            cutScene = YES;
            cutSceneTimer = 1;
            [Seior joinParty];
            break;
        case 148:
            stage++;
            cutScene = NO;
            int npcIndex = 0;
           /* while (npcIndex < 8) {
                NPCRedHairedRoderick *rhr = [[NPCRedHairedRoderick alloc] initAtTile:CGPointMake(20 + arc4random() % 10, 64 + arc4random() % 8)];
                [rhr setWanderInRect:CGRectMake(20, 64, 10, 8)];
                rhr.message = @"Lousy no good Langelois.";
                [self addEntityToActiveEntities:rhr];
                [rhr release];
                npcIndex++;
            }*/
            NPCVolur *dauphine = [[NPCVolur alloc] initAtTile:CGPointMake(25, 70)];
            dauphine.triggerNextStage = YES;
            [self addEntityToActiveEntities:dauphine];
            [dauphine release];
            sharedGameController.gameState = kGameState_World;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 149:
            stage++;
            [Seior seiorAppearAt:sharedGameController.player.currentLocation move:kMovingRight andFace:kMovingLeft];
            [Valkyrie valkyrieAppearAt:sharedGameController.player.currentLocation move:kMovingLeft andFace:kMovingUp];
            //[Textbox textboxWithText:@"Dauphine: Seior? Is that you? Haha how long has it been?"];
            [sharedScriptReader createCutScene:10];
            break;
        case 150:
            stage++;
            [Seior joinParty];
            [Valkyrie joinParty];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 151:
            stage++;
            cutScene = NO;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            NPCRedHairedRoderick *npcrhr = [[NPCRedHairedRoderick alloc] initAtTile:CGPointMake(38, 82)];
            [self addEntityToActiveEntities:npcrhr];
            [npcrhr release];
            break;
        case 152:
            stage++;
            [Valkyrie valkyrieAppearAt:sharedGameController.player.currentLocation move:kMovingLeft andFace:kMovingUp];
            [Seior seiorAppearAt:sharedGameController.player.currentLocation move:kMovingLeft andFace:kMovingUp];
            [sharedGameController.player stopMoving];
            [sharedScriptReader createCutScene:11];
            break;
        case 153:
            stage++;
            [Valkyrie joinParty];
            [Seior joinParty];
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    [entity moveToTile:CGPointMake(28, 82) duration:2];
                }
            }
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 154:
            stage++;
            cutScene = NO;
            NPCEnemySwordMan *npcesm = [[NPCEnemySwordMan alloc] initAtTile:CGPointMake(53, 70)];
            [self addEntityToActiveEntities:npcesm];
            [npcesm release];
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 155:
            stage++;
            [Valkyrie valkyrieAppearAt:sharedGameController.player.currentLocation move:kMovingLeft andFace:kMovingUp];
            [Seior seiorAppearAt:sharedGameController.player.currentLocation move:kMovingLeft andFace:kMovingUp];
            [sharedGameController.player stopMoving];
            [sharedScriptReader createCutScene:12];
            break;
        case 156:
            stage++;
            [self initGiantCaveBoss];
            break;
        case 157:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                    [entity fadeOut];
                }
            }
            [Valkyrie joinParty];
            [Seior joinParty];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 158:
            stage++;
            cutScene = NO;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 159:
            stage++;
            [Valkyrie valkyrieAppearAt:sharedGameController.player.currentLocation move:kMovingUp andFace:kMovingRight];
            [Seior seiorAppearAt:sharedGameController.player.currentLocation move:kMovingDown andFace:kMovingRight];
            [sharedGameController.player stopMoving];
            [sharedScriptReader createCutScene:13];
            break;
        case 160:
            stage++;
            [Valkyrie move:kMovingRight];
            [Seior move:kMovingRight];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 161:
            stage++;
            cutScene = NO;
            [sharedScriptReader advanceCutScene];
            break;
        case 162:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    [entity teleportToTile:CGPointMake(65, 75)];
                    [entity moveToTile:CGPointMake(65, 77) duration:1];
                    [entity fadeIn];
                }
            }
            cutScene = YES;
            cutSceneTimer = 0.5;
            break;
        case 163:
            stage++;
            cutScene = NO;
            [sharedScriptReader advanceCutScene];
            break;
        case 164:
            stage++;
            [Valkyrie joinParty];
            [Seior joinParty];
            cutScene = YES;
            cutSceneTimer = 1;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 165:
            stage++;
            cutScene = NO;
            [Teleportal teleportalToTile:CGPointMake(37, 75)];
            break;
        case 166:
            stage++;
            [sharedGameController.player stopMoving];
            [Valkyrie valkyrieAppearAt:sharedGameController.player.currentLocation move:kMovingLeft andFace:kMovingUp];
            [Seior seiorAppearAt:sharedGameController.player.currentLocation move:kMovingRight andFace:kMovingUp];
            [sharedScriptReader createCutScene:14];
            break;
        case 167:
            stage++;
            [sharedScriptReader advanceCutScene];
            break;
        case 168:
            stage++;
            [FadeInOrOut fadeOutWithDuration:0.5];
            cutScene = YES;
            cutSceneTimer = 0.5;
            break;
        case 169:
            stage++;
            [FadeInOrOut fadeInWithDuration:0.5];
            cutScene = YES;
            cutSceneTimer = 0.5;
            break;
        case 170:
            stage++;
            NSLog(@"170 gets called.");
            cutScene = NO;
            [sharedScriptReader advanceCutScene];
            break;
        case 171:
            stage++;
            NSLog(@"171 gets called.");
            [sharedScriptReader advanceCutScene];
            break;
        case 172:
            stage++;
            NSLog(@"172 gets called.");
            [Seior joinParty];
            [Valkyrie joinParty];
            [Textbox centerTextboxWithText:@"The Ranger Budrostir has joined your party!"];
            break;
        case 1710:
            stage++;
            [Seior joinParty];
            [Valkyrie joinParty];
            [Textbox textboxWithText:@"Roderick: Until next time Budrostir."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 1711:
            stage = 180;
            [Teleportal teleportalToTile:CGPointMake(24, 68)];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 180:
            stage++;
            cutSceneTimer = 1;
            [Seior seiorAppearAt:sharedGameController.player.currentLocation move:kMovingLeft andFace:kMovingUp];
            [Valkyrie valkyrieAppearAt:sharedGameController.player.currentLocation move:kMovingRight andFace:kMovingUp];
            break;
        case 181:
            stage = 1810;
            cutScene = NO;
            [sharedScriptReader createCutScene:17];
            break;
        case 1810:
            stage++;
            [sharedGameController.player moveToTile:CGPointMake(sharedGameController.player.currentTile.x, sharedGameController.player.currentTile.y + 1) duration:0.5];
            cutScene = YES;
            cutSceneTimer = 0.5;
            break;
        case 1811:
            stage++;
            cutScene = NO;
            [sharedScriptReader advanceCutScene];
            break;
        case 1812:
            stage++;
            [Textbox centerTextboxWithText:@"Roderick shows Dauphine the runestone."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 1813:
            stage = 182;
            [sharedScriptReader advanceCutScene];
            break;
            
        case 182:
            stage++;
            cutScene = YES;
            cutSceneTimer = 1;
            [Seior joinParty];
            [Valkyrie joinParty];
            break;
        case 183:
            stage++;
            cutScene = NO;
            for (AbstractEntity *volur in activeEntities) {
                if ([volur isMemberOfClass:[NPCVolur class]]) {
                    volur.triggerNextStage = YES;
                }
            }
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 184:
            stage++;
            [Textbox textboxWithText:@"Dauphine: Are you ready to travel to Nioavellir?"];
            [Choicebox choiceboxWithChoices:[NSArray arrayWithObjects:@"You know it! Let's go.", @"Not quite yet.", nil]];
            break;
        case 185:
            stage++;
            [Teleportal teleportalToTile:CGPointMake(53, 91)];
            NPCEnemySwordMan *fenrir = [[NPCEnemySwordMan alloc] initAtTile:CGPointMake(61, 91)];
            [self addEntityToActiveEntities:fenrir];
            [fenrir release];
            cutScene = YES;
            cutSceneTimer = 0.8;
            break;
        case 186:
            stage++;
            [sharedGameController.player moveToTile:CGPointMake(57, 91) duration:3];
            cutSceneTimer = 3;
            break;
        case 187:
            stage++;
            MoveMap *centerMap = [[MoveMap alloc] initMoveFromMapXY:sharedGameController.player.currentLocation to:CGPointMake(sharedGameController.player.currentLocation.x + 100, sharedGameController.player.currentLocation.y) withDuration:1];
            [self addObjectToActiveObjects:centerMap];
            [centerMap release];
            cutSceneTimer = 1;
            break;
        case 188:
            stage++;
            [sharedScriptReader createCutScene:18];
            cutScene = NO;
            break;
        case 189:
            stage++;
            [Textbox centerTextboxWithText:@"Here would be a battle against Fenrir"];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 190:
            stage++;
            [sharedScriptReader advanceCutScene];
            break;
        case 191:
            stage++;
            NPCRedHairedRoderick *budrostir = [[NPCRedHairedRoderick alloc] initAtTile:CGPointMake(58, 93)];
            [budrostir fadeIn];
            [budrostir moveToTile:CGPointMake(60, 91) duration:1];
            [self addEntityToActiveEntities:budrostir];
            [budrostir release];
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 192:
            stage++;
            cutScene = NO;
            [sharedScriptReader advanceCutScene];
            break;
        case 193:
            stage++;
            for (AbstractEntity *entity in activeEntities) {
                if ([entity isMemberOfClass:[NPCRedHairedRoderick class]]) {
                    [entity moveToTile:CGPointMake(entity.currentTile.x + 1, entity.currentTile.y) duration:0.5];
                } else if ([entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                    [entity moveToTile:CGPointMake(entity.currentTile.x + 4, entity.currentTile.y) duration:1];
                    [entity fadeOut];
                }
            }
            cutScene = YES;
            cutSceneTimer = 1;
            break;
        case 194:
            stage++;
            cutScene = NO;
            [sharedScriptReader advanceCutScene];
            break;
        case 195:
            stage++;
            Character *budrost = [sharedGameController.characters objectForKey:@"Ranger"];
            SwopazMenuAnimation *sma = [[SwopazMenuAnimation alloc] init];
            [budrost learnRune:sma withKey:@"Swopaz"];
            [sma release];
            [sharedGameController.party addObject:budrost];
            Character *roderic = [sharedGameController.characters objectForKey:@"Roderick"];
            while (budrost.level < roderic.level) {
                [budrost levelUp];
            }
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 196:
            stage++;
            cutScene = NO;
            sharedGameController.realm = kRealm_Midgard;
            [RangerBattleTutorial loadRangerBattleTutorial];
            allowBattles = YES;
            break;
        case 197:
            stage++;
            //[Textbox textboxWithText:@"Here is where Nioavellir would start."];
            Nioavellir *nioavellir = [[Nioavellir alloc] init];
            [sharedGameController.gameScenes setObject:nioavellir forKey:@"Nioavellir"];
            [FadeInOrOut fadeOutWithDuration:2];
            allowBattles = NO;
            cutScene = YES;
            cutSceneTimer = 2;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 198:
            stage++;
            [sharedGameController.player stopMoving];
            sharedGameController.currentScene = [sharedGameController.gameScenes objectForKey:@"Nioavellir"];
            break;
            
            
            
            
            
        case 100:
            stage++;
            for (AbstractGameObject *ago in activeObjects) {
                ago.active = NO;
            }
            for (AbstractBattleEntity *abe in activeEntities) {
                abe.active = NO;
            }
            [self endBattle];
            break;
        default:
            break;
    }
}

- (void)createPortalsArray {
    
    portals[64][34] = CGPointMake(98, 4);
    portals[64][33] = CGPointMake(98, 4);
    portals[97][2] = CGPointMake(99, 1400);
    portals[97][3] = CGPointMake(99, 1400);
    portals[97][4] = CGPointMake(99, 1400);
    portals[97][5] = CGPointMake(99, 1400);
    portals[97][6] = CGPointMake(99, 1400);
    portals[97][7] = CGPointMake(99, 1400);
    portals[60][20] = CGPointMake(99, 15);
    portals[61][20] = CGPointMake(99, 15);
    portals[42][2] = CGPointMake(99, 50);
    portals[42][3] = CGPointMake(99, 50);
    portals[42][4] = CGPointMake(99, 50);
    portals[42][5] = CGPointMake(99, 50);
    portals[90][32] = CGPointMake(33, 34);
    portals[90][31] = CGPointMake(33, 34);
    portals[90][37] = CGPointMake(76, 49);
    portals[90][36] = CGPointMake(76, 49);
    portals[94][39] = CGPointMake(35, 22);
    portals[95][39] = CGPointMake(35, 22);
    portals[96][39] = CGPointMake(35, 22);
    portals[33][33] = CGPointMake(99, 88);
    portals[33][34] = CGPointMake(99, 88);
    portals[33][35] = CGPointMake(99, 88);
    portals[76][49] = CGPointMake(99, 88);
    portals[75][49] = CGPointMake(99, 88);
    portals[35][21] = CGPointMake(99, 88);
    portals[35][22] = CGPointMake(99, 88);
    portals[35][23] = CGPointMake(99, 88);
    portals[21][47] = CGPointMake(99, 890);
    portals[22][47] = CGPointMake(99, 890);
    portals[23][47] = CGPointMake(99, 890);
    portals[24][47] = CGPointMake(99, 890);
    portals[25][47] = CGPointMake(99, 890);
    portals[24][76] = CGPointMake(38, 74);
    portals[35][79] = CGPointMake(99, 152);
    portals[36][79] = CGPointMake(99, 152);
    portals[37][79] = CGPointMake(99, 152);
    portals[38][79] = CGPointMake(99, 152);
    portals[39][79] = CGPointMake(99, 152);
    portals[40][79] = CGPointMake(99, 152);
    portals[37][90] = CGPointMake(53, 62);
    portals[48][67] = CGPointMake(99, 155);
    portals[49][67] = CGPointMake(99, 155);
    portals[50][67] = CGPointMake(99, 155);
    portals[51][67] = CGPointMake(99, 155);
    portals[52][67] = CGPointMake(99, 155);
    portals[53][67] = CGPointMake(99, 155);
    portals[54][67] = CGPointMake(99, 155);
    portals[55][67] = CGPointMake(99, 155);
    portals[56][67] = CGPointMake(99, 155);
    portals[57][67] = CGPointMake(99, 155);
    portals[58][67] = CGPointMake(99, 155);
    portals[61][81] = CGPointMake(99, 159);
    portals[61][80] = CGPointMake(99, 159);
    portals[61][79] = CGPointMake(99, 159);
    portals[61][78] = CGPointMake(99, 159);
    portals[61][77] = CGPointMake(99, 159);
    portals[35][85] = CGPointMake(99, 166);
    portals[36][85] = CGPointMake(99, 166);
    portals[37][85] = CGPointMake(99, 166);
    portals[38][85] = CGPointMake(99, 166);
    portals[39][85] = CGPointMake(99, 166);
    portals[40][85] = CGPointMake(99, 166);
    portals[68][91] = CGPointMake(99, 197);
    portals[68][90] = CGPointMake(99, 197);
    portals[68][89] = CGPointMake(99, 197);




    //Allow battles portals
    /*
    portals[33][33] = CGPointMake(99, kAllowBattles);
    portals[33][34] = CGPointMake(99, kAllowBattles);
    portals[33][35] = CGPointMake(99, kAllowBattles);
    portals[76][49] = CGPointMake(99, kAllowBattles);
    portals[75][49] = CGPointMake(99, kAllowBattles);
    portals[35][21] = CGPointMake(99, kAllowBattles);
    portals[35][22] = CGPointMake(99, kAllowBattles);
    portals[35][23] = CGPointMake(99, kAllowBattles);
    portals[21][47] = CGPointMake(99, kAllowBattles);
    portals[22][47] = CGPointMake(99, kAllowBattles);
    portals[23][47] = CGPointMake(99, kAllowBattles);
    portals[24][47] = CGPointMake(99, kAllowBattles);
    portals[25][47] = CGPointMake(99, kAllowBattles);*/


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

- (BOOL)checkForPortal {
   // NSLog(@"Checking for portal with portal value (%f, %f).", portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y].x, portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y].y);
    NSLog(@"Stage is: %d", stage);
    if (portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y].x != 0 || portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y].y != 0) {
        if (portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y].x == 99 && portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y].y == stage) {
            [self moveToNextStageInScene];
            return YES;
        } else if (portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y].x == 99 && portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y].y == kAllowBattles) {
            allowBattles = YES;
        }
        
        else if(portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y].x == 99 && portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y].y != stage) {
            return NO;
        } else {
            [Teleportal teleportalToTile:portals[(int)sharedGameController.player.currentTile.x][(int)sharedGameController.player.currentTile.y]];
            return YES;
        }
    }
    return NO;
}

- (BOOL)isBlocked:(float)x y:(float)y {
    
    return blocked[(int)x][(int)y];
}

- (void)initAlfheimBattle {
	
	if (stage == 27) {
        
        BattleWaterSpirit *ws = [[BattleWaterSpirit alloc] initWithBattleLocation:1];
        [self addEntityToActiveEntities:ws];
        [ws release];
        [self moveToNextStageInScene];
        return;
    } else {
        int numberOfEnemies = 1 + arc4random() % ([sharedGameController.party count] + 1);
        for (int i = 1; i <= numberOfEnemies; i++) {
            int whichEnemy = arc4random() % 3;
            switch (whichEnemy) {
                case 0:
                    whichEnemy = whichEnemy;
                    BattlePoisonDemonMage *bpdm = [[BattlePoisonDemonMage alloc] initWithBattleLocation:i];
                    [self addEntityToActiveEntities:bpdm];
                    [bpdm release];
                    break;
                case 1:
                    whichEnemy = whichEnemy;
                    BattlePoisonDemonRider *bpdr = [[BattlePoisonDemonRider alloc] initWithBattleLocation:i];
                    [self addEntityToActiveEntities:bpdr];
                    [bpdr release];                    
                    break;
                case 2:
                    whichEnemy = whichEnemy;
                    BattleWaterSpirit *bws = [[BattleWaterSpirit alloc] initWithBattleLocation:i];
                    [self addEntityToActiveEntities:bws];
                    [bws release];
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (void)restoreMap {
    [super restoreMap];
    if (stage == 300) {
        for (AbstractEntity *entity in activeEntities) {
            if ([entity isMemberOfClass:[NPCEnemySwordMan class]]) {
                entity.active = NO;
            }
        }
        [self moveToNextStageInScene];
    }
    //if (stage == 90) {
      //  [self moveToNextStageInScene];
   // }
}

- (void)choiceboxSelectionWas:(int)aSelection {
    
    BattlePriest *priest = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
    [self removeTextbox];
    if (stage == 41) {
        switch (aSelection) {
            case 0:
                stage = 410;
                priest.friggFavor--;
                priest.freyaFavor--;
                [self moveToNextStageInScene];
                break;
            case 1:
                priest.freyaFavor++;
                priest.friggFavor++;
                [self moveToNextStageInScene];
                break;
                
            default:
                break;
        }
    }
    if (stage == 68) {
        switch (aSelection) {
            case 0:
                stage = 680;
                priest.tyrFavor++;
                priest.freyaFavor--;
                [self moveToNextStageInScene];
                break;
            case 1:
                stage = 6800;
                priest.odinFavor--;
                priest.tyrFavor--;
                [self moveToNextStageInScene];
                break;
            case 2:
                priest.friggFavor++;
                priest.freyaFavor++;
                [self moveToNextStageInScene];
                break;
                
            default:
                break;
        }
    }
    if (stage == 137) {
        switch (aSelection) {
            case 0:
                [self moveToNextStageInScene];
                break;
            case 1:
                stage = 135;
                [self moveToNextStageInScene];
                break;
                
            default:
                break;
        }
    }
    if (stage == 171) {
        switch (aSelection) {
            case 0:
                [sharedScriptReader createCutScene:15];
                break;
            case 1:
                stage = 1710;
                [sharedScriptReader createCutScene:16];
                break;
                
            default:
                break;
        }
    }
    if (stage == 185) {
        switch (aSelection) {
            case 0:
                [self removeTextbox];
                [self moveToNextStageInScene];
                break;
            case 1:
                stage = 184;
                for (AbstractEntity *entity in activeEntities) {
                    if ([entity isMemberOfClass:[NPCVolur class]]) {
                        entity.triggerNextStage = YES;
                    }
                }
                [self removeTextbox];
                [sharedInputManager setState:kWalkingAround_NoTouches];
                break;
                
            default:
                break;
        }
    }
    NSLog(@"Freya favor is: %f", priest.freyaFavor);
}

- (void)initBattle {
    
    if (stage == 89 || stage == 90 || stage == 8900) {
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
        switch (stage) {
            case 89:
                [self initSwampBoss];
                break;
            case 890:
                [self initCaveBoss];
                break;
            case 8900:
                [self initMountainBoss];
                break;
                
            default:
                break;
        }
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
    [super initBattle];
}

- (void)initSwampBoss {}

- (void)initMountainBoss {}

- (void)initCaveBoss {

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
    Bats *bats = [[Bats alloc] init];
    [self addEntityToActiveEntities:bats];
    [bats release];
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

- (void)initGiantCaveBoss {
    
    [Textbox textboxWithText:@"Here would be the boss fight"];
    [sharedInputManager setState:kCutScene_TextboxOnScreen];
}

@end
