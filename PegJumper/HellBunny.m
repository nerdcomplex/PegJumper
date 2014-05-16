//
//  HellBunny.m
//  PegJumper
//
//  Created by brshapiro on 5/13/14.
//
//

#import "HellBunny.h"

@interface HellBunny ()

@property (strong,nonatomic) NSArray *function;

@end

@implementation HellBunny

-(id) init
{
    self = [super init];
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i=0; i<128; i++) {
        [temp addObject:[NSNumber numberWithInt:i%64]];
    }
    self.function = [HellBunny shuffle:temp];
    self.eggs = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO], nil];
    
    return self;
    
    //Function is a random ordering of the range 1-64, with each number appearing twice. See HellHash to understand how it's used; the point is that, because functions is defined randomly, each HellBunny interprets settings in its own way. Like abyssal snowflakes fluttering through the sorrow-laden air over the frozen river Acheron, each HellBunny is unique.
}

-(void) hellHash: (int)boardShape : (int)background : (int)pegColor : (int)boardTheme : (int)music : (int)size : (BOOL)hellbunny
{
    //Possible values per setting:
    //Board shape: 2 (0-1)
    //Background: 4 (0-3)
    //Peg color: 4 (0-3)
    //Board theme: 2 (0-1)
    //Music: 2 (0-1)
    //Size can be any int. Hellbunny can be any bool.
    
    if (!hellbunny) {
        self.eggs = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO], nil];
        //Eggs is just a list of weird stuff happening at the moment. If the hellbunny easter egg hasn't activated, then there are no eggs.
    }
    else {
        //The non-hellbunny, non-size settings are hashed into an integer between 0 and 127. Size is added to that number, looping back to 0 if it exceeds 127.
        //This number is then looked up by functions, creating an integer between 0 and 63, which is a binary representation of eggs. That binary representating is converted into an NSArray representation.
        
        int param = (boardShape + 2*background + 8*pegColor + 32*boardTheme + 64*music + size)%128;
        int result = [[self.function objectAtIndex:param] intValue];
        self.eggs = [[NSMutableArray alloc] init];
        for (int i=5; i>=0; i--) {
            if (result>=pow(2, i)) {
                [self.eggs addObject:[NSNumber numberWithBool:YES]];
                result -= pow(2, i);
            }
            else {
                [self.eggs addObject:[NSNumber numberWithBool:NO]];
            }
        }
    }
    
    //eggs is an NSArray of booleans, with each index representing a different alteration to the game:
    //0: When you win, King Arthur shouts "1... 2... 5!" "3, Sire, 3!" and then lobs the holy hand grenade.
    //1: When you lose, a Hellbunny appears and annihilates you with its laser and fire.
    //2: Throughout the game, the background is green and the Hellbunny is visible (but unhappy). When you lose, the background becomes orange and the Hellbunny happy.
    //3: All text is transliterated into the Vile Tongue of Orcus, Cursed Master of the Dead (aka Old Hungarian).
    //4: All text is translated into Swedish, Sabaton switches to the English version.
    //5: All insults of the day compliment you and end with the sentence, "I love you... that's why I'll kill you last."
}

+(NSArray*) shuffle: (NSArray*) list
{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:[list copy]];
    for (int i=0; i<[temp count]; i++) {
        [temp exchangeObjectAtIndex:i withObjectAtIndex:i+(arc4random()%([temp count]-i))];
    }
    return temp;
}

@end
