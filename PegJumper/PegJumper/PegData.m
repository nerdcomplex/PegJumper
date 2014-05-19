//
//  PegData.m
//  PegJumper
//
//  Created by brshapiro on 5/7/14.
//
//

#import "PegData.h"

@implementation PegData

//I've figured out how to do stuff with a triangle and plus, but I don't think my methods will work with other layouts — they'll need a little bit of tweaking at the very least. We'll talk about it on Thursday, but for now I'm giving this class a format variable, which tells us what the board layout is.

-(id)init: (NSString*)name : (int)size
{
    self = [super init];
    
    if ([name isEqualToString:@"Triangle"]&&size>=3) {
        self.data = [[NSMutableArray alloc] init];
        for (int i=1; i<=size; i++) {
            NSMutableArray *row = [[NSMutableArray alloc] init];
            for (int j=0; j<i; j++) {
                [row addObject:@"1"];
            }
            [self.data addObject:row];
        }
        self.format = @"Triangle";
        
        //This is the set-up for a triangle. Basically all I'm doing is taking the original triangle and left-aligning it. In the original triangle you can jump left, right, up-right, up-left, down-right, and down-left; in this triangle you can jump left, right, up, down, up-left, and down-right. In other words, I only need to look at one diagonal direction, instead of two.
        //Note that I'm using strings for entries. This is just a convenience thing; NSMutableArray can't take primitives, and strings are the fastest objects to define.
    }
    
    if ([name isEqualToString:@"Plus"]&&size%3==1&&size%2==1&&size>=7) {
        self.data = [[NSMutableArray alloc] init];
        NSMutableArray *row = [[NSMutableArray alloc] init];
        for (int i=0; i<size/3; i++) {
            [row addObject:@"-1"];
        }
        for (int i=0; i<=size/3; i++) {
            [row addObject:@"1"];
        }
        for (int i=0; i<size/3; i++) {
            [row addObject:@"-1"];
        }
        for (int i=0; i<size; i++) {
            [self.data addObject:[row copy]];
        }

        row = [[NSMutableArray alloc] init];
        for (int i=0; i<size; i++) {
            [row addObject:@"1"];
        }
        for (int i=size/3; i<=2*size/3; i++) {
            [self.data setObject:[row copy] atIndexedSubscript:i];
        }
        
        [row setObject:@"0" atIndexedSubscript:size/2];
        [self.data setObject:[row copy] atIndexedSubscript:size/2];
        
        self.format = @"Plus";
        
        //I'm using -1 to refer to forbidden regions, as opposed to empty spaces.
    }
    
    return self;
}

-(NSString*) getPeg:(int)i :(int)j
{
    @try {
        return [[self.data objectAtIndex:i] objectAtIndex:j];
    }
    @catch (NSException *e) {
        return @"-1";
    }
}

-(int) numPegs
{
    int num = 0;
    for (int i=0; i<[self.data count]; i++) {
        for (int j=0; j<[self.data count]; j++) {
            if ([[self getPeg:i :j] isEqualToString:@"1"]) {
                num++;
            }
        }
    }
    return num;
}

-(void) flipLoc: (int)i : (int)j
{
    if ([[[self.data objectAtIndex:i] objectAtIndex:j]  isEqual: @"0"]) {
        NSMutableArray *row = [[NSMutableArray alloc] initWithArray:[self.data objectAtIndex:i]];
        [row setObject:@"1" atIndexedSubscript:j];
        [self.data setObject:[row copy] atIndexedSubscript:i];
    }
    else if ([[[self.data objectAtIndex:i] objectAtIndex:j]  isEqual: @"1"]) {
        NSMutableArray *row = [[NSMutableArray alloc] initWithArray:[self.data objectAtIndex:i]];
        [row setObject:@"0" atIndexedSubscript:j];
        [self.data setObject:row atIndexedSubscript:i];
    }
}

-(BOOL) isDone
{
    if ([self.format isEqualToString:@"Triangle"]){
        //Check every row (with length 3 or more)
        for (int i=2; i<[self.data count]; i++) {
            if ([PegData hasMove:[self.data objectAtIndex:i]]) {
                return NO;
            }
        }
        
        //Check every column (with length 3 or more)
        for (int i=0; i<[self.data count]-2; i++) {
            NSMutableArray *col = [[NSMutableArray alloc] init];
            for (int j=i; j<[self.data count]; j++) {
                [col addObject:[[self.data objectAtIndex:j] objectAtIndex:i]];
            }
            if ([PegData hasMove:col]) {
                return NO;
            }
        }
        
        //Check every diagonal (with length 3 or more)
        for (int i=0; i<[self.data count]-2; i++) {
            NSMutableArray *diag = [[NSMutableArray alloc] init];
            for (int j=0; j+i<[self.data count]; j++) {
                [diag addObject:[[self.data objectAtIndex:j+i] objectAtIndex:j]];
            }
            if ([PegData hasMove:diag]) {
                return NO;
            }
        }
    }
    
    if ([self.format isEqualToString:@"Plus"]){
        //Check every row
        for (int i=0; i<[self.data count]; i++) {
            if ([PegData hasMove:[self.data objectAtIndex:i]]) {
                return NO;
            }
        }
        
        //Check every column
        for (int i=0; i<[self.data count]; i++) {
            NSMutableArray *col = [[NSMutableArray alloc] init];
            for (int j=0; j<[self.data count]; j++) {
                [col addObject:[[self.data objectAtIndex:j] objectAtIndex:i]];
            }
            if ([PegData hasMove:col]) {
                return NO;
            }
        }
        
        //Check every diagonal (with length 3 or more)
        NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:[self.data copy]];
        NSMutableArray *emptyRow = [[NSMutableArray alloc] init];
        for (int i=0; i<[self.data count]; i++) {
            [emptyRow addObject:@"-1"];
        }
        for (int i=0; i<[self.data count]/3; i++) {
            [temp addObject:emptyRow];
        }
        for (int i=2*[self.data count]/3; i<[temp count]; i++) {
            NSMutableArray *diag = [[NSMutableArray alloc] init];
            for (int n=0; n<=i&&n<[self.data count]; n++) {
                [diag addObject:[[temp objectAtIndex:i-n] objectAtIndex:n]];
            }
            if ([PegData hasMove:diag]) {
                return NO;
            }
            
            diag = [[NSMutableArray alloc] init];
            for (int n=0; n<=i&&n<[self.data count]; n++) {
                [diag addObject:[[temp objectAtIndex:i-n] objectAtIndex:[self.data count]-1-n]];
            }
            if ([PegData hasMove:diag]) {
                return NO;
            }
        }
    }

    return YES;
}

-(NSArray *)possibleMoves:(int)i :(int)j
{
    NSMutableArray *moves = [[NSMutableArray alloc] init];
    
    if (![[self getPeg:i :j] isEqualToString:@"1"]) {
        return moves;
    }
    
    if ([self.format isEqualToString:@"Triangle"]) {
        if (i>1&&[[self getPeg:i-1 :j] isEqualToString:@"1"]&&[[self getPeg:i-2 :j] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i-2],[NSNumber numberWithInt:j], nil]];
        }
        if (i<[self.data count]-2&&[[self getPeg:i+1 :j] isEqualToString:@"1"]&&[[self getPeg:i+2 :j] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i+2],[NSNumber numberWithInt:j], nil]];
        }
        if (j>1&&[[self getPeg:i :j-1] isEqualToString:@"1"]&&[[self getPeg:i :j-2] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i],[NSNumber numberWithInt:j-2], nil]];
        }
        if (j<[self.data count]-2&&[[self getPeg:i :j+1] isEqualToString:@"1"]&&[[self getPeg:i :j+2] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i],[NSNumber numberWithInt:j+2], nil]];
        }
        if (i<[self.data count]-2&&[[self getPeg:i+1 :j+1] isEqualToString:@"1"]&&[[self getPeg:i+2 :j+2] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i+2],[NSNumber numberWithInt:j+2], nil]];
        }
        if (j>1&&[[self getPeg:i-1 :j-1] isEqualToString:@"1"]&&[[self getPeg:i-2 :j-2] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i-2],[NSNumber numberWithInt:j-2], nil]];
        }
    }
    
    if ([self.format isEqualToString:@"Plus"]) {
        if (i>1&&[[self getPeg:i-1 :j] isEqualToString:@"1"]&&[[self getPeg:i-2 :j] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i-2],[NSNumber numberWithInt:j], nil]];
        }
        if (i<[self.data count]-2&&[[self getPeg:i+1 :j] isEqualToString:@"1"]&&[[self getPeg:i+2 :j] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i+2],[NSNumber numberWithInt:j], nil]];
        }
        if (j>1&&[[self getPeg:i :j-1] isEqualToString:@"1"]&&[[self getPeg:i :j-2] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i],[NSNumber numberWithInt:j-2], nil]];
        }
        if (j<[self.data count]-2&&[[self getPeg:i :j+1] isEqualToString:@"1"]&&[[self getPeg:i :j+2] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i],[NSNumber numberWithInt:j+2], nil]];
        }
        if (i>1&&j>1&&[[self getPeg:i-1 :j-1] isEqualToString:@"1"]&&[[self getPeg:i-2 :j-2] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i-2],[NSNumber numberWithInt:j-2], nil]];
        }
        if (i<[self.data count]-2&&j<[self.data count]-2&&[[self getPeg:i+1 :j+1] isEqualToString:@"1"]&&[[self getPeg:i+2 :j+2] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i+2],[NSNumber numberWithInt:j+2], nil]];
        }
        if (i>1&&j<[self.data count]-2&&[[self getPeg:i-1 :j+1] isEqualToString:@"1"]&&[[self getPeg:i-2 :j+2] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i-2],[NSNumber numberWithInt:j+2], nil]];
        }
        if (i<[self.data count]-2&&j>1&&[[self getPeg:i+1 :j-1] isEqualToString:@"1"]&&[[self getPeg:i+2 :j-2] isEqualToString:@"0"]) {
            [moves addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:i+2],[NSNumber numberWithInt:j-2], nil]];
        }
    }
    
    return moves;
    
    //Adham, you're the one who told me to add a possibleMoves method. You made me do this Adham. THIS IS YOUR FAULT.
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
