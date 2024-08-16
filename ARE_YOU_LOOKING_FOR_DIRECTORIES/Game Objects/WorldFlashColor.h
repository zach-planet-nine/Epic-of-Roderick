//
//  WorldFlashColor.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/16/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractGameObject.h"
#import "Global.h"

@class Image;

@interface WorldFlashColor : AbstractGameObject {
    
    Image *flashPixel;
}

+ (void)worldFlashColor:(Color4f)aColor;

- (id)initColorFlashWithColor:(Color4f)aColor;

@end
