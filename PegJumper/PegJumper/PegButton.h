//
//  PegButton.h
//  PegJumper
//
//  Created by Adham Meguid on 5/18/14.
//  Copyright (c) 2014 Organization XIII. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameView.h"

@interface PegButton : UIButton

@property (nonatomic) int row;
@property (nonatomic) int col;

-(id)initWithFrame: (CGRect) frame : (NSString *) name : (int) row : (int)col : (GameView *) parentGame;

@end
