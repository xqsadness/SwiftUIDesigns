//
//  MoviewBanner.swift
//  SwiftUIDesigns
//
//  Created by xqsadness on 20/12/24.
//

import SwiftUI

var posts = [
    Post(imageName: "ig1", title: "Introduction to Swift", description: "Swift is an easy-to-learn and easy-to-use programming language. It is the first system programming language that offers the same expressiveness and fun as scripting languages. Swift is designed with safety in mind to avoid many common programming errors.", starRating: 4, width: 1080, height: 1920),
    
    Post(imageName: "ig2", title: "Swift Overview", description: "Swift is a new programming language for creating iOS and macOS applications. It combines the best of C and Objective-C without the constraints of C compatibility. Swift adopts safe programming practices and adds many new features to make programming simpler, more flexible, and more enjoyable. Built on the mature and beloved Cocoa and Cocoa Touch frameworks, Swift redefines software development.", starRating: 3, width: 1080, height: 1920),
    
    Post(imageName: "ig3", title: "Introduction to Objective-C", description: "Developers familiar with Objective-C will find Swift approachable. It adopts Objective-C’s named parameters and dynamic object model, seamlessly integrating with existing Cocoa frameworks and Objective-C code. On top of that, Swift introduces many new features while supporting both procedural and object-oriented programming.", starRating: 5, width: 1080, height: 1920),
    
    Post(imageName: "ig4", title: "Easy Payments with \nWalletory", description: "Swift is beginner-friendly. It’s the first language that meets industrial standards while being as expressive and fun as scripting languages. With code previews, developers can run Swift code and see results in real-time without compiling and running the entire application.", starRating: 3, width: 1080, height: 1920),
    
    Post(imageName: "ig5", title: "Swift is Amazing", description: "Swift does not require header files, writing code in main(), or adding semicolons at the end of every line (though if you are used to languages like Java or C, adding semicolons will not cause errors).", starRating: 2, width: 1080, height: 1920),
    
    Post(imageName: "ig6", title: "Open Source Support", description: "Swift is the latest achievement in programming languages, combining decades of experience building Apple platforms. Derived from Objective-C’s named parameter expressions in a clean syntax, Swift APIs are easier to read and maintain.", starRating: 5, width: 500, height: 281),
    
    Post(imageName: "ig7", title: "Type Inference Keeps Code Clean", description: "Type inference keeps code clean and reduces errors, while modules eliminate headers and provide namespaces. Memory is managed automatically, and you don’t even need to type semicolons.", starRating: 4, width: 800, height: 500),
    
    Post(imageName: "ig8", title: "Test Title", description: "Test data for waterfall layout.", starRating: 4, width: 784, height: 500),
]

struct MovieBannerView: View {
    
    // current index
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                ForEach(posts.indices, id: \.self) { index in
                    GeometryReader { proxy in
                        Image(posts[index].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .cornerRadius(1)
                    }
                    .ignoresSafeArea()
                    .offset(y: -100)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            .overlay(
                LinearGradient(colors: [
                    Color.clear,
                    Color.black.opacity(0.2),
                    Color.white.opacity(0.4),
                    Color.white,
                    Color.white,
                    Color.white,
                ], startPoint: .top, endPoint: .bottom)
            )
            .ignoresSafeArea()
            
            //posts..
            SnapCarousel(trailingSpace: getScreenRect().height < 750 ? 100 : 150 ,index: $currentIndex, items: posts, isOffset: true) { post in
                
                CardView(post: post)
                
            }
            .offset(y: getScreenRect().height / 4)
        }
    }
    
    @ViewBuilder
    func CardView(post: Post) -> some View {
        
        VStack(spacing: 10) {
            GeometryReader { proxy in
                Image(post.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .cornerRadius(25)
            }
            .padding(15)
            .background(Color.white)
            .cornerRadius(25)
            .frame(height: getScreenRect().height / 2.5)
            .padding(.bottom, 15)
            
            Text(post.title)
                .foregroundStyle(.text)
                .bold()
            
            HStack(spacing: 3) {
                
                ForEach(1...5, id: \.self) { index in
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= post.starRating ? .yellow : .gray)
                }
                
                Text("(\(post.starRating).0)")
            }
            .font(.caption)
            
            Text(post.description)
                .foregroundStyle(.text)
                .font(.callout)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding(.top , 8)
                .padding(.horizontal)
        }
    }
    
}

#Preview {
    MovieBannerView()
}

extension View {
    func getScreenRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func frame(_ size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
}

struct SnapCarousel<Content: View, T: Identifiable>: View {
    
    var  content:(T) -> Content
    var  list : [T]
    //properties
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    var isOffset: Bool
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>, items:[T], isOffset: Bool = false, @ViewBuilder content: @escaping (T) -> Content){
        
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
        self.isOffset = isOffset
    }
    
    // offset ....
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        
        
        GeometryReader { proxy in
            
            // setting correct width for snap carousel....
            // on sided snap caorusel
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: spacing) {
                
                ForEach(list){item in
                    content(item)
                        .frame(width: proxy.size.width > trailingSpace ? (proxy.size.width - trailingSpace) : 0)
                        .offset(y: getOffset(item: item, width: width))
                }
            }
            //spacing will be horizontal padding....
            .padding(.horizontal, spacing)
            // setting only after oth index...
            .offset(x: (CGFloat(currentIndex) * -width) + (isOffset ? (currentIndex != 0 ? adjustMentWidth : 0) : adjustMentWidth) + offset)
            .gesture(
                
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        
                        // updating current index...
                        let offsetX = value.translation.width
                        
                        //were going to convert the tranlastion into progress(0- 1)
                        //and round the value....
                        //based on the progress increasing or decreasing the currentIndex.
                        
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                        currentIndex = index
                    })
                    .onChanged({ value in
                        
                        //updating only index...
                        
                        // updating current index...
                        let offsetX = value.translation.width
                        
                        //were going to convert the tranlastion into progress(0- 1)
                        //and round the value....
                        //based on the progress increasing or decreasing the currentIndex.
                        
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    })
            )
        }
        //Animating when offset = 0
        .animation(.easeInOut, value: offset == 0)
    }
    
    //moving view based on scroll offset....
    func getOffset(item : T, width: CGFloat) -> CGFloat {
        
        //progress....
        //shifting Current Item to Top
        let progress = ((offset < 0 ? offset : -offset) / width) * 60
        
        //max 60
        //minus from 60
        let topOffset = -progress < 60 ? progress : -(progress + 120)
        
        let previous = getIndex(item: item) - 1 == currentIndex ? (offset < 0 ? topOffset : -topOffset) : 0
        
        let next = getIndex(item: item) + 1 == currentIndex ? (offset < 0 ? -topOffset : topOffset) : 0
        
        //safty check between o to max list size...
        let checkBetween = currentIndex >= 0 && currentIndex < list.count ? (getIndex(item: item) - 1 == currentIndex ? previous : next) : 0
        
        return getIndex(item: item) == currentIndex ? -60 - topOffset : checkBetween
        
    }
    
    // fetching index...
    func getIndex(item: T) -> Int {
        
        let index = list.firstIndex { currentItem in
            
            return currentItem.id == item.id
        } ?? 0
        
        return index
    }
}

protocol Sizeable {
    var width: Double { get }
    var height: Double { get }
}
//Post model...
struct Post: Identifiable, Hashable, Sizeable {
    
    var id = UUID().uuidString
    var imageName: String
    var isLiked: Bool = false
    var title: String = ""
    var description: String = ""
    var starRating: Int = 0
    var width: Double = 160
    var height: Double = 90
}

struct PostCardView: View {
    
    var post: Post
    var body: some View {
        
        Image(post.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}
