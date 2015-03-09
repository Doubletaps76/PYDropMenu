//
//  ViewController.h
//  SampleMenu
//
//  Created by TsauPoYuan on 2015/3/6.
//  Copyright (c) 2015年 LiveSimply. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYDropMenu.h"

@interface ViewController : UIViewController<PYDropMenuDelegate,PYDropMenuDataSource>
@property (weak, nonatomic) IBOutlet UIButton *subButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

