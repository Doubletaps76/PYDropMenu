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

#import "PYDropMenu.h"

#define kMenuBackgroundColor [UIColor colorWithRed:1 green:1 blue:1 alpha:0.95]

#define kBtnBackgroundColor [UIColor clearColor]
#define kBtnSelectedColor [UIColor colorWithRed:19/255.0f green:149/255.0f blue:184/255.0f alpha:1.0f]
#define kBtnTitleColor [UIColor blackColor]
#define kBtnHeight 50
#define kBtnTitleLeftPadding 25

#define kSubBtnTitleLeftPadding 0

#define kSeparatelineHeight 1
#define kSeparatelineColor [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:0.95]
#define kSeparatelineLong 0.8

#define kContainerBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]

@interface PYDropMenu()

@property (nonatomic) UIView *targetView;

@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,assign) NSInteger subSelectIndex;
@property (nonatomic,assign) CGFloat scrollContentHeight;

@property (nonatomic,strong) NSMutableArray* btnTitles;
@property (nonatomic,strong) NSMutableArray* subBtnTitles;

@end

@implementation PYDropMenu

- (void)setupInfo
{
    if (_menuBackgroundColor == nil) _menuBackgroundColor = kMenuBackgroundColor;
    
    //btns
    if(_btnBackgroundColor == nil) _btnBackgroundColor = kBtnBackgroundColor;
    if(_btnSelectColor == nil) _btnSelectColor = kBtnSelectedColor;
    if(_btnTitleColor == nil) _btnTitleColor = kBtnTitleColor;
    if(_btnHeight == 0) _btnHeight = kBtnHeight;
    if(_btnTitleLeftPadding == 0) _btnTitleLeftPadding = kBtnTitleLeftPadding;
    if(_btnFont == nil) [UIFont systemFontOfSize:15.0];
    
    //subBtns
    if(_subBtnBackgroundColor == nil) _subBtnBackgroundColor = kBtnBackgroundColor;
    if(_subBtnSelectColor == nil) _subBtnSelectColor = kBtnSelectedColor;
    if(_subBtnTitleColor == nil) _subBtnTitleColor = kBtnTitleColor;
    if(_subBtnTitleLeftPadding == 0) _subBtnTitleLeftPadding = kSubBtnTitleLeftPadding;
    if(_subBtnFont == nil) [UIFont systemFontOfSize:15.0];
    
    //Separate
    if(_separateHeight == 0) _separateHeight = kSeparatelineHeight;
    if(_separateColor == 0) _separateColor = kSeparatelineColor;
}

- (void)setupWithButtonsCount:(NSInteger)buttonsCount
{
    [self setupInfo];
    
    CGFloat showMenuWidth = _targetView.frame.size.width;
    CGFloat showMenuHeight = _targetView.frame.size.height;
    
    [self.view setClipsToBounds:YES];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //setup container view
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, showMenuWidth, showMenuHeight)];
    [self.containerView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]];
    [self.containerView setAlpha:0];
    UITapGestureRecognizer *tapGuester = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleMenu)];
    tapGuester.delegate = self;
    [self.containerView addGestureRecognizer:tapGuester];
    
    //setup dropMenu
    self.menu = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -showMenuHeight, showMenuWidth, showMenuHeight)];
    [self.menu setBackgroundColor:_menuBackgroundColor];
    [self.menu setHidden:YES];
    
    _scrollContentHeight = 0;
    
    //setup Buttons
    for (int btnIndex = 0; btnIndex < buttonsCount; btnIndex++) {
        
        NSString *btnTitle = [self.dataSource titleForButtonAtIndex:btnIndex withPYDropMenu:self];
        
        NSInteger subButtonsCount = 0;
        if ([self.dataSource respondsToSelector:@selector(numberOfSubBtnsInButton:withPYDropMenu:)]) {
            subButtonsCount = [self.dataSource numberOfSubBtnsInButton:btnIndex withPYDropMenu:self];
        }
        CGFloat btnWidth;
        if (subButtonsCount > 0) {
            btnWidth = (subButtonsCount >= 3 )?showMenuWidth/4:showMenuWidth/2;
        }else{
            btnWidth = showMenuWidth;
        }
        
        // setup Buttons
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = btnIndex;
        [btn setBackgroundColor:_btnBackgroundColor];
        [btn setContentHorizontalAlignment:_btnHorizontalAlignment];
        CGFloat alignmentOffset = 0;
        if (btn.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter) {
            alignmentOffset = btnTitle.length/2;
            _btnTitleLeftPadding = -alignmentOffset;
        }
        [btn setFrame:CGRectMake(0, _scrollContentHeight, btnWidth, _btnHeight)];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, _btnTitleLeftPadding, 0, 0);
        [btn.titleLabel setFont:_btnFont];
        [btn setTitleColor:_btnTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:_btnSelectColor forState:UIControlStateSelected];
        [btn setTintColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.delegate respondsToSelector:@selector(getPYDropMenuButton:withIndex:)]) {
            [self.delegate getPYDropMenuButton:btn withIndex:btnIndex];
        }
        
        [self.menu addSubview:btn];
        
        _scrollContentHeight += _btnHeight;
        
        //setup separateLine
        if (subButtonsCount == 0) {
            UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(showMenuWidth*0.1, _scrollContentHeight, showMenuWidth*0.9, 1)];
            separateLine.backgroundColor = _separateColor;
            [self.menu addSubview:separateLine];
            _scrollContentHeight += 1;
        }
    
        if (subButtonsCount > 0) {
            //setup SubButtons
            for (int i = 0; i < subButtonsCount; i++) {
                
                NSString *subTitle = [self.dataSource titleForSubBtnsAtSubIndex:i andIndex:btnIndex withPYDropMenu:self];

                CGFloat subBtnWidth = 0 ;
                if (subButtonsCount <= 3) {
                    subBtnWidth = (showMenuWidth - btnWidth)/subButtonsCount;
                }else{
                    subBtnWidth = (showMenuWidth - btnWidth)/3;
                }
                
                CGFloat subBtnYoffSet = (_btnHeight+1) * (i/3);
                
                UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                subBtn.tag = i + 10000 * btnIndex;
                [subBtn setBackgroundColor:_subBtnBackgroundColor];
                [subBtn setFrame:CGRectMake(btnWidth + (subBtnWidth*(i%3)), btn.frame.origin.y + subBtnYoffSet, subBtnWidth, _btnHeight + 1)];
                [subBtn setTitle:subTitle forState:UIControlStateNormal];
                subBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                subBtn.contentEdgeInsets = UIEdgeInsetsMake(0, _subBtnTitleLeftPadding, 0, 0);
                [subBtn.titleLabel setFont:_subBtnFont];
                [subBtn setTitleColor:_btnTitleColor forState:UIControlStateNormal];
                [subBtn setTitleColor:_btnSelectColor forState:UIControlStateSelected];
                [subBtn setTintColor:[UIColor clearColor]];
                [subBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                if ([self.delegate respondsToSelector:@selector(getPYDropMenuSubButton:withIndex:andSubIndex:)]) {
                    [self.delegate getPYDropMenuSubButton:subBtn withIndex:btnIndex andSubIndex:subBtn.tag - 10000];
                }
                [self.menu addSubview:subBtn];
                
                //if enter next subbuttons row
                if (i % 3 == 0 && i != 0) _scrollContentHeight += _btnHeight;
                
                //if subbuttons row contain full buttons ,then add separate line
                if (i%3 == 2) {
                    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(btnWidth, _scrollContentHeight, showMenuWidth-btnWidth, 1)];
                    separateLine.backgroundColor = _separateColor;
                    [self.menu addSubview:separateLine];
                    _scrollContentHeight += 1;
                }
                
                //if row aren't contain full buttons ,then add full separate line
                if(i == subButtonsCount-1 && i%3 != 2){
                    UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(showMenuWidth*0.1, _scrollContentHeight, showMenuWidth*0.9, 1)];
                    separateLine.backgroundColor = _separateColor;
                    [self.menu addSubview:separateLine];
                    _scrollContentHeight += 1;
                }
            }
        }
    }
    
    // if buttons too less to need full screen layout then resetframe
    if (_scrollContentHeight < showMenuHeight) {
        [self.menu setFrame:CGRectMake(0, -_scrollContentHeight, showMenuWidth, _scrollContentHeight)];
    }
    
    [self.menu setContentSize:CGSizeMake(_targetView.frame.size.width, _scrollContentHeight + 2)];
    
    
    //setup selected Btn highlight
    for (UIView *subView in _menu.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)subView;
            btn.selected = NO;
            if (_subSelectIndex >= 0) {
                btn.selected = (btn.tag == _subSelectIndex);
            }else{
                btn.selected = (btn.tag == _selectIndex);
            }
        }
    }
    
}

- (instancetype)initWithTargetView:(UIView*)targetView
{
    self = [super init];
    
    _btnHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _targetView = targetView;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - toggle,show,hide Menu

- (void)toggleMenu
{
    (! self.menu) ? [self showPYDropMenu]:[self hidePYDropMenu];
}

- (void)showPYDropMenu
{
    
    //setup PYDropMenu
    [self setupWithButtonsCount:[self.dataSource numberOfButtonsInPYDropMenu:self]];

    // RePosition when Iphone in calling (because statusBar height changed)
    CGSize viewSize = self.view.frame.size;
    CGPoint viewPoint = self.view.frame.origin;
    
    if ([[UIApplication sharedApplication] statusBarFrame].size.height == 40){
        
        [self.view setFrame:CGRectMake(viewPoint.x, -6, viewSize.width, viewSize.height)];
    }else{
        
        [self.view setFrame:CGRectMake(viewPoint.x, 0, viewSize.width, viewSize.height)];
    }

    self.menu.hidden = NO;
    
    [_targetView addSubview:self.view];
    
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.menu];

    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.menu setFrame:CGRectMake(0, 0, self.menu.frame.size.width, self.menu.frame.size.height)];
                         [self.containerView setAlpha:0.7];
                     }
                     completion:^(BOOL finished){
                     }];
    
    [UIView commitAnimations];
}

- (void)hidePYDropMenu
{
    [UIView animateWithDuration:0.3f
                          delay:0.05f
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.menu setFrame:CGRectMake(0, 0, self.menu.frame.size.width, -self.menu.frame.size.height)];
                         [self.containerView setAlpha:0];
                     }
                     completion:^(BOOL finished){

                         [self.menu removeFromSuperview];
                         [self.containerView removeFromSuperview];
                         self.menu = nil;
                         self.containerView = nil;
                         [self.view removeFromSuperview];
                     }];
    [UIView commitAnimations];
}

#pragma mark - Delegate

- (void)btnClick:(UIButton*)btn
{
    for (UIView *subView in self.menu.subviews){
        
        if ([subView isKindOfClass:[UIButton class]]){
            
            UIButton *btn = (UIButton*)subView;
            [btn setSelected:NO];
        }
    }
    
    [btn setSelected:YES];
    
    if (btn.tag >= 10000) {
        NSInteger index = btn.tag/10000;
        NSInteger subIndex = btn.tag - 10000*index;
        
        _selectIndex = index;
        _subSelectIndex = btn.tag;
        [self.delegate pyDropMenuButtonClick:self WithIndex:index andSubIndex:subIndex];
    }else{
        
        _selectIndex = btn.tag;
        _subSelectIndex = -1;
        [self.delegate pyDropMenuButtonClick:self WithIndex:btn.tag andSubIndex:-1];
    }
    
    [self toggleMenu];
}

@end
