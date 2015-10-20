//
//  AppDelegate.h
//  mQEmployee
//
//  Created by Samuha on 10/17/15.
//  Copyright © 2015 Samuha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployeeLoginViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) EmployeeLoginViewController *empLoginVC;



@end

