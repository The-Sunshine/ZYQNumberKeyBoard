//
//  ViewController.m
//  ZYQNumberKeyBoard
//
//  Created by eagle on 2018/9/29.
//  Copyright © 2018 eagle. All rights reserved.
//

#import "ViewController.h"
#import "ZYQNumberKeyBoard.h"

@interface ViewController ()<ZYQNumberKeyBoardDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITextField * textField = [[UITextField alloc]init];
    textField.frame = CGRectMake(0, 200, 100, 40);
    textField.center = CGPointMake(self.view.center.x, textField.center.y);
    textField.font = [UIFont systemFontOfSize:14];
    textField.backgroundColor = [UIColor yellowColor];
    textField.placeholder = @"请输入金额";
    textField.textAlignment = NSTextAlignmentCenter;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:textField];
    
    ZYQNumberKeyBoard * keyBoard = [[ZYQNumberKeyBoard alloc]init];
    keyBoard.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
    keyBoard.delegate = self;
    keyBoard.isMoney = YES;
    
    textField.inputView = keyBoard;
}

-(void)KeyBoardTextFieldInputNumber:(NSInteger)number
{
    NSLog(@"输入了%ld",(long)number);
}

-(void)KeyBoardTextFieldSureClick
{
    NSLog(@"点击了确定");
}

@end
