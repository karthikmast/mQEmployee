//
//  CustomerBillPageViewController.h
//  mQueue_Cashier
//
//  Created by Samuha on 27/09/15.

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"



@interface CustomerBillPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    NSMutableArray *objectsArray;
    UIAlertView *settleAlertView;
}
- (IBAction)billSettlement:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *billData;
@property(nonatomic,copy) NSString *userID;
@property(nonatomic,copy) NSString *cellIdentifier;
@property (weak, nonatomic) IBOutlet UIButton *btnBillSettled;
@property (strong, nonatomic)MBProgressHUD  *HUD;
@property (nonatomic, retain) NSArray *billPaid;

- (IBAction)backButton:(id)sender;

//@property (strong, nonatomic) IBOutlet UICollectionView *billData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userName:(NSString*)userName;

@end
