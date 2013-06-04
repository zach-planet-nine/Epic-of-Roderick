//
//  Nioavellir.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractScene.h"

@interface Nioavellir : AbstractScene {
    
    BOOL blocked[100][100];
    CGPoint portals[100][100];
}

@end
