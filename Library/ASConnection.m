#import "ASConnection.h"


@implementation ASConnection

@synthesize urlOfConnection, request, delegate, activeConnection, connection, responseData, tagString;

- (id)initWithUrl:(NSString *) url delegate:(id<EMConnectionDelegate>) connectionDelegate {
    self = [super init];
    if(self != nil) {
        self.responseData = [[NSMutableData alloc] init];
        self.urlOfConnection = url;
        self.delegate = connectionDelegate;
        [self setActiveConnection:NO];
                
    }
    return self;
}

- (void)invokeMethod:(NSString *)method 
               query:(NSString *)query
         requestData:(NSData *)requestData
         contentType:(NSString *)contentType {
    //if connection will be in process then we will return
    if(self.activeConnection == YES) {
        return;
    }

    if(query == nil) {
        self.request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.urlOfConnection]]];
    }
    else {
        self.request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", self.urlOfConnection, query]]];
    }
        
    [self.request setHTTPMethod:method];
    
    //now set content type if not present then we will set default which is text/plain
    if (contentType != nil) {
        [request setValue:contentType forHTTPHeaderField:@"Content-type"];
    }
    else {
        [request setValue:@"text/plain" forHTTPHeaderField:@"Content-type"];
    }
        
    [self.request setValue:[NSString stringWithFormat:@"%d", [requestData length]] 
     forHTTPHeaderField:@"Content-length"];
    
    [self.request setHTTPBody:requestData];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
    self.activeConnection = YES;
}

- (void)cancel {
    //Before cancel the connection we will reset
    [self setRequest:nil];
    [self setActiveConnection:NO];
    //Now we will cancel the connection
    [self.connection cancel];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //when data is received we will append that data because data receive in parts
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //call delegate method when error come
    if ([self.delegate respondsToSelector:@selector(connection:didFailWithError:)]) {
        [self.delegate connection:self didFailWithError:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //when data reception complete this delegate will call
    if([self.delegate respondsToSelector:@selector(connection:didReceiveData:)]) {
        [self.delegate connection:self didReceiveData:self.responseData];
    }
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)urlRequest redirectResponse:(NSURLResponse *) redirectResponse
{
    return urlRequest;
}

@end
