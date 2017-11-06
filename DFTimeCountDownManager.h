//
//  DFTimeCountDownManager.h
//  DevilFinger Team Project
//
//  Created by DevilFinger on 17/6/1.
//  Copyright © 2017年 DevilFinger Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DFTimeCountDownManagerDelegate <NSObject>

@optional
-(void)countDidDoWithValue:(CGFloat)timeValue;
-(void)countDidCancelWithValue:(CGFloat)timeValue;
-(void)countDidStopWithValue:(CGFloat)timeValue;
@end

@interface DFTimeCountDownManager : NSObject

/*
 是否倒计时
 */
@property (nonatomic, assign) BOOL isCountDown;

/*
 是否循环倒计时
 */
@property (nonatomic, assign) BOOL isCycle;

/*
 是否正在倒计时
 */
@property (nonatomic, assign) BOOL isCouning;

/*
 每次执行的时间间隔
 */
@property (nonatomic, assign) NSTimeInterval perCountDownTime;

/*
 倒计时最小时间
 */
@property (nonatomic, assign) CGFloat minCountDownTime;

/*
 倒计时最大时间
 */
@property (nonatomic, assign) CGFloat maxCountDownTime;

/*
 当前倒计时时间
 */
@property (nonatomic, assign) CGFloat currentTime;

/*
 倒计时代理
 */
@property (nonatomic, weak) id<DFTimeCountDownManagerDelegate> countDownDelegate;

/*
 单列
 */
+ (instancetype)sharedManager;

/*
 倒计时开始方法
 */
-(void)doAction;

/*倒计时停止方法*/
-(void)cancelAction;

/*
 倒计时重置方法
 */
-(void)redoAction;

/*
 立即刷新
 */
-(void)refreshImmediatel;
@end
