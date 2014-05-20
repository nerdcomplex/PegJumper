//
//  XIIIStats.h
//  StartPage
//
//  Created by Junie Khang on 5/8/14.
//  Copyright (c) 2014 choaterosemaryhall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XIIIStats : NSObject
@property (nonatomic) float avgTime;
@property (nonatomic) int wins;
@property (nonatomic) int losses;
@property (nonatomic) float avgPegs;
@property (nonatomic) int games;
-(void)endGame:(float)time : (bool)win : (int)pegs;

@end
