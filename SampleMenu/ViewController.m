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
@property (nonatomic) NSMutableArray *subOptions;
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
    
    _options = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]];
    _subOptions = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D"]];
    
    [self dropDownMenuSetup];
    
    [_subButton addTarget:self action:@selector(toggleSubMenu) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - DropDownMenu

- (void)dropDownMenuSetup
{    
    _dropMenu = [[PYDropMenu alloc] initWithTargetView:self.view];
    _dropMenu.delegate = self;
    _dropMenu.dataSource = self;
    
    
    _subMenu = [[PYDropMenu alloc] initWithTargetView:_tableView];
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
        [_subButton setTitle:_subOptions[index] forState:UIControlStateNormal];
    }
}

#pragma mark DropDownMeny DataSource

- (NSMutableArray*)buttonTitlesSourceInPYDropMenu:(PYDropMenu *)dropMenu
{
    if (dropMenu == _dropMenu) {
        return _options;
    }else if(dropMenu == _subMenu){
        return _subOptions;
    }else{
        return nil;
    }
}

- (NSMutableArray *)pyDropMenu:(PYDropMenu *)dropMenu subButtonsAtIndex:(NSInteger)index
{
    if (dropMenu == _dropMenu) {
        
        if (index == 1) {
            NSMutableArray *ary = [NSMutableArray array];
            [ary addObjectsFromArray:@[@"2-1",@"2-2",@"2-3",@"2-4"]];
            return ary;
        }else if (index == 2){
            NSMutableArray *ary = [NSMutableArray array];
            [ary addObjectsFromArray:@[@"3-1",@"3-2"]];
            return ary;
        }else if (index == 3){
            NSMutableArray *ary = [NSMutableArray array];
            [ary addObjectsFromArray:@[@"4-1",@"4-2",@"4-3",@"4-1",@"4-2",@"4-3"]];
            return ary;
        }else if (index == 4){
            NSMutableArray *ary = [NSMutableArray array];
            [ary addObjectsFromArray:@[@"5-1",@"5-2"]];
            return ary;
        }
            
    }
    return nil;
}


@end
