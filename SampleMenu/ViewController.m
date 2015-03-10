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
@property (nonatomic) UIButton *navTitleBtn;
@property (nonatomic) NSMutableArray *options;
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
    
    _options = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"]];
    _secondOptions = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D"]];
    
    _subOptions2 = [NSMutableArray array];
    [_subOptions2 addObjectsFromArray:@[@"2-1",@"2-2",@"2-3",@"2-4"]];
    _subOptions4 = [NSMutableArray array];
    [_subOptions4 addObjectsFromArray:@[@"4-1",@"4-2"]];
    _subOptions9 = [NSMutableArray array];
    [_subOptions9 addObjectsFromArray:@[@"9-1",@"9-2",@"9-3"]];
    _subOptions10 = [NSMutableArray array];
    [_subOptions10 addObjectsFromArray:@[@"10-1",@"10-2",@"10-3",@"10-4",@"10-5",@"10-6"]];
    
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
    
    _subMenu = [[PYDropMenu alloc] initWithTargetView:_tableView];
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

- (void)pyDropMenuButtonClick:(PYDropMenu*)dropMenu WithIndex:(NSInteger)index andSubIndex:(NSInteger)subIndex
{
    NSLog(@"%li",(long)index);
    NSLog(@"%li",(long)subIndex);
    
    if (dropMenu == _dropMenu) {
        _nowSelect = _options[index];
        [_navTitleBtn setTitle:_nowSelect forState:UIControlStateNormal];
        
        //if subIndex >= 0, then do what u want
        
        
    }else if (dropMenu == _subMenu){
        [_subButton setTitle:_secondOptions[index] forState:UIControlStateNormal];
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
        if (buttonIndex == 1) {
            return _subOptions2.count;
        }else if (buttonIndex == 3){
            return _subOptions4.count;
        }else if (buttonIndex == 8){
            return _subOptions9.count;
        }else if (buttonIndex == 9){
            return _subOptions10.count;
        }
    }
    return 0;
}

- (NSString*)titleForButtonAtIndex:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu *)dropMenu
{
    if (dropMenu == _dropMenu) {
        return _options[buttonIndex];
    }else if(dropMenu == _subMenu){
        return _secondOptions[buttonIndex];
    }else{
        return @"";
    }
}

- (NSString*)titleForSubBtnsAtSubIndex:(NSInteger)subbuttonIndex andIndex:(NSInteger)buttonIndex withPYDropMenu:(PYDropMenu *)dropMenu
{
    if (dropMenu == _dropMenu) {
        if (buttonIndex == 1) {
            return _subOptions2[subbuttonIndex];
        }else if (buttonIndex == 3){
            return _subOptions4[subbuttonIndex];
        }else if (buttonIndex == 8){
            return _subOptions9[subbuttonIndex];
        }else if (buttonIndex == 9){
            return _subOptions10[subbuttonIndex];
        }
    }
    
    return @"";
}

@end
