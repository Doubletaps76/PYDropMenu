//
//  PYDropMenu.h
//
//  Created by TsauPoYuan on 2015/03/09.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PYDropMenu;

@protocol PYDropMenuDelegate <NSObject>

@required
- (void)pyDropMenuButtonClick:(PYDropMenu*)dropMenu WithIndex:(NSInteger)index andSubIndex:(NSInteger)subIndex;

@end

@protocol PYDropMenuDataSource <NSObject>

@required
- (NSMutableArray*)buttonTitlesSourceInPYDropMenu:(PYDropMenu*)dropMenu;

@optional
- (NSMutableArray*)pyDropMenu:(PYDropMenu*)dropMenu subButtonsAtIndex:(NSInteger)index;

@end

@interface PYDropMenu : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic) UIScrollView *menu;
@property (nonatomic) UIImageView *menuIndicator;
@property (nonatomic) UIView *containerView;
@property (nonatomic) NSMutableArray *buttoms;

//Buttons UI
@property (nonatomic,strong) UIColor *btnBackgroundColor;
@property (nonatomic,strong) UIColor *btnSelectColor;
@property (nonatomic,strong) UIColor *btnTitleColor;
@property (nonatomic,assign) CGFloat btnHeight;
@property (nonatomic,assign) CGFloat btnTitleLeftPadding;

//SubButtons UI
@property (nonatomic,strong) UIColor *subBtnBackgroundColor;
@property (nonatomic,strong) UIColor *subBtnSelectColor;
@property (nonatomic,strong) UIColor *subBtnTitleColor;
@property (nonatomic,assign) CGFloat subBtnTitleLeftPadding;

//Separate UI
@property (nonatomic,assign) CGFloat separateHeight;
@property (nonatomic,strong) UIColor *separateColor;

@property (nonatomic,assign) id <PYDropMenuDelegate> delegate;
@property (nonatomic,assign) id <PYDropMenuDataSource> dataSource;

- (id)initWithTargetView:(UIView*)targetView;
- (void)toggleMenu;
- (void)showPYDropMenu;
- (void)hidePYDropMenu;

@end
