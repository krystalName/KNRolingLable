# KNRolingLable

### 跑马灯效果lable. 简单使用。 上效果图

![](https://github.com/krystalName/KNRolingLable/blob/master/RolingLable.gif)

## 使用代码如下

```objc
#import "KNRolingLableView.h"

  @interface ViewController ()<KNRolingLableViewDelegate>

  @property(nonatomic, strong)KNRolingLableView *RolingLableView;

  _RolingLableView = [[KNRolingLableView alloc]initWithFrame:CGRectMake(10, 100, 300, 20)];
    _RolingLableView.delegate = self;
    [_RolingLableView setAnimationWithTextsL:@[@"这是第一条数据",@"这是第二条数据",@"这是第三条数据",@"这是第四条数据",]];
    _RolingLableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    [self.view addSubview:_RolingLableView];
    
```

### 实现代理方法。知道点击的下标
```objc

-(void)KNRolingLableView:(KNRolingLableView *)lableView TouchAtIndex:(NSInteger)index
{
    NSLog(@"Index :%ld",index);
    
}

```
