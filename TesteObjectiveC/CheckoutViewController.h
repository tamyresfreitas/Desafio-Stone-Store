//
//  CheckoutViewController.h
//  TesteObjectiveC
//
//  Created by Tamyres Freitas on 2/3/16.
//  Copyright © 2016 Tamyres Freitas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckoutViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UILabel *precoLabel;
@property (nonatomic, strong) NSString *precoName;
@property (nonatomic,strong) NSString *productName;

@end
