//
//  OperationsViewController.h
//  MqEmployee
//
//  Created by Samuha on 17/10/15.
//  Copyright (c) 2015 Samuha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationsViewController : UIViewController

//NO Product View
@property (weak, nonatomic) IBOutlet UIView *viewNoProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblNoProduct;

//Product View - just add this view as sub view to No Product view. By default No Product view will be displayed
@property (strong, nonatomic) IBOutlet UIView *viewProducts;
@property (weak, nonatomic) IBOutlet UILabel *lblQty;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblCart;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property(nonatomic,copy) NSString *queueObjectID;
@property(nonatomic,copy) NSString *objectID;
- (IBAction)doneButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnLogout;
- (IBAction)logoutButtonAction:(id)sender;

@end
