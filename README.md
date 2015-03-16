# ASConnection
ASConnection is simple, extensible and reuseable implementation of NSURLConnection.

Following is a sample code for a sample GET Request

ASConnection *connection = [[ASConnection alloc] initWithUrl:@"https://api.app.net/stream/0/posts/stream/global" delegate:self];

[connection invokeMethod:kHttpMethod_Get query:nil requestData:nil contentType:nil];
