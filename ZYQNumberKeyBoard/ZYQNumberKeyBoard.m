//
//  RH_CommonNumberKeyBoard.m
//  lotteryBox
//
//  Created by lewis on 2018/5/3.
//  Copyright © 2018年 luis. All rights reserved.
//

#import "ZYQNumberKeyBoard.h"

@interface ZYQNumberKeyBoard ()

@property (nonatomic,strong) UITextField * textField;

@end

@implementation ZYQNumberKeyBoard
{
    NSArray * _numberArray;
}

#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithRed:210/255.0 green:213/255.0 blue:229/255.0 alpha:1.0];
        
        _numberArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"确定",@"0",@"撤销"];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sureClickDelegate) name:UIKeyboardWillHideNotification object:nil];
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 40) / 3;
    CGFloat h = 50;
    
    for (int i = 0; i < _numberArray.count; i ++)
    {
        CGFloat y = 10 + i / 3 * (10 + h);
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        button.frame = CGRectMake( 10 + ( i % 3 * (10 + w)), y, w, h);
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:[NSString stringWithFormat:@"%@",_numberArray[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forState:UIControlStateHighlighted];
        [self addSubview:button];
        
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        
        if (i == 9 || i == 11)
        {
            button.titleLabel.font = [UIFont systemFontOfSize:17];
        }
        
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds cornerRadius:5];
        CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = button.bounds;
        maskLayer.path = maskPath.CGPath;
        button.layer.mask = maskLayer;
    }
}

#pragma mark - clickEvent
- (void)buttonClick:(UIButton *)sender
{
    NSInteger index = sender.tag - 100;

    if (index != 9 && index != 11)
    {
        if (_isMoney == YES && [_numberArray[index] integerValue] == 0 && self.textField.text.length == 0) return;

        self.textField.text = [self.textField.text stringByAppendingString:[NSString stringWithFormat:@"%ld",[_numberArray[index] integerValue]]];

        if (self.delegate && [self.delegate respondsToSelector:@selector(KeyBoardTextFieldInputNumber:TextField:)]) {
            
            [self.delegate KeyBoardTextFieldInputNumber:[_numberArray[index] integerValue] TextField:self.textField];
        }
    }
    
    if (index == 9)
    {
        [self sureClickDelegate];
    }
    
    if (index == 11 && self.textField.text.length > 0)
    {
        self.textField.text = [self.textField.text substringToIndex:[self.textField.text length] - 1];
    }
}

- (void)sureClickDelegate
{
    //键盘确定按钮
    if (self.delegate && [self.delegate respondsToSelector:@selector(KeyBoardTextFieldSureClick:)]) {
        
        [self.textField resignFirstResponder];
        
        [self.delegate KeyBoardTextFieldSureClick:self.textField];
    }
}
#pragma mark - tool
//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//查找textField
- (UITextField *)findTextField
{
    id target = self;
    
    while (target) {
        
        target = ((UIResponder *)target).nextResponder;
        
        if ([target isKindOfClass:[UITextField class]]) {
            
            break;
        }
    }
    return target;
}

#pragma mark - lazyload
-(UITextField *)textField
{
    if (!_textField) {
        
        _textField = [self findTextField];
    }
    return _textField;
}

@end
