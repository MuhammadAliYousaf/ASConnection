//
//  ViewController.m
//  ASConnectionTest
//
//  Created by Muhammad Ali Yousaf on 03/03/2015.
//  Copyright (c) 2015 AliSolutions. All rights reserved.
//

#import "ViewController.h"
#import "ASConnection.h"

@interface ViewController () <ASConnectionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ASConnection *connection = [[ASConnection alloc] initWithUrl:@"https://api.app.net/stream/0/posts/stream/global" delegate:self];
    [connection invokeMethod:kHttpMethod_Get query:nil requestData:nil contentType:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ASConnection Delegate
- (void)connection:(ASConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void)connection:(ASConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error --> %@", [error localizedDescription]);
}

@end
