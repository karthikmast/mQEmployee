//
//  EmployeeLoginViewController.h
//  mQEmployee
//
//  Created by Samuha on 10/18/15.
//  Copyright © 2015 Samuha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface EmployeeLoginViewController : UIViewController <MBProgressHUDDelegate>
{
    NSMutableArray *objectsArray;
}
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (strong, nonatomic)MBProgressHUD  *HUD;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
- (IBAction)loginButtonAction:(id)sender;


@end
