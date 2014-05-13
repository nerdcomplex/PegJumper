//
//  PegData.h
//  PegJumper
//
//  Created by brshapiro on 5/7/14.
//
//

#import <Foundation/Foundation.h>

@interface PegData : NSObject

@property (strong,nonatomic) NSMutableArray *data;
@property (nonatomic,strong) NSString *format;

-(id)init: (NSString*)name : (int)size;

-(NSString*) getPeg:(int)i :(int)j;
-(int) numPegs;
-(void) flipLoc: (int)i : (int)j;
-(BOOL) isDone;
-(NSArray*) possibleMoves: (int) i : (int)j;

@end
