package com.ict.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.dao.MyDAO;
import com.ict.vo.VO;

@Service
public class MyServiceImpl implements MyService{
	@Autowired
	private MyDAO myDAO ;
	
	@Override
	public int selectCount() throws Exception {
		return myDAO.selectCount();
	}

	@Override
	public List<VO> selectList(int begin, int end) throws Exception {
		return myDAO.selectList(begin, end);
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
