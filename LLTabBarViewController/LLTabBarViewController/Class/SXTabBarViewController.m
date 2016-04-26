//
//  SXTabBarViewController.m
//  SXCustomTabBar
//
//  Created by ShaoPro on 15/12/24.
//  Copyright © 2015年 ShaoPro. All rights reserved.
//

#import "SXTabBarViewController.h"
#import "LLTabBar.h"

typedef NS_OPTIONS(NSUInteger, LLTabBarViewControllerStyle) {
    LLTabBarViewControllerNormalStyle = 0,
    LLTabBarViewControllerCenterTabBarUpStyle = 1, //类似于咸鱼等,tabbar数量为奇数时候中间凸起,可自定义凸起的位置
    LLTabBarViewControllerCenterTabBarCenterStyle =2,  //类似于微博等,中间没有凸起但是占位比较大
    LLTabBarViewControllerOnlyImageStyle   //类似于人人只有图片,没有 title
};

@interface SXTabBarViewController ()
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
/**
 *  标题
 */
@property (nonatomic,strong) NSArray * titles;

@property (nonatomic,strong) NSMutableArray *tabBarArray;

@end

@implementation SXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    /**
     *  加载控制器：
     */
    [self loadChildControllers];
    /**
     *  自定义TabBar
     */
    [self creationCusTabBar];
    
}
#pragma mark - === 创建控制器  ===
- (void)loadChildControllers
{
    
    OneViewController * oneVC = [[OneViewController alloc]init];
    oneVC.title = @"测试一";
    TwoViewController * twoVC = [[TwoViewController alloc]init];
    twoVC.title = @"测试二";
    ThreeViewController * three = [[ThreeViewController alloc]init];
    three.title = @"测试三";
    
    UINavigationController * nav1 = [[UINavigationController alloc]initWithRootViewController:oneVC];
    [nav1.navigationBar setBarTintColor:[UIColor cyanColor]];
    
    UINavigationController * nav2 = [[UINavigationController alloc]initWithRootViewController:twoVC];
    [nav2.navigationBar setBarTintColor:[UIColor yellowColor]];
    
    UINavigationController * nav3 = [[UINavigationController alloc]initWithRootViewController:three];
    [nav3.navigationBar setBarTintColor:[UIColor redColor]];
    
    //添加控制器
    self.viewControllers = @[nav1,nav2,nav3,nav1,nav3,nav2];
    
}


#pragma mark - === 自定义的TabBar ==

static CGFloat const tabBarViewHeight = 49;//TabBarView高度

- (void)creationCusTabBar
{

    
    //干掉系统的tabbar
    for (UIView * view in self.tabBar.subviews)
    {
        [view removeFromSuperview];
    }
    self.tabBar.hidden = YES;
    
    
    //自定义tabBar
    _BackgroundView = ({
        
        UIView *tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-tabBarViewHeight, ScreenWidth, tabBarViewHeight)];
        //设置底部tabBar的颜色,可透明clearColor
        tabBarView.backgroundColor = ColorWithRGB(238, 238, 238, 1.0);
        [self.view addSubview:tabBarView];
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
    

    
    
//    _titles = @[@"测试一",@"测试二",@"",@"测试三",@"测试si"];
//    NSArray * norImagesArr = @[@"tabbar_contacts",@"tabbar_discover",@"1",@"tabbar_mainframe",@"3"];
//    NSArray * seleImagesArr = @[@"tabbar_contactsHL",@"tabbar_discoverHL",@"11",@"tabbar_mainframeHL",@"33"];
    
//    _titles = @[@"测试一",@"测试二",@"111"];
//    NSArray *norImagesArr = @[@"1",@"2",@"2",];
//    NSArray *seleImagesArr = @[@"11",@"22",@"22"];

    
    _titles = @[@"测试一",@"测试二",@"111",@"测试一",@"测试二",@"111"];
    NSArray *norImagesArr = @[@"1",@"2",@"2",@"1",@"2",@"2"];
    NSArray *seleImagesArr = @[@"11",@"22",@"22",@"1",@"2",@"2"];
    
    //按钮宽度
    CGFloat tabBarwidth = 50;
    //设置点击view的样式
    CGFloat margin = (ScreenWidth - tabBarwidth*_titles.count)/(_titles.count+1);
    for (NSInteger i = 0; i<_titles.count; i++)
    {
        
        LLTabBar *tabbar = [[LLTabBar alloc] init];
        
        tabbar.layer.borderColor = [self randomColor].CGColor;
        tabbar.layer.borderWidth = 2.f;
        
        //设置凸起中间
        if(i==2){
            tabbar.frame = CGRectMake(margin+(tabBarwidth+margin)*i, -10, 50 , 49);
        }else{
            tabbar.frame = CGRectMake(margin+(tabBarwidth+margin)*i, 0, 50 , 49);
        }
        
        tabbar.tag = i;
        tabbar.normalImage = [UIImage imageNamed:norImagesArr[i]];
        tabbar.selectedImage = [UIImage imageNamed:seleImagesArr[i]];
        tabbar.title = _titles[i];
        //接收点击事件
        [tabbar setTabBarViewClickBlock:^(LLTabBar *tabBar,NSInteger tag, UIImageView *iconView, UILabel *titleLabel) {
           
            NSLog(@"%s--------tag:%zd----------iconView:%@-------titleLabel:%@",__FUNCTION__,tag,iconView,titleLabel.text);
            
            [self TapBtn:tabBar tag:tag iconView:iconView titleLabel:titleLabel];

        }];
        //设置默认选中
        if(i==0){
            tabbar.isDefault = YES;
        }
        
        [_imageView addSubview:tabbar];
        
        [self.tabBarArray addObject:tabbar];
    }
    
    
//    UIButton *butto = [[UIButton alloc] init];
//    [butto setTitle:@"" forState:UIControlStateNormal];
    
//    _imageView.userInteractionEnabled = YES;
    
}


#pragma mark  longPress
- (void)longPress{
    NSLog(@"%s",__FUNCTION__);
}


#pragma mark - === 逻辑处理 ====
/**
 *  点击按钮，切换控制器：
 */
- (void)TapBtn:(LLTabBar *)tabBar tag:(NSInteger)tag iconView:(UIImageView *)iconView titleLabel:(UILabel *)titleLabel{

    for (int i = 0; i < _tabBarArray.count; i++)
    {
        LLTabBar *tabBar = (LLTabBar *)_tabBarArray[i];
        tabBar.selected = NO;
    }
    tabBar.selected = !tabBar.selected;
    
    //切换控制器：
    self.selectedIndex = tag;
    
}


#pragma mark - == 显示或隐藏TabBar ===
//隐藏
- (void)HideTabarView:(BOOL)isHideen  animated:(BOOL)animated;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%s",__FUNCTION__);
    // Dispose of any resources that can be recreated.
}



@end
