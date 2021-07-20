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
		return myDAO.InsertVO(vo);
	}

	@Override
	public int updateHit(String idx) throws Exception {
		return myDAO.updateHit(idx);
	}

	@Override
	public VO selectOneList(String idx) throws Exception {
		return myDAO.selectOneList(idx);
	}

	@Override
	public int updateLevUp(Map<String, Integer> map) throws Exception {
		return myDAO.updateLevUp(map);
	}

	@Override
	public int InsertAns(VO vo) throws Exception {
		return myDAO.InsertAns(vo);
	}
	
	@Override
	public int selectPwdChk(VO vo) throws Exception {
		return myDAO.selectPwdChk(vo);
	}
	
	@Override
	public int updateList(VO vo) throws Exception {
		return myDAO.updateList(vo);
	}


	@Override
	public int delete(String groups) throws Exception {
		return myDAO.delete(groups);
	}

	@Override
	public int deleteAns(String idx) throws Exception {
		return myDAO.deleteAns(idx);
	}
	
}
