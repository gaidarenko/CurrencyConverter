//
//  ViewController.h
//  CurrencyConverter
//
//  Created by Георгий Гайдаренко on 04/07/2017.
//  Copyright © 2017 Georgiy Gaidarenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *fromValue;
@property (weak, nonatomic) IBOutlet UITextField *toValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fromCurrency;
@property (weak, nonatomic) IBOutlet UISegmentedControl *toCurrency;
@property (strong, nonatomic) NSMutableArray* rates;

@end

