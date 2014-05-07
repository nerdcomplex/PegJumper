//
//  PegData.m
//  PegJumper
//
//  Created by brshapiro on 5/7/14.
//
//

#import "PegData.h"

@implementation PegData

//I've figured out how to do stuff with a triangle, but I don't think my methods will work with other layouts — they'll need a little bit of tweaking at the very least. We'll talk about it on Thursday, but for now I'm giving this class a format variable, which tells us what the board layout is.

-(id)init: (NSString*)name
{
    self = [super init];
    
    if ([name isEqualToString:@"Triangle"]) {
        self.data = [[NSMutableArray alloc] initWithObjects:
                     [[NSMutableArray alloc] initWithObjects:@"1", nil],
                     [[NSMutableArray alloc] initWithObjects:@"1",@"1", nil],
                     [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1", nil],
                     [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1",@"1", nil],
                      [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"1", nil],nil];
        self.format = name;
        
        //This is the set-up for a triangle of side-length five. Basically all I'm doing is taking the original triangle and left-aligning it. In the original triangle you can jump left, right, up-right, up-left, down-right, and down-left; in this triangle you can jump left, right, up, down, up-left, and down-right. In other words, I only need to look at one diagonal direction, instead of two.
        //Note that I'm using strings for entries. This is just a convenience thing; NSMutableArray can't take primitives, and strings are the fastest objects to define.
    }
    
    return self;
}

//I'm holding off on defining a getter method for individual pegs, because I don't know what parameters it'll need. For a standard triangle, the parameters would just be row and column (or i and j, as I use in flipLoc), but for weirder shapes those may not work.

-(void) flipLoc: (int)i : (int)j
{
    if ([self.format isEqualToString:@"Triangle"]){
        if ([[[self.data objectAtIndex:i] objectAtIndex:j]  isEqual: @"0"]) {
            [[self.data objectAtIndex:i] setObject:@"1" atIndex:j];
        }
        else {
            [[self.data objectAtIndex:i] setObject:@"0" atIndex:j];
        }
    }
    
}

-(BOOL) isDone
{
    if ([self.format isEqualToString:@"Triangle"]){
        //In order to know if a board is done, you have to check each line of length 3 or greater and see if you can make a move in that line. For our standard triangle of length 5, there are 9 such lines, so I've just defined this method to analyze those 9 cases individually. I'll make this method more general once I know what board layouts I'll be dealing with.
        
        if ([PegData hasMove:[self.data objectAtIndex:2]]) {
            return NO;
        }
        if ([PegData hasMove:[self.data objectAtIndex:3]]) {
            return NO;
        }
        if ([PegData hasMove:[self.data objectAtIndex:4]]) {
            return NO;
        }
        if ([PegData hasMove:[[NSArray alloc] initWithObjects:
                           [[self.data objectAtIndex:0] objectAtIndex:0],
                           [[self.data objectAtIndex:1] objectAtIndex:0],
                           [[self.data objectAtIndex:2] objectAtIndex:0],
                           [[self.data objectAtIndex:3] objectAtIndex:0],
                           [[self.data objectAtIndex:4] objectAtIndex:0],nil]]) {
            return NO;
        }
        if ([PegData hasMove:[[NSArray alloc] initWithObjects:
                           [[self.data objectAtIndex:1] objectAtIndex:1],
                           [[self.data objectAtIndex:2] objectAtIndex:1],
                           [[self.data objectAtIndex:3] objectAtIndex:1],
                           [[self.data objectAtIndex:4] objectAtIndex:1],nil]]) {
            return NO;
        }
        if ([PegData hasMove:[[NSArray alloc] initWithObjects:
                           [[self.data objectAtIndex:2] objectAtIndex:2],
                           [[self.data objectAtIndex:3] objectAtIndex:2],
                           [[self.data objectAtIndex:4] objectAtIndex:2],nil]]) {
            return NO;
        }
        if ([PegData hasMove:[[NSArray alloc] initWithObjects:
                           [[self.data objectAtIndex:0] objectAtIndex:0],
                           [[self.data objectAtIndex:1] objectAtIndex:1],
                           [[self.data objectAtIndex:2] objectAtIndex:2],
                           [[self.data objectAtIndex:3] objectAtIndex:3],
                           [[self.data objectAtIndex:4] objectAtIndex:4],nil]]) {
            return NO;
        }
        if ([PegData hasMove:[[NSArray alloc] initWithObjects:
                           [[self.data objectAtIndex:1] objectAtIndex:0],
                           [[self.data objectAtIndex:2] objectAtIndex:1],
                           [[self.data objectAtIndex:3] objectAtIndex:2],
                           [[self.data objectAtIndex:4] objectAtIndex:3],nil]]) {
            return NO;
        }
        if ([PegData hasMove:[[NSArray alloc] initWithObjects:
                           [[self.data objectAtIndex:2] objectAtIndex:0],
                           [[self.data objectAtIndex:3] objectAtIndex:1],
                           [[self.data objectAtIndex:4] objectAtIndex:2],nil]]) {
            return NO;
        }
    }

    return YES;
}

//In order for you to make a move, a line needs to contain 0-1-1 or 1-1-0 — i.e., you have to be able to jump left or right (left and right here are constructs of the way the NSArray is created, it doesn't necessarily mean left and right on board). This checks for those two triplets.
+(BOOL) hasMove: (NSArray *)line
{
    if ([line count] < 3) {
        return NO;
    }
    
    for (int i=0; i<[line count]-2; i++) {
        if ([[line subarrayWithRange:NSMakeRange(i, 3)] isEqualToArray:[[NSArray alloc] initWithObjects:@"0",@"1",@"1", nil]] || [[line subarrayWithRange:NSMakeRange(i, 3)] isEqualToArray:[[NSArray alloc] initWithObjects:@"1",@"1",@"0", nil]])
        {
            return YES;
        }
    }
    
    return NO;
}

@end
