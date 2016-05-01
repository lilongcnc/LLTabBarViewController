//
//  LLTabBarView.m
//  LLTabBarViewController
//
//  Created by 李龙 on 16/4/26.
//  Copyright © 2016年 lauren. All rights reserved.
//

#import "LLTabBarView.h"
#import "LLTabBar.h"
#import "LxDBAnything.h"

#define ColorWithRGB(r,g,b,p)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:p]
#define LLKeyWindowSize [UIScreen mainScreen].bounds.size
//避免宏循环引用
#define LLWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define LLStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;
@interface LLTabBarView ()
{
    CGAffineTransform trans;
}

/**
 *  背景视图：
 */
@property (nonatomic,strong) UIView * BackgroundView;
/**
 *  背景图片
 */
@property (nonatomic,strong) UIImageView * imageView;

@property (nonatomic,strong) NSMutableArray *tabBarArray;

@end


@implementation LLTabBarView

- (instancetype)init {
    if (self = [super init]) {
        //初始化控件
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //初始化控件
        [self initSubViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        //初始化控件
        [self initSubViews];
    }
    return self;
}

static CGFloat const tabBarViewHeight = 49;//TabBarView高度
- (void)initSubViews{
    //自定义tabBar
    _BackgroundView = ({
        
        UIView *tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, tabBarViewHeight)];
        //设置底部tabBar的颜色,可透明clearColor
        tabBarView.backgroundColor = ColorWithRGB(238, 238, 238, 1.0);
        [self addSubview:tabBarView];
        tabBarView;
        
    });
    
    _imageView = ({
        
        UIImageView *tabBarViewBgIconView = [[UIImageView alloc] initWithFrame:_BackgroundView.bounds];
        tabBarViewBgIconView.image = [UIImage imageNamed:@"icon_tabBar"];
        tabBarViewBgIconView.userInteractionEnabled = YES;
        [_BackgroundView addSubview:tabBarViewBgIconView];
        /**
         *  保持transform
         */
        tabBarViewBgIconView;
    });
    
    trans = _BackgroundView.transform;
    

}

//按钮宽度
static CGFloat const tabBarwidth = 50;


-(void)setTabbarViewTitleArray:(NSArray *)titleArray norImagesArr:(NSArray *)norImagesArr seleImagesArr:(NSArray *)seleImagesArr tabBar:(UITabBar *)tabBar{
    
    //干掉系统的tabbar
    for (UIView * view in tabBar.subviews)
    {
        [view removeFromSuperview];
    }
    tabBar.hidden = YES;
    
    
    
    NSInteger titleArrCount = titleArray.count;
    if(_tabBarStyle == LLTabBarViewControllerNormalStyle){
        
        
    }else if (_tabBarStyle == LLTabBarViewControllerCenterTabBarUpStyle){
        
    }
    


    //设置点击view的样式
    CGFloat margin = (LLKeyWindowSize.width - tabBarwidth*titleArrCount)/(titleArrCount+1);
    
    NSInteger index = 0;
    for (NSInteger i = 0; i<titleArrCount; i++)
    {
        
        LLTabBar *tabbar = [[LLTabBar alloc] init];
        
        tabbar.layer.borderColor = [self randomColor].CGColor;
        tabbar.layer.borderWidth = 2.f;
        
        //设置凸起中间
//        if(i==2){
//            tabbar.frame = CGRectMake(margin+(tabBarwidth+margin)*i, -10, 50 , 49);
//            [tabbar setIconViewSize:CGSizeMake(56, 56)];
//        }else{
        
//        NSInteger aaa = i>((titleArrCount-1)*0.5-1)?i:index++;
//        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        //设置除了中间之外的按钮
        if (i == (titleArrCount-1)/2) {
            continue;
        }
        CGFloat buttonX = (margin+(tabBarwidth+margin)*(index > 1?(index + 1):index));
        LxDBAnyVar(index);
        tabbar.frame = CGRectMake(buttonX, 0, 50 , 49);
        index++;
        LxDBAnyVar(index);
        
        
        
        tabbar.tag = i;
        tabbar.normalImage = [UIImage imageNamed:norImagesArr[i]];
        tabbar.selectedImage = [UIImage imageNamed:seleImagesArr[i]];
        tabbar.title = titleArray[i];
        
        //接收点击事件
        [tabbar setTabBarViewClickBlock:^(LLTabBar *tabBar,NSInteger tag, UIImageView *iconView, UILabel *titleLabel) {
            NSLog(@"%s--------tag:%zd----------iconView:%@-------titleLabel:%@",__FUNCTION__,tag,iconView,titleLabel.text);
            //改变 tabBar 状态
            [self changeTaBarStatus:tabBar index:i];
            //点击事件
            if (_tabBarOnClickBlock) {
                _tabBarOnClickBlock(tag);
            }
        }];
        
        //设置默认选中
        if(i==0){
            tabbar.isDefault = YES;
        }
        [_imageView addSubview:tabbar];
        [self.tabBarArray addObject:tabbar];
    }
    
    
    
    
    //设置中间的按钮
}





- (void)changeTaBarStatus:(LLTabBar *)tabBar index:(NSInteger)i{

    for (int i = 0; i < _tabBarArray.count; i++)
    {
        LLTabBar *tabBar = (LLTabBar *)_tabBarArray[i];
        tabBar.selected = NO;
    }
    tabBar.selected = !tabBar.selected;
}

//隐藏
- (void)HideTabarView:(BOOL)isHideen  animated:(BOOL)animated
{
    //隐藏
    if (isHideen == YES)
    {
        //需要动画
        if (animated)
        {
            [UIView animateWithDuration:0.6 animations:^{
            //旋转动画:
            _BackgroundView.transform = CGAffineTransformRotate(_BackgroundView.transform, M_PI);
            _BackgroundView.alpha = 0;
            }];
        }
        //没有动画
        else
        {
            _BackgroundView.alpha = 0;
        }
    }
    //显示
    else
    {
        //需要动画
        if (animated)
        {
            [UIView animateWithDuration:0.6 animations:^{
                _BackgroundView.alpha = 1.0;
                _BackgroundView.transform = trans;
            }];
        }
        //没有动画
        else
        {
            _BackgroundView.alpha = 1.0;
            _BackgroundView.transform = trans;
        }
    }
}



- (NSMutableArray *)tabBarArray
{
    if (!_tabBarArray) {
        _tabBarArray = [[NSMutableArray alloc] init];
    }
    return _tabBarArray;
}


- (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


@end
