//
//  ViewController.m
//  KNRolingLable
//
//  Created by 刘凡 on 2017/10/27.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "ViewController.h"
#import "KNRolingLableView.h"



@interface ViewController ()<KNRolingLableViewDelegate>

@property(nonatomic, strong)KNRolingLableView *RolingLableView;

@property(nonatomic, strong)UIButton *KNStopButton;

@property(nonatomic, strong)UIButton *KNContinueButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _RolingLableView = [[KNRolingLableView alloc]initWithFrame:CGRectMake(10, 100, 300, 20)];
    _RolingLableView.delegate = self;
    [_RolingLableView setAnimationWithTextsL:@[@"这是第一条数据",@"这是第二条数据",@"这是第三条数据",@"这是第四条数据",]];
    _RolingLableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    [self.view addSubview:_RolingLableView];
    
    //暂停按钮
    _KNStopButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 50, 40, 20)];
    [_KNStopButton setTitle:@"暂停" forState:UIControlStateNormal];
    [_KNStopButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_KNStopButton addTarget:self action:@selector(Stop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_KNStopButton];
    
    //继续按钮
    _KNContinueButton = [[UIButton alloc]initWithFrame:CGRectMake( 100, 50, 40, 20)];
    [_KNContinueButton setTitle:@"继续" forState:UIControlStateNormal];
    [_KNContinueButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_KNContinueButton addTarget:self action:@selector(Continue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_KNContinueButton];
    
}

-(void)Stop:(UIButton *)sender{
    [_RolingLableView stopAnmation];
}

-(void)Continue:(UIButton *)sender{
    [_RolingLableView continueAnmation];
}

-(void)KNRolingLableView:(KNRolingLableView *)lableView TouchAtIndex:(NSInteger)index
{
    NSLog(@"Index :%ld",index);
    
}

@end
