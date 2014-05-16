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
    
    self.songs = [NSArray arrayWithObjects:
                  [NSURL fileURLWithPath:@"/Users/brshapiro/PegJumper/PegJumper/ThroughTheFireAndFlames.m4a"],
                  [NSURL fileURLWithPath:@"/Users/brshapiro/PegJumper/PegJumper/CarolusRex(Sv).m4a"],
                  [NSURL fileURLWithPath:@"/Users/brshapiro/PegJumper/PegJumper/UnforgivingBlade.m4a"], nil];
    self.song = arc4random()%3;
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:[self.songs objectAtIndex:self.song] error:nil];
    [self.player setDelegate:self];
    [self.player play];
    
    return self;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
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
