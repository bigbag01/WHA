package service.impl;

import java.util.List;

import dao.impl.LockDao;
import model.Lock;
import service.ILockService;

public class LockService implements ILockService{

	private LockDao lockDao;
	public LockDao getLockDao() {
		return lockDao;
	}

	public void setLockDao(LockDao lockDao) {
		this.lockDao = lockDao;
	}
	
	@Override
	public void saveLock(Lock mylock) {
		this.lockDao.add(mylock);
		
	}

	@Override
	public void deleteLock(Lock mylock) {
		this.lockDao.delete(mylock);
		
	}

	@Override
	public void editLock(Lock mylock) {
		this.lockDao.update(mylock);
		
	}

	@Override
	public Lock findLockById(String userName) {
		return this.lockDao.findById(userName);
	}

	@Override
	public List<Lock> findAllLock() {
		return this.lockDao.findAll();
	}



}
