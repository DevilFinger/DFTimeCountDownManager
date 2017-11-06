//
//  DFTimeCountDownManager.m
//  DevilFinger Team Project
//
//  Created by DevilFinger on 17/6/1.
//  Copyright © 2017年 DevilFinger Team. All rights reserved.
//

#import "DFTimeCountDownManager.h"



@implementation DFTimeCountDownManager

+ (nonnull instancetype)sharedManager {
    static dispatch_once_t once;
    static DFTimeCountDownManager *sharedManager;
    dispatch_once(&once, ^{
        sharedManager = [DFTimeCountDownManager new];
    });
    return sharedManager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.isCountDown = YES;
        self.isCycle = NO;
        self.isCouning = NO;
        self.perCountDownTime = 1.0f;
        self.minCountDownTime = 0.0f;
        self.maxCountDownTime = 15.0f;
        self.currentTime = self.maxCountDownTime;
      
        
    }
    return self;
}

-(void)doAction
{
    self.isCouning = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(counting) object:nil];
    self.isCouning = YES;
    [self performSelector:@selector(counting) withObject:nil afterDelay:self.perCountDownTime];
}

-(void)cancelAction
{
    self.isCouning = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(counting) object:nil];
    if (self.countDownDelegate && [self.countDownDelegate respondsToSelector:@selector(countDidCancelWithValue:)]) {
        [self.countDownDelegate countDidCancelWithValue:self.currentTime];
        self.countDownDelegate = nil;
    }
}

-(void)redoAction
{
    
    self.isCouning = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(counting) object:nil];
    if (self.isCountDown) {
        self.currentTime = self.maxCountDownTime;
    }
    else
        self.currentTime = self.minCountDownTime;
    
    if (self.countDownDelegate && [self.countDownDelegate respondsToSelector:@selector(countDidDoWithValue:)]) {
        [self.countDownDelegate countDidDoWithValue:self.currentTime];
    }
    [self doAction];
}


-(void)counting
{
    NSLog(@"counting");
    if (self.isCountDown) {
        self.currentTime--;
    }
    else
        self.currentTime++;
    
    if (self.isCycle) {
        [self setCycleTime];
        if (self.countDownDelegate && [self.countDownDelegate respondsToSelector:@selector(countDidDoWithValue:)]) {
            [self.countDownDelegate countDidDoWithValue:self.currentTime];
        }
        [self doAction];
    }
    else
    {
        if ([self isToEnd]) {
            [self cancelAction];
            if (self.countDownDelegate && [self.countDownDelegate respondsToSelector:@selector(countDidStopWithValue:)]) {
                [self.countDownDelegate countDidStopWithValue:self.currentTime];
            }
        }
        else
        {
            if (self.countDownDelegate && [self.countDownDelegate respondsToSelector:@selector(countDidDoWithValue:)]) {
                [self.countDownDelegate countDidDoWithValue:self.currentTime];
            }
            [self doAction];
        }
    }
}


-(void)refreshImmediatel
{
    if (self.countDownDelegate && [self.countDownDelegate respondsToSelector:@selector(countDidDoWithValue:)]) {
        [self.countDownDelegate countDidDoWithValue:self.currentTime];
    }
}


-(BOOL)isToEnd
{
    if (self.isCountDown) {
        if (self.currentTime <= self.minCountDownTime) {
            return YES;
        }
        else
            return NO;
    }
    else
    {
        if (self.currentTime >= self.maxCountDownTime) {
            return YES;
        }
        else
            return NO;
    }
}

-(void)setCycleTime
{
    if (self.currentTime < self.minCountDownTime) {
        self.currentTime = self.maxCountDownTime;
    }
    
    if (self.currentTime > self.maxCountDownTime) {
        self.currentTime = self.minCountDownTime;
    }
}

-(void)setCountDownDelegate:(id<DFTimeCountDownManagerDelegate>)countDownDelegate
{
    if (_countDownDelegate) {
        if (self.isCouning) {
            [self cancelAction];
        }
        _countDownDelegate = nil;
    }
    _countDownDelegate = countDownDelegate;
}

@end
