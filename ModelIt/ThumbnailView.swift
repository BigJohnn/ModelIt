//
//  ThumbnailView.swift
//  ModelIt
//
//  Created by HouPeihong on 2023/7/16.
//

import SwiftUI
import QuickLook

func generateThumbnail(
    size: CGSize,
    scale: CGFloat,
    completion: @escaping (UIImage) -> Void
  ) {
    if let thumbnail = UIImage(systemName: "doc") {
      completion(thumbnail)
    }
  }

struct ThumbnailView: View {
    @EnvironmentObject var model:CameraModel
    
    let filteredUIImage: [Data]
    @State var image: Image?
    
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        ForEach(filteredUIImage, id:\.hashValue) { data in //<-
            Image(uiImage: UIImage(data: data)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                        //...
                                    }
//        Image
//        ForEach(filteredUIImage, id: \.self){ image in
//
//            Image(uiImage: UIImage(data: image)!)
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .frame(width: 60, height: 60)
//            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//
//        }
//        for image in model.imagesCached {
//            Image(uiImage: UIImage(data: image)!)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 60, height: 60)
//                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//        }
//        Image(uiImage: UIImage(data: model.imagesCached[0])!)
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .frame(width: 60, height: 60)
//            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//        Image(uiImage: UIImage(data: model.imagesCached[1])!)
//            .resizable()
//            .aspectRatio(contentMode: .fill)
//            .frame(width: 60, height: 60)
//            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
    
//    @ViewBuilder func makeImageList() -> some View {
//       for image in model.imagesCached {
//           Image(uiImage: UIImage(data: image)!)
//               .resizable()
//               .aspectRatio(contentMode: .fill)
//               .frame(width: 60, height: 60)
//               .clipShape(RoundedRectangle(cornerRadius: 10, style:
////            if isPlaying {
////                PauseIcon()
////            } else {
////                PlayIcon()
////            }
//        }
}


//struct ThumbnailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThumbnailView()
//    }
//}
