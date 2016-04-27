//
//  SXTabBarViewController.m
//  SXCustomTabBar
//
//  Created by ShaoPro on 15/12/24.
//  Copyright © 2015年 ShaoPro. All rights reserved.
//

#import "SXTabBarViewController.h"
#import "LLTabBar.h"
#import "LLTabBarView.h"

//避免宏循环引用
#define LLWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define LLStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

@interface SXTabBarViewController ()

@property (nonatomic,strong) LLTabBarView *myTabBarView;

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

#define LLKeyWindowSize [UIScreen mainScreen].bounds.size

- (void)creationCusTabBar
{
    
//    NSArray *titlesArray = @[@"测试一",@"测试二",@"",@"测试三",@"测试si"];
//    NSArray *norImagesArr = @[@"tabbar_contacts",@"tabbar_discover",@"1",@"tabbar_mainframe",@"3"];
//    NSArray *seleImagesArr = @[@"tabbar_contactsHL",@"tabbar_discoverHL",@"11",@"tabbar_mainframeHL",@"33"];
    
//    NSArray *titlesArray = @[@"测试一",@"测试二",@"111",@"测试一",@"测试二",@"111"];
//    NSArray *norImagesArr = @[@"1",@"2",@"2",@"1",@"2",@"2"];
//    NSArray *seleImagesArr = @[@"11",@"22",@"tabbar_contactsHL",@"11",@"tabbar_mainframeHL",@"33"];

    
    NSArray *titlesArray = @[@"首页",@"鱼塘",@"发布",@"消息",@"我的"];
    NSArray *norImagesArr = @[@"home_normal",@"fishpond_normal",@"post_animate_add",@"message_normal",@"account_normal"];
    NSArray *seleImagesArr = @[@"home_highlight",@"fishpond_highlight",@"post_animate_add",@"message_highlight",@"account_highlight"];
    
    _myTabBarView = ({
        LLTabBarView *tabBarView = [[LLTabBarView alloc] initWithFrame:CGRectMake(0, LLKeyWindowSize.height-49, LLKeyWindowSize.width, 49)];
        
//        tabBarView.tabBarStyle =
//        [tabBarView buttonWithType:]
//        [tabBarView buttonWithType2:LLTabBarVie];
        [tabBarView setTabbarViewTitleArray:titlesArray norImagesArr:norImagesArr seleImagesArr:seleImagesArr tabBar:self.tabBar];
        
        
        @LLWeakObj(self);
        [tabBarView setTabBarOnClickBlock:^(NSInteger index) {
            @LLStrongObj(self);
            self.selectedIndex = index;
        }];
        [self.view addSubview:tabBarView];
    
        tabBarView;
    });
    
    
    [UIButton buttonWithType:UIButtonTypeCustom];
//    [UITableViewStylePlain];

    
}


#pragma mark  longPress
- (void)longPress{
    NSLog(@"%s",__FUNCTION__);
}


#pragma mark - === 逻辑处理 ====



#pragma mark - == 显示或隐藏TabBar ===
//隐藏
- (void)HideTabarView:(BOOL)isHideen  animated:(BOOL)animated
{
    [_myTabBarView HideTabarView:isHideen animated:animated];
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
