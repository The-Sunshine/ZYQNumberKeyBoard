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
    textField.tag = 100;
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
    
    
    UITextField * textField2 = [[UITextField alloc]init];
    textField2.frame = CGRectMake(0, 400, 100, 40);
    textField2.center = CGPointMake(self.view.center.x, textField2.center.y);
    textField2.tag = 102;
    textField2.font = [UIFont systemFontOfSize:14];
    textField2.backgroundColor = [UIColor yellowColor];
    textField2.placeholder = @"请输入";
    textField2.textAlignment = NSTextAlignmentCenter;
    textField2.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:textField2];
    
    ZYQNumberKeyBoard * keyBoard2 = [[ZYQNumberKeyBoard alloc]init];
    keyBoard2.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
    keyBoard2.delegate = self;
    
    textField2.inputView = keyBoard2;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)KeyBoardTextFieldInputNumber:(NSInteger)number TextField:(UITextField *)textField
{
    NSLog(@"输入了%ld - textField.tag = %ld textField.text = %@",(long)number,(long)textField.tag,textField.text);
}

-(void)KeyBoardTextFieldSureClick:(UITextField *)textField
{
    NSLog(@"点击了确定 - textField.tag = %ld textField.text = %@",(long)textField.tag,textField.text);
}

@end
