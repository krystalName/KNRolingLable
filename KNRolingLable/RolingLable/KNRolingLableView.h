//
//  KNRolingLableView.h
//  KNRolingLable
//
//  Created by 刘凡 on 2017/10/27.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KNRolingLableView;

@protocol KNRolingLableViewDelegate <NSObject>

/**
 点击LbaleView 的时候触发事件

 @param lableView self
 @param index 触发的下标
 */
-(void)KNRolingLableView:(KNRolingLableView *)lableView TouchAtIndex:(NSInteger)index;

@end;


@interface KNRolingLableView : UIView

/**
 点击代理
 */
@property(nonatomic, assign) id<KNRolingLableViewDelegate> delegate;


/**
 设置动画滚动的字符串数组

 @param textArray 滚动内容数组
 */
-(void)setAnimationWithTextsL:(NSArray <NSString *> *)textArray;

/**
 暂停动画
 */
-(void)stopAnmation;

//继续动画
-(void)continueAnmation;
@end
