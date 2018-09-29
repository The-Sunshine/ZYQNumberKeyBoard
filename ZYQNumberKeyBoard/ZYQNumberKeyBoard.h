/*
-
-
-
*/
#import <UIKit/UIKit.h>

@protocol ZYQNumberKeyBoardDelegate<NSObject>

@optional

/** textfield 输入时 可限制长度 */

- (void)KeyBoardTextFieldInputNumber:(NSInteger)number;

/** 确定按钮 */
- (void)KeyBoardTextFieldSureClick;

@end

@interface ZYQNumberKeyBoard : UIView

@property (nonatomic,weak)id<ZYQNumberKeyBoardDelegate> delegate;

@property (nonatomic,assign) BOOL isMoney;

@end
