//
//  LLTabBarView.h
//  LLTabBarViewController
//
//  Created by 李龙 on 16/4/26.
//  Copyright © 2016年 lauren. All rights reserved.
//

#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LLTabBarViewControllerStyle) {
    LLTabBarViewControllerNormalStyle = 0,
    LLTabBarViewControllerCenterTabBarUpStyle = 1, //类似于咸鱼等,tabbar数量为奇数时候中间凸起,可自定义凸起的位置
    LLTabBarViewControllerCenterTabBarCenterStyle =2,  //类似于微博等,中间没有凸起但是占位比较大
    LLTabBarViewControllerOnlyImageStyle   //类似于人人只有图片,没有 title
};



@interface LLTabBarView : UIView

@property (nonatomic,assign) LLTabBarViewControllerStyle tabBarStyle;

- (void)setTabbarViewTitleArray:(NSArray *)titleArray norImagesArr:(NSArray *)norImagesArr seleImagesArr:(NSArray *)seleImagesArr  tabBar:(UITabBar*)tabBar;

@property (nonatomic,copy) void(^tabBarOnClickBlock)(NSInteger index);


- (void)HideTabarView:(BOOL)isHideen  animated:(BOOL)animated;

@end
