//
//  MusicDelegate.h
//  PegJumper
//
//  Created by brshapiro on 5/15/14.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicDelegate : NSObject<AVAudioPlayerDelegate>

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error;

@end
