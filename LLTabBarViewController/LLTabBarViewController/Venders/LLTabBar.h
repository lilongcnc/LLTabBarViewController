//
//  LLView.h
//  test0311
//
//  Created by 李龙 on 16/3/11.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLTabBar : UIView

/**
 *  非选中状态下的图片
 */
@property (nonatomic,strong) UIImage *normalImage;
/**
 *  选中状态下的图片
 */
@property (nonatomic,strong) UIImage *selectedImage;
/**
 *  tabBar名称
 */
@property (nonatomic,strong) NSString *title;
/**
 *  处于选中状态
 */
@property (nonatomic,assign) BOOL selected;
/**
 *  是否为默认选中tabbar
 */
@property (nonatomic,assign) BOOL isDefault;


/**
 *  tabBar的点击事件
 */
@property (nonatomic,copy) void(^tabBarViewClickBlock)(LLTabBar *tabBar,NSInteger viewTag,UIImageView *iocnView,UILabel *titleLabel);

-(void)setIconViewSize:(CGSize)iconSize;

@end
