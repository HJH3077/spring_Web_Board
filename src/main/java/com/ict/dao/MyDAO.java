package com.ict.dao;

import java.util.List;
import java.util.Map;

import com.ict.vo.VO;

public interface MyDAO {
	// 게시물의 수
	int selectCount() throws Exception;
	// 원글 리스트
	List<VO> selectList(int begin, int end) throws Exception;
	// 원글 삽입
	int InsertVO(VO vo) throws Exception;
	// 원글 히트 업데이트 
	int updateHit(String idx) throws Exception;
	// 원글 상세보기
	VO selectOneList(String idx) throws Exception;
	// 레벨업
	int updateLevUp(Map<String, Integer> map) throws Exception;
	// 원글 업데이트
	int updateList(VO vo) throws Exception;
	// 댓글 삽입
	int InsertAns(VO vo) throws Exception;
	// 원글 삭제
   	int delete(String groups) throws Exception;
   	// 댓글 삭제
   	int deleteAns(String idx) throws Exception;
   	
   	int selectPwdChk(VO vo) throws Exception;
	
}
