package com.kh.petever.animalboard.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.petever.animalboard.model.vo.AnimalAttach;
import com.kh.petever.animalboard.model.vo.AnimalBoard;
import com.kh.petever.animalboard.model.vo.AnimalComment;

@Repository
public class AnimalBoardDAOImpl implements AnimalBoardDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertBoard(AnimalBoard animal) {
		return sqlSession.insert("animalBoard.insertBoard", animal);
	}

	@Override
	public int insertAttachment(AnimalAttach attach) {
		return sqlSession.insert("animalBoard.insertAttachment", attach);
	}

	@Override
	public List<AnimalBoard> selectBoardList(int limit, int offset) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return sqlSession.selectList("animalBoard.selectBoardList");
	}

	@Override
	public AnimalBoard selectOneBoard(int no) {
		return sqlSession.selectOne("animalBoard.selectOneBoard", no);
	}

	@Override
	public List<AnimalAttach> selectAttachList() {
		return sqlSession.selectList("animalBoard.selectAttachList");
	}

	@Override
	public List<AnimalComment> selectCommentList(int no) {
		return sqlSession.selectList("animalBoard.selectCommentList", no);
	}
	
	@Override
	public int totalComment(int no) {
		return sqlSession.selectOne("animalBoard.totalComment", no);
	}

	@Override
	public int insertComment(AnimalComment aniComment) {
		return sqlSession.insert("animalBoard.insertComment", aniComment);
	}

	@Override
	public int deleteBoard(int no) {
		return sqlSession.delete("animalBoard.deleteBoard", no);
	}

	@Override
	public int deleteComment(int commentNo) {
		return sqlSession.delete("animalBoard.deleteComment", commentNo);
	}

	@Override
	public int editComment(AnimalComment aniComment) {
		return sqlSession.update("animalBoard.editComment", aniComment);
	}
	
}
