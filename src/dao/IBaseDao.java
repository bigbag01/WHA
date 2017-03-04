package dao;

import java.util.List;

public interface IBaseDao<T> {
	public void add(T entity);
	public void delete(T entity);
	public void update(T entity);
	public T findById(String id);
	public T findById(Long id);
	public List<T> findAll();
}
