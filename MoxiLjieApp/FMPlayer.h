//
//  FMPlayer.h
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/8.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioStreamer.h"

@interface FMPlayer : NSObject <DOUAudioFile>

@property (nonatomic) NSURL *audioFileURL;

@end
