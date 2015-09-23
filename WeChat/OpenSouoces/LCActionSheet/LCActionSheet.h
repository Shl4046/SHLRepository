

#import <UIKit/UIKit.h>

@class LCActionSheet;

@protocol LCActionSheetDelegate <NSObject>

@optional

/** 点击了buttonIndex处的按钮 */
- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(int)buttonIndex;

@end

@interface LCActionSheet : UIView

@property (nonatomic, weak) id<LCActionSheetDelegate> delegate;

/** Tip: 如果没有红色按钮, redButtonIndex给`-1`即可 */
- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles redButtonIndex:(int)buttonIndex delegate:(id<LCActionSheetDelegate>)delegate;

- (void)show;

@end
