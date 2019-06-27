//
//  AZControlViewController.m
//  WorkLogger
//
//  Created by 16805662 on 27/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "AZTimerViewController.h"
#import "AZIndicator.h"

@interface AZTimerViewController ()
@property (strong, nonatomic) UIStackView* stackView;
@property (strong, nonatomic) UILabel* durationLabel;
@property (strong, nonatomic) UISegmentedControl* durationControl;
@property (strong, nonatomic) UIButton* startButton;
@property (strong, nonatomic) UIButton* stopButton;
@property (strong, nonatomic) UILabel<AZTimerViewControllerIndicatorProtocol>* indicator;
@property (assign, nonatomic) BOOL isRunning;
@property (assign, nonatomic) NSInteger remainCounter;
@property (strong, nonatomic) NSTimer* timer;

@end

@implementation AZTimerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *orig_img = [UIImage imageNamed:@"timerBarItem"];
        UIImage *img = [orig_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Трекер" image:img tag:1];
    }
    return self;
}

- (void)addStackView {
    self.stackView = [[UIStackView alloc] initWithArrangedSubviews:@[
                                                                     self.indicator,
                                                                     self.startButton,
                                                                     self.stopButton]];
    self.stackView.spacing = 50.0f;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.stackView];
    
}

- (void)addDurationControll {
    self.durationLabel = [[UILabel alloc] init];
    self.durationLabel.text = @"Выберите продолжительность:";
    [self.view addSubview:self.durationLabel];
    UILayoutGuide* layoutGuide = self.view.readableContentGuide;
    self.durationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.durationLabel.leadingAnchor constraintEqualToAnchor:layoutGuide.leadingAnchor constant:0.0f].active = YES;
    [self.durationLabel.trailingAnchor constraintEqualToAnchor:layoutGuide.trailingAnchor constant:0.0f].active = YES;
    [self.durationLabel.topAnchor constraintEqualToAnchor:layoutGuide.topAnchor constant:30.0f].active = YES;
    self.durationControl = [[UISegmentedControl alloc] initWithItems:@[@"  10 мин ",@"  15 мин ",@"  25 мин "]];
    [self.view addSubview:self.durationControl];
    self.durationControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.durationControl.leadingAnchor constraintEqualToAnchor:self.durationLabel.leadingAnchor constant:0.0f].active = YES;
    [self.durationControl.trailingAnchor constraintEqualToAnchor:self.durationLabel.trailingAnchor constant:0.0f].active = YES;
    [self.durationControl.topAnchor constraintEqualToAnchor:self.durationLabel.bottomAnchor constant:30.0f].active = YES;
}

- (void)checkSelected {
    if (self.durationControl.selectedSegmentIndex == UISegmentedControlNoSegment){
        UIAlertController* alert =
        [UIAlertController alertControllerWithTitle:@"Упс!"
                                            message:@"Сначала установите продолжительность сессии"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
                                       self.durationControl.backgroundColor = [UIColor redColor];
                                   } completion:^(BOOL finished) {
                                       self.durationControl.backgroundColor = [UIColor whiteColor];
                                   }];
                               }];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void) start:(UIButton*) btn{
    if (!self.isRunning){
        self.startButton.enabled = NO;
        self.stopButton.enabled = YES;
        [self checkSelected];
        [self countTime];
        [self startTimer];
        self.isRunning = YES;
    }
}

-(void) stop:(UIButton*) btn{
    if (self.isRunning){
        [self stopTimer];
        [self.delegate AZTimerViewController:self didFinishedCompleted:NO];
        self.startButton.enabled = YES;
        self.stopButton.enabled = NO;
    }
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
    self.remainCounter = 0;
    self.isRunning = NO;
}

-(void) setRemainCounter:(NSInteger)remainCounter{
    _remainCounter = remainCounter;
    [self.indicator display: remainCounter];
}

-(void) countTime {
    switch (self.durationControl.selectedSegmentIndex) {
        case 0:
            self.remainCounter = 10 * 60;
            break;
        case 1:
            self.remainCounter = 15 * 60;
            break;
        case 2:
            self.remainCounter = 25 * 60;
            break;
        default:
            break;
    }
}

-(void) startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
}

-(void) updateTimer: (NSTimer*) t {
    if (self.remainCounter < 0){
        [self stopTimer];
        [self.delegate AZTimerViewController:self didFinishedCompleted:YES];
    } else {
        self.remainCounter = self.remainCounter - 1;
    }
}

- (void)addControlButtons {
    self.startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.startButton setTitle:@"Стартовать" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    // self.startButton.enabled = NO;
    
    self.stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.stopButton setTitle:@"Остановить" forState:UIControlStateNormal];
    [self.stopButton addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    self.stopButton.enabled = NO;
}

-(void) addIndicator {
    self.indicator = [[AZIndicator alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addDurationControll];
    [self addIndicator];
    [self addControlButtons];
    [self addStackView];
    [self.stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    
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
