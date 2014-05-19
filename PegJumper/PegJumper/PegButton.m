//
//  PegButton.m
//  PegJumper
//
//  Created by Adham Meguid on 5/18/14.
//  Copyright (c) 2014 Organization XIII. All rights reserved.
//

#import "PegButton.h"
#import "GameView.h"

@implementation PegButton
GameView *game;

-(id)initWithFrame: (CGRect) frame : (NSString *) name : (int) row : (int) col : (GameView *) parentGame {
    self = [super initWithFrame:frame];
    [self setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    self.row = row;
    self.col = col;
    game = parentGame;
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (![game started]) {
        [[game data] flipLoc:self.row :self.col];
        [game setStarted:YES];
    }
    else if ([[game possibleMoves] count]==0) {
        [game setCurrentPeg:[NSArray arrayWithObjects:[NSNumber numberWithInt:self.row],[NSNumber numberWithInt:self.col], nil]];
        [game setPossibleMoves:[[game data] possibleMoves:self.row :self.col]];
    }
    else if ([[game possibleMoves] containsObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:self.row],[NSNumber numberWithInt:self.col], nil]]) {
        [[game data] flipLoc:self.row :self.col];
        [[game data] flipLoc:[[[game currentPeg] objectAtIndex:0] intValue] :[[[game currentPeg] objectAtIndex:1] intValue]];
        [[game data] flipLoc:([[[game currentPeg] objectAtIndex:0] intValue]+self.row)/2 :([[[game currentPeg] objectAtIndex:1] intValue]+self.col)/2];
        
        [game setCurrentPeg:[[NSArray alloc] init]];
        [game setPossibleMoves:[[NSArray alloc] init]];
    }
    
    [game setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
