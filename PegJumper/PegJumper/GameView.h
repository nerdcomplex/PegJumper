//
//  GameView.h
//  PegJumper
//
//  Created by Adham Meguid on 5/18/14.
//  Copyright (c) 2014 Organization XIII. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PegData.h"

@interface GameView : UIView

@property (strong,nonatomic) PegData *data;
@property (strong,nonatomic) NSArray *possibleMoves;
@property (strong,nonatomic) NSArray *currentPeg;
@property (nonatomic) BOOL started;

- (id)initWithFrame:(CGRect)frame : (NSString *) shape : (int) size;

@end
