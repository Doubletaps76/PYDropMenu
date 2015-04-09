/*
    MIT License
    -----------

    Copyright (c) 2015 Tsau,Po-Yuan (tsaupoyuan.com)
    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following
    conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.
*/


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PYDropMenuStatus) {
    PYDropMenuStatusClose,
    PYDropMenuStatusClosing,
    PYDropMenuStatusShow,
    PYDropMenuStatusShowing
};

@class PYDropMenu;

@protocol PYDropMenuDelegate <NSObject>

@required
- (void)pyDropMenuDidButtonClick:(PYDropMenu*)dropMenu withIndex:(NSInteger)index andSubIndex:(NSInteger)subIndex;

@optional
- (void)pyDropMenu:(PYDropMenu*)dropMenu getPYDropMenuButton:(UIButton*)button withIndex:(NSInteger)index;

- (void)pyDropMenu:(PYDropMenu*)dropMenu getPYDropMenuSubButton:(UIButton*)subbutton withIndex:(NSInteger)index andSubIndex:(NSInteger)subIndex;

- (void)didChangeStatusWithPYDropMenu:(PYDropMenu*)dropMenu;
@end

@protocol PYDropMenuDataSource <NSObject>

@required
- (NSInteger)numberOfButtonsInPYDropMenu:(PYDropMenu*)dropMenu;

- (NSString*)titleForButtonAtIndex:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu*)dropMenu;

@optional
- (NSInteger)numberOfSubBtnsInButton:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu*)dropMenu;

- (NSString*)titleForSubBtnsAtSubIndex:(NSInteger)subbuttonIndex andIndex:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu*)dropMenu;

@end

@interface PYDropMenu : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIScrollView *menu;
@property (nonatomic,assign) PYDropMenuStatus status;
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) NSMutableArray *buttoms;

@property (nonatomic,strong) UIColor *menuBackgroundColor;
@property (nonatomic,assign) CGFloat btnHeight; //including btns and subBtns

//Buttons UI
@property (nonatomic,strong) UIFont *btnFont;
@property (nonatomic,strong) UIColor *btnBackgroundColor;
@property (nonatomic,strong) UIColor *btnSelectColor;
@property (nonatomic,strong) UIColor *btnTitleColor;
@property (nonatomic,assign) CGFloat btnTitleLeftPadding;
@property (nonatomic,assign) UIControlContentHorizontalAlignment btnHorizontalAlignment;

//SubButtons UI
@property (nonatomic,strong) UIFont *subBtnFont;
@property (nonatomic,strong) UIColor *subBtnBackgroundColor;
@property (nonatomic,strong) UIColor *subBtnSelectColor;
@property (nonatomic,strong) UIColor *subBtnTitleColor;
@property (nonatomic,assign) CGFloat subBtnTitleLeftPadding;

//Separate UI
@property (nonatomic,assign) CGFloat separateHeight;
@property (nonatomic,strong) UIColor *separateColor;

//
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,assign) NSInteger selectSubIndex;

@property (nonatomic,weak) id <PYDropMenuDelegate> delegate;
@property (nonatomic,weak) id <PYDropMenuDataSource> dataSource;

- (id)initWithTargetView:(UIView*)targetView;
- (void)toggleMenu;
- (void)showPYDropMenu;
- (void)hidePYDropMenu;

@end
