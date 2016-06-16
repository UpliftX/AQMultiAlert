/* Copyright 2016 UpliftX
 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 
 * http://www.apache.org/licenses/LICENSE-2.0
 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "AQAlertQueue.h"

@implementation AQAlertQueue

static dispatch_queue_t _alertQueue;
static dispatch_semaphore_t _queueSemaphore;

+ (AQAlertQueue *)sharedAlertQueue {
    
    static dispatch_once_t onceToken;
    static AQAlertQueue *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AQAlertQueue alloc] init];
        _queueSemaphore = dispatch_semaphore_create(1);
        _alertQueue = dispatch_queue_create("alert.queue", DISPATCH_QUEUE_SERIAL);
    });
    return sharedInstance;
}

- (void)showAlert:(UIAlertController*)alertController animated: (BOOL)flag completion:(void (^)(void))completion onViewController:(UIViewController*)parentViewController {
    dispatch_block_t alertBlock = ^{
        dispatch_semaphore_wait(_queueSemaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            [parentViewController presentViewController:alertController
                                               animated:flag
                                             completion:completion];
        });
    };
    dispatch_async(_alertQueue, alertBlock);
}

+ (void)signalSemaphore {
    dispatch_semaphore_signal(_queueSemaphore);
}

@end
