package service;

import java.util.List;

import model.Lock;

public interface ILockService {
	public void saveLock(Lock mylock);
	public void deleteLock(Lock mylock);
	public void editLock(Lock mylock);
	public Lock findLockById(String userName);
	public List<Lock> findAllLock();
}
