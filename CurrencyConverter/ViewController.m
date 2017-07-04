//
//  ViewController.m
//  CurrencyConverter
//
//  Created by Георгий Гайдаренко on 04/07/2017.
//  Copyright © 2017 Georgiy Gaidarenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.fromCurrency addTarget:self
                          action:@selector(onChange)
                forControlEvents:UIControlEventValueChanged];
    
    [self.toCurrency addTarget:self
                        action:@selector(onChange)
               forControlEvents:UIControlEventValueChanged];
    
    [self.fromValue addTarget:self
                       action:@selector(onChange)
             forControlEvents:UIControlEventEditingChanged];
    
    self.rates = [[NSMutableArray alloc] init];
    NSArray *currencies = @[@"RUB", @"USD", @"EUR"];
    
    // Загрузим курсы валют с бесплатного сервиса "fixer.io"
    for (NSString* str in currencies) {
        NSString *urlString = [NSString stringWithFormat:@"http://api.fixer.io/latest?base=%@", str];
        NSURL *url = [NSURL URLWithString:urlString];
    
        NSError *error;
        // ToDo: Не очень хороший вариант грузить данные синхронно в основном потоке.
        NSData* data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
        
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
            if (json) {
                [self.rates addObject:json];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float)convertFrom:(NSString *)from to:(NSString *)toCurrency value:(float)valueData {
    
    if ([from isEqualToString:toCurrency])
        return valueData;
    
    for (NSDictionary* dic in self.rates) {
        NSString *base = [dic objectForKey:@"base"];
        
        if (base && [base isEqualToString:from]) {
            NSDictionary *rates = [dic objectForKey:@"rates"];
            
            if (rates) {
                NSNumber *rate = [rates objectForKey:toCurrency];
                
                float result = valueData * [rate floatValue];
                return result;
            }
        }
    }
    
    return 0.0;
}

- (void)onChange {
    NSString *from = [self.fromCurrency titleForSegmentAtIndex:self.fromCurrency.selectedSegmentIndex];
    NSString *to = [self.toCurrency titleForSegmentAtIndex:self.toCurrency.selectedSegmentIndex];
    
    float value = [self.fromValue.text floatValue];
    
    float result = [self convertFrom:from to:to value:value];
    self.toValue.text = [NSString stringWithFormat:@"%.02f", result];
}

@end
