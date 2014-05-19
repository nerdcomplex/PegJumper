//
//  MusicDelegate.m
//  PegJumper
//
//  Created by brshapiro on 5/15/14.
//
//

#import <AVFoundation/AVFoundation.h>

#import "MusicDelegate.h"

@interface MusicDelegate ()

@property (strong,nonatomic) AVAudioPlayer *player;
@property (strong,nonatomic) NSArray *songs;
@property (nonatomic) int song;

@end

@implementation MusicDelegate

-(id) init
{
    self = [super init];
    
    //Play a random song.
    self.songs = [NSArray arrayWithObjects:
                  [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"UnforgivingBlade" ofType:@"m4a"]],
                  [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ThroughTheFireAndFlames" ofType:@"m4a"]],
                  [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CarolusRex(Sv)" ofType:@"m4a"]], nil];
    self.song = arc4random()%3;
    self.player=[[AVAudioPlayer alloc] initWithContentsOfURL:[self.songs objectAtIndex:self.song] error:nil];
    [self.player setDelegate:self];
    [self.player play];
    
    return self;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //When the current song finishes, play a different random song.
    NSMutableArray *temp = [NSMutableArray arrayWithObjects:@0,@1,@2, nil];
    [temp removeObjectAtIndex:self.song];
    self.song = [[temp objectAtIndex:arc4random()%2] intValue];
    
    [player stop];
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:[self.songs objectAtIndex:self.song] error:nil];
    [self.player setDelegate:self];
    [self.player play];
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
}
@end
