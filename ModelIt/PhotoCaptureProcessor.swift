//
//  PhotoCaptureProcessor.swift
//  abseil
//
//  Created by Rolando Rodriguez on 1/11/20.
//

import Foundation
import Photos
import UIKit

class PhotoCaptureProcessor: NSObject {
    private(set) var requestedPhotoSettings: AVCapturePhotoSettings
    
    private let willCapturePhotoAnimation: () -> Void
    
    private let completionHandler: (PhotoCaptureProcessor) -> Void
    
    //    private let photoProcessingHandler: (Bool) -> Void
    
    var photoData: Data?
    
    private var maxPhotoProcessingTime: CMTime?
    
    public static var sfmData = [[String:Any]]()
    
    private static var frameId = 0
        
    init(with requestedPhotoSettings: AVCapturePhotoSettings,
         willCapturePhotoAnimation: @escaping () -> Void,
         completionHandler: @escaping (PhotoCaptureProcessor) -> Void
//         photoProcessingHandler: @escaping (Bool) -> Void
    ) {
        self.requestedPhotoSettings = requestedPhotoSettings
        self.willCapturePhotoAnimation = willCapturePhotoAnimation
        self.completionHandler = completionHandler
//        self.photoProcessingHandler = photoProcessingHandler
    }
}

extension PhotoCaptureProcessor: AVCapturePhotoCaptureDelegate {
    /*
     This extension adopts all of the AVCapturePhotoCaptureDelegate protocol methods.
     */
    
    /// - Tag: WillBeginCapture
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        maxPhotoProcessingTime = resolvedSettings.photoProcessingTimeRange.start + resolvedSettings.photoProcessingTimeRange.duration
    }
    
    /// - Tag: WillCapturePhoto
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        DispatchQueue.main.async {
            self.willCapturePhotoAnimation()
        }
        
//        guard let maxPhotoProcessingTime = maxPhotoProcessingTime else {
//            return
//        }
        
        // Show a spinner if processing time exceeds one second.
//        let oneSecond = CMTime(seconds: 2, preferredTimescale: 1)
//        if maxPhotoProcessingTime > oneSecond {
//            DispatchQueue.main.async {
//                self.photoProcessingHandler(true)
//            }
//        }
    }
    
    /// - Tag: DidFinishProcessingPhoto
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
//        DispatchQueue.main.async {
//            self.photoProcessingHandler(false)
//        }
        DispatchQueue.main.async
        {
            if let error = error {
                print("Error capturing photo: \(error)")
            } else {
                self.photoData = photo.fileDataRepresentation()
                
                let exif_table = photo.metadata["{Exif}"] as? [String:AnyObject]
                print("FocalLength == \(String(describing: exif_table!["FocalLength"]))")
                print("FNumber == \(String(describing: exif_table!["FNumber"]))")
                print("PixelXDimension == \(String(describing: exif_table!["PixelXDimension"]))")
                print("PixelYDimension == \(String(describing: exif_table!["PixelYDimension"]))")
                
                let uuid = UInt32(truncatingIfNeeded: UUID().hashValue & LONG_MAX)
    //            let item = [
    //                "viewId":uuid,
    //                "poseId":uuid,
    //                "frameId":String(PhotoCaptureProcessor.frameId),
    //                "data": photoData?.description as Any,
    //                "width":String(describing: exif_table!["PixelXDimension"]!),
    //                "height":String(describing: exif_table!["PixelYDimension"]!),
    //                "metadata":exif_table as Any
    //            ] as [String : Any]
                PhotoCaptureProcessor.frameId += 1
    //            PhotoCaptureProcessor.sfmData.append(item)
                
    //            print("=====================================")
    //            print(exif_table!["PixelXDimension"]!)
    //            print("photodata == \(photoData)")
                
                if(photo.pixelBuffer != nil){
                    CVPixelBufferLockBaseAddress(photo.pixelBuffer!, .readOnly)
                    
                    //for single cam case, use the same intrinsic id
                    Pipeline_AppendSfMData(uuid,uuid,0,
                                           UInt32(truncating: PhotoCaptureProcessor.frameId as NSNumber),
                                           UInt32(truncating: exif_table!["PixelXDimension"]! as! NSNumber),
                                           UInt32(truncating: exif_table!["PixelYDimension"]! as! NSNumber),
                                           CVPixelBufferGetBaseAddress(photo.pixelBuffer!))
                    
                    
                    let pixelBuf = photo.pixelBuffer!
                    
    //                var type = CVPixelBufferGetPixelFormatName(pixelBuf) as OSType;
                    
    //                print("\(kCVPixelFormatType_32BGRA)")
                    print("pixeltype \(CVPixelBufferGetPixelFormatType(pixelBuf))")
    //                var name = CVPixelBufferGetPixelFormatName(pixelBuffer: pixelBuf)
    //                print("\(name)")
                    
                    print("w,h==\(CVPixelBufferGetWidth(pixelBuf)), \(CVPixelBufferGetHeight(pixelBuf))");
                    
    //                let tmpDirURL = FileManager.default.temporaryDirectory
    //
    //                Pipeline_SetOutputDataDir(tmpDirURL.absoluteString)
    //                Pipeline_FeatureExtraction()
                    
                    CVPixelBufferUnlockBaseAddress(photo.pixelBuffer!, .readOnly)
                }
            }
        }
        
    }

    fileprivate func saveToPhotoLibrary(_ photoData: Data) {
        //        MARK: Saves capture to photo library
        
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                PHPhotoLibrary.shared().performChanges({
                    let options = PHAssetResourceCreationOptions()
                    let creationRequest = PHAssetCreationRequest.forAsset()
                    options.uniformTypeIdentifier = self.requestedPhotoSettings.processedFileType.map { $0.rawValue }
                    creationRequest.addResource(with: .photo, data: photoData, options: options)
                }, completionHandler: { _, error in
                    if let error = error {
                        print("Error occurred while saving photo to photo library: \(error)")
                    }
                    
                    DispatchQueue.main.async {
                        self.completionHandler(self)
                    }
                }
                )
            } else {
                DispatchQueue.main.async {
                    self.completionHandler(self)
                }
            }
        }
    }
    
    /// - Tag: DidFinishCapture
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            DispatchQueue.main.async {
                self.completionHandler(self)
            }
            return
        }
        
        DispatchQueue.main.async {
//            let bSaveToLibrary = false;
//            if(bSaveToLibrary) {
//                self.completionHandler(self)
//            }
//            else {
                let photo = Photo(originalData: self.photoData!)
                self.saveToPhotoLibrary(photo.compressedData!)
//            }
        }
    }
}
