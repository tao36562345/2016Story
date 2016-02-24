//
//  ViewController.m
//  QLPDFViewer
//
//  Created by badman on 16/2/24.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "ViewController.h"
#import <QuickLook/QuickLook.h>

@interface ViewController ()<QLPreviewControllerDataSource, QLPreviewControllerDelegate, QLPreviewItem>
{
    QLPreviewController *previewController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.documents = [[NSArray alloc] initWithObjects:@"Predicates.pdf", nil];
    
    // initialize the QLPreviewController
    previewController = [[QLPreviewController alloc] init];
    previewController.dataSource = self;
    previewController.delegate = self;

    // Create a UIButton
    UIButton *pdfButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 70, 100)];
    pdfButton.backgroundColor = [UIColor clearColor];
    [pdfButton addTarget:self action:@selector(showDocument) forControlEvents:UIControlEventTouchUpInside];
    
    // set the image to thumbnail of page 4
    [pdfButton setImage:[self createThumbnailForPage:4] forState:UIControlStateNormal];
    [self.view addSubview:pdfButton];
}

- (void)showDocument
{
    [self presentViewController:previewController animated:YES completion:nil];
}

- (UIImage *)createThumbnailForPage:(int)pageno
{
    NSURL *pdfFileUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[self.documents objectAtIndex:0] ofType:nil]];
    
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfFileUrl);
    
    CGRect aRect = CGRectMake(0, 0, 70, 100);   // thumbnail size
    UIGraphicsBeginImageContext(aRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, 0.0, aRect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -(aRect.origin.x), -(aRect.origin.y));
    
    CGContextSetGrayFillColor(context, 1.0, 1.0);
    CGContextFillRect(context, aRect);
    
    // Grab the first PDF page
    CGPDFPageRef page = CGPDFDocumentGetPage(pdf, pageno);
    CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, aRect, 0, false);
    // And apply the transform.
    CGContextConcatCTM(context, pdfTransform);
    CGContextDrawPDFPage(context, page);
    
    // Create the new UIImage from the context
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    CGPDFDocumentRelease(pdf);
    
    return thumbnail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegates
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return [self.documents count];
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[self.documents objectAtIndex:index] ofType:nil]];
}

@end
