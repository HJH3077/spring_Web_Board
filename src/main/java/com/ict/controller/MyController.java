package com.ict.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.service.MyService;
import com.ict.service.Paging;
import com.ict.vo.VO;
import com.sun.prism.paint.Paint;

@Controller
public class MyController {

	@Autowired
	private MyService myService;
	@Autowired
	private Paging paging;

	@RequestMapping("list.do")
	public ModelAndView listCommand(@ModelAttribute("cPage")String cPage) {
		try {
			ModelAndView mv = new ModelAndView("list");
			// 전체 게시물의 수
			int count = myService.selectCount();
			paging.setTotalRecord(count);

			// 전체 페이지의 수
			if (paging.getTotalRecord() <= paging.getNumPerPage()) {
				paging.setTotalPage(1);
			} else {
				// 전체 페이지의 수 계산하기
				paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
				// 주의 사항 : 나머지가 존재하면 전체 페이지 수에 +1를 한다.
				if (paging.getTotalRecord() % paging.getNumPerPage() != 0) {
					paging.setTotalPage(paging.getTotalPage() + 1);
				}
			}
			// 현재 페이지 구하기
			paging.setNowPage(Integer.parseInt(cPage));
			
			// 시작번호, 끝번호
			paging.setBegin((paging.getNowPage() - 1) * paging.getNumPerPage() + 1);
			paging.setEnd((paging.getBegin() - 1) + paging.getNumPerPage());

			// 시작블록, 끝블록
			paging.setBeginBlock(
					(int) ((paging.getNowPage() - 1) / paging.getPagePerBlock()) * paging.getPagePerBlock() + 1);
			paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);

			// 주의사항 : endBlock 이 totalPage 보다 큰 경우 발생 할 수 있다.
			// 이 경우 endBlock를 totalPage에 맞춰야 한다.
			if (paging.getEndBlock() > paging.getTotalPage()) {
				paging.setEndBlock(paging.getTotalPage());
			}
			List<VO> list = myService.selectList(paging.getBegin(), paging.getEnd());
			
			mv.addObject("list", list);
			mv.addObject("pvo", paging);
			return mv;
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	@RequestMapping("write.do")
	public ModelAndView writeCommand(@ModelAttribute("cPage")String cPage) {
		return new ModelAndView("write");
	}
	
	@RequestMapping(value = "write_ok.do", method = RequestMethod.POST)
	public ModelAndView writeOkCommand(VO vo, HttpServletRequest request,
			@ModelAttribute("cPage")String cPage) { // 여기 cPage를 넣는 것 만으로 그냥 cPage로 넘어가짐
		try {
			String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			MultipartFile file = vo.getF_name();
			if(file.isEmpty()) {
				vo.setFile_name("");
			} else {
				vo.setFile_name(file.getOriginalFilename());
			}
			int result = myService.InsertVO(vo);
			if(result > 0) {
				if(!vo.getFile_name().isEmpty()) {
					byte[] in = file.getBytes();
					File out = new File(path, vo.getFile_name());
					FileCopyUtils.copy(in, out);
				}
				return new ModelAndView("redirect:list.do");
			} else {
				return new ModelAndView("redirect:write.do");
			}
		} catch (Exception e) {
		}
		return null;
	}
	
	@RequestMapping("onelist.do")
	public ModelAndView oneListCommand(@ModelAttribute("cPage")String cPage,
			@ModelAttribute("idx")String idx) {
		try {
			ModelAndView mv = new ModelAndView("onelist");
			// 이 두개가 묶음으로 하나가 실패하면 처리가 안되게 해야함(트랜잭션)
			// (myService에서 묶어서 처리, BBS참조)
			// 조회수 업데이트
			int result = myService.updateHit(idx);
			// 상세 보기
			VO vo = myService.selectOneList(idx);
			// 저장
			mv.addObject("vo", vo);
			return mv;
		} catch (Exception e) {
		}
		return null;
	}
	
	@RequestMapping("download.do")
	public void downCommand(@RequestParam("file_name")String file_name,
			HttpServletRequest request,
			HttpServletResponse response) {
		
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			String path = request.getSession().getServletContext()
					.getRealPath("/resources/upload/"+file_name);
			response.setContentType("application/x-msdownload");
			response.setHeader("Content-Disposition",
					"attachment; filename="+URLEncoder.encode(file_name,"utf-8"));
			File file = new File(new String(path.getBytes("utf-8")));
			fis = new FileInputStream(file);
			bis = new BufferedInputStream(fis);
			bos = new BufferedOutputStream(response.getOutputStream());
			FileCopyUtils.copy(bis, bos);
		} catch (Exception e) {
		} finally {
			try {
				bos.close();
				bis.close();
				fis.close();
			} catch (Exception e2) {
			}
		}
	}
	
	@RequestMapping("ans_write.do")
	public ModelAndView Ans_WriteCommand(@ModelAttribute("cPage")String cPage,
			@ModelAttribute("idx")String idx) {
		return new ModelAndView("ans_write");
	}
	
	@RequestMapping(value = "ans_write_ok.do", method = RequestMethod.POST)
	public ModelAndView Ans_Write_OKCommand(VO vo,HttpServletRequest request,
			@ModelAttribute("cPage")String cPage) {
		try {
			// 댓글 원리
			/*
			 	groups, step, lev
				16, 0, 0 의 댓글 => 16, 1, 1 / 16, 0, 0 의 댓글2  => 16, 1, 1 (전의 것이 16, 1, 2가 됨), 오래된 댓글의 lev이 증가하는 방식
			 	16, 1, 1 의 댓글 => 16, 2, 2 / 16, 2, 2 의 댓글 => 16, 3, 3
				
			 	즉, step이 댓글의 댓글인지 구별하는 것, lev는 댓글의 수와 댓글 생성순서를 알 수 있게함 (lev가 높을수록 최근)
				 	
			 	주의 : 이러한 방식은 삭제할 때 댓글을 삭제하면 댓글의 댓글은 남아있음. 그래서 삭제하면 그 밑은 다 삭제하던가 하는 처리를 해줘야함
			*/
			
			
			
			// groups, step, lev 를 구하자 
			VO vo2 = myService.selectOneList(vo.getIdx());
			
			// step, lev 1씩 증가 시키자 
			int lev = Integer.parseInt(vo2.getLev());
			int step = Integer.parseInt(vo2.getStep());
			int groups = Integer.parseInt(vo2.getGroups());
			
			step ++;
			lev ++ ;
			
			// DB에 groups, lev를 이용해서 업데이트를 한다.
			// group이 같은 원글 찾아서 레벌이 같거나 크면 레벨을 증가 
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("groups", groups);
			map.put("lev", lev);
			
			 myService.updateLevUp(map); // 첫 댓글은 이걸로 가도 조건이 만족되지 않으므로 update 실행 x
			
			// 이 아래의 3개는 현재 이 페이지에서 1증가시킨 lev와 step이 들어가게된다. 
			// 그래서 댓글은 groups, 1, 1 이됨 (현재 원글은 groups, 0, 0)
			vo.setStep(String.valueOf(step));
			vo.setLev(String.valueOf(lev));
			vo.setGroups(String.valueOf(groups));
			
			// 파일 처리 
			String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			
			MultipartFile file = vo.getF_name();
			if(file.isEmpty()) {
				vo.setFile_name("");
			}else {
				vo.setFile_name(file.getOriginalFilename());
			}
			int result = myService.InsertAns(vo);
		
			if(result>0) {
				if(! vo.getFile_name().isEmpty()) {
					byte[] in = file.getBytes();
					File out = new File(path, vo.getFile_name());
					FileCopyUtils.copy(in, out);
				}
				return new ModelAndView("redirect:list.do?cPage="+cPage);
			}else {
				return new ModelAndView("redirect:ans_write.do?cPage="+cPage+"&idx="+vo.getIdx());
			}
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	@RequestMapping("update.do")
	public ModelAndView updateCommand(@ModelAttribute("cPage")String cPage,
			@ModelAttribute("idx")String idx) {
		try {
			ModelAndView mv = new ModelAndView("update");
			VO vo = myService.selectOneList(idx);
			mv.addObject("vo", vo);
			return mv;
		} catch (Exception e) {
		}
		return null;
	}
	
	@RequestMapping(value = "pwd_chk.do", produces = "html/text; charset=utf-8")
	@ResponseBody
	public String pwd_chkCommand(@ModelAttribute("idx") String idx, // String이므로 text, VO같은 거면 json
			@ModelAttribute("pwd")String pwd) { 
		try {
			VO vo = new VO();
			vo.setIdx(idx);
			vo.setPwd(pwd);
			int result = myService.selectPwdChk(vo);
			return String.valueOf(result);
		} catch (Exception e) {
			System.out.println(e);
			return null;
		}
	}
	
	@RequestMapping(value = "update_ok.do", method = RequestMethod.POST)
	public ModelAndView updateOkCommand(VO vo, HttpServletRequest request,
			@ModelAttribute("cPage")String cPage) {
		try {
			String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			MultipartFile file = vo.getF_name();
			String old_file_name = request.getParameter("old_file_name");
			if(file.isEmpty()) { // 현재파일이 없을 때
				/*
				if(old_file_name == null) {  // 이전파일이 없을 때
					vo.setFile_name("");
				} else { // 이전 파일이 있을 때
					vo.setFile_name(old_file_name);
				}
				*/
				// 이렇게 써도 문제가 생기진 않았음
				vo.setFile_name(old_file_name);
			} else { // 현재파일이 있을 때
				vo.setFile_name(file.getOriginalFilename()); // 현재 파일을 넣음
			}
			
			int result = myService.updateList(vo);
			if(!file.isEmpty()) { // 파일이 비어있지 않으면 업로드 해야함
				byte[] in = file.getBytes();
				File out = new File(path, vo.getFile_name());
				FileCopyUtils.copy(in, out);
			}
			return new ModelAndView("redirect:onelist.do?idx=" + vo.getIdx());
		} catch (Exception e) {
		}
		return null;
	}
	
	@RequestMapping("delete.do")
	public ModelAndView deleteCommand(@ModelAttribute("cPage")String cPage,
			@ModelAttribute("idx")String idx) {
		try {
			return new ModelAndView("delete");
		} catch (Exception e) {
		}
		return null;
	}
	
	@RequestMapping("delete_ok.do")
	public ModelAndView deleteOkCommand(@ModelAttribute("cPage")String cPage,
			@RequestParam("idx")String idx) {
		try {
			VO vo = myService.selectOneList(idx);
			// 원글과 댓글 구분해서 삭제 하자
			int result = 0 ;
			if(Integer.parseInt(vo.getStep()) == 0) {
				// 원글일 경우 댓글 전체 삭제 
				result = myService.delete(vo.getGroups()); // 그룹에 관련된 것은 모두 삭제
			}else {
				result = myService.deleteAns(idx); // 댓글 삭제(댓글도 idx가 생기므로 idx로 찾아서 삭제)
			}
			if(result>0) {
				return new ModelAndView("redirect:list.do");
			}
			
		} catch (Exception e) {
		}
		return null;
	}
}
