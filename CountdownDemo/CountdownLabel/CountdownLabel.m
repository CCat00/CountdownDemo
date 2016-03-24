//
//  CountdownLabel.m
//  CountdownDemo
//
//  Created by HanWei on 16/3/24.
//  Copyright © 2016年 AndLiSoft. All rights reserved.
//

#import "CountdownLabel.h"

@interface CountdownLabel ()
{
    dispatch_queue_t    _countdownQueue;
    dispatch_source_t   _timer;
}
@end

@implementation CountdownLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _countdownQueue = dispatch_queue_create("com.andlisoft.countdownDemo", DISPATCH_QUEUE_SERIAL);
    
    [self initTimer];
}

- (void)initTimer
{
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _countdownQueue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
}

- (void)setCountdownTime:(int)countdownTime
{
    _countdownTime = countdownTime;
    
    if (_countdownTime==0) return;
    
    if (!_timer) {
        
        [self initTimer];
    };
    
    __block int time = _countdownTime;
    dispatch_source_set_event_handler(_timer, ^{
        
        if (time <= 0) {
            dispatch_source_cancel(_timer);
            _timer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.text = @"0天0小时0分0秒";
            });
        }
        else {
            int days = (int)(time/(60*60*24));
            int hours = (int)((time-days*24*60*60)/(60*60));
            int minutes = (int)((time-days*24*60*60 - hours*60*60)/60);
            int seconds = time-days*24*60*60 - hours*60*60 - minutes*60;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.text = [NSString stringWithFormat:@"%d天%02d小时%02d分%02d秒", days, hours, minutes, seconds];
            });
        }
        time--;
    });
    dispatch_resume(_timer);
    
}

@end
