package com.ict.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.vo.VO;

@Repository
public class MyDAOImpl implements MyDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public int selectCount() throws Exception {
		return sqlSessionTemplate.selectOne("board.count");
	}

	@Override
	public List<VO> selectList(int begin, int end) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("begin", begin);
		map.put("end", end);
		return sqlSessionTemplate.selectList("board.list", map);
	}

	@Override
	public int InsertVO(VO vo) throws Exception {
		return sqlSessionTemplate.insert("board.insert", vo);
	}

	@Override
	public int updateHit(String idx) throws Exception {
		return sqlSessionTemplate.update("board.updateHit", idx);
	}

	@Override
	public VO selectOneList(String idx) throws Exception {
		return sqlSessionTemplate.selectOne("board.onelist", idx);
	}

	@Override
	public int updateLevUp(Map<String, Integer> map) throws Exception {
		return sqlSessionTemplate.update("board.lev_up", map);
	}

	@Override
	public int InsertAns(VO vo) throws Exception {
		return sqlSessionTemplate.insert("board.ans_insert", vo);
	}
	
	@Override
	public int selectPwdChk(VO vo) throws Exception {
		return sqlSessionTemplate.selectOne("board.pwd_chk", vo);
	}
	
	@Override
	public int updateList(VO vo) throws Exception {
		return sqlSessionTemplate.update("board.update", vo);
	}


	@Override
	public int delete(String groups) throws Exception {
		return sqlSessionTemplate.delete("board.delete", groups);
	}

	@Override
	public int deleteAns(String idx) throws Exception {
		return sqlSessionTemplate.delete("board.ans_delete", idx);
	}

}
