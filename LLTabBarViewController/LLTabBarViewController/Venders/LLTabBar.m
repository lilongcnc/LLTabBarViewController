
//
//  LLView.m
//  test0311
//
//  Created by 李龙 on 16/3/11.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "LLTabBar.h"

@interface LLTabBar ()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *clickBtn;

@end

@implementation LLTabBar

- (instancetype)init{
    if (self = [super init]) {
        [self initView]; //init里边不可以准确获取到当前的view的frame
    }
    
    return self;
}

- (void)initView{
    
    
    
    _iconView = ({
    
        UIImageView *tmpIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 28)];
//        tmpIconView.backgroundColor = [UIColor redColor];
//        tmpIconView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTab:)];
//        [tmpIconView addGestureRecognizer:pan];
        
        tmpIconView;
    });
    [self addSubview:_iconView];
    

    _titleLabel = ({
    
        NSLog(@"%f---%f",CGRectGetMaxY(_iconView.frame),self.frame.size.width);
        
        UILabel *titlelab = [[UILabel alloc] initWithFrame:CGRectMake(0,20, 50,20)];
        titlelab.numberOfLines = 2;
        titlelab.textColor = [UIColor blackColor];
//        titlelab.backgroundColor = [self randomColor];
        titlelab.font = [UIFont boldSystemFontOfSize:11];
        titlelab.textAlignment = NSTextAlignmentCenter;
        
        
//        [lb setTextColor:[UIColor colorWithRed:41/255.0f green:128/255.0f blue:185/255.0f alpha:        1]];
//        [lb setFont:[UIFont systemFontOfSize:11]];
//        CGPoint ctLb = CGPointMake(circle.center.x, circle.center.y + circle.bounds.size.height/2         + 10);
//        [lb setCenter:ctLb];
//            [self.listOfTextItemTabbar addObject:titlelab];
    
        titlelab;
    });
    [self addSubview:_titleLabel];
    
    
    self.backgroundColor = [UIColor clearColor];
    
    _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 49)];
//    _clickBtn.backgroundColor = [UIColor redColor];
    _clickBtn.alpha = 0.02;
    [_clickBtn addTarget:self action:@selector(clickBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_clickBtn];
    
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;
    
    if (_selected) {
        _iconView.image = _selectedImage;
        _titleLabel.textColor = [UIColor redColor];
    }else{
        _iconView.image = _normalImage;
        _titleLabel.textColor = [UIColor blackColor];
    }


}

-(void)setIsDefault:(BOOL)isDefault{
    _isDefault = isDefault;
    
    self.selected = isDefault;
}

-(void)setNormalImage:(UIImage *)normalImage{
    _normalImage = normalImage;
    
    _iconView.image = normalImage;
    //重新设置位置
    CGRect tempRect = _iconView.frame;
    tempRect.origin.y = _iconView.frame.origin.y + 3;
    tempRect.origin.x = (self.frame.size.width-tempRect.size.width)*0.5;
    _iconView.frame = tempRect;
}

static const CGFloat marignTB = 3;
-(void)setTitle:(NSString *)title{
    _title = title;
    
    _titleLabel.text = title;
    
    //重新设置高度
    CGSize titlelabSize = [self getSizeWithStrig:title font:[UIFont systemFontOfSize:11] maxSize:CGSizeMake(self.frame.size.width, 2)];
    CGRect tempRect = _titleLabel.frame;
    tempRect.origin.y = CGRectGetMaxY(_iconView.frame) + marignTB;
    tempRect.size.height = titlelabSize.height;
    tempRect.size.width = self.frame.size.width;
//    NSLog(@">>>%f---%f",CGRectGetMaxY(_iconView.frame),self.frame.size.width);
    _titleLabel.frame = tempRect;
    
}

#pragma mark 工具方法
- (void)clickBtnOnClick:(UIButton *)btn{
//    NSLog(@"%s",__FUNCTION__);
    _tabBarViewClickBlock(self,self.tag,_iconView,_titleLabel);
    
}


- (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (CGSize)getSizeWithStrig:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
