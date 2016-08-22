//
//  ViewController.m
//  RMWeatherApp
//
//  Created by Student P_02 on 04/08/16.
//  Copyright © 2016 Rahul Mankar. All rights reserved.
//


#define kFahrenheitUnit @"imperial"
#define kCelsiusUnit @"metric"

#import "ViewController.h"

typedef enum : NSUInteger{
    Fahrenheit = 0,
    Celsius = 1
}UnitType;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID=069271c372b80c0cc3c5c0370e67eb2d

    locationManager=[[CLLocationManager alloc]init];
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.delegate=self;
    [locationManager requestWhenInUseAuthorization];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)downloadWeatherDataWithLatitude:(NSString *)latitudeString
                             longitude:(NSString*) longitudeString unit:(UnitType) unitForSearch
{

    NSString *urlString;
    
    switch (unitForSearch) {
        case Fahrenheit:
            urlString=[NSString stringWithFormat:@"api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&APPID=%@&units=%@",l,kWeatherAPIKey,kFahrenheitUnit];
            break;
        case Celsius:
            urlString=[NSString stringWithFormat:@"api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&APPID=%@&units=%@",kWeatherAPIKey,kCelsiusUnit];
            break;
            default:
            break;
    }
    
    NSURLSession *urlSession =[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error : %@",error.localizedDescription);
        }
        else {
            
    if (response) {
                
                NSHTTPURLResponse *httpRepsonse = (NSHTTPURLResponse *)response;
                
                if (httpRepsonse.statusCode == 200) {
                    
                    if (data) {
                        
                        
                        NSError *error;
                        NSDictionary *jsonReponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                        
                        if (error) {
                            NSLog(@"JSON Parsing Error : %@",error.localizedDescription);
                        }
                        else {
                            
                            [self performSelectorOnMainThread:@selector(updateUI:) withObject:jsonReponse waitUntilDone:NO];
                            
                        }
                        
                        
                    }
                    else {
                        NSLog(@"Data nil.");
                    }
                    
                }
                else {
                    NSLog(@"HTTP Status Code : %ld",(long)httpRepsonse.statusCode);
                }
                
            }
            else {
                NSLog(@"Reponse Nil.");
            }
            
        }
        
        
    }];
    
    [dataTask resume];
    
}

    
}

@end
