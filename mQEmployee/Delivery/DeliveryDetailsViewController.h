//
//  DeliveryDetailsViewController.h
//  MqEmployee
//
//  Created by Samuha on 18/10/15.
//  Copyright (c) 2015 Samuha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeliveryDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)backButtonAction:(id)sender;


//NO Kart View
@property (weak, nonatomic) IBOutlet UIView *viewNoKart;
@property (weak, nonatomic) IBOutlet UILabel *lblNoKartFound;


//Kart Data View
@property (strong, nonatomic) IBOutlet UIView *viewKartData;
@property (weak, nonatomic) IBOutlet UILabel *lblKartID;
@property (weak, nonatomic) IBOutlet UILabel *lblUserID;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;

@property(nonatomic,copy) NSString *userId;
@property (nonatomic, retain) NSArray *cartProducts;
@property (nonatomic, retain) NSArray *billProducts;

- (IBAction)doneButtonAction:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userName:(NSString*)userName;


@end
