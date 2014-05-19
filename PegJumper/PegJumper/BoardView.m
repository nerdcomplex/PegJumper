//
//  BoardView.m
//  PegJumper
//
//  Created by brshapiro on 5/18/14.
//
//

#import "BoardView.h"

@implementation BoardView
UIBezierPath *boundary;

- (id)initWithFrame:(CGRect)frame : (NSString *) shape
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //boundary is the boundary of the board.
        if ([shape isEqualToString:@"Triangle"]) {
            boundary = [[UIBezierPath alloc] init];
            [boundary moveToPoint:CGPointMake(frame.size.width/2, 0)];
            [boundary addLineToPoint:CGPointMake(frame.size.width, frame.size.height)];
            [boundary addLineToPoint:CGPointMake(0, frame.size.height)];
            [boundary closePath];
        }
        if ([shape isEqualToString:@"Plus"]) {
            boundary = [[UIBezierPath alloc] init];
            [boundary moveToPoint:CGPointMake(.3*frame.size.width, 0)];
            [boundary addLineToPoint:CGPointMake(.7*frame.size.width, 0)];
            [boundary addLineToPoint:CGPointMake(.7*frame.size.width, .3*frame.size.height)];
            [boundary addLineToPoint:CGPointMake(frame.size.width, .3*frame.size.height)];
            [boundary addLineToPoint:CGPointMake(frame.size.width, .7*frame.size.height)];
            [boundary addLineToPoint:CGPointMake(.7*frame.size.width, .7*frame.size.height)];
            [boundary addLineToPoint:CGPointMake(.7*frame.size.width, frame.size.height)];
            [boundary addLineToPoint:CGPointMake(.3*frame.size.width, frame.size.height)];
            [boundary addLineToPoint:CGPointMake(.3*frame.size.width, .7*frame.size.height)];
            [boundary addLineToPoint:CGPointMake(0, .7*frame.size.height)];
            [boundary addLineToPoint:CGPointMake(0, .3*frame.size.height)];
            [boundary addLineToPoint:CGPointMake(.3*frame.size.width, .3*frame.size.height)];
            [boundary closePath];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //Replace brownColor with a fill that's dependant on Board Theme.
    [[UIColor brownColor] setFill];
    [boundary fill];
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        //If you click outside the board, you're just clicking the view behind TableView.
        //But if you click the board, nothing happens. This "do nothing" touchBegan overrides the superview's touchBegan, which is why you can only change currentPeg by clicking outside the board.
        if (![boundary containsPoint:[touch locationInView:self]]) {
            [[self superview] touchesBegan:[NSSet setWithObject:touch] withEvent:event];
        }
    }
}


@end
