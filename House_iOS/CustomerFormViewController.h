//
//  CustomerFormViewController.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-15.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ValueTableViewController.h"

@interface CustomerFormViewController : UIViewController <ValueTableViewControllerDelegate, UIActionSheetDelegate, UITextViewDelegate>

+ (CustomerFormViewController *) sharedInstance;

@property (retain, nonatomic) NSString *valueID;
@property (retain, nonatomic) IBOutlet UITextField *cField;
@property (retain, nonatomic) IBOutlet UIView *cView;
@property (retain, nonatomic) IBOutlet UIView *csView;

@property (retain, nonatomic) UIPopoverController *valueTablePopoverController;

@property (retain, nonatomic) UITabBarController *tabBarController;
@property (retain, nonatomic) IBOutlet UITextField *username;
@property (retain, nonatomic) IBOutlet UITextField *sellerName;
@property (retain, nonatomic) IBOutlet UITextField *phone1;
@property (retain, nonatomic) IBOutlet UITextField *phone2;
@property (retain, nonatomic) IBOutlet UITextField *phone3;

@property (retain, nonatomic) IBOutlet UIButton *phone2btn;
@property (retain, nonatomic) IBOutlet UIButton *phone3btn;

- (IBAction)addPhone2:(id)sender;
- (IBAction)addPhone3:(id)sender;

- (IBAction)customer:(id)sender;

- (IBAction)phoneView:(id)sender;
- (IBAction)visitView:(id)sender;
- (IBAction)revisitView:(id)sender;
- (IBAction)serviceView:(id)sender;

- (IBAction)advSelBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *advTypeLb;
- (void)hideBtns;

@property (retain, nonatomic) IBOutlet UIButton *phoneViewBtn;
@property (retain, nonatomic) IBOutlet UIButton *visitViewBtn;
@property (retain, nonatomic) IBOutlet UIButton *revisitViewBtn;
@property (retain, nonatomic) IBOutlet UIButton *serviceViewBtn;

@property (retain, nonatomic) IBOutlet UITextField *age;
- (IBAction)setAgeValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *hztj;
- (IBAction)setHztjValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *jzqy;
- (IBAction)setJzqyValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *gzqy;
- (IBAction)setGzqyValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *khlb;
- (IBAction)setKhlbValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *jtsr;
- (IBAction)setJtsrValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *cszy;
- (IBAction)setCszyValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *jtjg;
- (IBAction)setJtjgValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *zflx;
- (IBAction)setZflxValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextView *remark;
@property (retain, nonatomic) IBOutlet UITextView *zysx;

@property (retain, nonatomic) IBOutlet UITextField *zygw;

@property (retain, nonatomic) IBOutlet UITextField *hxxq;
- (IBAction)sethxxqValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *jgjsfw;
- (IBAction)setJgjsfwValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *zjjsfw;
- (IBAction)setZjjsfwValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *mjxq;
- (IBAction)setMjxqValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *smyx;
- (IBAction)setSmyxValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *zymd;
- (IBAction)setZymdValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *khzxd;
- (IBAction)setKhzxdValue:(id)sender;

- (void)setValue;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;

@property (retain, nonatomic) IBOutlet UIView *basicView;
@property (retain, nonatomic) IBOutlet UIView *phoneForm;
@property (retain, nonatomic) IBOutlet UIView *visitForm;
@property (retain, nonatomic) IBOutlet UIView *revisitForm;
@property (retain, nonatomic) IBOutlet UIView *serviceForm;

@property (retain, nonatomic) IBOutlet UITextField *khgzys;
- (IBAction)setKhgzysValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *jgjsfw_lf;
- (IBAction)setJgjsfw_lfValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *zymd_lf;
- (IBAction)setZymd_lfValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *hxlf;
- (IBAction)setHxlfValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *mjlf;
- (IBAction)setMjlfValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *lcxx;
- (IBAction)setLcxxValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *cxxx;
- (IBAction)setCxxxValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *sfjsjz;
- (IBAction)setSfjsjzValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *jzbz;
- (IBAction)setJzbzValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextView *tsyq;
@property (retain, nonatomic) IBOutlet UITextView *cjyy;
@property (retain, nonatomic) IBOutlet UITextView *qtyyfx;

@property (retain, nonatomic) IBOutlet UITextField *hxwcj;
- (IBAction)setHxwcjValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *xmwcj;
- (IBAction)setXmwcjValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *fkwcj;
- (IBAction)setFkwcjValue:(id)sender;

@property (retain, nonatomic) IBOutlet UITextView *revisitDesc;
@property (retain, nonatomic) IBOutlet UITextField *revisitInfo;

-(void) clearColor;
-(void) hideForm;

@property (retain, nonatomic) IBOutlet UITextField *whjr;
- (IBAction)setWhjrValue:(id)sender;
@property (retain, nonatomic) IBOutlet UITextView *whmr;
@property (retain, nonatomic) IBOutlet UITextView *fknr;

@property (retain, nonatomic) IBOutlet UITextField *hffs;
- (IBAction)setHffsValue:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *hfsj;

- (IBAction)submit:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *wcjxm;
@property (retain, nonatomic) IBOutlet UITextField *wcjhx;
- (IBAction)setWcjhxV:(id)sender;
- (IBAction)setWcjxmV:(id)sender;
@property (retain, nonatomic) IBOutlet UINavigationItem *navT;

- (void)xzrq;
- (IBAction)setLdsjValue:(id)sender;
- (IBAction)setLfsjValue:(id)sender;
- (IBAction)setHfsjValue:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *biView;
@property (retain, nonatomic) IBOutlet UIButton *basicBtn;

- (IBAction)showBasic:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *sckfF;
@property (retain, nonatomic) IBOutlet UITextField *jyfyF;
@property (retain, nonatomic) IBOutlet UITextField *qtfxF;
@property (retain, nonatomic) IBOutlet UITextField *hfnrF;
@property (retain, nonatomic) IBOutlet UITextField *whnrF;
@property (retain, nonatomic) IBOutlet UITextField *fknrF;

@end
