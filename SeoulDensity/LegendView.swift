import SwiftUI

struct LegendView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle().fill(Color.red).frame(width: 10, height: 10)
                Text("붐빔").font(.caption)
            }
            HStack {
                Circle().fill(Color.orange).frame(width: 10, height: 10)
                Text("약간 붐빔").font(.caption)
            }
            HStack {
                Circle().fill(Color.yellow).frame(width: 10, height: 10)
                Text("보통").font(.caption)
            }
            HStack {
                Circle().fill(Color.green).frame(width: 10, height: 10)
                Text("여유").font(.caption)
            }
        }
        .padding(5)
        .background(Color.white.opacity(0.8))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView()
    }
}
