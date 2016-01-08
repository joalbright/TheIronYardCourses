//
//  NSAViewController.m
//  Noisy
//
//  Created by Jo Albright on 6/5/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "NSAViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface NSAViewController () <AVCaptureAudioDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate>

@end

@implementation NSAViewController
{
    AVAudioSession * session;
    AVCaptureAudioDataOutput * output;
    AVCaptureSession * capture;
    
    UIView * peakView;
    UIView * powerView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        
        peakView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0, 0, 0)];
        peakView.backgroundColor = [UIColor whiteColor];
        peakView.alpha = 0.5;
        [self.view addSubview:peakView];
        
        powerView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0, 0, 0)];
        powerView.backgroundColor = [UIColor whiteColor];
        powerView.alpha = 0.5;
        [self.view addSubview:powerView];
        
        session = [AVAudioSession sharedInstance];
        
        [session setCategory:AVAudioSessionCategoryRecord error:NULL];
        [session setMode:AVAudioSessionModeMeasurement error:NULL];
        [session setActive:YES error:NULL];
        
        capture = [[AVCaptureSession alloc] init];
        
        // Configure audio device input
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
        [capture addInput:input];
        
        // Configure audio data output
        output = [[AVCaptureAudioDataOutput alloc] init];
        [output setSampleBufferDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,(unsigned long)NULL)];
        [capture addOutput:output];
        
        // Start the capture session.   
        [capture startRunning];
    }
    return self;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
//    NSLog(@"Seconds %f",CMTimeGetSeconds(CMSampleBufferGetDuration(sampleBuffer)));
//    
//    NSLog(@"size %lu",CMSampleBufferGetTotalSampleSize(sampleBuffer));
//    
//    // Save the Timescale
//    
//    CMTime timestamp = CMSampleBufferGetOutputPresentationTimeStamp(sampleBuffer);
//    
//    NSLog(@"Timestamp %f",CMTimeGetSeconds(timestamp));
//    
//    
//    CMFormatDescriptionRef formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer);
//    
//    const AudioStreamBasicDescription * const asbd = CMAudioFormatDescriptionGetStreamBasicDescription(formatDescription);
//    
//    double sampleRate = asbd->mSampleRate;
//    
//    NSLog(@"sample rate : %f", sampleRate);
    
    NSArray *audioChannels = connection.audioChannels;
    
    for (AVCaptureAudioChannel *channel in audioChannels)
    {
        float avg = channel.averagePowerLevel;
        float peak = channel.peakHoldLevel;
        // Update the level meter user interface.
        
//        NSLog(@"power %f peak %f",avg,peak);
        
        float powerSize = fabsf(-60.0 - avg) * 10;
        float peakSize = fabsf(-60.0 - peak) * 10;
        
        NSLog(@"power %f peak %f",powerSize,peakSize);
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            powerView.frame = CGRectMake((SCREEN_WIDTH - powerSize) / 2.0, (SCREEN_HEIGHT - powerSize) / 2.0, powerSize, powerSize);
            powerView.layer.cornerRadius = powerSize / 2.0;
            
//            peakView.frame = CGRectMake((SCREEN_WIDTH - peakSize) / 2.0, (SCREEN_HEIGHT - peakSize) / 2.0, peakSize, peakSize);
//            peakView.layer.cornerRadius = peakSize / 2.0;
            
        });
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden { return YES; }

@end
