//  HAZenDeskTicket.m
//
//Copyright (c) 2014 HelpStack (http://helpstack.io)
//
//Permission is hereby granted, free of charge, to any person obtaining a cop
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
#import "HSZenDeskTicket.h"
#import "HSZenDeskTicketUpdate.h"

@interface HSZenDeskTicket()

@end

@implementation HSZenDeskTicket

- (id)initWithRequestFields:(NSDictionary*)fields {
    if (self = [super init]) {
        self.ticketID = [[fields objectForKey:@"id"] stringValue];
        self.subject = [fields objectForKey:@"subject"];
    }
    return self;
}

- (id)initWithTicketFields:(NSDictionary *)fields {
    if (self = [super init]) {
        NSDictionary* ticketDictionary = [fields objectForKey:@"ticket"];
        self.ticketID = [ticketDictionary objectForKey:@"id"];
        self.subject = [ticketDictionary objectForKey:@"subject"];
    }
    return self;
}


@end
