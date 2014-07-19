//
//  AOAudioListener.h
//  On Fire
//
//  Created by Ariane de Oliveira on 09/07/2014.
//  Copyright (c) 2014 Ariane de Oliveira. All rights reserved.
//


@protocol AOAudioListenerProtocols <NSObject>

@required
-(void)blowingAction;

@end

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface AOAudioListener : NSObject


-(void) stopListening;
- (void)startListening;
@property(weak, nonatomic) id<AOAudioListenerProtocols> delegate;
@end
