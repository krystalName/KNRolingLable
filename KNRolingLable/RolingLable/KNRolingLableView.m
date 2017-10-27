//
//  KNRolingLableView.m
//  KNRolingLable
//
//  Created by 刘凡 on 2017/10/27.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "KNRolingLableView.h"

#define DEALY_WHEN_TITLE_IN_MIDDLE  3.0
#define DEALY_WHEN_TITLE_IN_BOTTOM  0.0

typedef NS_ENUM(NSInteger, KNTitlePosition){
    KNTitlePositionTop = 1,
    KNTitlePositionMiddle = 2,
    KNTitlePositionBottom = 3
};

@interface KNRolingLableView ()

//标题Lable;
@property(nonatomic, strong)UILabel *titleLable;
//内容数组
@property(nonatomic, strong)NSArray <NSString *>* contentsArray;
//top 位置
@property(nonatomic, assign)CGPoint topPosition;
//middle 位置
@property(nonatomic, assign)CGPoint middlePostion;
//bottom 位置
@property(nonatomic, assign)CGPoint bottomPostion;
/*
 1.控制延迟时间，当文字在中间时候。延时时间长一些。如3秒。这样可以让用户浏览清楚内容
 2.当文字隐藏在底部的时候，不需要延迟，这样衔接才流畅
 */
 
@property(nonatomic, assign) CGFloat needDealy;
@property(nonatomic, assign) NSInteger currentIndex;
@property(nonatomic, assign) BOOL shouldStop;

@end

@implementation KNRolingLableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //获取宽高
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetHeight(self.frame);
        //初始化位置
        self.topPosition = CGPointMake(width/2, -height/2);
        self.middlePostion = CGPointMake(width/2, height/2);
        self.bottomPostion = CGPointMake(width/2, height/2*3);
        
        //添加字符串
        [self addSubview:self.titleLable];
        self.titleLable.layer.bounds = CGRectMake(0, 0, width, height);
        self.titleLable.layer.position = self.middlePostion;
        //设置文字不跑出来
        self.clipsToBounds = YES;
        self.shouldStop = NO;
        self.needDealy = DEALY_WHEN_TITLE_IN_MIDDLE;
        self.currentIndex = 0;
        
    }
    return self;
}

-(void)setAnimationWithTextsL:(NSArray<NSString *> *)textArray{
    self.contentsArray = textArray;
    self.titleLable.text = textArray[0];
    [self startAnimation];
}

//开始动画
-(void)startAnimation{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:self.needDealy options:UIViewAnimationOptionTransitionFlipFromLeft
     animations:^{
        __strong typeof(weakSelf)StrongSelf = weakSelf;
        if ([StrongSelf currentTitlePosition] == KNTitlePositionMiddle) {
            StrongSelf.titleLable.layer.position = StrongSelf.topPosition;
        }else if([StrongSelf currentTitlePosition] == KNTitlePositionBottom){
            StrongSelf.titleLable.layer.position = StrongSelf.middlePostion;
        }
        
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf)StrongSelf = weakSelf;
        if ([StrongSelf currentTitlePosition] == KNTitlePositionTop) {
            StrongSelf.titleLable.layer.position = StrongSelf.bottomPostion;
            StrongSelf.needDealy = DEALY_WHEN_TITLE_IN_BOTTOM;
            StrongSelf.currentIndex ++;
            StrongSelf.titleLable.text = [StrongSelf.contentsArray objectAtIndex:[StrongSelf realCurrentIndex]];
        }else{
            StrongSelf.needDealy = DEALY_WHEN_TITLE_IN_MIDDLE;
        }
        //如果不是暂停。继续动画
        if (StrongSelf.shouldStop) {
            StrongSelf.titleLable.layer.position = StrongSelf.middlePostion;
            StrongSelf.titleLable.text = [StrongSelf.contentsArray objectAtIndex:[StrongSelf realCurrentIndex]];
        }else{
          [StrongSelf startAnimation];
        }
        
    }];

}

-(void)stopAnmation{
    self.shouldStop = YES;
}

-(void)continueAnmation{
    self.shouldStop = NO;
    [self startAnimation];
}

- (NSInteger)realCurrentIndex {
    return self.currentIndex % [self.contentsArray count];
}


- (KNTitlePosition)currentTitlePosition {
    if (self.titleLable.layer.position.y == self.topPosition.y) {
        return KNTitlePositionTop;
    } else if (self.titleLable.layer.position.y == self.middlePostion.y) {
        return KNTitlePositionMiddle;
    }
    return KNTitlePositionBottom;
}

//处理点击代理
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(KNRolingLableView:TouchAtIndex:)]) {
        [self.delegate KNRolingLableView:self TouchAtIndex:[self realCurrentIndex]];
    }
}

-(void)setTitleColor:(UIColor *)titleColor{
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
        _titleLable.textColor = _titleColor;
    }
}

-(void)setTitleFont:(UIFont *)titleFont{
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
        _titleLable.font = _titleFont;
    }
}


-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.font = [UIFont systemFontOfSize:14];
        _titleLable.textColor = [UIColor orangeColor];
        _titleLable.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLable;
}

@end
