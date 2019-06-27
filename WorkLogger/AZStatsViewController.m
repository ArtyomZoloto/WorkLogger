//
//  AZStatsViewController.m
//  WorkLogger
//
//  Created by 16805662 on 27/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "AZStatsViewController.h"

@interface AZStatsViewController ()

@end

@implementation AZStatsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *orig_img = [UIImage imageNamed:@"statsBarItem"];
        UIImage *img = [orig_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Статистика" image:img tag:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
