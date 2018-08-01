package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.PhotoVO;
import org.zerock.mapper.PhotoMapper;

import lombok.Setter;

@Service
public class PhotoServiceImpl implements PhotoService {

	@Setter(onMethod_= {@Autowired})
	private PhotoMapper mapper;
	
	@Override
	public PhotoVO read(int pno) {	
		return mapper.read(pno);
	}

	@Override
	public List<PhotoVO> pageList(Criteria cri) {
		return mapper.list(cri);
	}

	@Transactional
	@Override
	public void write(PhotoVO vo) throws Exception {
		mapper.insert(vo);
		if(vo.getImages() != null) {
		mapper.addImage(vo);	
		}
	}

	@Transactional
	@Override
	public int modify(PhotoVO vo) {
		
		if(vo.getImages() != null) {
			mapper.modiImage(vo);
		}
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(int pno) {
		int row = mapper.removeImage(pno);
		mapper.delete(pno);
		return row;
	}

	@Override
	public int count(Criteria cri) {
		return mapper.count(cri);
	}

	@Override
	public List<PhotoVO> searchList(Criteria cri) {
		return mapper.searchList(cri);
	}
	
	@Override
	public List<PhotoVO> joinList(Criteria cri) {
	
		return mapper.joinList(cri);
	}

	@Override
	public int addImage(PhotoVO vo) {
		return mapper.addImage(vo);
	}

	@Override
	public int viewCnt(int pno) {
		return mapper.addViews(pno);
	}

	@Override
	public int removeImage(int pno) {
		return mapper.removeImage(pno);
	}

	@Override
	public String[] searchImage(int pno) {
		return mapper.searchImage(pno);
	}
	
	@Override
	public int removeImages(String[] deleteImages) {	
		return mapper.removeImages(deleteImages);
	}

	@Override
	public int modiImage(PhotoVO vo) {	
		return mapper.modiImage(vo);
	}

	

}
