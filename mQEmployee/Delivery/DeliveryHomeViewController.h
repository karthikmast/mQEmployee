//
//  DeliveryHomeViewController.h
//  MqEmployee
//
//  Created by Samuha on 18/10/15.
//  Copyright (c) 2015 Samuha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DeliveryHomeViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblCustomer;

@property (weak, nonatomic) IBOutlet UIButton *btnLogOut;
- (IBAction)logOutButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnStartStop;
- (IBAction)startStopButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnGetCustomerCart;
- (IBAction)getCustomerCartButtonAction:(id)sender;


@end
