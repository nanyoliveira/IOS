//
//  AOAudioListener.m
//  On Fire
//
//  Created by Ariane de Oliveira on 09/07/2014.
//  Copyright (c) 2014 Ariane de Oliveira. All rights reserved.
//

#import "AOAudioListener.h"

@interface AOAudioListener ()



@end

@implementation AOAudioListener

AVAudioRecorder * recorder;
NSTimer * levelTimer;
double lowPassResults;
SEL audioSelector;

// I THINK THE CORRECT FOR THE SELECT TO WORK WOULD BE INITIALIZING THE CLASS WITH THE SELECTION

/*

-(id) initWithSelectior:(SEL) selector
{
    self = [super init];
    if(self)
    {
        audioSelector = @selector(selector);
    }
    
    return self;
}
 
 */

- (void)startListening{
    NSURL * url = [NSURL fileURLWithPath:@"/dev/null"];
    
    NSDictionary * audioSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                    [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                    [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                    [NSNumber numberWithInt:AVAudioQualityMax], AVEncoderAudioQualityKey, nil];
    
    NSError * error;
    
    recorder = [[AVAudioRecorder alloc]initWithURL:url settings:audioSettings error:&error];
    if(recorder)
    {
        [recorder prepareToRecord];
        recorder.meteringEnabled = YES;
        [recorder record];
        levelTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(levelTimerCallback:) userInfo:nil repeats:YES];
    }
    else{
        NSLog([error description]);
    }
}

-(void)levelTimerCallback:(NSTimer *)timer
{
    [recorder updateMeters];
    const double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
    lowPassResults = ALPHA *peakPowerForChannel + (1.0 - ALPHA)*lowPassResults;
    
    if(lowPassResults > 0.95)
    {
        
        NSLog(@"blowing");

        if(self.delegate != nil)
        {
            [self.delegate blowingAction];
        }
        else{
            NSLog(@"you must set a delegate first");
        }
    }
}

-(void) stopListening
{
    if(levelTimer != nil)
    {
        [levelTimer invalidate];
    }

}


@end
