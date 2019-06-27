//
//  AZIndicator.m
//  WorkLogger
//
//  Created by 16805662 on 27/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "AZIndicator.h"

@interface AZIndicator ()
@property (strong, nonatomic) UILabel* label;
@end

@implementation AZIndicator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self setFont:[UIFont systemFontOfSize:72]];
        [self display:0];
    }
    return self;
}

-(void) display: (NSInteger) seconds{
    self.text = [self secondsToString: seconds];
};

- (NSString*) secondsToString: (NSInteger) seconds {
    long h = seconds / 3600;
    long m = seconds / 60 % 60;
    long s = seconds % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", h,m,s];
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
