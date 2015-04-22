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
}

- (void)setUrl:(NSURL *)url {
    _url = url;
    if (_url) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_url];
        [(UIWebView *)self.view loadRequest:req];
    }
}

@end
