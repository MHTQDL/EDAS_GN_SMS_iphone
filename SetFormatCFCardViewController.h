//
//  SetFormatCFCardViewController.h
//  EDAS_GN_SMS
//
//  Created by 莫浩天 on 2017/1/18.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include "GlobalData.h"

@interface SetFormatCFCardViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *btnOK;
@property (retain, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)btnOKClick:(id)sender;
- (IBAction)btnCancelClick:(id)sender;

@end
