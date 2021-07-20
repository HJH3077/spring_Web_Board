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
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateHit(String idx) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public VO selectOneList(String idx) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateLevUp(Map<String, Integer> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateList(VO vo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int InsertAns(VO vo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String groups) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteAns(String idx) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
