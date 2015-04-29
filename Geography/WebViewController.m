//
//  WebViewController.m
//  Geography
//
//  Created by Omar Rahman on 4/22/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)loadView {
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    self.view = webView;
    self.title = @"Wikipedia";
}

- (void)setURL:(NSURL *)URL {
    NSLog(@"Setting URL %@", URL);
    _URL = URL;
    if (_URL) {
        NSLog(@"Loading URL %@", URL);
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}

@end
