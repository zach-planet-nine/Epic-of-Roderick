//
//  Arena.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/17/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Arena.h"
#import "GameController.h"
#import "InputManager.h"
#import "SoundManager.h"
#import "Character.h"
#import "PackedSpriteSheet.h"
#import "FontManager.h"
#import "Image.h"
#import "Textbox.h"
#import "BattleRoderick.h"
#import "ParticleEmitter.h"
#import "AbstractBattleCharacter.h"
#import "AbstractEntity.h"
#import "Animation.h"
#import "OverMind.h"
#import "Choicebox.h"
#import "Bats.h"
#import "OldMan.h"
#import "Roderick.h"
#import "BattlePoisonDemonMage.h"
#import "BattlePoisonDemonRider.h"
#import "BattleExampleEnemyForMenus.h"
#import "BattleWaterSpirit.h"
#import "AnsuzMenuAnimation.h"
#import "EihwazMenuAnimation.h"
#import "IsaMenuAnimation.h"
#import "OthalaMenuAnimation.h"
#import "GromanthMenuAnimation.h"
#import "NordrinMenuAnimation.h"
#import "SudrinMenuAnimation.h"
#import "AustrinMenuAnimation.h"
#import "VestrinMenuAnimation.h"
#import "HagalazMenuAnimation.h"
#import "JeraMenuAnimation.h"
#import "NauthizMenuAnimation.h"
#import "BerkanoMenuAnimation.h"
#import "PrimazMenuAnimation.h"
#import "AkathMenuAnimation.h"
#import "HolgethMenuAnimation.h"
#import "RaidhoMenuAnimation.h"
#import "MannazMenuAnimation.h"
#import "TiwazMenuAnimation.h"
#import "IngwazMenuAnimation.h"
#import "FyrazMenuAnimation.h"
#import "DaleythMenuAnimation.h"
#import "EkwazMenuAnimation.h"
#import "FehuMenuAnimation.h"
#import "UruzMenuAnimation.h"
#import "ThurisazMenuAnimation.h"
#import "AlgizMenuAnimation.h"
#import "LaguzMenuAnimation.h"
#import "HoppatMenuAnimation.h"
#import "SwopazMenuAnimation.h"
#import "WunjoMenuAnimation.h"
#import "GeboMenuAnimation.h"
#import "EhwazMenuAnimation.h"
#import "DagazMenuAnimation.h"
#import "IngrethMenuAnimation.h"
#import "HelazMenuAnimation.h"
#import "EpelthMenuAnimation.h"
#import "SmeazMenuAnimation.h"
#import "KenazMenuAnimation.h"
#import "SowiloMenuAnimation.h"
#import "DwarfapultMenuAnimation.h"
#import "BuyARoundMenuAnimation.h"
#import "FinishingMoveMenuAnimation.h"
#import "BoobytrapMenuAnimation.h"
#import "SuperAxerangMenuAnimation.h"
#import "TiledMap.h"
#import "MotivateMenuAnimation.h"
#import "BombulusMenuAnimation.h"
#import "Ranger.h"
#import "Seior.h"

@implementation Arena

- (id)init
{
    self = [super init];
    if (self) {
        battleImage = [[Image alloc] initWithImageNamed:@"jotunheim.png" filter:GL_LINEAR];
        //battleImage = [sharedGameController.teorPSS imageForKey:@"BeachBackground480x320.png"];
        sceneMap = [[TiledMap alloc] initWithFileName:@"SnowyCamp" fileExtension:@"tmx"];
        battleFont = [sharedFontManager getFontWithKey:@"battleFont"];
        sharedGameController.realm = kRealm_Midgard;
        [sharedInputManager setUpRuneRect];
        [sharedSoundManager loadMusicWithKey:@"battle" musicFile:@"battle mode.mp3"];
        Seior *rod = [[Seior alloc] initAtLocation:CGPointMake(77 * 40, 36 * 40)];
        OldMan *oldMan = [[OldMan alloc] initAtLocation:CGPointMake(77 * 40, 40 * 40)];
        oldMan.triggerNextStage = YES;
        sharedGameController.player = rod;
        [self addEntityToActiveEntities:rod];
        [self addEntityToActiveEntities:oldMan];
        [rod release];
        [oldMan release];
        sharedGameController.gameState = kGameState_World;
        //Textbox *tb = [[Textbox alloc] initWithRect:CGRectMake(120, 120, 100, 40) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:2 animating:NO text:@"This is a test"];
        //[self addObjectToActiveObjects:tb];
        //[tb release];
        cutScene = YES;
        cutSceneTimer = 0.5;
        stage = 0;
    }
    
    return self;
}

- (void)restoreMap {
    
    [super restoreMap];
    [self initBattle];
}

- (void)moveToNextStageInScene {
    
    switch (stage) {
        case 0:
            stage++;
            //[sharedSoundManager playMusicWithKey:@"battle" timesToRepeat:-1];
            /*for (Character *character in sharedGameController.party) {
                character.essence = character.maxEssence = 10;
                int level = 50;
                while (level != 0) {
                    [character levelUp];
                    level--;
                }
            }*/
            //[self initBattle];
            Character *roderick = [sharedGameController.characters objectForKey:@"Roderick"];
            Character *valkyrie = [sharedGameController.characters objectForKey:@"Valkyrie"];
            Character *seior = [sharedGameController.characters objectForKey:@"Wizard"];
            Character *bud = [sharedGameController.characters objectForKey:@"Ranger"];
            Character *alvis = [sharedGameController.characters objectForKey:@"Dwarf"];
            Character *poet = [sharedGameController.characters objectForKey:@"Priest"];
            NSLog(@"No problem getting characters.");
            AnsuzMenuAnimation *ansuz = [[AnsuzMenuAnimation alloc] init];
            EihwazMenuAnimation *eihwaz = [[EihwazMenuAnimation alloc] init];
            IsaMenuAnimation *isarune = [[IsaMenuAnimation alloc] init];
            //OthalaMenuAnimation *othala = [[OthalaMenuAnimation alloc] init];
            GromanthMenuAnimation *gromanth = [[GromanthMenuAnimation alloc] init];
            NordrinMenuAnimation *nordrin = [[NordrinMenuAnimation alloc] init];
            SudrinMenuAnimation *sudrin = [[SudrinMenuAnimation alloc] init];
            AustrinMenuAnimation *austrin = [[AustrinMenuAnimation alloc] init];
            VestrinMenuAnimation *vestrin = [[VestrinMenuAnimation alloc] init];
            HagalazMenuAnimation *hagalaz = [[HagalazMenuAnimation alloc] init];
            JeraMenuAnimation *jera = [[JeraMenuAnimation alloc] init];
            NauthizMenuAnimation *nauthiz = [[NauthizMenuAnimation alloc] init];
            BerkanoMenuAnimation *berkano = [[BerkanoMenuAnimation alloc] init];
            PrimazMenuAnimation *primaz = [[PrimazMenuAnimation alloc] init];
            AkathMenuAnimation *akath = [[AkathMenuAnimation alloc] init];
            HolgethMenuAnimation *holgeth = [[HolgethMenuAnimation alloc] init];
            RaidhoMenuAnimation *raidho = [[RaidhoMenuAnimation alloc] init];
            MannazMenuAnimation *mannaz = [[MannazMenuAnimation alloc] init];
            TiwazMenuAnimation *tiwaz = [[TiwazMenuAnimation alloc] init];
            IngwazMenuAnimation *ingwaz = [[IngwazMenuAnimation alloc] init];
            FyrazMenuAnimation *fyraz = [[FyrazMenuAnimation alloc] init];
            DaleythMenuAnimation *daleyth = [[DaleythMenuAnimation alloc] init];
            EkwazMenuAnimation *ekwaz = [[EkwazMenuAnimation alloc] init];
            FehuMenuAnimation *fehu = [[FehuMenuAnimation alloc] init];
            UruzMenuAnimation *uruz = [[UruzMenuAnimation alloc] init];
            ThurisazMenuAnimation *thurisaz = [[ThurisazMenuAnimation alloc] init];
            AlgizMenuAnimation *algiz = [[AlgizMenuAnimation alloc] init];
            LaguzMenuAnimation *laguz = [[LaguzMenuAnimation alloc] init];
            HoppatMenuAnimation *hoppat = [[HoppatMenuAnimation alloc] init];
            SwopazMenuAnimation *swopaz = [[SwopazMenuAnimation alloc] init];
            WunjoMenuAnimation *wunjo = [[WunjoMenuAnimation alloc] init];
            GeboMenuAnimation *gebo = [[GeboMenuAnimation alloc] init];
            EhwazMenuAnimation *ehwaz = [[EhwazMenuAnimation alloc] init];
            DagazMenuAnimation *dagaz = [[DagazMenuAnimation alloc] init];
            IngrethMenuAnimation *ingreth = [[IngrethMenuAnimation alloc] init];
            HelazMenuAnimation *helaz = [[HelazMenuAnimation alloc] init];
            EpelthMenuAnimation *epelth = [[EpelthMenuAnimation alloc] init];
            SmeazMenuAnimation *smeaz = [[SmeazMenuAnimation alloc] init];
            KenazMenuAnimation *kenaz = [[KenazMenuAnimation alloc] init];
            SowiloMenuAnimation *sowilo = [[SowiloMenuAnimation alloc] init];
            DwarfapultMenuAnimation *dwarfapult = [[DwarfapultMenuAnimation alloc] init];
            BuyARoundMenuAnimation *buyaround = [[BuyARoundMenuAnimation alloc] init];
            FinishingMoveMenuAnimation *finishingmove = [[FinishingMoveMenuAnimation alloc] init];
            BoobytrapMenuAnimation *boobytrap = [[BoobytrapMenuAnimation alloc] init];
            SuperAxerangMenuAnimation *superaxerang = [[SuperAxerangMenuAnimation alloc] init];
            MotivateMenuAnimation *motivate = [[MotivateMenuAnimation alloc] init];
            BombulusMenuAnimation *bomb = [[BombulusMenuAnimation alloc] init];
            NSLog(@"No problem initializing runes.");
            [roderick learnRune:ansuz withKey:@"Ansuz"];
            [bud learnRune:eihwaz withKey:@"Eihwaz"];
            [roderick learnRune:isarune withKey:@"Isa"];
            //[roderick learnRune:othala withKey:@"Othala"];
            [roderick learnRune:gromanth withKey:@"Gromanth"];
            [roderick learnRune:nordrin withKey:@"Nordrin"];
            [roderick learnRune:sudrin withKey:@"Sudrin"];
            [roderick learnRune:austrin withKey:@"Austrin"];
            [roderick learnRune:vestrin withKey:@"Vestrin"];
            [valkyrie learnRune:sowilo withKey:@"Sowilo"];
            [valkyrie learnRune:hagalaz withKey:@"Hagalaz"];
            [valkyrie learnRune:jera withKey:@"Jera"];
            [valkyrie learnRune:nauthiz withKey:@"Nauthiz"];
            [valkyrie learnRune:berkano withKey:@"Berkano"];
            [valkyrie learnRune:primaz withKey:@"Primaz"];
            [valkyrie learnRune:akath withKey:@"Akath"];
            [valkyrie learnRune:holgeth withKey:@"Holgeth"];
            [seior learnRune:kenaz withKey:@"Kenaz"];
            [seior learnRune:raidho withKey:@"Raidho"];
            [seior learnRune:mannaz withKey:@"Mannaz"];
            [seior learnRune:tiwaz withKey:@"Tiwaz"];
            [seior learnRune:ingwaz withKey:@"Ingwaz"];
            [seior learnRune:fyraz withKey:@"Fyraz"];
            [seior learnRune:daleyth withKey:@"Daleyth"];
            [seior learnRune:ekwaz withKey:@"Ekwaz"];
            [bud learnRune:fehu withKey:@"Fehu"];
            [bud learnRune:uruz withKey:@"Uruz"];
            [bud learnRune:thurisaz withKey:@"Thurisaz"];
            [bud learnRune:algiz withKey:@"Algiz"];
            [bud learnRune:laguz withKey:@"Laguz"];
            [bud learnRune:hoppat withKey:@"Hoppat"];
            [bud learnRune:swopaz withKey:@"Swopaz"];
            [poet learnRune:gebo withKey:@"Gebo"];
            [poet learnRune:ehwaz withKey:@"Ehwaz"];
            [poet learnRune:dagaz withKey:@"Dagaz"];
            [poet learnRune:ingreth withKey:@"Ingreth"];
            [poet learnRune:helaz withKey:@"Helaz"];
            [poet learnRune:epelth withKey:@"Epelth"];
            [poet learnRune:smeaz withKey:@"Smeaz"];
            [poet learnRune:wunjo withKey:@"Wunjo"];
            [alvis learnRune:dwarfapult withKey:@"Dwarfapult"];
            [alvis learnRune:buyaround withKey:@"BuyARound"];
            [alvis learnRune:boobytrap withKey:@"Boobytrap"];
            [alvis learnRune:finishingmove withKey:@"FinishingMove"];
            [alvis learnRune:superaxerang withKey:@"SuperAxerang"];
            [alvis learnRune:motivate withKey:@"Motivate"];
            [alvis learnRune:bomb withKey:@"Bombulus"];
            NSLog(@"No problem with learning runes.");
            [sharedGameController.party addObject:roderick];
            [sharedGameController.party addObject:valkyrie];
            [sharedGameController.party addObject:seior];
            [sharedGameController.party addObject:alvis];
            [sharedGameController.party addObject:bud];
            [sharedGameController.party addObject:poet];
            [ansuz release];
            [eihwaz release];
            [isarune release];
            //[othala release];
            [gromanth release];
            [nordrin release];
            [sudrin release];
            [austrin release];
            [vestrin release];
            [hagalaz release];
            [jera release];
            [nauthiz release];
            [berkano release];
            [primaz release];
            [akath release];
            [holgeth release];
            [raidho release];
            [mannaz release];
            [tiwaz release];
            [ingwaz release];
            [fyraz release];
            [daleyth release];
            [ekwaz release];
            [fehu release];
            [uruz release];
            [thurisaz release];
            [algiz release];
            [laguz release];
            [hoppat release];
            [swopaz release];
            [gebo release];
            [ehwaz release];
            [dagaz release];
            [ingreth release];
            [helaz release];
            [epelth release];
            [smeaz release];
            [kenaz release];
            [sowilo release];
            [dwarfapult release];
            [buyaround release];
            [finishingmove release];
            [boobytrap release];
            [superaxerang release];
            [wunjo release];
            [motivate release];
            [bomb release];
            NSLog(@"No problem in the above.");
            // RuneStones
            Image *ansuzRS = [[[sharedGameController.teorPSS imageForKey:@"AnsuzRuneStone.png"] imageDuplicate] retain];
            Image *isaRS = [[[sharedGameController.teorPSS imageForKey:@"IsaRuneStone.png"] imageDuplicate] retain];
            Image *othalaRS = [[[sharedGameController.teorPSS imageForKey:@"OthalaRuneStone.png"] imageDuplicate] retain];
            Image *gromanthRS = [[[sharedGameController.teorPSS imageForKey:@"GromanthRuneStone.png"] imageDuplicate] retain];
            Image *nordrinRS = [[[sharedGameController.teorPSS imageForKey:@"NordrinRuneStone.png"] imageDuplicate] retain];
            Image *sudrinRS = [[[sharedGameController.teorPSS imageForKey:@"SudrinRuneStone.png"] imageDuplicate] retain];
            Image *austrinRS = [[[sharedGameController.teorPSS imageForKey:@"AustrinRuneStone.png"] imageDuplicate] retain];
            Image *vestrinRS = [[[sharedGameController.teorPSS imageForKey:@"VestrinRuneStone.png"] imageDuplicate] retain];
            Image *sowiloRS = [[[sharedGameController.teorPSS imageForKey:@"SowiloRuneStone.png"] imageDuplicate] retain];
            Image *hagalazRS = [[[sharedGameController.teorPSS imageForKey:@"HagalazRuneStone.png"] imageDuplicate] retain];
            Image *jeraRS = [[[sharedGameController.teorPSS imageForKey:@"JeraRuneStone.png"] imageDuplicate] retain];
            Image *nauthizRS = [[[sharedGameController.teorPSS imageForKey:@"NauthizRuneStone.png"] imageDuplicate] retain];
            Image *berkanoRS = [[[sharedGameController.teorPSS imageForKey:@"BerkanoRuneStone.png"] imageDuplicate] retain];
            Image *primazRS = [[[sharedGameController.teorPSS imageForKey:@"PrimazRuneStone.png"] imageDuplicate] retain];
            Image *akathRS = [[[sharedGameController.teorPSS imageForKey:@"AkathRuneStone.png"] imageDuplicate] retain];
            Image *holgethRS = [[[sharedGameController.teorPSS imageForKey:@"HolgethRuneStone.png"] imageDuplicate] retain];
            Image *kenazRS = [[[sharedGameController.teorPSS imageForKey:@"KenazRuneStone.png"] imageDuplicate] retain];
            Image *raidhoRS = [[[sharedGameController.teorPSS imageForKey:@"RaidhoRuneStone.png"] imageDuplicate] retain];
            Image *mannazRS = [[[sharedGameController.teorPSS imageForKey:@"MannazRuneStone.png"] imageDuplicate] retain];
            Image *tiwazRS = [[[sharedGameController.teorPSS imageForKey:@"TiwazRuneStone.png"] imageDuplicate] retain];
            Image *ingwazRS = [[[sharedGameController.teorPSS imageForKey:@"IngwazRuneStone.png"] imageDuplicate] retain];
            Image *fyrazRS = [[[sharedGameController.teorPSS imageForKey:@"FyrazRuneStone.png"] imageDuplicate] retain];
            Image *daleythRS = [[[sharedGameController.teorPSS imageForKey:@"DaleythRuneStone.png"] imageDuplicate] retain];
            Image *ekwazRS = [[[sharedGameController.teorPSS imageForKey:@"EkwazRuneStone.png"] imageDuplicate] retain];
            Image *eihwazRS = [[[sharedGameController.teorPSS imageForKey:@"EihwazRuneStone.png"] imageDuplicate] retain];
            Image *fehuRS = [[[sharedGameController.teorPSS imageForKey:@"FehuRuneStone.png"] imageDuplicate] retain];
            Image *uruzRS = [[[sharedGameController.teorPSS imageForKey:@"UruzRuneStone.png"] imageDuplicate] retain];
            Image *thurisazRS = [[[sharedGameController.teorPSS imageForKey:@"ThurisazRuneStone.png"] imageDuplicate] retain];
            Image *algizRS = [[[sharedGameController.teorPSS imageForKey:@"AlgizRuneStone.png"] imageDuplicate] retain];
            Image *laguzRS = [[[sharedGameController.teorPSS imageForKey:@"LaguzRuneStone.png"] imageDuplicate] retain];
            Image *hoppatRS = [[[sharedGameController.teorPSS imageForKey:@"HoppatRuneStone.png"] imageDuplicate] retain];
            Image *swopazRS = [[[sharedGameController.teorPSS imageForKey:@"SwopazRuneStone.png"] imageDuplicate] retain];
            Image *wunjoRS = [[[sharedGameController.teorPSS imageForKey:@"WunjoRuneStone.png"] imageDuplicate] retain];
            Image *geboRS = [[[sharedGameController.teorPSS imageForKey:@"GeboRuneStone.png"] imageDuplicate] retain];
            Image *ehwazRS = [[[sharedGameController.teorPSS imageForKey:@"EhwazRuneStone.png"] imageDuplicate] retain];
            Image *dagazRS = [[[sharedGameController.teorPSS imageForKey:@"DagazRuneStone.png"] imageDuplicate] retain];
            Image *ingrethRS = [[[sharedGameController.teorPSS imageForKey:@"IngrethRuneStone.png"] imageDuplicate] retain];
            Image *helazRS = [[[sharedGameController.teorPSS imageForKey:@"HelazRuneStone.png"] imageDuplicate] retain];
            Image *epelthRS = [[[sharedGameController.teorPSS imageForKey:@"EpelthRuneStone.png"] imageDuplicate] retain];
            Image *smeazRS = [[[sharedGameController.teorPSS imageForKey:@"SmeazRuneStone.png"] imageDuplicate] retain];
            [sharedGameController.runeStones addObject:ansuzRS];
            [sharedGameController.runeStones addObject:isaRS];
            [sharedGameController.runeStones addObject:othalaRS];
            [sharedGameController.runeStones addObject:gromanthRS];
            [sharedGameController.runeStones addObject:nordrinRS];
            [sharedGameController.runeStones addObject:sudrinRS];
            [sharedGameController.runeStones addObject:austrinRS];
            [sharedGameController.runeStones addObject:vestrinRS];
            [sharedGameController.runeStones addObject:sowiloRS];
            [sharedGameController.runeStones addObject:hagalazRS];
            [sharedGameController.runeStones addObject:jeraRS];
            [sharedGameController.runeStones addObject:nauthizRS];
            [sharedGameController.runeStones addObject:berkanoRS];
            [sharedGameController.runeStones addObject:primazRS];
            [sharedGameController.runeStones addObject:akathRS];
            [sharedGameController.runeStones addObject:holgethRS];
            [sharedGameController.runeStones addObject:kenazRS];
            [sharedGameController.runeStones addObject:raidhoRS];
            [sharedGameController.runeStones addObject:mannazRS];
            [sharedGameController.runeStones addObject:tiwazRS];
            [sharedGameController.runeStones addObject:ingwazRS];
            [sharedGameController.runeStones addObject:fyrazRS];
            [sharedGameController.runeStones addObject:daleythRS];
            [sharedGameController.runeStones addObject:ekwazRS];
            [sharedGameController.runeStones addObject:eihwazRS];
            [sharedGameController.runeStones addObject:fehuRS];
            [sharedGameController.runeStones addObject:uruzRS];
            [sharedGameController.runeStones addObject:thurisazRS];
            [sharedGameController.runeStones addObject:algizRS];
            [sharedGameController.runeStones addObject:laguzRS];
            [sharedGameController.runeStones addObject:hoppatRS];
            [sharedGameController.runeStones addObject:swopazRS];
            [sharedGameController.runeStones addObject:wunjoRS];
            [sharedGameController.runeStones addObject:geboRS];
            [sharedGameController.runeStones addObject:ehwazRS];
            [sharedGameController.runeStones addObject:dagazRS];
            [sharedGameController.runeStones addObject:ingrethRS];
            [sharedGameController.runeStones addObject:helazRS];
            [sharedGameController.runeStones addObject:epelthRS];
            [sharedGameController.runeStones addObject:smeazRS];
            [sharedGameController.runeStones addObject:ansuzRS];
            [sharedGameController.runeStones addObject:isaRS];
            [sharedGameController.runeStones addObject:othalaRS];
            [sharedGameController.runeStones addObject:gromanthRS];
            [sharedGameController.runeStones addObject:nordrinRS];
            [sharedGameController.runeStones addObject:sudrinRS];
            [sharedGameController.runeStones addObject:austrinRS];
            [sharedGameController.runeStones addObject:vestrinRS];
            [sharedGameController.runeStones addObject:sowiloRS];
            [sharedGameController.runeStones addObject:hagalazRS];
            [sharedGameController.runeStones addObject:jeraRS];
            [sharedGameController.runeStones addObject:nauthizRS];
            [sharedGameController.runeStones addObject:berkanoRS];
            [sharedGameController.runeStones addObject:primazRS];
            [sharedGameController.runeStones addObject:akathRS];
            [sharedGameController.runeStones addObject:holgethRS];
            [sharedGameController.runeStones addObject:kenazRS];
            [sharedGameController.runeStones addObject:raidhoRS];
            [sharedGameController.runeStones addObject:mannazRS];
            [sharedGameController.runeStones addObject:tiwazRS];
            [sharedGameController.runeStones addObject:ingwazRS];
            [sharedGameController.runeStones addObject:fyrazRS];
            [sharedGameController.runeStones addObject:daleythRS];
            [sharedGameController.runeStones addObject:ekwazRS];
            [sharedGameController.runeStones addObject:eihwazRS];
            [sharedGameController.runeStones addObject:fehuRS];
            [sharedGameController.runeStones addObject:uruzRS];
            [sharedGameController.runeStones addObject:thurisazRS];
            [sharedGameController.runeStones addObject:algizRS];
            [sharedGameController.runeStones addObject:laguzRS];
            [sharedGameController.runeStones addObject:hoppatRS];
            [sharedGameController.runeStones addObject:swopazRS];
            [sharedGameController.runeStones addObject:wunjoRS];
            [sharedGameController.runeStones addObject:geboRS];
            [sharedGameController.runeStones addObject:ehwazRS];
            [sharedGameController.runeStones addObject:dagazRS];
            [sharedGameController.runeStones addObject:ingrethRS];
            [sharedGameController.runeStones addObject:helazRS];
            [sharedGameController.runeStones addObject:epelthRS];
            [sharedGameController.runeStones addObject:smeazRS];

            cutScene = NO;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            stage = 1;
            break;
        case 1:
            stage++;
            [Textbox textboxWithText:@"You are about to enter battle, but first a couple of questions."];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 2:
            stage++;
            [Textbox textboxWithText:@"What level would you like to fight at?"];
            [Choicebox choiceboxWithChoices:[NSArray arrayWithObjects:@"5", @"15", @"25", @"35", @"50", nil]];
            break;
        case 3:
            stage++;
            [self removeTextbox];
            [Textbox textboxWithText:@"And what group of enemies would you like to fight?"];
            [Choicebox choiceboxWithChoices:[NSArray arrayWithObjects:@"Midgard", @"Alfheim", @"Training Dummy", nil]];
            break;
        case 4:
            stage++;
            [self removeTextbox];
            [Textbox textboxWithText:@"Ok, are you ready?"];
            [Choicebox choiceboxWithChoices:[NSArray arrayWithObjects:@"Yes", @"No", nil]];
            break;
        case 5:
            stage++;
            [self removeTextbox];
            for (Character *character in sharedGameController.party) {
                character.essence = character.maxEssence = 10;
                int gotoLevel = level;
                while (gotoLevel != 0) {
                    [character levelUp];
                    gotoLevel--;
                }
            }
            [self initBattle];
            break;
        case 7:
            for (Character *character in sharedGameController.party) {
                int startHp = character.maxHP;
                int startEnd = character.maxEndurance;
                int startEss = character.essence = character.maxEssence = 12;
                int startStr = character.strength;
                int startAgi = character.agility;
                int startDex = character.dexterity; 
                int startSta = character.stamina;
                int startPow = character.power;
                int startAff = character.affinity;
                int startLuck = character.luck;
                double hp10 = 0, hp20 = 0, hp30 = 0, hp40 = 0, hp50 = 0, hp60 = 0, hp70 = 0, hp80 = 0, hp90 = 0, hp100 = 0;
                double end10 = 0, end20 = 0, end30 = 0, end40 = 0, end50 = 0, end60 = 0, end70 = 0, end80 = 0, end90 = 0, end100 = 0;
                double ess10 = 0, ess20 = 0, ess30 = 0, ess40 = 0, ess50 = 0, ess60 = 0, ess70 = 0, ess80 = 0, ess90 = 0, ess100 = 0;
                double str10 = 0, str20 = 0, str30 = 0, str40 = 0, str50 = 0, str60 = 0, str70 = 0, str80 = 0, str90 = 0, str100 = 0;
                double agi10 = 0, agi20 = 0, agi30 = 0, agi40 = 0, agi50 = 0, agi60 = 0, agi70 = 0, agi80 = 0, agi90 = 0, agi100 = 0;
                double dex10 = 0, dex20 = 0, dex30 = 0, dex40 = 0, dex50 = 0, dex60 = 0, dex70 = 0, dex80 = 0, dex90 = 0, dex100 = 0;
                double sta10 = 0, sta20 = 0, sta30 = 0, sta40 = 0, sta50 = 0, sta60 = 0, sta70 = 0, sta80 = 0, sta90 = 0, sta100 = 0;
                double pow10 = 0, pow20 = 0, pow30 = 0, pow40 = 0, pow50 = 0, pow60 = 0, pow70 = 0, pow80 = 0, pow90 = 0, pow100 = 0;
                double aff10 = 0, aff20 = 0, aff30 = 0, aff40 = 0, aff50 = 0, aff60 = 0, aff70 = 0, aff80 = 0, aff90 = 0, aff100 = 0;
                double luc10 = 0, luc20 = 0, luc30 = 0, luc40 = 0, luc50 = 0, luc60 = 0, luc70 = 0, luc80 = 0, luc90 = 0, luc100 = 0;
                //character.essence = character.maxEssence = 10;
                int gotoLevel = 5000;
                while (gotoLevel != 0) {
                    [character levelUp];
                    gotoLevel--;
                    if(character.level == 10 || character.level == 20 || character.level == 30 ||
                       character.level == 40 || character.level == 50 || character.level == 60 || character.level == 70 ||
                       character.level == 80 || character.level == 90 || character.level == 100) {
                        switch (character.level) {
                            case 10:
                                hp10 += character.maxHP;
                                end10 += character.maxEndurance;
                                ess10 += character.maxEssence;
                                str10 += character.strength;
                                agi10 += character.agility;
                                dex10 += character.dexterity;
                                sta10 += character.stamina;
                                pow10 += character.power;
                                aff10 += character.affinity;
                                luc10 += character.luck;
                                break;
                            case 20:
                                hp20 += character.maxHP;
                                end20 += character.maxEndurance;
                                ess20 += character.maxEssence;
                                str20 += character.strength;
                                agi20 += character.agility;
                                dex20 += character.dexterity;
                                sta20 += character.stamina;
                                pow20 += character.power;
                                aff20 += character.affinity;
                                luc20 += character.luck;
                                break;
                            case 30:
                                hp30 += character.maxHP;
                                end30 += character.maxEndurance;
                                ess30 += character.maxEssence;
                                str30 += character.strength;
                                agi30 += character.agility;
                                dex30 += character.dexterity;
                                sta30 += character.stamina;
                                pow30 += character.power;
                                aff30 += character.affinity;
                                luc30 += character.luck;
                                break;
                            case 40:
                                hp40 += character.maxHP;
                                end40 += character.maxEndurance;
                                ess40 += character.maxEssence;
                                str40 += character.strength;
                                agi40 += character.agility;
                                dex40 += character.dexterity;
                                sta40 += character.stamina;
                                pow40 += character.power;
                                aff40 += character.affinity;
                                luc40 += character.luck;
                                break;
                            case 50:
                                hp50 += character.maxHP;
                                end50 += character.maxEndurance;
                                ess50 += character.maxEssence;
                                str50 += character.strength;
                                agi50 += character.agility;
                                dex50 += character.dexterity;
                                sta50 += character.stamina;
                                pow50 += character.power;
                                aff50 += character.affinity;
                                luc50 += character.luck;
                                break;
                            case 60:
                                hp60 += character.maxHP;
                                end60 += character.maxEndurance;
                                ess60 += character.maxEssence;
                                str60 += character.strength;
                                agi60 += character.agility;
                                dex60 += character.dexterity;
                                sta60 += character.stamina;
                                pow60 += character.power;
                                aff60 += character.affinity;
                                luc60 += character.luck;
                                break;
                            case 70:
                                hp70 += character.maxHP;
                                end70 += character.maxEndurance;
                                ess70 += character.maxEssence;
                                str70 += character.strength;
                                agi70 += character.agility;
                                dex70 += character.dexterity;
                                sta70 += character.stamina;
                                pow70 += character.power;
                                aff70 += character.affinity;
                                luc70 += character.luck;
                                break;
                            case 80:
                                hp80 += character.maxHP;
                                end80 += character.maxEndurance;
                                ess80 += character.maxEssence;
                                str80 += character.strength;
                                agi80 += character.agility;
                                dex80 += character.dexterity;
                                sta80 += character.stamina;
                                pow80 += character.power;
                                aff80 += character.affinity;
                                luc80 += character.luck;
                                break;
                            case 90:
                                hp90 += character.maxHP;
                                end90 += character.maxEndurance;
                                ess90 += character.maxEssence;
                                str90 += character.strength;
                                agi90 += character.agility;
                                dex90 += character.dexterity;
                                sta90 += character.stamina;
                                pow90 += character.power;
                                aff90 += character.affinity;
                                luc90 += character.luck;
                                break;
                            case 100:
                                hp100 += character.maxHP;
                                end100 += character.maxEndurance;
                                ess100 += character.maxEssence;
                                str100 += character.strength;
                                agi100 += character.agility;
                                dex100 += character.dexterity;
                                sta100 += character.stamina;
                                pow100 += character.power;
                                aff100 += character.affinity;
                                luc100 += character.luck;
                                character.maxHP = startHp;
                                character.maxEndurance = startEnd;
                                character.maxEssence = startEss;
                                character.strength = startStr;
                                character.agility = startAgi;
                                character.dexterity = startDex;
                                character.stamina = startSta;
                                character.power = startPow;
                                character.affinity = startAff;
                                character.luck = startLuck;
                                character.level = 1;
                                break;
                            default:
                                break;
                        }
                        //NSLog(@"%@'s stats are: %d, %d, %d, %d, %d, %d, %d, %d, %d. At level: %d.",[character getNameForCharacter:character.whichCharacter],character.hp,character.endurance,character.essence,character.strength,character.agility,character.dexterity,character.stamina,character.power,character.affinity,character.level);
                    }
                }
                //NSLog(@"%f",hp10);
                NSLog(@"%@'s lvl 60 stats average to:\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f\n%f",[character getNameForCharacter:character.whichCharacter], hp60 / 50, end60 / 50, ess60 / 50, str60 / 50, agi60 / 50, dex60 / 50, sta60 / 50, pow60 / 50, aff60 / 50, luc60 / 50);
                /*NSLog(@"%f",hp10 / 50.0);
                NSLog(@"%f",end10 / 50.0);
                NSLog(@"%f",ess10 / 50.0);
                NSLog(@"%f",str10 / 50.0);
                NSLog(@"%f",agi10 / 50.0);
                NSLog(@"%f",dex10 / 50.0);
                NSLog(@"%f",sta10 / 50.0);
                NSLog(@"%f",pow10 / 50.0);
                NSLog(@"%f",aff10 / 50.0);
                NSLog(@"%f",luc10 / 50.0);*/
            }
            break;
        case 88:
            stage = 890;
            for (Character *character in sharedGameController.party) {
                character.essence = character.maxEssence = 12;
                while (level != 0) {
                    [character levelUp];
                    level--;
                }
            }
            [self initBattle];
            break;
            
        case 100:
            stage++;
            cutScene = NO;
            sharedGameController.gameState = kGameState_Cutscene;
            Textbox *youHaveDied = [[Textbox alloc] initWithRect:CGRectMake(80, 120, 300, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:YES text:@"You have died."];
            [self addObjectToActiveObjects:youHaveDied];
            [youHaveDied release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 101:
            stage++;
            [activeEntities removeAllObjects];
            [activeObjects removeAllObjects];
            Textbox *playAgain = [[Textbox alloc] initWithRect:CGRectMake(80, 120, 300, 80) color:Color4fMake(0.3, 0.3, 0.3, 0.9) duration:-1 animating:NO text:@"Tap to play again."];
            [self addObjectToActiveObjects:playAgain];
            [playAgain release];
            [sharedInputManager setState:kCutScene_TextboxOnScreen];
            break;
        case 102:
            stage = 0;
            sharedGameController.gameState = kGameState_Battle;
            [self restoreMap];
            break;
            
        default:
            break;
    }
}

- (void)initBattle {
    
    if (stage == 89 || stage == 890 || stage == 8900) {
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
                //[self initSwampBoss];
                break;
            case 890:
                [self initCaveBoss];
                break;
            case 8900:
                //[self initMountainBoss];
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
        return;
    }
    [super initBattle];
}

- (void)initBattleEnemies {
    
    switch (realm) {
        case kRealm_Midgard:
            [super initMidgardBattle];
            break;
        case kRealm_Alfheim:
            [self initAlfheimBattle];
            break;
        case 15:
            [self initTrainingDummyBattle];
            break;
        
        default:
            break;
    }
}

- (void)initAlfheimBattle {
    int numberOfEnemies = 1 + arc4random() % 4;
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

- (void)initTrainingDummyBattle {
    BattleExampleEnemyForMenus *beem = [[BattleExampleEnemyForMenus alloc] init];
    int gotolevel = level;
    while (gotolevel > 0) {
        [beem levelUp];
        gotolevel--;
    }
    [self addEntityToActiveEntities:beem];
    [beem release];
}

- (void)initCaveBoss {
    
    Bats *bats = [[Bats alloc] init];
    [self addEntityToActiveEntities:bats];
    [bats release];
}

- (void)choiceboxSelectionWas:(int)aSelection {
    
    NSLog(@"Choicebox selection was %d", aSelection);
    switch (aSelection) {
        case 0:
            if (stage == 3) {
                level = 5;
            }
            if (stage == 4) {
                realm = kRealm_Midgard;
            }
            if (stage == 5) {
                [self moveToNextStageInScene];
            }
            break;
        case 1:
            if (stage == 3) {
                level = 15;
            }
            if (stage == 4) {
                realm = kRealm_Alfheim;
            }
            if (stage == 5) {
                stage = 4;
                [self removeTextbox];
                [sharedInputManager setState:kWalkingAround_NoTouches];
            }
            break;
        case 2:
            if (stage == 3) {
                level = 25;
            }
            if (stage == 4) {
                realm = 15;
            }
            break;
        case 3:
            if (stage == 3) {
                level = 35;
            }
            break;
        case 4:
            if (stage == 3) {
                level = 50;
            }
            break;
        default:
            break;
    }
    [self moveToNextStageInScene];
}


@end
