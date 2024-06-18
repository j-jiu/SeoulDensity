import SwiftUI
import MapKit
//최종
struct ContentView: View {
    @State private var seoulCityData: [SeoulCityData] = []
    @State private var selectedLocations: [String] = [
        "4·19 카페거리", "DDP(동대문디자인플라자)", "DMC(디지털미디어시티)", "경복궁", "고덕역", "고속터미널역", "고척돔", "광나루한강공원", "광장(전통)시장", "광화문광장", "광화문·덕수궁", "교대역", "구로디지털단지역", "구로역", "군자역", "국립중앙박물관·용산가족공원", "김포공항", "가락시장", "가로수길", "가산디지털단지역", "강남 MICE 관광특구", "강남역", "강서한강공원", "건대입구역", "고덕역", "고속터미널역", "교대역", "구로디지털단지역", "구로역", "군자역", "광나루한강공원", "광화문광장", "국립중앙박물관·용산가족공원", "김포공항", "낙산공원·이화마을", "남구로역", "남대문시장", "남산공원", "노량진", "노들섬", "대림역", "덕수궁길·정동길", "동대문 관광특구", "동대문역", "뚝섬역", "뚝섬한강공원", "망원한강공원", "명동 관광특구", "미아사거리역", "발산역", "방배역 먹자골목", "보신각", "북서울꿈의숲", "북한산우이역", "북창동 먹자골목", "북촌한옥마을", "불광천", "서울 암사동 유적", "서울광장", "서울대공원", "서울대입구역", "서울숲공원", "서울식물원·마곡나루역", "서울역", "서리풀공원·몽마르뜨공원", "서촌", "선릉역", "성신여대입구역", "성수카페거리", "수유리 먹자골목", "수유역", "신논현역·논현역", "신도림역", "신림역", "신촌·이대역", "쌍문동 맛집거리", "압구정로데오거리", "아차산", "양재역", "양화한강공원", "어린이대공원", "여의도", "여의도한강공원", "연남동", "연신내역", "영등포 타임스퀘어", "외대앞", "용리단길", "용산역", "우이북한산역", "응봉산", "잠실 관광특구", "잠실종합운동장", "잠실한강공원", "잠원한강공원", "장지역", "장한평역", "종로·청계 관광특구", "창동 신경제 중심지", "창덕궁·종묘", "청계산", "청담동 명품거리", "청량리 제기동 일대 전통시장", "청와대", "천호역", "총신대입구(이수)역", "충정로역", "합정역", "해방촌·경리단길", "혜화역", "홍대 관광특구", "홍대입구역(2호선)", "회기역"
    ]
    @State private var selectedAnnotation: CustomAnnotation?

    var body: some View {
        VStack {
            // 상단 로고 및 갱신 버튼
            HStack {
                Text("Seoul Density Map") // 앱 이름
                    .font(.title)
                    .bold()
                    .padding(.leading)
                Spacer()
                Button(action: fetchData) { // 새로고침 버튼
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .padding(.trailing)
            }
            .padding(.top)

            ZStack(alignment: .topLeading) {
                MapView(seoulCityData: seoulCityData, selectedAnnotation: $selectedAnnotation)
                    .frame(height: 300)
                    .padding()
                LegendView()
                    .padding()
            }

            if let selectedAnnotation = selectedAnnotation {
                LocationDetailView(annotation: selectedAnnotation)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
            }

            if seoulCityData.isEmpty && selectedAnnotation == nil {
                Text("로딩 중...")
                    .padding()
                    .onAppear {
                        fetchData() // 뷰가 나타날 때 데이터 가져오기
                    }
            }
        }
    }

    private func fetchData() {
        let group = DispatchGroup()
        var cityDataList: [SeoulCityData] = []

        for location in selectedLocations {
            group.enter()
            GeocodingAPIClient.shared.geocode(address: location) { coordinate in
                guard let coordinate = coordinate else {
                    group.leave()
                    return
                }

                APIClient.shared.fetchData(for: [location]) { data in
                    if var data = data?.first {
                        data.latitude = coordinate.latitude
                        data.longitude = coordinate.longitude
                        cityDataList.append(data)
                    } else {
                        print("데이터 로드 실패")
                    }
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            self.seoulCityData = cityDataList
        }
    }
}
