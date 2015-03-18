//
//  ViewController.m
//  SampleMenu
//
//  Created by TsauPoYuan on 2015/3/6.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) PYDropMenu *dropMenu;
@property (nonatomic) PYDropMenu *subMenu;
@property (nonatomic) UIView *subMenuBoxView;
@property (nonatomic) UIButton *navTitleBtn;
@property (nonatomic) NSMutableArray *options;
@property (nonatomic) NSMutableArray *subOptions;
@property (nonatomic) NSMutableArray *subOptions2;
@property (nonatomic) NSMutableArray *subOptions4;
@property (nonatomic) NSMutableArray *subOptions9;
@property (nonatomic) NSMutableArray *subOptions10;

@property (nonatomic) NSMutableArray *secondOptions;
@property (nonatomic) NSString *nowSelect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Do any additional setup after loading the view, typically from a nib.
    CGSize screenRect = [UIScreen mainScreen].bounds.size;
    _navTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_navTitleBtn setFrame:CGRectMake(0, 0, screenRect.width-20, 44)];
    [_navTitleBtn.titleLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:22]];
    [_navTitleBtn setImage:[UIImage imageNamed:@"nav_arrow"] forState:UIControlStateNormal];
    [_navTitleBtn setBackgroundColor:[UIColor clearColor]];
    [_navTitleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_navTitleBtn addTarget:self action:@selector(toggleMainMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem.titleView setFrame:CGRectMake(0, 0, screenRect.width, 44)];
    self.navigationItem.titleView = _navTitleBtn;
    [_navTitleBtn setTitle:@"1" forState:UIControlStateNormal];

    _subOptions = [NSMutableArray array];
    [_subOptions addObjectsFromArray:@[@"1-1",@"1-2"]];
    _subOptions2 = [NSMutableArray array];
    [_subOptions2 addObjectsFromArray:@[@"2-1",@"2-2",@"2-3",@"2-4"]];
    _subOptions4 = [NSMutableArray array];
    [_subOptions4 addObjectsFromArray:@[@"4-1",@"4-2"]];
    _subOptions9 = [NSMutableArray array];
    [_subOptions9 addObjectsFromArray:@[@"9-1",@"9-2",@"9-3"]];
    _subOptions10 = [NSMutableArray array];
    [_subOptions10 addObjectsFromArray:@[@"10-1",@"10-2",@"10-3",@"10-4",@"10-5",@"10-6"]];
    NSDictionary *option = @{@"optionTitle":@"1",@"subcat":_subOptions};
    NSDictionary *option2 = @{@"optionTitle":@"2",@"subcat":_subOptions2};
    NSDictionary *option4 = @{@"optionTitle":@"4",@"subcat":_subOptions4};
    NSDictionary *option9 = @{@"optionTitle":@"9",@"subcat":_subOptions9};
    NSDictionary *option10 = @{@"optionTitle":@"10",@"subcat":_subOptions10};
    
    _options = [NSMutableArray arrayWithArray:@[option,option2,@"3",option4,@"5",@"6",@"7",@"8",option9,option10,@"11"]];
    _secondOptions = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D"]];
    
    [self pyDropMenuSetup];
    
    [_subButton addTarget:self action:@selector(toggleSubMenu) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - pyDropMenu

- (void)pyDropMenuSetup
{    
    _dropMenu = [[PYDropMenu alloc] initWithTargetView:self.view];
    _dropMenu.btnFont = [UIFont fontWithName:@"Futura-Medium" size:15.0];
    _dropMenu.subBtnFont = [UIFont fontWithName:@"Futura-Medium" size:15.0];
    _dropMenu.delegate = self;
    _dropMenu.dataSource = self;
    
    _subMenuBoxView = [[UIView alloc] initWithFrame:CGRectMake(0, _subButton.frame.size.height, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height - _subButton.frame.size.height)];
    _subMenuBoxView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_subMenuBoxView];
    _subMenuBoxView.hidden = YES;
    
    _subMenu = [[PYDropMenu alloc] initWithTargetView:_subMenuBoxView];
    _subMenu.btnHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _subMenu.delegate = self;
    _subMenu.dataSource = self;
}

- (void)toggleMainMenu
{
    [_dropMenu toggleMenu];
}
- (void)toggleSubMenu
{
    [_subMenu toggleMenu];
}

#pragma mark pyDropMenu Delegate

- (void)pyDropMenuDidButtonClick:(PYDropMenu *)dropMenu withIndex:(NSInteger)index andSubIndex:(NSInteger)subIndex
{
    NSLog(@"%li",(long)index);
    NSLog(@"%li",(long)subIndex);
    
    if (dropMenu == _dropMenu) {
        
        if (subIndex >= 0) {
            _nowSelect = _options[index][@"subcat"][subIndex];
            [_navTitleBtn setTitle:_nowSelect forState:UIControlStateNormal];
        }else{
            if ([_options[index] isKindOfClass:[NSDictionary class]]) {
                _nowSelect = _options[index][@"optionTitle"];
            }else{
                _nowSelect = _options[index];
            }
            [_navTitleBtn setTitle:_nowSelect forState:UIControlStateNormal];
        }
        
    }else if (dropMenu == _subMenu){
        [_subButton setTitle:_secondOptions[index] forState:UIControlStateNormal];
    }
}

- (void)didChangeStatusWithPYDropMenu:(PYDropMenu *)dropMenu
{
    if (dropMenu == _subMenu) {
        if (dropMenu.status == PYDropMenuStatusShowing) {
            _subMenuBoxView.hidden = NO;
        }else if (dropMenu.status == PYDropMenuStatusClose){
            _subMenuBoxView.hidden = YES;
        }
    }
}


#pragma mark pyDropMenu DataSource
- (NSInteger)numberOfButtonsInPYDropMenu:(PYDropMenu *)dropMenu
{
    if (dropMenu == _dropMenu) {
        return _options.count;
    }else if(dropMenu == _subMenu){
        return _secondOptions.count;
    }
    return 0;
}

- (NSInteger)numberOfSubBtnsInButton:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu *)dropMenu
{
    if (dropMenu == _dropMenu) {
        if ([_options[buttonIndex] isKindOfClass:[NSDictionary class]]) {
            NSArray *subCat = _options[buttonIndex][@"subcat"];
            return subCat.count;
        }
    }
    return 0;
}

- (NSString*)titleForButtonAtIndex:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu *)dropMenu
{
    if (dropMenu == _dropMenu) {
        if ([_options[buttonIndex] isKindOfClass:[NSDictionary class]]) {
            return _options[buttonIndex][@"optionTitle"];
        }else{
            return _options[buttonIndex];
        }
    }else if(dropMenu == _subMenu){
        return _secondOptions[buttonIndex];
    }else{
        return @"";
    }
}

- (NSString*)titleForSubBtnsAtSubIndex:(NSInteger)subbuttonIndex andIndex:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu *)dropMenu
{
    if (dropMenu == _dropMenu) {
        return _options[buttonIndex][@"subcat"][subbuttonIndex];
    }
    
    return @"";
}

@end
