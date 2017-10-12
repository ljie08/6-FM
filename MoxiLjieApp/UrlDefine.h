//
//  UrlDefine.h
//  MyWeather
//
//  Created by lijie on 2017/7/27.
//  Copyright © 2017年 lijie. All rights reserved.
//

#ifndef UrlDefine_h
#define UrlDefine_h

//主页
#define HomeURL @"http://yiapi.xinli001.com/fm/home-list.json?key=046b6a2a43dc6ff6e770255f57328f89"

//发现 - 主播
#define DiscoverURL @"http://yiapi.xinli001.com/fm/diantai-find-list.json?key=046b6a2a43dc6ff6e770255f57328f89&offset=0&limit=6"

#define DiscoverHeadViewURL @"http://bapi.xinli001.com/fm2/hot_tag_list.json/?rows=10&key=046b6a2a43dc6ff6e770255f57328f89&flag=4&offset=0"

// 发现详情
#define COMMDetailURL @"http://yiapi.xinli001.com/fm/forum-comment-list.json?key=046b6a2a43dc6ff6e770255f57328f89&post_id=%@&offset=%d&limit=10"

// 选择的网址(catagory)
#define CatagoryURL @"http://yiapi.xinli001.com/fm/category-jiemu-list.json?category_id=%@&key=046b6a2a43dc6ff6e770255f57328f89&offset=%d&limit=%d"

#define PlayerURL @"http://yiapi.xinli001.com/fm/broadcast-detail.json?key=046b6a2a43dc6ff6e770255f57328f89&id=%@"
// 更多心理课
#define MoreLessonURL @"http://yiapi.xinli001.com/fm/newlesson-list.json?key=046b6a2a43dc6ff6e770255f57328f89&offset=%d&limit=%d"
// 更多最新FM
#define MoreFMURL @"http://yiapi.xinli001.com/fm/newfm-list.json?key=046b6a2a43dc6ff6e770255f57328f89&offset=%d&limit=%d"
// 更多电台
#define MoreDianTaiURL @"http://yiapi.xinli001.com/fm/diantai-page.json?key=046b6a2a43dc6ff6e770255f57328f89"
#define MoreAnchorURL @"http://yiapi.xinli001.com/fm/diantai-hot-list.json?key=046b6a2a43dc6ff6e770255f57328f89&offset=%d&limit=%d"

// 主播详情
#define AnchorDetailURL @"http://yiapi.xinli001.com/fm/diantai-detai.json?key=046b6a2a43dc6ff6e770255f57328f89&id=%@"
#define AnchorJieMuURL @"http://yiapi.xinli001.com/fm/diantai-jiemu-list.json?key=046b6a2a43dc6ff6e770255f57328f89&offset=%d&diantai_id=%@&limit=%d"
//
#define DisCoverChooseURL @"http://bapi.xinli001.com/fm2/broadcast_list.json/?tag=%@&rows=%d&key=046b6a2a43dc6ff6e770255f57328f89&offset=%d&speaker_id=0"

// 所有主播
#define AllAnchorURL @"http://yiapi.xinli001.com/fm/diantai-find-list.json?key=046b6a2a43dc6ff6e770255f57328f89&offset=%d&limit=10"


#endif /* UrlDefine_h */
