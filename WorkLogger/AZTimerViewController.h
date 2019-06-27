//
//  AZControlViewController.h
//  WorkLogger
//
//  Created by 16805662 on 27/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AZTimerViewControllerIndicatorProtocol <NSObject>
@required
-(void) display: (NSInteger) seconds;
@end

@protocol AZTimerViewControllerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface AZTimerViewController : UIViewController
@property (weak, nonatomic) id<AZTimerViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

@protocol AZTimerViewControllerDelegate <NSObject>
-(void) AZTimerViewController: (AZTimerViewController* _Nullable) controller didFinishedCompleted: (BOOL) completed;
@end
