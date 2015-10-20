//
//  CashierViewController.h
//  mQEmployee
//
//  Created by Samuha on 10/18/15.
//  Copyright © 2015 Samuha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CashierViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblCustomer;

@property (weak, nonatomic) IBOutlet UIButton *btnLogOut;
- (IBAction)logOutButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnStartStop;
- (IBAction)startStopButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnGetBill;
- (IBAction)getBillButtonAction:(id)sender;



@end
