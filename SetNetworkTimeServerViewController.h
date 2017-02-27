//
//  SetNetworkTimeServerViewController.h
//  EDAS_GN_SMS
//
//  Created by 莫浩天 on 2017/1/10.
//
//

#import <UIKit/UIKit.h>

@interface SetNetworkTimeServerViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *btnCancel;
@property (retain, nonatomic) IBOutlet UIButton *btnOK;
@property (retain, nonatomic) IBOutlet UITextField *host1;
@property (retain, nonatomic) IBOutlet UITextField *host2;
@property (retain, nonatomic) IBOutlet UITextField *host3;

- (IBAction)btnOKClick:(id)sender;
- (IBAction)btnCancelClick:(id)sender;

@end
