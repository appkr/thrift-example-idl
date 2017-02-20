include "Errors.thrift"

namespace php Appkr.Thrift.Post
namespace java kr.appkr.thrift.post
namespace js Appkr.Thrift.Post

/**
 * Post 엔티티
 */
struct Post {
    /** 기본 키 */
    1: optional i32 id,

    /** 포스트 제목 */
    2: optional string title,

    /** 포스트 본문 */
    3: optional string content,

    /** 포스트 최초 생성 시각 */
    4: optional string created_at,

    /** 포스트 최종 수정 시각 */
    5: optional string updated_at
}

/**
 * PostCollection 엔티티
 */
typedef list<Post> PostCollection

/**
 * 쿼리 필터 엔티티
 */
struct QueryFilter {
    /** 검색할 키워드 */
    1: optional string keyword = '',

    /** 정렬 기준이 되는 필드 */
    2: optional string sortBy = 'created_at',

    /** 정렬 방향 */
    3: optional string sortDirection = 'desc'
}

/**
 * Post 서비스
 */
service PostService {
    /**
     * 포스트 목록을 응답합니다.
     */
    PostCollection all(
        1: QueryFilter qf,
        2: i32 offset = 0,
        3: i32 limit = 10
    ) throws (
        1: Errors.UserException userException,
        2: Errors.SystemException systemException
    ),

    /**
     * 특정 포스트의 상세 정보를 응답합니다.
     */
    Post find(
        1: i32 id
    ) throws (
        1: Errors.UserException userException
        2: Errors.SystemException systemException
    ),

    /**
     * 새 포스트를 만듭니다.
     */
    Post store(
        1: Post post
    ) throws (
        1: Errors.UserException userException
        2: Errors.SystemException systemException
    )
}