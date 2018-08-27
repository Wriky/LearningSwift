//
//  Enums.swift
//  LearningSwift
//
//  Created by wangyuan on 2018/8/9.
//  Copyright © 2018年 wangyuan. All rights reserved.
//

import Foundation
import HandyJSON

enum ChatToolBarStatus: String {
    
    case Nothing = "Nothing"     // 默认状态
    case ShowVoice = "ShowVoice"  // 录音状态
    case ShowFace = "ShowFace"    // 输入表情状态
    case ShowMore = "ShowMore"    // 显示“更多”页面状态
    case ShowKeyboard = "ShowKeyboard"// 正常键盘
    case ShowVideo = "ShowVideo"   // 录制视频
}

enum EmotionMenuButtonType: Int {
    case Emoji = 100
    case Custom = 101
    case Gif = 102
} 

public enum CentrifugeMethod: String {
    case connect = "connect"
    case disconnect = "disconnect"
    case subscribe = "subscribe"
    case unsubscribe = "unsubscribe"
    case publish = "publish"
    case presence = "presence"
    case history = "history"
    case join = "join"
    case leave = "leave"
    case message = "message"
    case refresh = "refresh"
    case ping = "ping"
}

enum NewsTitleCategory: String, HandyJSONEnum {
    /// 推荐
    case recommend = ""
    /// 热点
    case hot = "news_hot"
    /// 地区
    case local = "news_local"
    /// 视频
    case video = "video"
    /// 社会
    case society = "news_society"
    /// 图片,组图
    case photos = "组图"
    /// 娱乐
    case entertainment = "news_entertainment"
    /// 科技
    case newsTech = "news_tech"
    /// 科技
    case car = "news_car"
    /// 财经
    case finance = "news_finance"
    /// 军事
    case military = "news_military"
    /// 体育
    case sports = "news_sports"
    /// 段子
    case essayJoke = "essay_joke"
    /// 街拍
    case imagePPMM = "image_ppmm"
    /// 趣图
    case imageFunny = "image_funny"
    /// 美图
    case imageWonderful = "image_wonderful"
    /// 国际
    case world = "news_world"
    /// 搞笑
    case funny = "funny"
    /// 健康
    case health = "news_health"
    /// 特卖
    case jinritemai = "jinritemai"
    /// 房产
    case house = "news_house"
    /// 时尚
    case fashion = "news_fashion"
    /// 历史
    case history = "news_history"
    /// 育儿
    case baby = "news_baby"
    /// 数码
    case digital = "digital"
    /// 语录
    case essaySaying = "essay_saying"
    /// 星座
    case astrology = "news_astrology"
    /// 辟谣
    case rumor = "rumor"
    /// 正能量
    case positive = "positive"
    /// 动漫
    case comic = "news_comic"
    /// 故事
    case story = "news_story"
    /// 收藏
    case collect = "news_collect"
    /// 精选
    case boutique = "boutique"
    /// 孕产
    case pregnancy = "pregnancy"
    /// 文化
    case culture = "news_culture"
    /// 游戏
    case game = "news_game"
    /// 股票
    case stock = "stock"
    /// 科学
    case science = "science_all"
    /// 宠物
    case pet = "宠物"
    /// 情感
    case emotion = "emotion"
    /// 家居
    case home = "news_home"
    /// 教育
    case education = "news_edu"
    /// 三农
    case agriculture = "news_agriculture"
    /// 美食
    case food = "news_food"
    /// 养生
    case regimen = "news_regimen"
    /// 电影
    case movie = "movie"
    /// 手机
    case cellphone = "cellphone"
    /// 旅行
    case travel = "news_travel"
    /// 问答
    case questionAndAnswer = "question_and_answer"
    /// 小说
    case novelChannel = "novel_channel"
    /// 直播
    case live_talk = "live_talk"
    /// 中国新唱将
    case chinaSinger = "中国新唱将"
    /// 火山直播
    case hotsoon = "hotsoon"
    /// 互联网法院
    case highCourt = "high_court"
    /// 快乐男声
    case happyBoy = "快乐男声"
    /// 传媒
    case media = "media"
    /// 百万英雄
    case millionHero = "million_hero"
    /// 彩票
    case lottery = "彩票"
    /// 中国好表演
    case chinaAct = "中国好表演"
    /// 春节
    case springFestival = "spring_festival"
    /// 微头条
    case weitoutiao = "weitoutiao"
    /// 小视频 推荐
    case hotsoonVideo = "hotsoon_video"
    /// 小视频 颜值/美女
    case ugcVideoBeauty = "ugc_video_beauty"
    /// 小视频 随拍
    case ugcVideoCasual = "ugc_video_casual"
    /// 小视频 美食
    case ugcVideoFood = "ugc_video_food"
    /// 小视频 户外
    case ugcVideoLife = "ugc_video_life"
}

/// 从哪里进入头条
enum TTFrom: String {
    case pull = "pull"
    case loadMore = "load_more"
    case auto = "auto"
    case enterAuto = "enter_auto"
    case preLoadMoreDraw = "pre_load_more_draw"
}
