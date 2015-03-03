#import <Foundation/Foundation.h>

@class ASConnection;
@protocol EMConnectionDelegate <NSObject>

//This method is called when data is received
- (void)connection:(ASConnection *)connection didReceiveData:(NSData *)data;

//This method is called when an NSURLConnection has
//failed to load successfully.
- (void)connection:(ASConnection *)connection didFailWithError:(NSError *)error;

@end

@interface ASConnection : NSObject  {
    
    //url of current connection
    NSString *urlOfConnection;
    //request of http
    NSMutableURLRequest *request;
    //instance of ConnectionDelegate 
    id <EMConnectionDelegate> delegate;
    //if connectin is present then its value will be YES other wise NO we can check 
    //status of our connection
    BOOL activeConnection;
    //instance of connection which will send request
    NSURLConnection *connection;
    //data in response of http request
    NSMutableData *responseData;
    
    NSString *tagString;
}

@property (nonatomic, strong) NSString *urlOfConnection;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) id <EMConnectionDelegate> delegate;
@property (nonatomic, assign) BOOL activeConnection;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSString *tagString;

//@param url tell the host address
//@param connectiondelegate will tell him that which will implement Connection delegate 
- (id)initWithUrl:(NSString *) url delegate:(id <EMConnectionDelegate>) connectionDelegate;

//This method will send http request if there is no connection present
//@param method will tell type of http request for example GET, POST, DELETE ......
//@Param query will be the query string which will be connect with url
//@param requestData will be the body of http
//@param contentType will tell that which type of conten we are going to put in http body like
- (void)invokeMethod:(NSString *)method 
               query:(NSString *)query
            requestData:(NSData *)requestData
               contentType:(NSString *)contentType;

//This method will cancel NSURLConnection if connection is present
- (void)cancel;

@end
