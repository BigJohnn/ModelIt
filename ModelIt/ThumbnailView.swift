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

enum Items: String, CaseIterable, Equatable {
    case item1
    case item2
    case item3
    case item4
    case item5
    case item6
}

struct ThumbnailView: View {
//    @EnvironmentObject var model:CameraModel
    
    let filteredUIImage: [Data]
//    @State var image: Image?
    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
        
    @State  var selectedItems: [Data] = []
//    let rows = [GridItem(.fixed(160)), GridItem(.fixed(160))]
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                
                LazyHGrid(rows: rows) {
//                    ForEach(Items.allCases, id: \.self) { item in
//                                            GridColumn(item: item, items: $selectedItems)
//                                        }
                    ForEach(filteredUIImage, id:\.hashValue) { data in //<-
                        GridColumn(item: data, items: $selectedItems)
//                        Image(uiImage: UIImage(data: data)!)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 160, height: 160)
//                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct GridColumn:View {
    let item: Data
    
    @Binding var items: [Data]
    
    let imageWidth:CGFloat = 140
    var body: some View {
        Button(action: {
            if items.contains(item) {
                items.removeAll { $0 == item}
            } else {
                items.append(item)
            }
        }, label: {
            Image(uiImage: UIImage(data: item)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: imageWidth, height: imageWidth)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .tag(item)
                        .border(items.contains(item) ? Color.white : Color.black, width: 3)
//                        .colorMultiply(items.contains(item) ? .blue : .white)
        })
        .frame(width: imageWidth + CGFloat(10), height: imageWidth + CGFloat(10))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(filteredUIImage: [])
    }
}
