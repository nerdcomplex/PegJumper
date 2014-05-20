//
//  XIIIStats.m
//  StartPage
//
//  Created by Junie Khang on 5/8/14.
//  Copyright (c) 2014 choaterosemaryhall. All rights reserved.
//

#import "XIIIStats.h"

@implementation XIIIStats

-(id)init
{
    self=[super init];
    self.avgTime=0;
    self.wins=0;
    self.losses=0;
    self.avgPegs=0;
    self.games=0;
    return self;
}
-(void)endGame:(float)time : (bool)win : (int)pegs
{
    self.avgTime= (self.games*self.avgTime + time)/(self.games+1);
    self.avgPegs= (self.games*self.avgPegs + pegs)/(self.games+1);
    self.games++;
    if (win)
    {
        self.wins++;
    }
    else
    {
        self.losses++;
    }
    
}
@end
