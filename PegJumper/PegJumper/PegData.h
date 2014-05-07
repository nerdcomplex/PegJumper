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

-(id)init: (NSString*)name;

-(void) flipLoc: (int)i : (int)j;
-(BOOL) isDone;

+(BOOL) hasMove: (NSArray *)line;

@end
