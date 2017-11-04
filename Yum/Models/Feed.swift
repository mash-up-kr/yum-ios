//
//  Feed.swift
//  Yum
//
//  Created by Ryan Yoo on 2017. 11. 5..
//  Copyright © 2017년 Mash-up. All rights reserved.
//

import Foundation

struct Feed: Codable {
    
    var userProfileImageUrl: String?
    var userName: String?
    var foodImageUrl: String?
    var body: String?
    var calorie: Int?
    var tags: [String] = []
    
    init(userProfileImageUrl: String? = nil, userName: String? = nil, foodImageUrl: String? = nil, body: String? = nil) {
        self.userProfileImageUrl = userProfileImageUrl
        self.userName = userName
        self.foodImageUrl = foodImageUrl
        self.body = body
    }
    
}

extension Feed {
    
    static var sampleFeeds: [Feed] = [
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504884790557-80daa3a9e621?auto=format&fit=crop&w=400",
            userName: "박종훈", foodImageUrl: "https://images.unsplash.com/photo-1465014925804-7b9ede58d0d7?auto=format&fit=crop&w=500",
            body: "만나는 사람 마다 자비를 베풀고 싶어진다. 역시 한국인 심성의 흉악함은 뚜렷한 사계절 때문이었다."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "이현승",
            foodImageUrl: "https://images.unsplash.com/photo-1478369402113-1fd53f17e8b4?auto=format&fit=crop&w=500",
            body: "비싼 힐은 신어도 발이 안아프고 이런게 아니라 그런 가격의 힐을 신을 정도면 대중교통 같은거 타면서 걸을 일이 없기 때문에 그냥 예쁘게 만드는거라던 말이 생각나요..."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "기우영", foodImageUrl: "https://images.unsplash.com/photo-1453831362806-3d5577f014a4?auto=format&fit=crop&w=500",
            body: "각 나라 위로법\ns나: 난 병신 쓰레기야 난 못해\n미국: 노우노우마이갓! 네버 세이 댓 어게인 옼게이? 유캔두잇 네버 기법\n일본: 헤에 나니! 그런말 하지말라데스!와타시 응원해줄 수 있다굿! 잇쇼니! 간바떼네!!\n한국인: 시발ㄹ나도..."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "유병한", foodImageUrl: "https://images.unsplash.com/photo-1497888329096-51c27beff665?auto=format&fit=crop&w=500",
            body: "세프의 도시락 후기 : 고든 렘지가 때릴 맛"
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "고은이", foodImageUrl: "https://images.unsplash.com/photo-1502911478555-cada2f65234f?auto=format&fit=crop&w=500",
            body: "문득 중3 개근상을 봤는데... 고1 때 담임이 그랬다. 개근상 만큼 미련하고 쓸모없는 상도 없다. 어떻게 3년 동안 사람이 학교에 못올만큼 한번도 안아프거나 일이 없을 수 있느냐, 근면성실이란 이름 속에 얼마나 사회가 경직되었는지 알게 되길 바란다고."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "김동현", foodImageUrl: "https://images.unsplash.com/photo-1504263716296-ed1a29eca28c?auto=format&fit=crop&w=500",
            body: "씨ㅣ발 모기들이 존ㄴ나 우리집 들어올 때 35만원 씩 내면서 '하하..숙식 제공이라니 감사합니다'이러고 들어오면 좋겠다.\n존ㄴ나 양심없는 새끼들"
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "김현섭", foodImageUrl: "https://images.unsplash.com/photo-1502550900787-e956c314a221?auto=format&fit=crop&w=500",
            body: "세상에서 가장 도움이 안되는 이론은?\n제가 알기론"
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "박종훈", foodImageUrl: "https://images.unsplash.com/reserve/bnW1TuTV2YGcoh1HyWNQ_IMG_0207.JPG?auto=format&fit=crop&w=500",
            body: "만나는 사람 마다 자비를 베풀고 싶어진다. 역시 한국인 심성의 흉악함은 뚜렷한 사계절 때문이었다."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "이현승", foodImageUrl: "https://images.unsplash.com/photo-1455099675745-a442989ac8bf?auto=format&fit=crop&w=500",
            body: "비싼 힐은 신어도 발이 안아프고 이런게 아니라 그런 가격의 힐을 신을 정도면 대중교통 같은거 타면서 걸을 일이 없기 때문에 그냥 예쁘게 만드는거라던 말이 생각나요..."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?auto=format&fit=crop&w=400",
            userName: "기우영", foodImageUrl: "https://images.unsplash.com/photo-1479894720049-067d8b87f2d9?auto=format&fit=crop&w=500",
            body: "각 나라 위로법\ns나: 난 병신 쓰레기야 난 못해\n미국: 노우노우마이갓! 네버 세이 댓 어게인 옼게이? 유캔두잇 네버 기법\n일본: 헤에 나니! 그런말 하지말라데스!와타시 응원해줄 수 있다굿! 잇쇼니! 간바떼네!!\n한국인: 시발ㄹ나도..."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "유병한", foodImageUrl: "https://images.unsplash.com/photo-1482423064560-3e394ae8f216?auto=format&fit=crop&w=500",
            body: "세프의 도시락 후기 : 고든 렘지가 때릴 맛"
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?auto=format&fit=crop&w=400",
            userName: "고은이", foodImageUrl: "https://images.unsplash.com/photo-1496568554266-bc8a06b4d8b5?auto=format&fit=crop&w=500",
            body: "문득 중3 개근상을 봤는데... 고1 때 담임이 그랬다. 개근상 만큼 미련하고 쓸모없는 상도 없다. 어떻게 3년 동안 사람이 학교에 못올만큼 한번도 안아프거나 일이 없을 수 있느냐, 근면성실이란 이름 속에 얼마나 사회가 경직되었는지 알게 되길 바란다고."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1496302662116-35cc4f36df92?auto=format&fit=crop&w=400",
            userName: "김동현", foodImageUrl: "https://images.unsplash.com/photo-1477921510058-85812315a3c4?auto=format&fit=crop&w=500",
            body: "씨ㅣ발 모기들이 존ㄴ나 우리집 들어올 때 35만원 씩 내면서 '하하..숙식 제공이라니 감사합니다'이러고 들어오면 좋겠다.\n존ㄴ나 양심없는 새끼들"
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "박종훈", foodImageUrl: "https://images.unsplash.com/photo-1465014925804-7b9ede58d0d7?auto=format&fit=crop&w=500",
            body: "만나는 사람 마다 자비를 베풀고 싶어진다. 역시 한국인 심성의 흉악함은 뚜렷한 사계절 때문이었다."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?auto=format&fit=crop&w=400",
            userName: "이현승", foodImageUrl: "https://images.unsplash.com/photo-1478369402113-1fd53f17e8b4?auto=format&fit=crop&w=500",
            body: "비싼 힐은 신어도 발이 안아프고 이런게 아니라 그런 가격의 힐을 신을 정도면 대중교통 같은거 타면서 걸을 일이 없기 때문에 그냥 예쁘게 만드는거라던 말이 생각나요..."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "기우영", foodImageUrl: "https://images.unsplash.com/photo-1453831362806-3d5577f014a4?auto=format&fit=crop&w=500",
            body: "각 나라 위로법\ns나: 난 병신 쓰레기야 난 못해\n미국: 노우노우마이갓! 네버 세이 댓 어게인 옼게이? 유캔두잇 네버 기법\n일본: 헤에 나니! 그런말 하지말라데스!와타시 응원해줄 수 있다굿! 잇쇼니! 간바떼네!!\n한국인: 시발ㄹ나도..."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1496302662116-35cc4f36df92?auto=format&fit=crop&w=400",
            userName: "유병한", foodImageUrl: "https://images.unsplash.com/photo-1497888329096-51c27beff665?auto=format&fit=crop&w=500",
            body: "세프의 도시락 후기 : 고든 렘지가 때릴 맛"
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "고은이", foodImageUrl: "https://images.unsplash.com/photo-1502911478555-cada2f65234f?auto=format&fit=crop&w=500",
            body: "문득 중3 개근상을 봤는데... 고1 때 담임이 그랬다. 개근상 만큼 미련하고 쓸모없는 상도 없다. 어떻게 3년 동안 사람이 학교에 못올만큼 한번도 안아프거나 일이 없을 수 있느냐, 근면성실이란 이름 속에 얼마나 사회가 경직되었는지 알게 되길 바란다고."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "김동현", foodImageUrl: "https://images.unsplash.com/photo-1504263716296-ed1a29eca28c?auto=format&fit=crop&w=500",
            body: "씨ㅣ발 모기들이 존ㄴ나 우리집 들어올 때 35만원 씩 내면서 '하하..숙식 제공이라니 감사합니다'이러고 들어오면 좋겠다.\n존ㄴ나 양심없는 새끼들"
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1496302662116-35cc4f36df92?auto=format&fit=crop&w=400",
            userName: "김현섭", foodImageUrl: "https://images.unsplash.com/photo-1502550900787-e956c314a221?auto=format&fit=crop&w=500",
            body: "세상에서 가장 도움이 안되는 이론은?\n제가 알기론"
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "박종훈", foodImageUrl: "https://images.unsplash.com/reserve/bnW1TuTV2YGcoh1HyWNQ_IMG_0207.JPG?auto=format&fit=crop&w=500",
            body: "만나는 사람 마다 자비를 베풀고 싶어진다. 역시 한국인 심성의 흉악함은 뚜렷한 사계절 때문이었다."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "이현승", foodImageUrl: "https://images.unsplash.com/photo-1455099675745-a442989ac8bf?auto=format&fit=crop&w=500",
            body: "비싼 힐은 신어도 발이 안아프고 이런게 아니라 그런 가격의 힐을 신을 정도면 대중교통 같은거 타면서 걸을 일이 없기 때문에 그냥 예쁘게 만드는거라던 말이 생각나요..."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "기우영", foodImageUrl: "https://images.unsplash.com/photo-1479894720049-067d8b87f2d9?auto=format&fit=crop&w=500",
            body: "각 나라 위로법\ns나: 난 병신 쓰레기야 난 못해\n미국: 노우노우마이갓! 네버 세이 댓 어게인 옼게이? 유캔두잇 네버 기법\n일본: 헤에 나니! 그런말 하지말라데스!와타시 응원해줄 수 있다굿! 잇쇼니! 간바떼네!!\n한국인: 시발ㄹ나도..."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?auto=format&fit=crop&w=400",
            userName: "유병한", foodImageUrl: "https://images.unsplash.com/photo-1482423064560-3e394ae8f216?auto=format&fit=crop&w=500",
            body: "세프의 도시락 후기 : 고든 렘지가 때릴 맛"
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1504455583697-3a9b04be6397?auto=format&fit=crop&w=400",
            userName: "고은이", foodImageUrl: "https://images.unsplash.com/photo-1496568554266-bc8a06b4d8b5?auto=format&fit=crop&w=500",
            body: "문득 중3 개근상을 봤는데... 고1 때 담임이 그랬다. 개근상 만큼 미련하고 쓸모없는 상도 없다. 어떻게 3년 동안 사람이 학교에 못올만큼 한번도 안아프거나 일이 없을 수 있느냐, 근면성실이란 이름 속에 얼마나 사회가 경직되었는지 알게 되길 바란다고."
        ),
        Feed(
            userProfileImageUrl: "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?auto=format&fit=crop&w=400",
            userName: "김동현", foodImageUrl: "https://images.unsplash.com/photo-1477921510058-85812315a3c4?auto=format&fit=crop&w=500",
            body: "씨ㅣ발 모기들이 존ㄴ나 우리집 들어올 때 35만원 씩 내면서 '하하..숙식 제공이라니 감사합니다'이러고 들어오면 좋겠다.\n존ㄴ나 양심없는 새끼들"
        )
    ]
    
}
