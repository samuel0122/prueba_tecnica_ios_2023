
import SwiftUI
import Combine

struct ExerciseSwiftUI: View {
    
    // MARK: - Properties
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject private var viewModel = NewsViewModel()

    @State private var onViewAnimation: Bool = false
    
    var gridColumns: [GridItem] {
        withAnimation(.easeInOut){
                if horizontalSizeClass == .regular {
                    return [GridItem(.flexible()), GridItem(.flexible())]
                } else {
                    return [GridItem(.flexible())]
                }
            }
        }
    
    // MARK: - Body
    
    var body: some View {
        // todo: Your solution here
        ScrollView (.vertical) {
            LazyVGrid(columns: gridColumns, alignment: .center, spacing: 10) {
            //VStack (alignment: .center) {
                // Loop every viewModel
                ForEach(viewModel.news.indices, id: \.self) { newIndex in
                    ExerciseSwiftUIListItem (
                        imageName: viewModel.news[newIndex].imageName,
                        title: viewModel.news[newIndex].title 
                    )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 1)
                    .offset(x: onViewAnimation ? 0 // Start from left or right
                            : newIndex.isMultiple(of: 2) ? -500 : 500)
                    .opacity(onViewAnimation ? 1 : 0) // Start hidden
                    .animation( // Add an spring animation
                        .spring (response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)
                        .delay(TimeInterval(newIndex) / 15)
                        , value: onViewAnimation )
                } //: FOREACH
            } //: VSTACK
        } //: SCROLLVIEW
        .onAppear {
            viewModel.load()
            
            withAnimation {
                onViewAnimation.toggle()
            }
        } //: onAppear
    }
}

// MARK: - Preview

struct ExerciseSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSwiftUI()
    }
}

// MARK: - New View Model

private class NewsViewModel: ObservableObject {
    
    @Published var news: [Content] = []
    
    struct Content: Hashable, Identifiable {
        let id: Int
        let title: String
        let imageName: String
    }
    
    func load() {
        let titles: [String] = [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
            "Curabitur non ipsum eros. Suspendisse non dictum dolor",
            "Sed commodo rhoncus magna, et aliquam ante vehicula sit amet",
            "Proin fringilla rutrum enim, et blandit erat"
        ]
        
        let images: [String] = [
            "ingredients_1",
            "ingredients_2",
            "ingredients_3",
            "ingredients_4"
        ]
        
        let contents: [Content] = (0..<20).map { i in
            Content(id: i, title: titles[i % titles.count], imageName: images[i % images.count])
        }
        
        news = contents
    }
}

